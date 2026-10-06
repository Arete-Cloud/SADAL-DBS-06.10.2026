@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BP Listesi Projection View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_PV_T018
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T018
{
  key BusinessPartner,
      BusinessPartnerFullName,
      BptaxNumber
}
