@EndUserText.label: 'DBS - Belge Türleri Bakım Tablosu'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_DbsBelgeTRleriBakMT
  as select from ZARETE_DBS_T026
  association to parent ZI_DbsBelgeTRleriBakMT_S as _DbsBelgeTRleriBaAll on $projection.SingletonID = _DbsBelgeTRleriBaAll.SingletonID
{
  key ACCOUNTINGDOCUMENTTYPE as Accountingdocumenttype,
  key DEBITCREDITCODE as Debitcreditcode,
  @Consumption.hidden: true
  1 as SingletonID,
  _DbsBelgeTRleriBaAll
}
