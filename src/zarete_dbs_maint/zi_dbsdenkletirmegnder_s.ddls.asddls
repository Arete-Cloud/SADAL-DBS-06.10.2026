@EndUserText.label: 'DBS Denkleştirme Gönderilenler Takip Tab'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'DbsDenkleTirmeGNAll'
  }
}
define root view entity ZI_DbsDenkleTirmeGNder_S
  as select from I_Language
    left outer join ZARETE_DBS_T024 on 0 = 0
  composition [0..*] of ZI_DbsDenkleTirmeGNder as _DbsDenkleTirmeGNder
{
  @UI.facet: [ {
    id: 'ZI_DbsDenkleTirmeGNder', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'DBS Denkleştirme Gönderilenler Takip Tab', 
    position: 1 , 
    targetElement: '_DbsDenkleTirmeGNder'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _DbsDenkleTirmeGNder,
  @UI.hidden: true
  max( ZARETE_DBS_T024.LAST_CHANGED_AT ) as LastChangedAtMax
}
where I_Language.Language = $session.system_language
