@EndUserText.label: 'DBS VL10C Hariç Tut. Cariler Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'DbsVl10cHariTutCAll'
  }
}
define root view entity ZI_DbsVl10cHariTutCari_S
  as select from I_Language
    left outer join ZARETE_DBS_T025 on 0 = 0
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_DbsVl10cHariTutCari as _DbsVl10cHariTutCari
{
  @UI.facet: [ {
    id: 'ZI_DbsVl10cHariTutCari', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'DBS VL10C Hariç Tut. Cariler', 
    position: 1 , 
    targetElement: '_DbsVl10cHariTutCari'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _DbsVl10cHariTutCari,
  @UI.hidden: true
  max( ZARETE_DBS_T025.LAST_CHANGED_AT ) as LastChangedAtMax,
  @ObjectModel.text.association: '_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 1 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  _ABAPTransportRequestText
}
where I_Language.Language = $session.system_language
