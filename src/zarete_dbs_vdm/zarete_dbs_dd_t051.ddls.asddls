@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ödeme Belgeleri Toplamı CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T051
  as select from ZARETE_DBS_DD_T043 as T043
{
  key T043.Customer,
  key T043.CompanyCode,
  key T043.FiscalYear,
      T043.Currency,
      @Semantics: { amount : {currencyCode: 'Currency'} }
      sum( case
           when T043.Kalan > 0 then abs( T043.Kalan )
           else T043.DocumentAmountAbs
           end ) as Odeme
}
where
          T043.AccountingDocumentType <> 'RV'
  and     T043.AccountingDocumentType <> 'DR'
  and     T043.AccountingDocumentType <> 'KT'
  and     T043.AccountingDocumentType <> 'DZ'
  and     T043.DebitCreditCode        =  'H'
  and(
          T043.AccountingDocumentType <> 'UE'
    or(
          T043.AccountingDocumentType =  'UE'
      and T043.DebitCreditCode        =  'H'
    )
  )
group by
  T043.Customer,
  T043.CompanyCode,
  T043.FiscalYear,
  T043.Currency
