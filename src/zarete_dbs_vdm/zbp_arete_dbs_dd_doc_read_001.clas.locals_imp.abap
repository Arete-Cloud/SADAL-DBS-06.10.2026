CLASS lhc_ZARETE_DBS_DD_DOC_READ_001 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_doc_read_001 RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_doc_read_001 RESULT result.
*
*    METHODS lock FOR LOCK
*      IMPORTING keys FOR LOCK zarete_dbs_dd_doc_read_001.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_DOC_READ_001 IMPLEMENTATION.

*  METHOD get_global_authorizations.
*    result-%update = if_abap_behv=>auth-allowed.
*  ENDMETHOD.

  METHOD read.

    DATA: lt_data           TYPE TABLE OF zarete_dbs_dd_doc_read_001,
          lt_filter         TYPE if_rap_query_filter=>tt_name_range_pairs,
          lt_doc_type_range TYPE if_rap_query_filter=>tt_range_option.

    DATA(lo_api) = NEW zarete_dbs_cl_doc_read_api(  ).

*    LOOP AT keys INTO DATA(ls_key).
*
*      IF ls_key-accounting_document_type IS NOT INITIAL.
*        APPEND VALUE #( name  = 'ACCOUNTING_DOCUMENT_TYPE'
*                        range = VALUE #( ( sign = 'I' option = 'EQ' low = ls_key-accounting_document_type ) ) ) TO lt_filter.
*      ENDIF.
*
*    ENDLOOP.
*
    LOOP AT keys INTO DATA(ls_key).
      IF ls_key-accounting_document_type IS NOT INITIAL.
        APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_key-accounting_document_type ) TO lt_doc_type_range.
      ENDIF.
    ENDLOOP.

    IF lt_doc_type_range IS NOT INITIAL.
      APPEND VALUE #( name  = 'ACCOUNTING_DOCUMENT_TYPE'
                      range = lt_doc_type_range ) TO lt_filter.
    ENDIF.

    lo_api->get_accounting_document(
    EXPORTING
        it_filter        = lt_filter
      IMPORTING
        et_business_data = lt_data
    ).


    MOVE-CORRESPONDING lt_data TO result.
  ENDMETHOD.

*  METHOD lock.
*  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_DOC_READ_001 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_DOC_READ_001 IMPLEMENTATION.

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
