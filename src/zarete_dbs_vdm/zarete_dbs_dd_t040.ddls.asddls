@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Denkleştirme Güncel Durumu'
define root view entity ZARETE_DBS_DD_T040
  as select from ZARETE_DBS_DD_T039 as MaxKayit
    inner join   ZARETE_DBS_DD_T038 as Tablo on  MaxKayit.invoice_number       = Tablo.invoice_number
                                             and MaxKayit.id                   = Tablo.id
                                             and MaxKayit.max_datetime         = Tablo.response_datetime
                                             and MaxKayit.invoice_acc_doc      = Tablo.invoice_acc_doc
                                             and MaxKayit.invoice_acc_doc_item = Tablo.invoice_acc_doc_item
{
  key MaxKayit.invoice_number,
  key MaxKayit.id,
      Tablo.message,
      Tablo.status,
      MaxKayit.clearing_document,
      MaxKayit.invoice_acc_doc,
      MaxKayit.invoice_acc_doc_item
}
