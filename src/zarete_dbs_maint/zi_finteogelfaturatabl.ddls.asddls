@EndUserText.label: 'Finteo Gel_Fatura Tablosu'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_FinteoGelFaturaTabl
  as select from ZARETE_DBS_T016
  association to parent ZI_FinteoGelFaturaTabl_S as _FinteoGelFaturaTAll on $projection.SingletonID = _FinteoGelFaturaTAll.SingletonID
{
  key IDENTIFIER as Identifier,
  key DBS_INVOICE_ID as DbsInvoiceId,
  ID as Id,
  AMOUNT as Amount,
  DELETED_AMOUNT as DeletedAmount,
  CURRENCY_CODE as CurrencyCode,
  DUE_DATE as DueDate,
  SEND_DATE as SendDate,
  INVOICE_NUMBER as InvoiceNumber,
  PARTIAL_INVOICE_NUMBER as PartialInvoiceNumber,
  INVOICE_AMOUNT_DUE as InvoiceAmountDue,
  LAST_PAYMENT_DATE as LastPaymentDate,
  PARTIAL_GUARANTEED_AMOUNT as PartialGuaranteedAmount,
  AMOUNT_REMAINING_BEFORE_PAYMEN as AmountRemainingBeforePaymen,
  PAYMENT_DESCRIPTION as PaymentDescription,
  STATUS_CODE as StatusCode,
  STATUS_DESCRIPTION as StatusDescription,
  TRANSACTION_DATE as TransactionDate,
  DBS_ACCOUNT_ID as DbsAccountId,
  PARTY_CODE as PartyCode,
  PARTY_TITLE as PartyTitle,
  PARTY_TAX_NUMBER as PartyTaxNumber,
  BANK_CODE as BankCode,
  BANK_NAME as BankName,
  @Semantics.user.createdBy: true
  CREATED_BY as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _FinteoGelFaturaTAll
}
