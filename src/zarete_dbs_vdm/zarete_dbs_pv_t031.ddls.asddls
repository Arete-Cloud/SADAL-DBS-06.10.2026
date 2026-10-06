@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Oluşan Belgeler SH Projection View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_PV_T031
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T031

{
  key AccountingDocument,
  key CompanyCode,
  key FiscalYear,
      InvoiceNumber,
      Id,
      Customer
}
