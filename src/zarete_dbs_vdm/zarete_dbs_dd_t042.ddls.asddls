@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Açık Kalemler'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T042
  as select from    I_OperationalAcctgDocItem as denk
    left outer join I_OperationalAcctgDocItem as invoice on  invoice.AccountingDocument = denk.InvoiceReference
                                                         and invoice.FiscalYear         = denk.InvoiceReferenceFiscalYear
                                                         and invoice.Customer           = denk.Customer
                                                         and invoice.DebitCreditCode    = 'S'

    left outer join I_OperationalAcctgDocItem as Payment on  Payment.AccountingDocument = denk.InvoiceReference
                                                         and Payment.FiscalYear         = denk.InvoiceReferenceFiscalYear
                                                         and Payment.Customer           = denk.Customer
                                                         and Payment.DebitCreditCode    = 'H'

{
  key denk.InvoiceReference,
  key denk.InvoiceReferenceFiscalYear,
      denk.TransactionCurrency,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }

      case
       when invoice.AccountingDocument is not initial
        then invoice.AmountInTransactionCurrency - abs( sum( denk.AmountInTransactionCurrency ) )
       when Payment.AccountingDocument is not initial
        then ( Payment.AmountInTransactionCurrency + abs( sum( denk.AmountInTransactionCurrency ) ) ) * -1
        end as Amount,

      denk.Customer
}
where
      denk.InvoiceReference     is not initial
  and denk.Customer             is not initial
  and denk.ClearingCreationDate is initial
group by
  invoice.AccountingDocument,
  Payment.AccountingDocument,
  denk.TransactionCurrency,
  denk.Customer,
  denk.InvoiceReferenceFiscalYear,
  denk.CompanyCode,
  denk.InvoiceReference,
  invoice.AmountInTransactionCurrency,
  Payment.AmountInTransactionCurrency
