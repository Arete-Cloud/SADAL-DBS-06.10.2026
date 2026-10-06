@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Banka Listesi'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.supportedCapabilities: [#CDS_MODELING_DATA_SOURCE]
define root view entity ZARETE_DBS_DD_T019
  as select from zarete_dbs_t019
{
      @UI.selectionField: [{position: 10}]
      @Search.defaultSearchElement: true
  key bank_code             as BankCode,
      @UI.selectionField: [{position: 20}]
      @Search.defaultSearchElement: true
  key bank_name             as BankName,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
