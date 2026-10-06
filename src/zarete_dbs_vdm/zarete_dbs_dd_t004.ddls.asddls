@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aksiyonlar'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T004
  as select from zarete_dbs_t004
{
  key action_code           as ActionCode,
      action_definition     as ActionDefinition,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_at       as LastChangedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt
}
