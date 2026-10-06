@EndUserText.label: 'Finteo Faturaları Tablosu Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Semantics.valueRange.maximum: '1'
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'FinteoFaturalarTAll'
  }
}
define root view entity ZI_FinteoFaturalarTabl_S
  as select from I_Language
    left outer join ZARETE_DBS_T016 on 0 = 0
  composition [0..*] of ZI_FinteoFaturalarTabl as _FinteoFaturalarTabl
{
  @UI.facet: [ {
    id: 'FinteoFaturalarTabl', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Finteo Faturaları Tablosu', 
    position: 1 , 
    targetElement: '_FinteoFaturalarTabl'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _FinteoFaturalarTabl,
  @UI.hidden: true
  max( ZARETE_DBS_T016.LAST_CHANGED_AT ) as LastChangedAtMax
}
where I_Language.Language = $session.system_language
