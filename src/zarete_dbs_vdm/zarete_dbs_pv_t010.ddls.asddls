@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sap Statüleri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T010 provider contract transactional_query as projection on ZARETE_DBS_DD_T010
{
    key SapStatusCode,
    SapStatusDefinition
}
