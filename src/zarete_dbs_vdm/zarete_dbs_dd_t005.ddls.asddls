@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Belge Türleri'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T005 as select from zarete_dbs_t005
{
    key belge_turu as BelgeTuru,
    belge_turu_description as BelgeTuruDescription,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_at as LastChangedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt
}
