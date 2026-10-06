@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FI Belgesinin Sabit Verileri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T006 provider contract transactional_query as projection on ZARETE_DBS_DD_T006
{
    key SapAlanAdi,
    key SapKayitOrnegi,
    SapAlanDegeri
}
