@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Finteo-SAP Statü Eşleştirmeleri PV'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T002
  as select from zarete_dbs_t002
{
  key finteo_status_code        as FinteoStatusCode,
  key finteo_status_description as FinteoStatusDescription,
  key sap_status_code           as SapStatusCode,
  key status_icon               as StatusIcon,
      finteo_status_code_text   as FinteoStatusCodeText,
      finteo_status_desc_text   as FinteoStatusDescText,
      sap_status_code_text      as SapStatusCodeText,
      created_by                as CreatedBy,
      created_at                as CreatedAt,
      last_changed_at           as LastChangedAt,
      local_last_changed_by     as LocalLastChangedBy,
      local_last_changed_at     as LocalLastChangedAt
}
