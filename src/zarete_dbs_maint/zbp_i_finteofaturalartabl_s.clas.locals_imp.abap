CLASS LHC_FINTEOFATURALARTALL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PUBLIC SECTION.
    CONSTANTS:
      CO_ENTITY TYPE abp_entity_name VALUE `ZI_FINTEOFATURALARTABL_S`,
      CO_TRANSPORT_OBJECT TYPE mbc_cp_api=>indiv_transaction_obj_name VALUE `ZFINTEOFATURALARTABL`,
      CO_AUTHORIZATION_ENTITY TYPE abp_entity_name VALUE `ZI_FINTEOFATURALARTABL`.

  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR FinteoFaturalarTAll
        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR FinteoFaturalarTAll
        RESULT result,
      Edit FOR MODIFY
            keys FOR ACTION FinteoFaturalarTAll~Edit.
ENDCLASS.

CLASS LHC_FINTEOFATURALARTALL IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
*  mbc_cp_api=>rap_bc_api( )->get_instance_features(
*    transport_object   = co_transport_object
*    entity             = co_entity
*    keys               = REF #( keys )
*    requested_features = REF #( requested_features )
*    result             = REF #( result )
*    failed             = REF #( failed )
*    reported           = REF #( reported ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  mbc_cp_api=>rap_bc_api( )->get_global_authorizations(
    entity                   = co_authorization_entity
    requested_authorizations = REF #( requested_authorizations )
    result                   = REF #( result )
    reported                 = REF #( reported ) ).
  ENDMETHOD.
  METHOD Edit.
  ENDMETHOD.

ENDCLASS.
CLASS LSC_FINTEOFATURALARTALL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION.
ENDCLASS.

CLASS LSC_FINTEOFATURALARTALL IMPLEMENTATION.
  METHOD SAVE_MODIFIED ##NEEDED.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_FINTEOFATURALARTABL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PUBLIC SECTION.
    CONSTANTS:
      CO_ENTITY TYPE abp_entity_name VALUE `ZI_FINTEOFATURALARTABL`.

  PRIVATE SECTION.
    METHODS:
*      VALIDATEDATACONSISTENCY FOR VALIDATE ON SAVE
*        IMPORTING
*          KEYS FOR FinteoFaturalarTabl~ValidateDataConsistency,
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR FinteoFaturalarTabl
        RESULT result.
ENDCLASS.

CLASS LHC_FINTEOFATURALARTABL IMPLEMENTATION.
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
    transport_object   = lhc_FinteoFaturalarTAll=>co_transport_object
    entity             = co_entity
    requested_features = REF #( requested_features )
    result             = REF #( result )
    reported           = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.
