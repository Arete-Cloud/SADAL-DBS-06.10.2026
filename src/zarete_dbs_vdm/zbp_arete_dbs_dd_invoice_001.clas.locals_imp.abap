CLASS lhc_ZARETE_DBS_DD_INVOICE_001 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_invoice_001 RESULT result.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zarete_dbs_dd_invoice_001.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_invoice_001 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zarete_dbs_dd_invoice_001.

    METHODS send_invoice FOR MODIFY
      IMPORTING keys FOR ACTION zarete_dbs_dd_invoice_001~send_invoice RESULT result.

    METHODS delete_invoice FOR MODIFY
      IMPORTING keys FOR ACTION zarete_dbs_dd_invoice_001~delete_invoice RESULT result.

    METHODS accounting_document FOR MODIFY
      IMPORTING keys FOR ACTION zarete_dbs_dd_invoice_001~accounting_document RESULT result.
    METHODS clearing_all FOR MODIFY
      IMPORTING keys FOR ACTION zarete_dbs_dd_invoice_001~clearing_all RESULT result.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_INVOICE_001 IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%update = if_abap_behv=>mk-on.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD send_invoice.

    TYPES: BEGIN OF ty_selected_invoices,
             dbs_invoice_id         TYPE zarete_dbs_dd_t016-DbsInvoiceId,
             invoice_number         TYPE zarete_dbs_dd_t015-InvoiceNumber,
             partial_invoice_number TYPE zarete_dbs_dd_t016-PartialInvoiceNumber,
             id                     TYPE zarete_dbs_dd_t015-Id,
             bank_code              TYPE zarete_dbs_dd_t012-CompanyBankCode,
             amount                 TYPE zarete_dbs_dd_t016-Amount,
             currency               TYPE zarete_dbs_dd_t016-CurrencyCode,
             customer               TYPE zarete_dbs_dd_t017-Customer,
             message                TYPE char72,
           END OF ty_selected_invoices.

    DATA: lt_invoices TYPE TABLE OF ty_selected_invoices,
          lv_rowno(2) TYPE c VALUE '1'.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).

    READ TABLE keys INTO DATA(ls_keys) INDEX 1.

*Rowlar içerisinde gönderilen satıralar tabloya toplanır
    DO 20 TIMES.

      DATA(lv_rowname) = 'ROW' && lv_rowno.
      ASSIGN COMPONENT lv_rowname OF STRUCTURE ls_keys-%param TO FIELD-SYMBOL(<fs_rowvalue>).
      IF sy-subrc EQ 0.
        IF <fs_rowvalue> IS NOT INITIAL.
          SPLIT <fs_rowvalue> AT ';' INTO DATA(lv_invoice_number) DATA(lv_partial_invoice_number) DATA(lv_id)
                                          DATA(lv_bank) DATA(lv_amount) DATA(lv_currency) DATA(lv_customer).
          APPEND INITIAL LINE TO lt_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).
          <fs_invoices>-invoice_number         = lv_invoice_number.
          <fs_invoices>-partial_invoice_number = lv_partial_invoice_number.
          <fs_invoices>-id                     = lv_id.
          <fs_invoices>-bank_code              = lv_bank.
          <fs_invoices>-amount                 = lv_amount.
          <fs_invoices>-currency               = lv_currency.
          <fs_invoices>-customer               = |{ lv_customer ALPHA = OUT }|.
        ENDIF.
      ENDIF.

      lv_rowno += 1.
      CLEAR: lv_rowname, lv_invoice_number, lv_partial_invoice_number, lv_id, lv_bank, lv_amount, lv_currency.

    ENDDO.

    IF lt_invoices IS NOT INITIAL.
      lo_util->send_invoice( CHANGING ct_invoices = lt_invoices ).
    ENDIF.

    lv_rowno = 1.

    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
    <fs_result>-Id = ls_keys-id.
    <fs_result>-InvoiceNumber = ls_keys-InvoiceNumber.
    <fs_result>-%param-action_code = ls_keys-%param-action_code.

    LOOP AT lt_invoices ASSIGNING <fs_invoices>.

      DATA(lv_result_rowname) = '%PARAM-ROW' && lv_rowno.
      ASSIGN COMPONENT lv_result_rowname OF STRUCTURE <fs_result> TO FIELD-SYMBOL(<fs_result_value>).
      IF sy-subrc EQ 0.
        lv_amount = <fs_invoices>-amount.

        CONCATENATE <fs_invoices>-invoice_number
                    <fs_invoices>-partial_invoice_number
                    <fs_invoices>-id
                    <fs_invoices>-bank_code
                    lv_amount
                    <fs_invoices>-currency
                    <fs_invoices>-customer
                    <fs_invoices>-message INTO <fs_result_value> SEPARATED BY ';'.

      ENDIF.

      lv_rowno += 1.

      CLEAR: lv_result_rowname, lv_amount.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete_invoice.

    TYPES: BEGIN OF ty_selected_invoices,
             dbs_invoice_id         TYPE zarete_dbs_dd_t016-DbsInvoiceId,
             invoice_number         TYPE zarete_dbs_dd_t015-InvoiceNumber,
             partial_invoice_number TYPE zarete_dbs_dd_t016-PartialInvoiceNumber,
             id                     TYPE zarete_dbs_dd_t015-Id,
             bank_code              TYPE zarete_dbs_dd_t012-CompanyBankCode,
             amount                 TYPE zarete_dbs_dd_t016-Amount,
             currency               TYPE zarete_dbs_dd_t016-CurrencyCode,
             customer               TYPE zarete_dbs_dd_t017-Customer,
             message                TYPE char72,
           END OF ty_selected_invoices.

    DATA: lt_invoices TYPE TABLE OF ty_selected_invoices,
          lv_rowno(2) TYPE c VALUE '1'.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).

    READ TABLE keys INTO DATA(ls_keys) INDEX 1.

*Rowlar içerisinde gönderilen satıralar tabloya toplanır
    DO 20 TIMES.

      DATA(lv_rowname) = 'ROW' && lv_rowno.
      ASSIGN COMPONENT lv_rowname OF STRUCTURE ls_keys-%param TO FIELD-SYMBOL(<fs_rowvalue>).
      IF sy-subrc EQ 0.
        IF <fs_rowvalue> IS NOT INITIAL.
          SPLIT <fs_rowvalue> AT ';' INTO DATA(lv_invoice_number) DATA(lv_partial_invoice_number) DATA(lv_id)
                                          DATA(lv_bank) DATA(lv_amount) DATA(lv_currency) DATA(lv_customer).
          APPEND INITIAL LINE TO lt_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).
          <fs_invoices>-invoice_number         = lv_invoice_number.
          <fs_invoices>-partial_invoice_number = lv_partial_invoice_number.
          <fs_invoices>-id                     = lv_id.
          <fs_invoices>-bank_code              = lv_bank.
          <fs_invoices>-amount                 = lv_amount.
          <fs_invoices>-currency               = lv_currency.
          <fs_invoices>-customer               = |{ lv_customer ALPHA = OUT }|.
        ENDIF.
      ENDIF.

      lv_rowno += 1.
      CLEAR: lv_rowname, lv_invoice_number, lv_partial_invoice_number, lv_id, lv_bank, lv_amount, lv_currency.

    ENDDO.

    IF lt_invoices IS NOT INITIAL.
      lo_util->delete_invoice( CHANGING ct_invoices = lt_invoices ).
    ENDIF.

    lv_rowno = 1.

    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
    <fs_result>-Id = ls_keys-id.
    <fs_result>-InvoiceNumber = ls_keys-InvoiceNumber.
    <fs_result>-%param-action_code = ls_keys-%param-action_code.

    LOOP AT lt_invoices ASSIGNING <fs_invoices>.

      DATA(lv_result_rowname) = '%PARAM-ROW' && lv_rowno.
      ASSIGN COMPONENT lv_result_rowname OF STRUCTURE <fs_result> TO FIELD-SYMBOL(<fs_result_value>).
      IF sy-subrc EQ 0.
        lv_amount = <fs_invoices>-amount.

        CONCATENATE <fs_invoices>-invoice_number
                    <fs_invoices>-partial_invoice_number
                    <fs_invoices>-id
                    <fs_invoices>-bank_code
                    lv_amount
                    <fs_invoices>-currency
                    <fs_invoices>-customer
                    <fs_invoices>-message INTO <fs_result_value> SEPARATED BY ';'.

      ENDIF.

      lv_rowno += 1.

      CLEAR: lv_result_rowname, lv_amount.

    ENDLOOP.


  ENDMETHOD.

  METHOD accounting_document.

    TYPES: BEGIN OF ty_selected_invoices,
             dbs_invoice_id         TYPE zarete_dbs_dd_t016-DbsInvoiceId,
             invoice_number         TYPE zarete_dbs_dd_t015-InvoiceNumber,
             partial_invoice_number TYPE zarete_dbs_dd_t016-PartialInvoiceNumber,
             id                     TYPE zarete_dbs_dd_t015-Id,
             bank_code              TYPE zarete_dbs_dd_t012-CompanyBankCode,
             amount                 TYPE zarete_dbs_dd_t016-Amount,
             currency               TYPE zarete_dbs_dd_t016-CurrencyCode,
             customer               TYPE zarete_dbs_dd_t017-Customer,
             message                TYPE char72,
           END OF ty_selected_invoices.

    DATA: lt_invoices TYPE TABLE OF ty_selected_invoices,
          lv_rowno(2) TYPE c VALUE '1'.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).

    READ TABLE keys INTO DATA(ls_keys) INDEX 1.

*Rowlar içerisinde gönderilen satıralar tabloya toplanır
    DO 20 TIMES.

      DATA(lv_rowname) = 'ROW' && lv_rowno.
      ASSIGN COMPONENT lv_rowname OF STRUCTURE ls_keys-%param TO FIELD-SYMBOL(<fs_rowvalue>).
      IF sy-subrc EQ 0.
        IF <fs_rowvalue> IS NOT INITIAL.
          SPLIT <fs_rowvalue> AT ';' INTO DATA(lv_invoice_number) DATA(lv_partial_invoice_number) DATA(lv_id)
                                          DATA(lv_bank) DATA(lv_amount) DATA(lv_currency) DATA(lv_customer).
          APPEND INITIAL LINE TO lt_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).
          <fs_invoices>-invoice_number         = lv_invoice_number.
          <fs_invoices>-partial_invoice_number = lv_partial_invoice_number.
          <fs_invoices>-id                     = lv_id.
          <fs_invoices>-bank_code              = lv_bank.
          <fs_invoices>-amount                 = lv_amount.
          <fs_invoices>-currency               = lv_currency.
          <fs_invoices>-customer               = |{ lv_customer ALPHA = OUT }|.
        ENDIF.
      ENDIF.

      lv_rowno += 1.
      CLEAR: lv_rowname, lv_invoice_number, lv_partial_invoice_number, lv_id, lv_bank, lv_amount, lv_currency.

    ENDDO.

    IF lt_invoices IS NOT INITIAL.
      lo_util->create_acc_doc( CHANGING ct_invoices = lt_invoices ).
    ENDIF.

    lv_rowno = 1.

    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fs_result>).
    <fs_result>-Id = ls_keys-id.
    <fs_result>-InvoiceNumber = ls_keys-InvoiceNumber.
    <fs_result>-%param-action_code = ls_keys-%param-action_code.

    LOOP AT lt_invoices ASSIGNING <fs_invoices>.

      DATA(lv_result_rowname) = '%PARAM-ROW' && lv_rowno.
      ASSIGN COMPONENT lv_result_rowname OF STRUCTURE <fs_result> TO FIELD-SYMBOL(<fs_result_value>).
      IF sy-subrc EQ 0.
        lv_amount = <fs_invoices>-amount.

        CONCATENATE <fs_invoices>-invoice_number
                    <fs_invoices>-partial_invoice_number
                    <fs_invoices>-id
                    <fs_invoices>-bank_code
                    lv_amount
                    <fs_invoices>-currency
                    <fs_invoices>-customer
                    <fs_invoices>-message INTO <fs_result_value> SEPARATED BY ';'.

      ENDIF.

      lv_rowno += 1.

      CLEAR: lv_result_rowname, lv_amount.

    ENDLOOP.

  ENDMETHOD.

  METHOD clearing_all.

    DATA(lv_yasin) = ''.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_INVOICE_001 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_INVOICE_001 IMPLEMENTATION.

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
