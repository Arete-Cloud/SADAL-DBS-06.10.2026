@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS Fatura için Denkl. Tutar Toplama CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T036
  as select from zarete_dbs_t024
{
  invoice_number,
  customer,
  sum( used_amount ) as used_amount
}
where
  reverse is initial and status = 'S'
group by
  invoice_number,
  customer
