@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Fatura Bazında Toplam Tutar Aggregation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZARETE_DBS_DD_T030
  as select from zarete_dbs_t016
{
  invoice_number,
  sum( amount ) as total_amount
}
group by
  invoice_number
