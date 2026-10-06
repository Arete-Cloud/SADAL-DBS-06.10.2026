@EndUserText.label: 'Finteodan Gelen Faturalar Tablosu Single'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'FinteodanGelenFaAll'
  }
}
define root view entity ZI_FinteodanGelenFatur_S
  as select from I_Language
    left outer join ZARETE_DBS_T016 on 0 = 0
  composition [0..*] of ZI_FinteodanGelenFatur as _FinteodanGelenFatur
{
  @UI.facet: [ {
    id: 'ZI_FinteodanGelenFatur', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Finteodan Gelen Faturalar Tablosu', 
    position: 1 , 
    targetElement: '_FinteodanGelenFatur'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _FinteodanGelenFatur,
  @UI.hidden: true
  max( ZARETE_DBS_T016.LAST_CHANGED_AT ) as LastChangedAtMax
}
where I_Language.Language = $session.system_language
