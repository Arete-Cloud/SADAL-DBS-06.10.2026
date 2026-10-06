@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Limit Geçmişi Log Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_T032
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T032
{
  key LogId,
      Identifier,
      LimitId,
      PartyCode,
      PartyTaxNumber,
      PartyTitle,
      Limit,
      ActiveLimit,
      PendingInvoiceCount,
      PendingInvoiceAmount,
      GuarantedInvoiceAmount,
      FundedExposure,
      BankCode,
      BankName,
      CurrencyCode,
      CreatedBy,
      CreatedAt
      //      LastChangedAt,
      //      LocalLastChangedBy,
      //      LocalLastChangedAt
}
