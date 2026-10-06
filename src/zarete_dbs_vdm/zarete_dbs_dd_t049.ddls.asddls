@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clearing'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T049
  as select from ZARETE_DBS_DD_T043
{
  key max( AccountingDocument ) as AccountingDocument,
      @Semantics: { amount : {currencyCode: 'Currency'} }
      sum( Kalan )              as Kalan,
      @Semantics: { amount : {currencyCode: 'Currency'} }
      sum( DocumentAmountAbs )  as DocumentAmountAbs,
      Currency,
      InvoiceReference,
      InvoiceReferenceFiscalYear
}
group by
  Currency,
  InvoiceReference,
  InvoiceReferenceFiscalYear
