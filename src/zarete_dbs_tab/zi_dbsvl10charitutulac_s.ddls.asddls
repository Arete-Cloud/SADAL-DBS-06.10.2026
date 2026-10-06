@EndUserText.label: 'DBS-VL10C Hariç Tutulacak Cariler Single'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'DbsVl10cHariTutuAll'
  }
}
define root view entity ZI_DbsVl10cHariTutulac_S
  as select from I_Language
    left outer join zarete_dbs_t025 on 0 = 0
//  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_DbsVl10cHariTutulac as _DbsVl10cHariTutulac
{
  @UI.facet: [ {
    id: 'Transport', 
    purpose: #STANDARD, 
    type: #IDENTIFICATION_REFERENCE, 
    label: 'Taşı', 
    position: 1 , 
    hidden: #(HideTransport)
  }, {
    id: 'ZI_DbsVl10cHariTutulac', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'DBS-VL10C Hariç Tutulacak Cariler', 
    position: 2 , 
    targetElement: '_DbsVl10cHariTutulac'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _DbsVl10cHariTutulac,
  @UI.hidden: true
  max( zarete_dbs_t025.last_changed_at ) as LastChangedAtMax,
//  @ObjectModel.text.association: '_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 1 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  } 
//{
//    type: #FOR_ACTION, 
//    dataAction: 'SelectCustomizingTransptReq', 
//    label: 'Taşıma seç'
  ]
  @Consumption.semanticObject: 'CustomizingTransport'
//  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
//  _ABAPTransportRequestText,
  @UI.hidden: true
  cast( 'X' as abap_boolean preserving type) as HideTransport
}
where I_Language.Language = $session.system_language
