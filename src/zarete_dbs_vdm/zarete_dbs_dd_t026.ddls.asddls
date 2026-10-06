@EndUserText.label: 'DBS Muh Belgesi Yaratma Custom CDS'
define root custom entity ZARETE_DBS_DD_T026
{
      @UI.facet           : [
        {
          id              : 'Main',
          purpose         : #STANDARD,
          type            : #IDENTIFICATION_REFERENCE,
          label           : 'Muhasebeleştir',
          position        : 10
        }
      ]
      @UI.lineItem        : [ { importance : #MEDIUM } ]
      @UI.identification  : [ { position : 20 , label : 'Fatura Numarası' } ]
      @EndUserText.label  : 'Fatura Numarası'
  key invoice_number      : abap.char(16);
      @UI.lineItem        : [ { importance : #MEDIUM } ]
      @UI.identification  : [ { position : 30 , label : 'ID' } ]
      @EndUserText.label  : 'ID'
      id                  : abap.numc(7);
      @UI.lineItem        : [ { importance : #MEDIUM } ]
      @UI.identification  : [ { position : 40 , label : 'FI Belgesi' } ]
      @EndUserText.label  : 'FI Belgesi'
      accounting_document : abap.char(10);
}
