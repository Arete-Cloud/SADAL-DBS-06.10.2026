CLASS zarete_dbs_cl_denk_paralel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES : BEGIN OF ty_input ,
              !accountingdocheader TYPE zarete_dbs_s004,
              !accountingdocitems  TYPE zarete_dbs_tt005,
              !uncompresseditems   TYPE zarete_dbs_tt006,
              !validationmessage   TYPE symsg,
            END OF ty_input.

    INTERFACES if_serializable_object .
    INTERFACES if_abap_parallel.

    DATA input  TYPE ty_input.
    DATA output TYPE ty_input.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZARETE_DBS_CL_DENK_PARALEL IMPLEMENTATION.


  METHOD if_abap_parallel~do.

    DATA: lv_jobname_denk   TYPE cl_apj_rt_api=>ty_jobname VALUE 'ZARETE_DBS_JOB_CATALOG_003',
          lv_job_text       TYPE cl_apj_rt_api=>ty_job_text VALUE 'DBS Denkleştirme - Banka Bildirimi (Otomatik)',
          lv_temp_name_denk TYPE cl_apj_rt_api=>ty_template_name VALUE 'ZDBS_JOB_TEMPLATE_003'.

    DATA: lv_high_res_tstmp TYPE tzntstmpl,
          lv_std_tstmp      TYPE timestamp,
          ls_job_info       TYPE cl_apj_rt_api=>ty_job_info,
          ls_start_info     TYPE cl_apj_rt_api=>ty_start_info.
    DATA: lt_job_params     TYPE cl_apj_rt_api=>tt_job_parameter_value.
    DATA: lv_jobname  TYPE cl_apj_rt_api=>ty_jobname,
          lv_jobcount TYPE cl_apj_rt_api=>ty_jobcount.


    CHECK input IS NOT INITIAL.

    IF input-accountingdocheader-reversedocument IS NOT INITIAL.

      SELECT * FROM I_OperationalAcctgDocItem
       WHERE ClearingJournalEntry = @input-accountingdocheader-reversedocument
         AND ( AccountingDocumentType = 'DR' OR AccountingDocumentType = 'RV' )
        INTO TABLE @DATA(lt_open_clearing).

      IF sy-subrc = 0.

        SELECT *                                   "#EC CI_NO_TRANSFORM
         FROM zarete_dbs_t015
           FOR ALL ENTRIES IN @lt_open_clearing
        WHERE invoice_acc_doc = @lt_open_clearing-AccountingDocument
          AND invoice_acc_doc_item = @lt_open_clearing-AccountingDocumentItem
         INTO TABLE @DATA(lt_t015).
      ENDIF.

    ELSE.

      " Fatura Listesi Detay Tablosu
      SELECT *                                     "#EC CI_NO_TRANSFORM
       FROM zarete_dbs_t015
        FOR ALL ENTRIES IN @input-accountingdocitems
       WHERE invoice_acc_doc = @input-accountingdocitems-invoicereference
        INTO TABLE @lt_t015.

    ENDIF.

    " DBS Denkleştirme Gönderilenler Takip Tablosu
    IF lt_t015 IS NOT INITIAL.
      SELECT *                                     "#EC CI_NO_TRANSFORM
       FROM zarete_dbs_t024
        FOR ALL ENTRIES IN @lt_t015
       WHERE invoice_acc_doc = @lt_t015-invoice_acc_doc
        INTO TABLE @DATA(lt_t024).

      " Fatura - Detay Tablosu (Cockpit)
      SELECT *                                     "#EC CI_NO_TRANSFORM
        FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
        FOR ALL ENTRIES IN @lt_t015           "#EC CI_ALL_FIELDS_NEEDED
        WHERE Id EQ @lt_t015-id
        AND   InvoiceNumber EQ @lt_t015-invoice_number
        INTO TABLE @DATA(lt_main_inv).
    ENDIF.

    " DBS Denkleştirme Belgeleri Tablosu
    IF lt_t024 IS NOT INITIAL.
      SELECT * FROM zarete_dbs_t023                "#EC CI_NO_TRANSFORM
        FOR ALL ENTRIES IN @lt_t024           "#EC CI_ALL_FIELDS_NEEDED
       WHERE invoice_number = @lt_t024-invoice_number
        INTO TABLE @DATA(lt_t023).
    ENDIF.

    " TK olarak gönderiliyorsa
    IF input-accountingdocheader-accountingdocumenttype = 'TK' AND input-accountingdocheader-reversedocument IS NOT INITIAL.

      LOOP AT lt_open_clearing ASSIGNING FIELD-SYMBOL(<fs_open_clearing>) .

        READ TABLE lt_t015 INTO DATA(ls_t015) WITH KEY invoice_acc_doc = <fs_open_clearing>-AccountingDocument
                                                       invoice_acc_doc_item = <fs_open_clearing>-AccountingDocumentItem.
        IF sy-subrc = 0 .

          READ TABLE lt_main_inv INTO DATA(ls_main_inv) WITH KEY id = ls_t015-id
                                                                 InvoiceNumber = ls_t015-invoice_number.
          "00 İşlem Başarıyla Tamamlandı
          "01 Bankaya Gönderildi
          "08 Tahsil Edilemedi
          "09 İptal Edildi

          CONDENSE: ls_t015-statu.

          IF ( ls_main_inv-SapStatusCode = '' OR ls_main_inv-SapStatusCode = '1' OR
               ls_main_inv-SapStatusCode = '8' OR ls_main_inv-SapStatusCode = '9' OR
               ls_t015-statu = '9' OR ( ls_main_inv-DbsInvoiceId IS INITIAL AND ( ls_main_inv-SapStatusCode = '11' OR
                                                                                  ls_main_inv-SapStatusCode = 'D' )  ) ).


            LOOP AT lt_t024 INTO DATA(ls_t024) WHERE invoice_acc_doc      = ls_t015-invoice_acc_doc
                                                 AND invoice_acc_doc_item = ls_t015-invoice_acc_doc_item.

              READ TABLE lt_t023 INTO DATA(ls_t023) WITH KEY invoice_number = ls_t024-invoice_number
                                                             reverse        = abap_false.
              IF sy-subrc = 0.
                UPDATE  zarete_dbs_t023 SET reverse = @abap_true
                                      WHERE invoice_number = @ls_t023-invoice_number.
              ENDIF.

              UPDATE  zarete_dbs_t024 SET status = 'E' ,
                                          message = 'Denkleştirme-Ters kayıt alındı'
                                    WHERE invoice_number = @ls_t023-invoice_number.
            ENDLOOP.

*            "02 Vade Bekliyor
*            "03 Vade Bekliyor-Garanti Verildi
*            "04 Vade Bekliyor-Garanti Verileme
*            "05 Vade Bekliyor-Kısmi Garanti
          ELSE.

            output-validationmessage-msgv1 = ls_main_inv-FinteoStatusCodeText && | | && 'Statü. için Ters Kayıt Alınamaz !! '.
            output-validationmessage-msgid = 'FIN_SUB_VAL'.
            output-validationmessage-msgty = 'E'.
            output-validationmessage-msgno = '000'.

          ENDIF.

        ENDIF.
      ENDLOOP.

      " Denkleştirme Belgeleri için geliştirme yapılamadı -- Belge numaraları dönmüyor !!

    ENDIF.

  ENDMETHOD.
ENDCLASS.
