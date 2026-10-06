@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Statülerin Aksiyonları PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T003 provider contract transactional_query as projection on ZARETE_DBS_DD_T003
{
    key SapStatusCode,
    key ActionCode,
    ActionDefinition,
    SapStatusDefinition
}
