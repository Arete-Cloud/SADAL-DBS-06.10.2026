@EndUserText.label: 'Finteo Gel_Fatura Tablosu Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Semantics.valueRange.maximum: '1'
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'FinteoGelFaturaTAll'
  }
}
define root view entity ZI_FinteoGelFaturaTabl_S
  as select from I_Language
    left outer join ZARETE_DBS_T016 on 0 = 0
  composition [0..*] of ZI_FinteoGelFaturaTabl as _FinteoGelFaturaTabl
{
  @UI.facet: [ {
    id: 'FinteoGelFaturaTabl', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Finteo Gel_Fatura Tablosu', 
    position: 1 , 
    targetElement: '_FinteoGelFaturaTabl'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _FinteoGelFaturaTabl,
  @UI.hidden: true
  max( ZARETE_DBS_T016.LAST_CHANGED_AT ) as LastChangedAtMax
}
where I_Language.Language = $session.system_language
