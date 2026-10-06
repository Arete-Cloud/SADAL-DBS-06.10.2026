@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Denkleştirme Pop Up'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T055
  as select from I_JournalEntryItem as ClearingDocs
{
      @EndUserText.label: 'Denkleştirme Belgesi'
  key ClearingDocs.AccountingDocument,
      @EndUserText.label: 'ŞK'
      ClearingDocs.CompanyCode,
      @EndUserText.label: 'Mali Yıl'
      ClearingDocs.FiscalYear,
      ClearingDocs.InvoiceReference,
      @EndUserText.label: 'Cari'
      ClearingDocs.Customer,
      @EndUserText.label: 'Para Birimi'
      ClearingDocs.TransactionCurrency                 as Currency,
      @Semantics: { amount : {currencyCode: 'Currency'} }
      @EndUserText.label: 'Tutar'
      abs(  ClearingDocs.AmountInTransactionCurrency ) as Amount
}
where
      ClearingDocs.Customer               is not initial
  and ClearingDocs.AccountingDocumentType = 'DZ'
  and ClearingDocs.InvoiceReference       is not initial
  and ClearingDocs.IsReversed             is initial
