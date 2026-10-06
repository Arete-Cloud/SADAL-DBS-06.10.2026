CLASS LHC_FATURALISTESIDETALL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PUBLIC SECTION.
    CONSTANTS:
      CO_ENTITY TYPE abp_entity_name VALUE `ZI_FATURALISTESIDETAYT_S`,
      CO_TRANSPORT_OBJECT TYPE mbc_cp_api=>indiv_transaction_obj_name VALUE `ZFATURALISTESIDETAYT`,
      CO_AUTHORIZATION_ENTITY TYPE abp_entity_name VALUE `ZI_FATURALISTESIDETAYT`.

  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR FaturaListesiDetAll
        RESULT result,
*      SELECTCUSTOMIZINGTRANSPTREQ FOR MODIFY
*        IMPORTING
*          KEYS FOR ACTION FaturaListesiDetAll~SelectCustomizingTransptReq
*        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR FaturaListesiDetAll
        RESULT result,
      EDIT FOR MODIFY
        IMPORTING
          KEYS FOR ACTION FaturaListesiDetAll~edit.
ENDCLASS.

CLASS LHC_FATURALISTESIDETALL IMPLEMENTATION.
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
*  METHOD SELECTCUSTOMIZINGTRANSPTREQ.
*  mbc_cp_api=>rap_bc_api( )->select_transport_action(
*    entity   = co_entity
*    keys     = REF #( keys )
*    result   = REF #( result )
*    mapped   = REF #( mapped )
*    failed   = REF #( failed )
*    reported = REF #( reported ) ).
*  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  mbc_cp_api=>rap_bc_api( )->get_global_authorizations(
    entity                   = co_authorization_entity
    requested_authorizations = REF #( requested_authorizations )
    result                   = REF #( result )
    reported                 = REF #( reported ) ).
  ENDMETHOD.
  METHOD EDIT.
*  mbc_cp_api=>rap_bc_api( )->get_default_transport_request(
*    transport_object = co_transport_object
*    entity           = co_entity
*    keys             = REF #( keys )
*    mapped           = REF #( mapped )
*    failed           = REF #( failed )
*    reported         = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.
CLASS LSC_FATURALISTESIDETALL DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION.
ENDCLASS.

CLASS LSC_FATURALISTESIDETALL IMPLEMENTATION.
  METHOD SAVE_MODIFIED.
  mbc_cp_api=>rap_bc_api( )->record_changes(
    transport_object = lhc_FaturaListesiDetAll=>co_transport_object
    entity           = lhc_FaturaListesiDetAll=>co_entity
    create           = REF #( create )
    update           = REF #( update )
    delete           = REF #( delete )
    reported         = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.
CLASS LHC_FATURALISTESIDETAYT DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PUBLIC SECTION.
    CONSTANTS:
      CO_ENTITY TYPE abp_entity_name VALUE `ZI_FATURALISTESIDETAYT`.

  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR FaturaListesiDetayT
        RESULT result.
*      VALIDATETRANSPORTREQUEST FOR VALIDATE ON SAVE
*        IMPORTING
*          KEYS_FATURALISTESIDETALL FOR FaturaListesiDetAll~ValidateTransportRequest
*          KEYS_FATURALISTESIDETAYT FOR FaturaListesiDetayT~ValidateTransportRequest.
ENDCLASS.

CLASS LHC_FATURALISTESIDETAYT IMPLEMENTATION.
  METHOD GET_GLOBAL_FEATURES.
  mbc_cp_api=>rap_bc_api( )->get_global_features(
    transport_object   = lhc_FaturaListesiDetAll=>co_transport_object
    entity             = co_entity
    requested_features = REF #( requested_features )
    result             = REF #( result )
    reported           = REF #( reported ) ).
  ENDMETHOD.
*  METHOD VALIDATETRANSPORTREQUEST.
*  mbc_cp_api=>rap_bc_api( )->validate_transport_request(
*    transport_object = lhc_FaturaListesiDetAll=>co_transport_object
*    entity           = lhc_FaturaListesiDetAll=>co_entity
*    validation_keys  = VALUE #( ( REF #( keys_FaturaListesiDetAll ) )
*                                ( REF #( keys_FaturaListesiDetayT ) ) )
*    failed           = REF #( failed )
*    reported         = REF #( reported ) ).
*  ENDMETHOD.
ENDCLASS.
