@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Denkleştirme T024 CDS Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T054
  as select from zarete_dbs_t024
{
  key invoice_number,
      max( created_clearing_document ) as clearing_document
}
where
  status = 'S'
group by
  invoice_number
