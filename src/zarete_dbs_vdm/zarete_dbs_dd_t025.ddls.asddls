@EndUserText.label: 'DBS Fatura Silme Custom CDS'
define root custom entity ZARETE_DBS_DD_T025
{
      @UI.facet      : [
        {
          id         : 'Main',
          purpose    : #STANDARD,
          type       : #IDENTIFICATION_REFERENCE,
          label      : 'Fatura Silme',
          position   : 10
        }
      ]
      @UI.lineItem   : [ { importance : #MEDIUM } ]
      @UI.identification: [ { position : 20 , label : 'Fatura Numarası' } ]
      @EndUserText.label   : 'Fatura Numarası'
  key invoice_number : abap.char(16);
      @UI.lineItem   : [ { importance : #MEDIUM } ]
      @UI.identification: [ { position : 30 , label : 'ID' } ]
      @EndUserText.label   : 'ID'
      id             : abap.numc(7);
      @UI.lineItem   : [ { importance : #MEDIUM } ]
      @UI.identification: [ { position : 40 , label : 'DBS Fatura ID' } ]
      @EndUserText.label   : 'DBS Fatura ID'
      dbs_invoice_id : abap.char(50);
      @UI.lineItem   : [ { importance : #MEDIUM } ]
      @UI.identification: [ { position : 50 , label : 'Durum' } ]
      @EndUserText.label   : 'Durum'
      status         : abap.char(10);
      @UI.lineItem   : [ { importance : #MEDIUM } ]
      @UI.identification: [ { position : 60 , label : 'Durum Açıklaması' } ]
      @EndUserText.label   : 'Durum Açıklaması'
      status_message : abap.char(16);
}
