@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Limit Bilgileri PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T013
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T013
{
  key Identifier,
  key Limitid,
      Partycode,
      Partytaxnumber,
      Partytitle,
      Limit,
      Activelimit,
      Pendinginvoicecount,
      Pendinginvoiceamount,
      Bankcode,
      Bankname,
      Currencycode,
      IsActive,
      GuarantedInvoiceAmount,
      LinkedIban,
      BankPriority
}
