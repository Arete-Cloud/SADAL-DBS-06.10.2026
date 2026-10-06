@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FI Belgesinin Sabit Verileri'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T006 as select from zarete_dbs_t006
{
    key sap_alan_adi as SapAlanAdi,
    key sap_kayit_ornegi as SapKayitOrnegi,
    sap_alan_degeri as SapAlanDegeri,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_at as LastChangedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt
}
