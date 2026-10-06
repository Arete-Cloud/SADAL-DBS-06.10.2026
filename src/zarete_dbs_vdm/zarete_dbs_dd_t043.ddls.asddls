@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Müşteri Belgeleri Tutarlar'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T043
  as select from    I_OperationalAcctgDocItem as item
    left outer join ZARETE_DBS_DD_T042        as T042 on  T042.InvoiceReference           = item.AccountingDocument
                                                      and T042.InvoiceReferenceFiscalYear = item.FiscalYear
    inner join      ZARETE_DBS_DD_T041        as T041 on  T041.CompanyCode            = item.CompanyCode
                                                      and T041.AccountingDocument     = item.AccountingDocument
                                                      and T041.AccountingDocument     = item.AccountingDocument
                                                      and T041.AccountingDocumentType = item.AccountingDocumentType
{
  key            T041.CompanyCode,
  key            item.AccountingDocument,
  key            item.FiscalYear,
  key            item.AccountingDocumentItem,
                 T041.Customer,
                 item.ClearingJournalEntryFiscalYear,
                 item.AssignmentReference,
                 item.DocumentDate,
                 item.AccountingDocumentType,
                 item.FinancialAccountType,
                 item.DebitCreditCode,
                 item._JournalEntry.DocumentReferenceID,
                 item.ClearingJournalEntry,
                 @Semantics: { amount : {currencyCode: 'Currency'} }
                 item.AmountInTransactionCurrency        as DocumentAmount,
                 @Semantics: { amount : {currencyCode: 'Currency'} }
                 item.AmountInTransactionCurrency        as OriginalAmount,
                 @Semantics: { amount : {currencyCode: 'Currency'} }
                 abs( item.AmountInTransactionCurrency ) as DocumentAmountAbs,
                 item.TransactionCurrency                as Currency,
                 @Semantics: { amount : {currencyCode: 'Currency'} }
                 T042.Amount                             as Kalan,
                 item.InvoiceReference,
                 item.InvoiceReferenceFiscalYear,
                 ' '                                     as Changed,

                 case
                  when item.AccountingDocumentType <> 'DZ' and item.DebitCreditCode = 'H'
                   then 'Ödeme'
                  when item.AccountingDocumentType = 'DZ' and item.DebitCreditCode = 'H'
                   then 'Fatura - Kalan'
                  when item.AccountingDocumentType = 'DZ' and item.DebitCreditCode = 'S'
                   then 'Ödeme - Kalan'
                  else ''
                 end                                     as text


}
where
      item.FinancialAccountType           = 'D'
  and item.ClearingJournalEntryFiscalYear = '0000'
//  and item.AccountingDocumentType         != 'UE'
