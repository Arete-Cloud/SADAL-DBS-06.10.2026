@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Muhasebe Belgeleri Distinct Join'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T047
  as select from    zarete_dbs_t015    as Invoices
    left outer join ZARETE_DBS_DD_T046 as AccountingDistinct1 on  AccountingDistinct1.AccountingDocumentHeaderText = Invoices.invoice_acc_doc
                                                              and AccountingDistinct1.DocumentReferenceID          = Invoices.accounting_document
    inner join      I_JournalEntry     as JE                  on  JE.AccountingDocument = Invoices.accounting_document
                                                              and JE.ReverseDocument    is initial
{
  key  Invoices.invoice_number,
  key  Invoices.id,

       case
       when AccountingDistinct1.AccountingDocument is not initial then AccountingDistinct1.AccountingDocument
        else cast( Invoices.accounting_document as abap.char( 10 ) )
       end as AccountingDocument,

       case
        when AccountingDistinct1.AccountingDocumentHeaderText is not initial then AccountingDistinct1.AccountingDocumentHeaderText
        else Invoices.invoice_acc_doc
       end as AccountingDocumentHeaderText,

       case
       when Invoices.invoice_acc_doc is initial then Invoices.invoice_number
       else JE.DocumentReferenceID
       //       when JE.DocumentReferenceID is not initial then JE.DocumentReferenceID
       //       else Invoices.invoice_number
       end as DocumentReferenceID

}
