@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fatura Listesi Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZARETE_DBS_PV_T015
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T015
{
  key Uuid,
  key InvoiceNumber,
  key Id,
      DbsInvoiceId,
      ScenarioType,
      Statu,
      AccountingDocument,
      CompanyCode,
      FiscalYear,
      TransactionDate,
      FiAccount,
      DbsAccountId

}
