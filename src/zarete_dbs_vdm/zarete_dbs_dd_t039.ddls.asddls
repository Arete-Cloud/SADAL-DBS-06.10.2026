@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maksimum Zaman'
define view entity ZARETE_DBS_DD_T039
  as select from ZARETE_DBS_DD_T038
{
  key invoice_number,
  key id,
      invoice_acc_doc,
      invoice_acc_doc_item,
      max( response_datetime )         as max_datetime,
      max( created_clearing_document ) as clearing_document
}
group by
  invoice_number,
  id,
  invoice_acc_doc,
  invoice_acc_doc_item
