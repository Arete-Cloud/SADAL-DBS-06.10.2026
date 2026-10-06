@EndUserText.label: 'Document Read API Custom Entity'
@ObjectModel.query.implementedBy:'ABAP:ZARETE_DBS_CL_DOC_READ_API'
define root custom entity ZARETE_DBS_DD_DOC_READ_001
{

      @UI.lineItem               : [ { position          : 10, importance        : #MEDIUM, label             : 'Şirket Kodu' } ]
      @EndUserText.label         : 'Şirket Kodu'
  key company_code               : abap.char( 4 );
      @UI.lineItem               : [ { position          : 20, importance        : #MEDIUM, label             : 'Mali Yıl' } ]
      @EndUserText.label         : 'Mali Yıl'
  key fiscal_year                : abap.char( 4 );
      @UI.lineItem               : [ { position          : 30, importance        : #MEDIUM, label             : 'Belge No' } ]
      @EndUserText.label         : 'Belge No'
  key accounting_document        : abap.char( 10 );
      @UI.lineItem               : [ { position          : 40, importance        : #MEDIUM, label             : 'Belge Kalemi' } ]
      @EndUserText.label         : 'Belge Kalemi'
  key accounting_document_item   : abap.char( 3 );
      @UI.lineItem               : [ { position          : 130, importance        : #MEDIUM, label             : 'Belge Türü' } ]
      @EndUserText.label         : 'Belge Türü'
  key accounting_document_type   : abap.char( 2 );
      @UI.lineItem               : [ { position          : 50, importance        : #MEDIUM, label             : 'B/A Göstergesi' } ]
      @EndUserText.label         : 'B/A Göstergesi'
      debit_credit_code          : abap.char( 1 );
      @UI.lineItem               : [ { position          : 60, importance        : #MEDIUM, label             : 'Açıklama' } ]
      @EndUserText.label         : 'Açıklama'
      document_item_text         : abap.char( 50 );
      @UI.lineItem               : [ { position          : 70, importance        : #MEDIUM, label             : 'Müşteri' } ]
      @EndUserText.label         : 'Müşteri'
      customer                   : abap.char( 10 );
      @UI.lineItem               : [ { position          : 80, importance        : #MEDIUM, label             : 'Kayıt Tarihi' } ]
      @EndUserText.label         : 'Kayıt Tarihi'
      posting_date               : abap.dats;
      @UI.lineItem               : [ { position          : 90, importance        : #MEDIUM, label             : 'Belge Tarihi' } ]
      @EndUserText.label         : 'Belge Tarihi'
      document_date              : abap.dats;
      @UI.lineItem               : [ { position          : 100, importance        : #MEDIUM, label             : 'Vade Tarihi' } ]
      @EndUserText.label         : 'Vade Tarihi'
      net_due_date               : abap.dats;
      @UI.lineItem               : [ { position          : 110, importance        : #MEDIUM, label             : 'Valör Tarihi' } ]
      @EndUserText.label         : 'Valör Tarihi'
      value_date                 : abap.dats;
      @UI.lineItem               : [ { position          : 120, importance        : #MEDIUM, label             : 'Ana Banka' } ]
      @EndUserText.label         : 'Ana Banka'
      house_bank                 : abap.char( 5 );
      @UI.lineItem               : [ { position          : 140, importance        : #MEDIUM, label             : 'İşlem Tutarı' } ]
      @EndUserText.label         : 'İşlem Tutarı'
      amount_in_transaction_curr : abap.dec(13,2);
      @UI.lineItem               : [ { position          : 150, importance        : #MEDIUM, label             : 'PB' } ]
      @EndUserText.label         : 'PB'
      transaction_currency       : abap.char( 3 );
      @UI.lineItem               : [ { position          : 160, importance        : #MEDIUM, label             : 'Referans Fatura No' } ]
      @EndUserText.label         : 'Referans Fatura No'
      document_reference_id      : abap.char( 20 );
      @UI.lineItem               : [ { position          : 170, importance        : #MEDIUM, label             : 'Tayin' } ]
      @EndUserText.label         : 'Tayin'
      assignment_reference       : abap.char( 10 );
      @UI.lineItem               : [ { position          : 180, importance        : #MEDIUM, label             : 'Müşteri Adı' } ]
      @EndUserText.label         : 'Müşteri Adı'
      customer_name              : abap.char( 80 );
      @UI.lineItem               : [ { position          : 190, importance        : #MEDIUM, label             : 'Denkl.Belge No' } ]
      @EndUserText.label         : 'Denkl.Belge No'
      clearing_accounting_docume : abap.char( 10 );
      @UI.lineItem               : [ { position          : 200, importance        : #MEDIUM, label             : 'Denkl.Mali Yıl' } ]
      @EndUserText.label         : 'Denkl.Mali Yıl'
      clearing_doc_fiscal_year   : abap.char( 4 );
      @UI.lineItem               : [ { position          : 210, importance        : #MEDIUM, label             : 'Cleared' } ]
      @EndUserText.label         : 'Cleared'
      is_cleared                 : abap.char( 1 );
      @UI.lineItem               : [ { position          : 220, importance        : #MEDIUM, label             : 'Reversed' } ]
      @EndUserText.label         : 'Reversed'
      is_reversed                : abap.char( 1 );
      @UI.lineItem               : [ { position          : 230, importance        : #MEDIUM, label             : 'Ledger' } ]
      @EndUserText.label         : 'Ledger'
      ledger                     : abap.char( 2 );

}
