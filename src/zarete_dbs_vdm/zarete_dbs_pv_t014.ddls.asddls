@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Şirket Bilgileri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T014
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T014
{
  key Uuid,
      CompanyCode,
      CompanyIdentifier
}
