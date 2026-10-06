@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Denkleştirme Belgeleri PV'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_PV_T034
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T034

{
  key ClearingDocument,
  key CompanyCode,
  key FiscalYear,
      AccountingDocument,
      AccountingDocumentItem,
      Customer

}
