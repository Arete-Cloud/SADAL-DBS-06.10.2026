CLASS lhc_ZARETE_DBS_DD_T003 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_t003 RESULT result.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_T003 IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%create = if_abap_behv=>auth-allowed.
  result-%delete = if_abap_behv=>auth-allowed.
  result-%update = if_abap_behv=>auth-allowed.
  ENDMETHOD.

ENDCLASS.
