@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clearing Sum'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T050
  as select from I_OperationalAcctgDocItem as item
{
  key item.ClearingJournalEntry,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      sum( item.AmountInTransactionCurrency ) as AmountInTransactionCurrency,
      item.TransactionCurrency

}
where
      item.DebitCreditCode        = 'S'
  and item.AccountingDocumentType = 'DZ'
  and item.AccountingDocument != item.ClearingJournalEntry
group by
  item.ClearingJournalEntry,
  item.TransactionCurrency
