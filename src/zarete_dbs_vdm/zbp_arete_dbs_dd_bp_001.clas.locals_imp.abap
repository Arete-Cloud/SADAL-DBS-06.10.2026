CLASS lhc_ZARETE_DBS_DD_BP_001 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_bp_001 RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_bp_001 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zarete_dbs_dd_bp_001.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_BP_001 IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%update = if_abap_behv=>auth-allowed.
  ENDMETHOD.

  METHOD read.

    TYPES: BEGIN OF ty_data .
             INCLUDE TYPE zarete_dbs_sc_bp_api=>tys_a_business_partner_type .
    TYPES:   to_business_partner_tax TYPE STANDARD TABLE OF zarete_dbs_sc_bp_api=>tys_a_business_partner_tax_n_2 WITH EMPTY KEY.

    TYPES END OF ty_data.

    DATA: lt_data TYPE TABLE OF ty_data.
    DATA(lo_api) = NEW zarete_dbs_cl_bp_api(  ).

    lo_api->get_taxnumber(
      IMPORTING
        et_business_data = lt_data
    ).

    MOVE-CORRESPONDING lt_data TO result.

  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_BP_001 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_BP_001 IMPLEMENTATION.

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
