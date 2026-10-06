@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Fatura Ekranı Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZARETE_DBS_PV_INVOICE_001
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_INVOICE_001
{
  key Id,
  key InvoiceNumber,
  key DbsInvoiceId,
  key PartialInvoiceNumber,
      AccountingDocument,
      InvoiceAccountingDocument,
      Customer,
      CustomerName,
      FiscalYear,
      DocumentDate,
      PostingDate,
      DueDate,
      Amount,
      @UI.hidden: true
      Currency,
      DocumentText,
      HouseBank,
      SendAmount,
      RemainingAmount,
      FinteoStatusCodeText,
      FinteoStatusDescText,
      SapStatusCodeText,
      ShowLog,
      Clearing
}
