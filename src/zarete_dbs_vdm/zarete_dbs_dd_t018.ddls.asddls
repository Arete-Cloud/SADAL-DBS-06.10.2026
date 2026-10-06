@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BP Listesi'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_DD_T018
  as select from zarete_dbs_t018
{
      @UI.selectionField: [{position: 10}]
      @Search.defaultSearchElement: true
  key business_partner           as BusinessPartner,
      @UI.selectionField: [{position: 20}]
      @Search.defaultSearchElement: true
      business_partner_full_name as BusinessPartnerFullName,
      bptax_number               as BptaxNumber,
      @Semantics.user.createdBy: true
      created_by                 as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                 as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at            as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by      as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at      as LocalLastChangedAt
}
