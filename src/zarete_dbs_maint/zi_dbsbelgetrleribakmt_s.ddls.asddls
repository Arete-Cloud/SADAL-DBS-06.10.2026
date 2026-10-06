@EndUserText.label: 'DBS - Belge Türleri Bakım Tablosu Single'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Semantics.valueRange.maximum: '1'
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'DbsBelgeTRleriBaAll'
  }
}
define root view entity ZI_DbsBelgeTRleriBakMT_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_DBSBELGETRLERIBAKMT'
  composition [0..*] of ZI_DbsBelgeTRleriBakMT as _DbsBelgeTRleriBakMT
{
  @UI.facet: [ {
    id: 'DbsBelgeTRleriBakMT', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'DBS - Belge Türleri Bakım Tablosu', 
    position: 1 , 
    targetElement: '_DbsBelgeTRleriBakMT'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _DbsBelgeTRleriBakMT,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax
}
where I_Language.Language = $session.system_language
