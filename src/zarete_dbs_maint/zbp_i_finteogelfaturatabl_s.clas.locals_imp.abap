CLASS LHC_FINTEOGELFATURATALL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PUBLIC SECTION.
    CONSTANTS:
      CO_ENTITY TYPE abp_entity_name VALUE `ZI_FINTEOGELFATURATABL_S`,
      CO_TRANSPORT_OBJECT TYPE mbc_cp_api=>indiv_transaction_obj_name VALUE `ZFINTEOGELFATURATABL`,
      CO_AUTHORIZATION_ENTITY TYPE abp_entity_name VALUE `ZI_FINTEOGELFATURATABL`.

  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR FinteoGelFaturaTAll
        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR FinteoGelFaturaTAll
        RESULT result.
ENDCLASS.

CLASS LHC_FINTEOGELFATURATALL IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
  mbc_cp_api=>rap_bc_api( )->get_instance_features(
    transport_object   = co_transport_object
    entity             = co_entity
    keys               = REF #( keys )
    requested_features = REF #( requested_features )
    result             = REF #( result )
    failed             = REF #( failed )
    reported           = REF #( reported ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  mbc_cp_api=>rap_bc_api( )->get_global_authorizations(
    entity                   = co_authorization_entity
    requested_authorizations = REF #( requested_authorizations )
    result                   = REF #( result )
    reported                 = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.
CLASS LSC_FINTEOGELFATURATALL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION.
ENDCLASS.

CLASS LSC_FINTEOGELFATURATALL IMPLEMENTATION.
  METHOD SAVE_MODIFIED ##NEEDED.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_FINTEOGELFATURATABL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PUBLIC SECTION.
    CONSTANTS:
      CO_ENTITY TYPE abp_entity_name VALUE `ZI_FINTEOGELFATURATABL`.

  PRIVATE SECTION.
    METHODS:
*      VALIDATEDATACONSISTENCY FOR VALIDATE ON SAVE
*        IMPORTING
*          KEYS FOR FinteoGelFaturaTabl~ValidateDataConsistency,
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR FinteoGelFaturaTabl
        RESULT result.
ENDCLASS.

CLASS LHC_FINTEOGELFATURATABL IMPLEMENTATION.
*  METHOD VALIDATEDATACONSISTENCY.
*  mbc_cp_api=>rap_bc_api( )->check_consistency(
*    entity   = co_entity
*    fields_not_initial = VALUE #( ( CONV #( 'Identifier' ) )
*                                  ( CONV #( 'DbsInvoiceId' ) ) )
*    keys     = REF #( keys )
*    failed   = REF #( failed )
*    reported = REF #( reported ) ).
*  ENDMETHOD.
  METHOD GET_GLOBAL_FEATURES.
  mbc_cp_api=>rap_bc_api( )->get_global_features(
    transport_object   = lhc_FinteoGelFaturaTAll=>co_transport_object
    entity             = co_entity
    requested_features = REF #( requested_features )
    result             = REF #( result )
    reported           = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.
