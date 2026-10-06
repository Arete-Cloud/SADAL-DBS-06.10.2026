@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Limit Ekranı Projection View'
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_CV001
  as projection on ZARETE_DBS_DD_CV001
{
  key PartyTaxNumber,
  key Bankname,
      PartyTitle,
      Limit,
      Activelimit,
      Kullanilanlimit,
      Pendinginvoiceamount
}
