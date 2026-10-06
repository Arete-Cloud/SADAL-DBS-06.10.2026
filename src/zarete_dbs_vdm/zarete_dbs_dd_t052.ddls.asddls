@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Muhasebe Belgeleri Distinct Join 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T052
  as select from zarete_dbs_t016    as partial
    inner join   ZARETE_DBS_DD_T046 as AccountingDistinct on AccountingDistinct.DocumentReferenceID = partial.partial_invoice_number
    inner join   I_JournalEntry     as JE                 on  JE.AccountingDocument = AccountingDistinct.AccountingDocument
                                                          and JE.ReverseDocument    is initial
{
  key AccountingDistinct.AccountingDocument,
      AccountingDistinct.AccountingDocumentHeaderText,
      AccountingDistinct.DocumentReferenceID
}
where
      partial.partial_invoice_number is not initial
  and partial.amount                 <> 0
