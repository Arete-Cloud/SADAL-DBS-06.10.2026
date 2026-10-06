@EndUserText.label: 'Fatura Listesi Detay Tablosu'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_FaturaListesiDetayT
  as select from ZARETE_DBS_T015
  association to parent ZI_FaturaListesiDetayT_S as _FaturaListesiDetAll on $projection.SingletonID = _FaturaListesiDetAll.SingletonID
{
  key UUID as Uuid,
  key INVOICE_NUMBER as InvoiceNumber,
  key ID as Id,
  INVOICE_ACC_DOC as InvoiceAccDoc,
  INVOICE_ACC_DOC_ITEM as InvoiceAccDocItem,
  DBS_INVOICE_ID as DbsInvoiceId,
  SCENARIO_TYPE as ScenarioType,
  STATU as Statu,
  ACCOUNTING_DOCUMENT as AccountingDocument,
  CLEARING_DOCUMENT as ClearingDocument,
  COMPANY_CODE as CompanyCode,
  FISCAL_YEAR as FiscalYear,
  TRANSACTION_DATE as TransactionDate,
  AMOUNT as Amount,
  DUE_DATE as DueDate,
  FI_ACCOUNT as FiAccount,
  DBS_ACCOUNT_ID as DbsAccountId,
  IS_CANCELLED as IsCancelled,
  ACC_ERROR as AccError,
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
  _FaturaListesiDetAll
}
