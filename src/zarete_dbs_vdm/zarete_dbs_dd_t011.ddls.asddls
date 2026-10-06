@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Finteo Statüleri'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T011
  as select from zarete_dbs_t011
{
  key finteo_status_code        as FinteoStatusCode,
  key finteo_status_description as FinteoStatusDescription,
      finteo_status_code_text   as FinteoStatusCodeText,
      finteo_status_desc_text   as FinteoStatusDescText,
      created_by                as CreatedBy,
      created_at                as CreatedAt,
      last_changed_at           as LastChangedAt,
      local_last_changed_by     as LocalLastChangedBy,
      local_last_changed_at     as LocalLastChangedAt
}
