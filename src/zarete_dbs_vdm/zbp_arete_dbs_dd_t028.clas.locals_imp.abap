CLASS lhc_ZARETE_DBS_DD_T028 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_t028 RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zarete_dbs_dd_t028.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zarete_dbs_dd_t028.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zarete_dbs_dd_t028.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_t028 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zarete_dbs_dd_t028.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_T028 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

    TYPES: BEGIN OF ty_selected_invoices,
             invoice_number TYPE zarete_dbs_dd_t015-InvoiceNumber,
             id             TYPE zarete_dbs_dd_t015-Id,
             bank_code      TYPE zarete_dbs_dd_t012-HouseBank,
             amount         TYPE zarete_dbs_dd_t016-Amount,
             currency       TYPE zarete_dbs_dd_t016-CurrencyCode,
           END OF ty_selected_invoices.

    DATA: lt_invoices   TYPE TABLE OF ty_selected_invoices,
          lv_rowno(2)   TYPE c VALUE '1',
          lv_amount2(9) TYPE p DECIMALS 2.

    DATA(lo_util) = NEW zarete_dbs_cl_utility( ).

    READ TABLE entities ASSIGNING FIELD-SYMBOL(<fs_entities>) INDEX 1.

*Rowlar içerisinde gönderilen satıralar tabloya toplanır
    DO 20 TIMES.

      DATA(lv_rowname) = 'ROW' && lv_rowno.
      ASSIGN COMPONENT lv_rowname OF STRUCTURE <fs_entities> TO FIELD-SYMBOL(<fs_rowvalue>).
      IF sy-subrc EQ 0.
        IF <fs_rowvalue> IS NOT INITIAL.
          SPLIT <fs_rowvalue> AT ';' INTO DATA(lv_invoice_number) DATA(lv_id) DATA(lv_bank) DATA(lv_amount) DATA(lv_currency).
          APPEND INITIAL LINE TO lt_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).
          <fs_invoices>-invoice_number = lv_invoice_number.
          <fs_invoices>-id             = lv_id.
          <fs_invoices>-bank_code      = lv_bank.
          <fs_invoices>-amount         = lv_amount.
          <fs_invoices>-currency       = lv_currency.
        ENDIF.
      ENDIF.

      lv_rowno += 1.
      CLEAR: lv_rowname, lv_invoice_number, lv_id, lv_bank, lv_amount, lv_currency.

    ENDDO.

*    CASE <fs_entities>-action_code.
*      WHEN 'A'.
*      WHEN 'C'.
*        lo_util->delete_invoice( it_invoices = lt_invoices ).
*      WHEN 'S'.
*        lo_util->send_invoice( it_invoices = lt_invoices ).
*    ENDCASE.
*
*    APPEND VALUE #( action_code = <fs_entities>-action_code row1 = '1;2;3;4;5;6'   ) TO mapped-zarete_dbs_dd_t028.
*<fs_entities>-row1 = <fs_entities>-row1 &&';deneme mesaj'.


  ENDMETHOD.

  METHOD update.


  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_T028 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_T028 IMPLEMENTATION.

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
