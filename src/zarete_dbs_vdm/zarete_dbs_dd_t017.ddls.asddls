@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SAPden Gelen Faturalar'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_DD_T017
  as select from zarete_dbs_t017
{
  key company_code               as CompanyCode,
  key fiscal_year                as FiscalYear,
  key accounting_document        as AccountingDocument,
  key accounting_document_item   as AccountingDocumentItem,
  key document_reference_id      as DocumentReferenceId,
      debit_credit_code          as DebitCreditCode,
      document_item_text         as DocumentItemText,
      customer                   as Customer,
      customer_name              as CustomerName,
      posting_date               as PostingDate,
      document_date              as DocumentDate,
      net_due_date               as NetDueDate,
      value_date                 as ValueDate,
      house_bank                 as HouseBank,
      accounting_document_type   as AccountingDocumentType,
      amount_in_transaction_curr as AmountInTransactionCurr,
      transaction_currency       as TransactionCurrency,
      assignment_reference       as AssignmentReference,
      clearing_accounting_docume as ClearingAccountingDocume,
      clearing_doc_fiscal_year   as ClearingDocFiscalYear,
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
