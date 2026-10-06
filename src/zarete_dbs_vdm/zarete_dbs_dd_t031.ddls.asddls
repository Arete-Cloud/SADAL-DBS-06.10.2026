@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Oluşan Belgeler SH'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZARETE_DBS_DD_T031
  as select from zarete_dbs_t020    as AccDocs
    inner join   ZARETE_DBS_DD_T044 as AccountingControl on AccountingControl.AccountingDocument = AccDocs.accounting_document
{
  key AccDocs.accounting_document   as AccountingDocument,
  key AccDocs.company_code          as CompanyCode,
  key AccDocs.fiscal_year           as FiscalYear,
      AccDocs.invoice_number        as InvoiceNumber,
      AccDocs.id                    as Id,
      AccDocs.customer              as Customer,
      @Semantics.user.createdBy: true
      AccDocs.created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      AccDocs.created_at            as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      AccDocs.last_changed_at       as LastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      AccDocs.local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      AccDocs.local_last_changed_at as LocalLastChangedAt
}
