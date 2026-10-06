@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Denkleştirme Belge Numarası'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T044
  as select distinct from I_OperationalAcctgDocItem as Denk
    inner join            I_OperationalAcctgDocItem as TK on  TK.AccountingDocument     =  Denk.ClearingJournalEntry
                                                          and TK.AccountingDocumentType != 'TK'
{
  key Denk.AccountingDocument
}
