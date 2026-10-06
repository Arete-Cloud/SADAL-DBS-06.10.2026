@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Denkleştirme Belgeleri Distinct'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T045
  as select distinct from ZARETE_DBS_DD_T034
{
  key max( cast( ClearingDocument as belnr_d preserving type ) ) as ClearingDocument,
      @Semantics: { amount : {currencyCode: 'Currency'} }
      sum( Amount )                                              as Amount,
      Currency,
      AccountingDocument,
      AccountingDocumentItem,
      FiscalYear
}
group by
  AccountingDocument,
  AccountingDocumentItem,
  FiscalYear,
  Currency
