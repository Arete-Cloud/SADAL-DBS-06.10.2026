@EndUserText.label: 'DBS Denkleştirme Gönderilenler Takip Tab'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_DbsDenkleTirmeGNder
  as select from zarete_dbs_t024
  association to parent ZI_DbsDenkleTirmeGNder_S as _DbsDenkleTirmeGNAll on $projection.SingletonID = _DbsDenkleTirmeGNAll.SingletonID
{
  key uuid as Uuid,
  key invoice_number as InvoiceNumber,
  key accounting_document as AccountingDocument,
  key accounting_document_item as AccountingDocumentItem,
  invoice_acc_doc as InvoiceAccDoc,
  invoice_acc_doc_item as InvoiceAccDocItem,
  item_uuid as ItemUuid,
  partial_invoice_number as PartialInvoiceNumber,
  id as Id,
  customer as Customer,
  invoice_amount as InvoiceAmount,
  clearing_doc_amount as ClearingDocAmount,
  used_amount as UsedAmount,
  remaining_amount as RemainingAmount,
  currency as Currency,
  created_clearing_document as CreatedClearingDocument,
  clearing_company_code as ClearingCompanyCode,
  clearing_fiscal_year as ClearingFiscalYear,
  message as Message,
  status as Status,
  response_date as ResponseDate,
  response_time as ResponseTime,
  reverse as Reverse,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  local_last_changed_at as LocalLastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _DbsDenkleTirmeGNAll
}
