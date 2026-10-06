@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Clering Document CDS'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_DD_T048

  // ---------------------------------------------------------------------
  // 1. DAL - STANDART (JournalEntry / T045) - EN YUKSEK ONCELIK
  //    invoice_acc_doc'a gore eslesen bir standart denklestirme kaydi varsa
  //    bu dal kullanilir.
  // ---------------------------------------------------------------------
  as select distinct from zarete_dbs_t015    as Invoices
    inner join            ZARETE_DBS_DD_T045 as Clearing_standart on  Clearing_standart.AccountingDocument     = lpad(
      Invoices.invoice_acc_doc, 10, '0'
    )
                                                                  and Clearing_standart.AccountingDocumentItem = Invoices.invoice_acc_doc_item
{
  key Invoices.invoice_acc_doc                              as AccountingDocument,
  key Invoices.invoice_acc_doc_item                         as AccountingDocumentItem,
      Invoices.invoice_number                               as InvoiceNumber,
      Clearing_standart.ClearingDocument                    as ClearingDocument_Std,
      Clearing_standart.ClearingDocument                    as ClearingDocument,
      cast( '' as abap.cuky( 5 ) )                          as Currency,

      @Semantics.amount.currencyCode: 'Currency'
      cast( Clearing_standart.Amount as abap.dec( 15, 2 ) ) as UsedAmountForClearing
}

union all

// ---------------------------------------------------------------------
// 2. DAL - KISMI / LOCAL (T049) - Standart'ta kayit YOKSA kullanilir
// ---------------------------------------------------------------------
select distinct from zarete_dbs_t015    as Invoices
  inner join         ZARETE_DBS_DD_T049 as Clearing_local on Clearing_local.InvoiceReference = lpad(
    Invoices.invoice_acc_doc, 10, '0'
  )
//  left outer join    ZARETE_DBS_DD_T045 as Std_check      on  Invoices.invoice_acc_doc         is not initial
//                                                          and Std_check.AccountingDocument     = lpad(
//    Invoices.invoice_acc_doc, 10, '0'
//  )
//                                                          and Std_check.AccountingDocumentItem = Invoices.invoice_acc_doc_item
{
  key Invoices.invoice_acc_doc                                     as AccountingDocument,
  key Invoices.invoice_acc_doc_item                                as AccountingDocumentItem,
      Invoices.invoice_number                                      as InvoiceNumber,
      cast( Clearing_local.AccountingDocument as abap.char( 10 ) ) as ClearingDocument_Std,
      Clearing_local.AccountingDocument                            as ClearingDocument,
      Clearing_local.Currency                                      as Currency,

      case
        when Clearing_local.Kalan is not initial then cast( Clearing_local.Kalan as abap.dec( 15, 2 ) )
        else cast( Clearing_local.DocumentAmountAbs as abap.dec( 15, 2 ) )
      end                                                          as UsedAmountForClearing
}
//where
//  Std_check.AccountingDocument is initial

union all

// ---------------------------------------------------------------------
// 3. DAL - TAKIP / ZLI (T054) - Standart'ta VE Local'de kayit YOKSA kullanilir.
//    invoice_number uzerinden eslestigi icin invoice_acc_doc bos olan
//    (eski/UE) faturalar icin de calisir.
// ---------------------------------------------------------------------
select distinct from zarete_dbs_t015    as Invoices
  inner join         ZARETE_DBS_DD_T054 as Clearing_takip on Clearing_takip.invoice_number = Invoices.invoice_number
  left outer join    ZARETE_DBS_DD_T045 as Std_check      on  Invoices.invoice_acc_doc         is not initial
                                                          and Std_check.AccountingDocument     = lpad(
    Invoices.invoice_acc_doc, 10, '0'
  )
                                                          and Std_check.AccountingDocumentItem = Invoices.invoice_acc_doc_item
  left outer join    ZARETE_DBS_DD_T049 as Local_check    on  Invoices.invoice_acc_doc     is not initial
                                                          and Local_check.InvoiceReference = lpad(
    Invoices.invoice_acc_doc, 10, '0'
  )
{
  key Invoices.invoice_acc_doc                                    as AccountingDocument,
  key Invoices.invoice_acc_doc_item                               as AccountingDocumentItem,
      Invoices.invoice_number                                     as InvoiceNumber,
      cast( Clearing_takip.clearing_document as abap.char( 10 ) ) as ClearingDocument_Std,
      Clearing_takip.clearing_document                            as ClearingDocument,
      cast( '' as abap.cuky( 5 ) )                                as Currency,

      cast( 0 as abap.dec( 15, 2 ) )                              as UsedAmountForClearing
}
where
//      Clearing_takip.clearing_document is not initial
//  and Std_check.AccountingDocument     is initial
//  and Local_check.InvoiceReference     is initial
    Invoices.invoice_acc_doc         is initial
