@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Belge Türleri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T005  provider contract transactional_query as projection on ZARETE_DBS_DD_T005
{
    key BelgeTuru,
    BelgeTuruDescription
}
