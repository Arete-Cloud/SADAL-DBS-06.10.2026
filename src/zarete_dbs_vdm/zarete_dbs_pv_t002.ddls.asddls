@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Finteo-SAP Statü Eşleştirmeleri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T002
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T002
{
  key FinteoStatusCode,
  key FinteoStatusDescription,
  key SapStatusCode,
  key StatusIcon,
      FinteoStatusCodeText,
      FinteoStatusDescText,
      SapStatusCodeText
}
