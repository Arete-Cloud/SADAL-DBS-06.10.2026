CLASS zarete_dbs_cl_denklestirme_job DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_apj_rt_exec_object.
    INTERFACES if_apj_dt_exec_object.

    DATA : g_log   TYPE REF TO if_bali_log.

ENDCLASS.



CLASS ZARETE_DBS_CL_DENKLESTIRME_JOB IMPLEMENTATION.


  METHOD if_apj_rt_exec_object~execute.


*    DATA: lv_belnr TYPE belnr_d,
*          lv_bukrs TYPE bukrs,
*          lv_gjahr TYPE gjahr,
*          lv_blart TYPE blart.
*
*    " 1. Gelen Parametre Değerlerini Okuma
*    LOOP AT it_parameters INTO DATA(ls_param).
*      CASE ls_param-selname.
*        WHEN 'P_BELNR'.
*          lv_belnr = ls_param-low.
*        WHEN 'P_BUKRS'.
*          lv_bukrs = ls_param-low.
*        WHEN 'P_GJAHR'.
*          lv_gjahr = ls_param-low.
*        WHEN 'P_BLART'.
*          lv_blart = ls_param-low.
*      ENDCASE.
*    ENDLOOP.

    " 2. Parametre Doluluk Kontrolü
*    CHECK lv_belnr IS INITIAL OR lv_bukrs IS INITIAL OR lv_gjahr IS INITIAL.
*
*    SELECT * FROM I_OperationalAcctgDocItem
*      WHERE ClearingJournalEntry = @lv_belnr
*        AND CompanyCode  = @lv_bukrs
*        AND FiscalYear   = @lv_gjahr
*        AND ( AccountingDocumentType = 'DR' OR AccountingDocumentType = 'RV' )
*       INTO TABLE @DATA(lt_open_clearing).
*
*    IF sy-subrc = 0.
*
*      SELECT *                                     "#EC CI_NO_TRANSFORM
*         FROM zarete_dbs_t015
*           FOR ALL ENTRIES IN @lt_open_clearing
*        WHERE invoice_acc_doc = @lt_open_clearing-AccountingDocument
*          AND invoice_acc_doc_item = @lt_open_clearing-AccountingDocumentItem
*         INTO TABLE @DATA(lt_t015).
*
*
*      " DBS Denkleştirme Gönderilenler Takip Tablosu
*      IF lt_t015 IS NOT INITIAL.
*        SELECT *                                   "#EC CI_NO_TRANSFORM
*         FROM zarete_dbs_t024
*          FOR ALL ENTRIES IN @lt_t015
*         WHERE invoice_acc_doc = @lt_t015-invoice_acc_doc
*          INTO TABLE @DATA(lt_t024).
*
*        " Fatura - Detay Tablosu (Cockpit)
*        SELECT *                                   "#EC CI_NO_TRANSFORM
*          FROM zarete_dbs_dd_invoice_001 WITH PRIVILEGED ACCESS
*          FOR ALL ENTRIES IN @lt_t015         "#EC CI_ALL_FIELDS_NEEDED
*          WHERE Id EQ @lt_t015-id
*          AND   InvoiceNumber EQ @lt_t015-invoice_number
*          INTO TABLE @DATA(lt_main_inv).
*      ENDIF.
*
*      " DBS Denkleştirme Belgeleri Tablosu
*      IF lt_t024 IS NOT INITIAL.
*        SELECT * FROM zarete_dbs_t023              "#EC CI_NO_TRANSFORM
*          FOR ALL ENTRIES IN @lt_t024         "#EC CI_ALL_FIELDS_NEEDED
*         WHERE invoice_number = @lt_t024-invoice_number
*          INTO TABLE @DATA(lt_t023).
*      ENDIF.
*
*    ENDIF.
*
*    IF lv_blart = 'TK'.
*
*
*
*    ENDIF.











  ENDMETHOD.


  METHOD if_apj_dt_exec_object~get_parameters.

    " 1. Parametre Tanımlamaları (Definition)
    et_parameter_def = VALUE #(
      " Belge Numarası (BELNR) -> CHAR 10
      ( selname        = 'P_BELNR'
        kind           = if_apj_dt_exec_object=>parameter
        datatype       = 'C'
        length         = 10
        param_text     = 'Belge Numarası'
        changeable_ind = abap_true )

      " Mali Yıl (GJAHR) -> NUMC 4
      ( selname        = 'P_GJAHR'
        kind           = if_apj_dt_exec_object=>parameter
        datatype       = 'N'
        length         = 4
        param_text     = 'Mali Yıl'
        changeable_ind = abap_true )

      " Şirket Kodu (BUKRS) -> CHAR 4
      ( selname        = 'P_BUKRS'
        kind           = if_apj_dt_exec_object=>parameter
        datatype       = 'C'
        length         = 4
        param_text     = 'Şirket Kodu'
        changeable_ind = abap_true )

      " Belge Türü
      ( selname        = 'P_BLART'
        kind           = if_apj_dt_exec_object=>parameter
        datatype       = 'C'
        length         = 2
        param_text     = 'Belge Türü'
        changeable_ind = abap_true )

    ).

    " 2. Parametre Değerleri (Values / Defaults)
    et_parameter_val = VALUE #(
      ( selname = 'P_BELNR'
        kind    = if_apj_dt_exec_object=>parameter
        sign    = 'I'
        option  = 'EQ'
        low     = '' )

      ( selname = 'P_GJAHR'
        kind    = if_apj_dt_exec_object=>parameter
        sign    = 'I'
        option  = 'EQ'
        low     = '' )

      ( selname = 'P_BUKRS'
        kind    = if_apj_dt_exec_object=>parameter
        sign    = 'I'
        option  = 'EQ'
        low     = '' )

      ( selname = 'P_BLART'
        kind    = if_apj_dt_exec_object=>parameter
        sign    = 'I'
        option  = 'EQ'
        low     = '' )


    ).

  ENDMETHOD.
ENDCLASS.
