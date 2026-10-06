@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Muhasebe Belgeleri Distinct'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T046
  as select from I_JournalEntry
{
  key cast( AccountingDocument as abap.char( 10 ) ) as AccountingDocument,
      AccountingDocumentHeaderText ,
      DocumentReferenceID 
}
where
      AccountingDocumentType       = 'ZA'
  and ReverseDocument              is initial
  and AccountingDocumentHeaderText is not initial
