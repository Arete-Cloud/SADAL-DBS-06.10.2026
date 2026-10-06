@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Finteo Statüleri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T011
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T011
{
  key FinteoStatusCode,
  key FinteoStatusDescription,
      FinteoStatusCodeText,
      FinteoStatusDescText
}
