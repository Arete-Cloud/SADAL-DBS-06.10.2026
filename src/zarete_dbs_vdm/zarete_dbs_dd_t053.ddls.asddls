@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Muhasebe Belgeleri Partial Kontrol'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T053
  as select from    zarete_dbs_t015    as Invoices
    left outer join zarete_dbs_t016    as Finteo             on  Finteo.invoice_number = Invoices.invoice_number
                                                             and Finteo.amount         > 0
    left outer join ZARETE_DBS_DD_T047 as AccountingDistinct on  AccountingDistinct.AccountingDocumentHeaderText = Invoices.invoice_acc_doc
                                                             and AccountingDistinct.invoice_number               = Invoices.invoice_number
                                                             and AccountingDistinct.id                           = Invoices.id
                                                             and AccountingDistinct.DocumentReferenceID          = Invoices.invoice_number
    left outer join ZARETE_DBS_DD_T052 as AccountingPartial  on AccountingPartial.DocumentReferenceID = Finteo.partial_invoice_number
{
  key Invoices.id,
  key Invoices.invoice_number,
      Finteo.partial_invoice_number,

      case
      when  $projection.partial_invoice_number is not initial then AccountingPartial.AccountingDocument
      else AccountingDistinct.AccountingDocument
      end as AccountingDocument
}
