@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Kayıtları Fatura Tekilleştirmesi'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T024_G
  as select from ZARETE_DBS_DD_T024_S
{
  invoice_number,
  max( max_timestamp ) as max_timestamp
}
group by
  invoice_number
