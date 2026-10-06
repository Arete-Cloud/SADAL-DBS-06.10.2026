@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Finteodan Gelen Faturalar ProjectionView'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZARETE_DBS_PV_T016
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T016
{
  key Identifier,
  key DbsInvoiceId,
      Amount,
      DeletedAmount,
      CurrencyCode,
      DueDate,
      InvoiceNumber,
      PartialInvoiceNumber,
      InvoiceAmountDue,
      LastPaymentDate,
      PartialGuaranteedAmount,
      AmountRemainingBeforePaymen,
      PaymentDescription,
      StatusCode,
      StatusDescription,
      TransactionDate,
      DbsAccountId,
      PartyCode,
      PartyTitle,
      PartyTaxNumber,
      BankCode,
      BankName
}
