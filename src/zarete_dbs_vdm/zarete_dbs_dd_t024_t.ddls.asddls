@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Kayıtları Fatura Tekilleştirmesi'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZARETE_DBS_DD_T024_T
  as select distinct from ZARETE_DBS_DD_T024_G
    inner join            ZARETE_DBS_DD_T024_S    on  ZARETE_DBS_DD_T024_S.max_timestamp  = ZARETE_DBS_DD_T024_G.max_timestamp
                                                  and ZARETE_DBS_DD_T024_S.invoice_number = ZARETE_DBS_DD_T024_G.invoice_number
    inner join            zarete_dbs_t024 as t024 on ZARETE_DBS_DD_T024_S.uuid = t024.uuid
{
  key ZARETE_DBS_DD_T024_S.uuid,
      ZARETE_DBS_DD_T024_G.invoice_number,
      ZARETE_DBS_DD_T024_G.max_timestamp,
      //  t024.accounting_document,
      //  t024.accounting_document_item,
      //  t024.item_uuid,
      //  t024.id,
      //  t024.customer,
      //  t024.invoice_amount,
      //  t024.clearing_doc_amount,
      //  t024.used_amount,
      //  t024.remaining_amount,
      //  t024.currency,
      //  t024.created_clearing_document,
      //  t024.clearing_company_code,
      //  t024.clearing_fiscal_year,
      t024.message,
      t024.status,
      t024.response_date,
      t024.response_time,
      t024.reverse

}
