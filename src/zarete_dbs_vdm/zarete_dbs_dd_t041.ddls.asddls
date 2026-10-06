@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Müşteri Belgeleri'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T041
  as select from I_OperationalAcctgDocItem
{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      AccountingDocumentType,
      Customer
}
where
  Customer is not initial
group by
  Customer,
  AccountingDocumentType,
  CompanyCode,
  AccountingDocument,
  FiscalYear
