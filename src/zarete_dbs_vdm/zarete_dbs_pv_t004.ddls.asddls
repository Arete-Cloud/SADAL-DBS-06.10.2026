@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aksiyonlar PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T004 provider contract transactional_query as projection on ZARETE_DBS_DD_T004
{
    key ActionCode,
    ActionDefinition
}
