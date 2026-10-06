@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Denkleştirme Belgeleri CDS'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZARETE_DBS_DD_T034
  as select from I_OperationalAcctgDocItem as ClearingDocs
    inner join   ZARETE_DBS_DD_T044        as ClearingControl on ClearingControl.AccountingDocument = ClearingDocs.ClearingJournalEntry
{
  key ClearingDocs.ClearingJournalEntry                as ClearingDocument,
  key ClearingDocs.CompanyCode                         as CompanyCode,
  key ClearingDocs.ClearingJournalEntryFiscalYear      as FiscalYear,
      ClearingDocs.AccountingDocument                  as AccountingDocument,
      ClearingDocs.AccountingDocumentItem              as AccountingDocumentItem,
      ClearingDocs.Customer                            as Customer,
      ClearingDocs.TransactionCurrency                 as Currency,
      @Semantics: { amount : {currencyCode: 'Currency'} }
      abs(  ClearingDocs.AmountInTransactionCurrency ) as Amount

}
where
  ClearingDocs.Customer is not initial
