CLASS lhc_ZARETE_DBS_DD_FINTEO_LMT_0 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zarete_dbs_dd_finteo_lmt_001 RESULT result.

*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE zarete_dbs_dd_finteo_lmt_001.
*
*    METHODS update FOR MODIFY
*      IMPORTING entities FOR UPDATE zarete_dbs_dd_finteo_lmt_001.
*
*    METHODS delete FOR MODIFY
*      IMPORTING keys FOR DELETE zarete_dbs_dd_finteo_lmt_001.

    METHODS read FOR READ
      IMPORTING keys FOR READ zarete_dbs_dd_finteo_lmt_001 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zarete_dbs_dd_finteo_lmt_001.

    METHODS musteri_ekle FOR MODIFY
      IMPORTING keys FOR ACTION zarete_dbs_dd_finteo_lmt_001~musteri_ekle RESULT result.

ENDCLASS.

CLASS lhc_ZARETE_DBS_DD_FINTEO_LMT_0 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

*  METHOD create.
*  ENDMETHOD.
*
*  METHOD update.
*  ENDMETHOD.
*
*  METHOD delete.
*  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD musteri_ekle.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_FINTEO_LMT_0 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZARETE_DBS_DD_FINTEO_LMT_0 IMPLEMENTATION.

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
