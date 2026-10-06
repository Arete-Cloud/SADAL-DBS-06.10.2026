@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Banka Listesi Projection View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_PV_T019
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T019
{
    key BankCode,
    key BankName
}
