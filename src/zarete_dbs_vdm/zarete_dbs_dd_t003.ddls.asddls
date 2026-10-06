@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Statülerin Aksiyonları'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T003
  as select from zarete_dbs_t003
{
  key sap_status_code       as SapStatusCode,
  key action_code           as ActionCode,
      action_definition     as ActionDefinition,
      sap_status_definition as SapStatusDefinition,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_at       as LastChangedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt
}
