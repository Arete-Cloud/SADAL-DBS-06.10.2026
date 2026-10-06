CLASS lhc_ZARETE_DBS_DD_BANK_001 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_bank_001 RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_bank_001 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zarete_dbs_dd_bank_001.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_BANK_001 IMPLEMENTATION.

  METHOD get_global_authorizations.

    result-%update = if_abap_behv=>auth-allowed.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_BANK_001 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_BANK_001 IMPLEMENTATION.

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
