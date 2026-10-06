@EndUserText.label: 'Fatura Listesi Detay Tablosu Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'FaturaListesiDetAll'
  }
}
define root view entity ZI_FaturaListesiDetayT_S
  as select from I_Language
    left outer join zarete_dbs_t015 on 0 = 0
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_FaturaListesiDetayT as _FaturaListesiDetayT
{
  @UI.facet: [ {
    id: 'Transport', 
    purpose: #STANDARD, 
    type: #IDENTIFICATION_REFERENCE, 
    label: 'Taşı', 
    position: 1 , 
    hidden: #(HideTransport)
  }, {
    id: 'ZI_FaturaListesiDetayT', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Fatura Listesi Detay Tablosu', 
    position: 2 , 
    targetElement: '_FaturaListesiDetayT'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _FaturaListesiDetayT,
  @UI.hidden: true
  max( zarete_dbs_t015.last_changed_at ) as LastChangedAtMax,
  @ObjectModel.text.association: '_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 1 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
    
    }]
//  }, {
//    type: #FOR_ACTION, 
//    dataAction: 'SelectCustomizingTransptReq', 
//    label: 'Taşıma seç'
//  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as sxco_transport) as TransportRequestID,
  _ABAPTransportRequestText,
  @UI.hidden: true
  cast( 'X' as abap_boolean preserving type) as HideTransport
}
where I_Language.Language = $session.system_language
