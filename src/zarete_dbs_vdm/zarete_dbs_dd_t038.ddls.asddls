@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tarih Saat Birleştirme'
define view entity ZARETE_DBS_DD_T038
  as select distinct from zarete_dbs_t024
{
  key invoice_number,
  key id,
      message,
      status,
      concat( response_date , response_time ) as response_datetime,
      created_clearing_document,
      invoice_acc_doc,
      invoice_acc_doc_item
}
