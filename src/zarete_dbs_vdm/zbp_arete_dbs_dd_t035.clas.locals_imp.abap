CLASS lhc_ZARETE_DBS_DD_T035 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zarete_dbs_dd_t035 RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_t035 RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zarete_dbs_dd_t035.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zarete_dbs_dd_t035.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zarete_dbs_dd_t035.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_t035 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zarete_dbs_dd_t035.

    METHODS clearing FOR MODIFY
      IMPORTING keys FOR ACTION zarete_dbs_dd_t035~clearing RESULT result.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_T035 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD clearing.

    DATA: lt_in_tab  TYPE cl_abap_parallel=>t_in_inst_tab,
          lt_out_tab TYPE cl_abap_parallel=>t_out_inst_tab,
          lt_t024    TYPE TABLE OF zarete_dbs_t024.

    DATA(lo_parallel) = NEW cl_abap_parallel( ).
    DATA(lo_denk) = NEW zcl_fi_denk_parallel( ).

    DATA: ls_request TYPE  zfi_denk_journal_entry_bulk_cl.

    TYPES:
      BEGIN OF ty_clearing_documents,
        company_code               TYPE zarete_dbs_t022-company_code,
        fiscal_year                TYPE zarete_dbs_t022-fiscal_year,
        accounting_document        TYPE zarete_dbs_t022-accounting_document,
        accounting_document_item   TYPE zarete_dbs_t022-accounting_document_item,
        customer                   TYPE zarete_dbs_t022-customer,
        customer_name              TYPE zarete_dbs_t022-customer_name,
        posting_date               TYPE zarete_dbs_t022-posting_date,
        document_date              TYPE zarete_dbs_t022-document_date,
        net_due_date               TYPE zarete_dbs_t022-net_due_date,
        accounting_document_type   TYPE zarete_dbs_t022-accounting_document_type,
        amount_in_transaction_curr TYPE zarete_dbs_t022-amount_in_transaction_curr,
        transaction_currency       TYPE zarete_dbs_t022-transaction_currency,
        used_amount                TYPE zarete_dbs_t022-used_amount,
        available_amount           TYPE zarete_dbs_t022-available_amount,
      END OF ty_clearing_documents.

    DATA: lt_limit              TYPE zarete_dbs_sc_finteo_api=>ty_limit,
          lv_scenario           TYPE c,
          lt_clearing_documents TYPE TABLE OF ty_clearing_documents.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).
    DATA(lo_log) = zarete_dbs_cl_log=>get_factory( ).

    lo_util->get_limit_data( EXPORTING iv_behavior = abap_true IMPORTING et_limit = lt_limit ).

    READ TABLE keys INTO DATA(ls_keys) INDEX 1.
    IF sy-subrc EQ 0.

      "Denkleştirmede kullanılacak verilerin tüm detayları alınır
      IF ls_keys-%param-documents IS NOT INITIAL.
        SELECT *
          FROM zarete_dbs_t022
          FOR ALL ENTRIES IN @ls_keys-%param-documents
          WHERE company_code EQ @ls_keys-%param-documents-company_code
          AND   fiscal_year EQ @ls_keys-%param-documents-fiscal_year
          AND   accounting_document EQ @ls_keys-%param-documents-accounting_document
          AND   accounting_document_item EQ @ls_keys-%param-documents-accounting_document_item
          AND   customer EQ @ls_keys-%param-documents-customer
          INTO TABLE @DATA(lt_clearing_data).

*        lt_clearing_documents = CORRESPONDING #( lt_clearing_data ).

        LOOP AT ls_keys-%param-documents ASSIGNING FIELD-SYMBOL(<fs_docs>).
          READ TABLE lt_clearing_data ASSIGNING FIELD-SYMBOL(<fs_clearing>) WITH KEY company_code = <fs_docs>-company_code
                                                                                     fiscal_year  = <fs_docs>-fiscal_year
                                                                                     accounting_document = <fs_docs>-accounting_document
                                                                                     accounting_document_item = <fs_docs>-accounting_document_item
                                                                                     customer = <fs_docs>-customer.
          IF sy-subrc EQ 0.

            IF <fs_clearing>-status EQ 'B' AND <fs_clearing>-message EQ 'İşleniyor.'.
*              <fs_docs>-message = 'Denkleştirme Zaten İşlemede.'.

              APPEND VALUE #(  %tky = ls_keys-%tky ) TO failed-zarete_dbs_dd_t035.
              APPEND VALUE #(  %tky =  ls_keys-%tky
                               %msg = new_message_with_text(
                               severity = if_abap_behv_message=>severity-warning
                               text = 'Denkleştirme Zaten İşlemede.'
                                     )  ) TO reported-zarete_dbs_dd_t035.
            ELSE.
              APPEND INITIAL LINE TO lt_clearing_documents ASSIGNING FIELD-SYMBOL(<fs_clearing_docs>).
              <fs_clearing_docs> = CORRESPONDING #( <fs_clearing> ).
            ENDIF.

          ENDIF.

        ENDLOOP.

*        DATA(lv_lines) = lines( ls_keys-%param-documents ).
        DATA(lv_lines) = lines( lt_clearing_documents ).
      ENDIF.

      IF lv_lines GE 1.
        "Ana tablodaki seçili satırın detayına bakılır
        READ TABLE ls_keys-%param-row INTO DATA(ls_row) INDEX 1.
        IF sy-subrc EQ 0.

          DATA(lv_denk_toplam) = REDUCE #( INIT tutar TYPE dmbtr
                                           FOR ls_data IN lt_clearing_data
                                           WHERE ( customer = ls_row-customer )
                                           NEXT tutar = tutar + ls_data-available_amount ).

          DATA(lv_limit_toplam) = REDUCE #( INIT tutar TYPE dmbtr
                                           FOR ls_limit IN lt_limit-data
                                           WHERE ( partycode = ls_row-customer )
                                           NEXT tutar = tutar + ls_limit-activelimit ).

          DATA(lv_limit_toplam_risksiz) = REDUCE #( INIT tutar TYPE dmbtr
                                           FOR ls_limit IN lt_limit-data
                                           WHERE ( partycode = ls_row-customer AND guarantedinvoiceamount IS INITIAL )
                                           NEXT tutar = tutar + ls_limit-activelimit ).

          SELECT SINGLE * "#EC CI_ALL_FIELDS_NEEDED
            FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
            WHERE Id EQ @ls_row-id
            AND   InvoiceNumber EQ @ls_row-invoicenumber
*          AND   PartialInvoiceNumber EQ @ls_row-Partialinvoicenumber
            INTO @DATA(ls_main_inv).
          IF sy-subrc EQ 0.

            DATA(lv_system_date) = cl_abap_context_info=>get_system_date( ).
            DATA(lv_nextday) = lv_system_date + 1.
            DATA(lv_fiveday) = lv_system_date + 5.
            IF ls_keys-%param-code EQ 'Y' AND ls_main_inv-DueDate NOT BETWEEN lv_nextday AND lv_fiveday.
              LOOP AT ls_keys-%param-documents ASSIGNING <fs_docs>.
                <fs_docs>-message = 'Faturanın vade tarihi 5 gün içerisinde değil'.
              ENDLOOP.
              lo_log->set_sapinvoiceno( iv_sapinvoiceno = ls_main_inv-InvoiceNumber
                                        iv_id           = ls_main_inv-Id ).
              lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                               msgno = '019'  ).
            ELSE.
              "O carinin bankalarda yeterli limiti var mı kontrol edilir
*          READ TABLE lt_limit-data ASSIGNING FIELD-SYMBOL(<fs_limit>) WITH KEY partycode = ls_row-customer
*                                                                               bankcode  = ls_row-housebank.
*          IF sy-subrc EQ 0.

              "Banka limiti denkleştirme tutarını karşılıyorsa
              IF lv_limit_toplam GE lv_denk_toplam.

                "Seçilen belgeler toplamı esas fatura toplamına eşitse ya da daha fazlaysa denkleştirme yapılabilir,
                "nakdi riske bakılmasına gerek yok
                IF ls_main_inv-RemainingAmount LE lv_denk_toplam.
                  "eğer tek belge ile karşılıyorsa 1 numaralı senaryo, çok belge ise 2 numaralı senaryo
                  "denkleştirme sonucu 202 varsa işleniyor mesajı yoksa denkleştrime başarısız mesajı

                  IF lv_lines EQ 1.
                    lv_scenario = '1'.
                  ELSEIF lv_lines GT 1.
                    lv_scenario = '2'.
                  ENDIF.

*                  lo_util->clearing_mapping( EXPORTING
*                    iv_clearing_scenario  = lv_scenario
*                    is_main_inv           = ls_main_inv
*                    it_clearing_documents = lt_clearing_documents
*                    IMPORTING
*                    es_request = ls_request
*                  ).

                  lo_denk->input = ls_request.
                  APPEND lo_denk TO lt_in_tab.

                  lo_parallel->run_inst( EXPORTING p_in_tab  = lt_in_tab  IMPORTING p_out_tab = lt_out_tab ).

                  LOOP AT ls_keys-%param-documents ASSIGNING <fs_docs>.
                    <fs_docs>-message = 'İşleniyor.'.

                    UPDATE zarete_dbs_t022
                    SET message = 'İşleniyor.',
                        status = 'B'
                    WHERE accounting_document = @<fs_docs>-accounting_document
                    AND   accounting_document_item = @<fs_docs>-accounting_document_item
                    AND   company_code = @<fs_docs>-company_code
                    AND   fiscal_year = @<fs_docs>-fiscal_year.

                  ENDLOOP.

*             "Seçilen belgeler toplamı esas fatura toplamını karşılamıyorsa nakdi riske bakılmalı
*             "nakdi risk boşsa yettiği kadarıyla denkleştirme yapılır, doluysa denkleştirilemez
                ELSE.
*              select SINGLE * from zarete_dbs_
                  READ TABLE lt_limit-data ASSIGNING FIELD-SYMBOL(<fs_limit>) WITH KEY partycode = ls_row-customer.
                  IF sy-subrc EQ 0.
                    IF <fs_limit>-guarantedinvoiceamount IS INITIAL.
                      "eğer tek belge ile eksikse 3 numaralı senaryo, çok belge ile eksikse 4 numaralı senaryo
                      "denkleştirme sonucu 202 varsa işleniyor mesajı yoksa denkleştrime başarısız mesajı

                      IF lv_lines EQ 1.
                        lv_scenario = '3'.
                      ELSEIF lv_lines GT 1.
                        lv_scenario = '4'.
                      ENDIF.

*                      lo_util->clearing_mapping( EXPORTING
*                        iv_clearing_scenario  = lv_scenario
*                        is_main_inv           = ls_main_inv
*                        it_clearing_documents = lt_clearing_documents
*                    IMPORTING
*                    es_request = ls_request
*                  ).

                      lo_denk->input = ls_request.
                      APPEND lo_denk TO lt_in_tab.

                      lo_parallel->run_inst( EXPORTING p_in_tab  = lt_in_tab  IMPORTING p_out_tab = lt_out_tab ).


                      LOOP AT ls_keys-%param-documents ASSIGNING <fs_docs>.
                        <fs_docs>-message = 'İşleniyor.'.
                      ENDLOOP.

                    ELSE.
                      LOOP AT ls_keys-%param-documents ASSIGNING <fs_docs>.
                        <fs_docs>-message = 'İlgili caride nakdi risk bulunmaktadır.'.
                      ENDLOOP.
                      lo_log->set_sapinvoiceno( iv_sapinvoiceno = ls_main_inv-InvoiceNumber
                                                iv_id           = ls_main_inv-Id ).
                      lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                       msgno = '020'  ).
                    ENDIF.

                  ENDIF.

                ENDIF.

*           "Banka limiti denkleştirme tutarını karşılamıyorsa direkt hata mesajı verilir
              ELSE.
                LOOP AT ls_keys-%param-documents ASSIGNING <fs_docs>.
                  <fs_docs>-message = 'Banka limiti yetersiz.'.
                ENDLOOP.
                lo_log->set_sapinvoiceno( iv_sapinvoiceno = ls_main_inv-InvoiceNumber
                                          iv_id           = ls_main_inv-Id ).
                lo_log->add_log( msgty = if_abap_behv_message=>severity-error
                                 msgno = '021'  ).
              ENDIF.

            ENDIF.

          ENDIF.

        ENDIF.

      ENDIF.

    ENDIF.

    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
    <fs_result> = CORRESPONDING #( ls_keys ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_T035 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_T035 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
