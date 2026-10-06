CLASS lhc_ZARETE_DBS_DD_T027 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_t027 RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zarete_dbs_dd_t027.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zarete_dbs_dd_t027.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zarete_dbs_dd_t027.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_t027 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zarete_dbs_dd_t027.

    METHODS rba_Invoices FOR READ
      IMPORTING keys_rba FOR READ zarete_dbs_dd_t027\_Invoices FULL result_requested RESULT result LINK association_links.
    METHODS cba_Invoices FOR MODIFY
      IMPORTING entities_cba FOR CREATE zarete_dbs_dd_t027\_Invoices.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_T027 IMPLEMENTATION.

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

  METHOD rba_Invoices.
  ENDMETHOD.

  METHOD cba_Invoices.

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

    DATA: lt_limit TYPE zarete_dbs_sc_finteo_api=>ty_limit.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).

    READ TABLE entities_cba ASSIGNING FIELD-SYMBOL(<fs_entities_cba>) INDEX 1.
    IF sy-subrc EQ 0.

      DATA: lt_invoices TYPE TABLE OF ty_selected_invoices.

      LOOP AT <fs_entities_cba>-%target ASSIGNING FIELD-SYMBOL(<fs_target>).
        APPEND INITIAL LINE TO lt_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).
        <fs_invoices>-dbs_invoice_id         = <fs_target>-dbs_invoice_id.
        <fs_invoices>-invoice_number         = <fs_target>-invoice_number.
        <fs_invoices>-partial_invoice_number = <fs_target>-partial_invoice_number.
        <fs_invoices>-id                     = <fs_target>-id.
        <fs_invoices>-bank_code              = <fs_target>-bank_code.
        <fs_invoices>-amount                 = <fs_target>-amount.
        <fs_invoices>-currency               = <fs_target>-currency_code.
        <fs_invoices>-customer               = |{ <fs_target>-customer ALPHA = OUT }|.
      ENDLOOP.

*Action Codes
*D = Denkleştir
*A = Muhasebeleştir
*C = Geri al
*S = Gönder

      CASE <fs_entities_cba>-action_code.
        WHEN 'D'.

          IF lt_invoices IS NOT INITIAL.
            lo_util->clearing_new( CHANGING ct_invoices = lt_invoices ).
*            lo_util->clearing( CHANGING ct_invoices = lt_invoices ).
          ENDIF.

        WHEN 'A'.

          IF lt_invoices IS NOT INITIAL.
            lo_util->create_acc_doc( CHANGING ct_invoices = lt_invoices ).
          ENDIF.

        WHEN 'C'.

          IF lt_invoices IS NOT INITIAL.
            lo_util->delete_invoice( CHANGING ct_invoices = lt_invoices ).
          ENDIF.

        WHEN 'S'.

          IF lt_invoices IS NOT INITIAL.
            lo_util->send_invoice( CHANGING ct_invoices = lt_invoices ).
          ENDIF.

      ENDCASE.

      IF <fs_entities_cba>-action_code NE 'D'.

        DATA(lo_buffer) = zarete_dbs_cl_tab_memory_ins=>get_instance( ).

        lo_buffer->set_table(
          iv_table = lt_invoices
          iv_table_name = 'ZARETE_DBS_DD_T024'
        ).

      ENDIF.

      lo_util->get_limit_data( EXPORTING iv_behavior = abap_true IMPORTING et_limit = lt_limit ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_T024 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_t024 RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zarete_dbs_dd_t024.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zarete_dbs_dd_t024.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zarete_dbs_dd_t024.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_t024 RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ zarete_dbs_dd_t024\_Header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_T024 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA(lv_debug) = 'X'.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Header.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_T027 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_T027 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA(lv) = 'x'.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
