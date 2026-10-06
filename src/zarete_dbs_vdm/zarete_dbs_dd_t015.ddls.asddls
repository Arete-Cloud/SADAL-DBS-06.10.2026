@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fatura Listesi'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_DD_T015
  as select from zarete_dbs_t015
{
  key uuid                  as Uuid,
  key invoice_number        as InvoiceNumber,
  key id                    as Id,
      invoice_acc_doc       as InvoiceAccDoc,
      invoice_acc_doc_item  as InvoiceAccDocItem,
      dbs_invoice_id        as DbsInvoiceId,
      scenario_type         as ScenarioType,
      statu                 as Statu,
      accounting_document   as AccountingDocument,
      clearing_document     as ClearingDocument,
      company_code          as CompanyCode,
      fiscal_year           as FiscalYear,
      transaction_date      as TransactionDate,
      due_date              as DueDate,
      amount                as Amount,
      fi_account            as FiAccount,
      dbs_account_id        as DbsAccountId,
      is_cancelled          as IsCancelled,
      acc_error             as AccError,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
