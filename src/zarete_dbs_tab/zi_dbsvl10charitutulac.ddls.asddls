@EndUserText.label: 'DBS-VL10C Hariç Tutulacak Cariler'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_DbsVl10cHariTutulac
  as select from zarete_dbs_t025
  association to parent ZI_DbsVl10cHariTutulac_S as _DbsVl10cHariTutuAll on $projection.SingletonID = _DbsVl10cHariTutuAll.SingletonID
{
  key customer as Customer,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  local_last_changed_at as LocalLastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _DbsVl10cHariTutuAll
}
