@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Denkleştirmeye Uygun Belgeler CDS'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T033
  as select from zarete_dbs_t022
{

  key company_code               as CompanyCode,
  key fiscal_year                as FiscalYear,
  key accounting_document        as AccountingDocument,
  key accounting_document_item   as AccountingDocumentItem,
      customer                   as Customer,
      customer_name              as CustomerName,
      posting_date               as PostingDate,
      document_date              as DocumentDate,
      net_due_date               as NetDueDate,
      accounting_document_type   as AccountingDocumentType,
      amount_in_transaction_curr as AmountInTransactionCurr,
      transaction_currency       as TransactionCurrency,
      used_amount                as UsedAmount,
      available_amount           as AvailableAmount,
      message                    as Message,
      reverse                    as Reverse,
      @Semantics.user.createdBy: true
      created_by                 as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                 as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at            as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by      as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at      as LocalLastChangedAt
}
where
  reverse is initial
