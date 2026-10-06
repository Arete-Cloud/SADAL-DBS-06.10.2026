@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SAPden Gelen Faturalar Projection View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_PV_T017
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T017
{
  key CompanyCode,
  key FiscalYear,
  key AccountingDocument,
  key AccountingDocumentItem,
  key DocumentReferenceId,
      DebitCreditCode,
      DocumentItemText,
      Customer,
      CustomerName,
      PostingDate,
      DocumentDate,
      NetDueDate,
      ValueDate,
      HouseBank,
      AccountingDocumentType,
      AmountInTransactionCurr,
      TransactionCurrency,
      AssignmentReference,
      ClearingAccountingDocume,
      ClearingDocFiscalYear
}
