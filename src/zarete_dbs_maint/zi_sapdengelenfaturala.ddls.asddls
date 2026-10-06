@EndUserText.label: 'SAPden Gelen Faturalar Tablosu'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_SapdenGelenFaturala
  as select from ZARETE_DBS_T017
  association to parent ZI_SapdenGelenFaturala_S as _SapdenGelenFaturAll on $projection.SingletonID = _SapdenGelenFaturAll.SingletonID
{
  key COMPANY_CODE as CompanyCode,
  key FISCAL_YEAR as FiscalYear,
  key ACCOUNTING_DOCUMENT as AccountingDocument,
  key ACCOUNTING_DOCUMENT_ITEM as AccountingDocumentItem,
  key DOCUMENT_REFERENCE_ID as DocumentReferenceId,
  DEBIT_CREDIT_CODE as DebitCreditCode,
  DOCUMENT_ITEM_TEXT as DocumentItemText,
  CUSTOMER as Customer,
  CUSTOMER_NAME as CustomerName,
  POSTING_DATE as PostingDate,
  DOCUMENT_DATE as DocumentDate,
  NET_DUE_DATE as NetDueDate,
  VALUE_DATE as ValueDate,
  HOUSE_BANK as HouseBank,
  ACCOUNTING_DOCUMENT_TYPE as AccountingDocumentType,
  AMOUNT_IN_TRANSACTION_CURR as AmountInTransactionCurr,
  TRANSACTION_CURRENCY as TransactionCurrency,
  ASSIGNMENT_REFERENCE as AssignmentReference,
  CLEARING_ACCOUNTING_DOCUME as ClearingAccountingDocume,
  CLEARING_DOC_FISCAL_YEAR as ClearingDocFiscalYear,
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
  _SapdenGelenFaturAll
}
