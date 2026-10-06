@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Kayıtları Fatura Tekilleştirmesi'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T024_S
  as select from zarete_dbs_t024
{
  uuid,
  invoice_number,
  concat( cast( response_date as abap.char( 8 ) ), cast( response_time as abap.char( 6 ) ) ) as max_timestamp
}

group by
  uuid,
  invoice_number,
  response_date,
  response_time
