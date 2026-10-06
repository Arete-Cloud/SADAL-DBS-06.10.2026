@EndUserText.label: 'Finteo Limit Apisi Alanları'
@ObjectModel.query.implementedBy:'ABAP:ZARETE_DBS_CL_FINTEO_LMT'
@Metadata.allowExtensions: true
define root custom entity ZARETE_DBS_DD_FINTEO_LMT_001
{

      @UI                    : {
         selectionField      :[{position:10}],
        lineItem             :[
         {position           :10,type:#FOR_ACTION ,dataAction:'Musteri_Ekle',label:'Müşteri Ekle',invocationGrouping:#CHANGE_SET}
         ] }

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'VKN'
  key identifier             : abap.sstring( 11 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'Limit ID'
  key limitid                : abap.int4;

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'İlgili VKN'
  key partyTaxNumber         : abap.sstring( 11 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'Müşteri VKN'
  key bpTaxNumber            : abap.char( 11 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'Banka Kodu'
      @Consumption.valueHelpDefinition: [{ entity: {name: 'ZARETE_DBS_DD_T019', element: 'BankCode'}}] //,
      //      additionalBinding: [{ localElement: 'bankName', element: 'BankName' }] }]
  key bankCode               : abap.char( 4 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'Banka'
  key bankName               : abap.sstring( 100 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'Müşteri No'
      //      @Consumption.valueHelpDefinition: [{ entity: {name: 'ZARETE_DBS_DD_T018', element: 'BusinessPartner'} }]
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZARETE_DBS_DD_BP_001', element: 'business_partner' } }]
      bpNo                   : abap.char( 11 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'Müşteri Adı'
      bpName                 : abap.sstring( 100 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'İlgili Adı'
      partyTitle             : abap.sstring( 100 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
      @EndUserText.label     : 'İlgili Kişi'
      partyCode              : abap.sstring( 50 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
//      @Semantics.amount.currencyCode: 'currencyCode'
      @EndUserText.label     : 'Toplam Limit'
      limit                  : abap.dec( 15, 2 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
//      @Semantics.amount.currencyCode: 'currencyCode'
      @EndUserText.label     : 'Kalan Limit'
      activeLimit            : abap.dec( 15, 2 );

      @UI.lineItem           : [ { importance : #MEDIUM } ]
//      @Semantics.amount.currencyCode: 'currencyCode'
      @EndUserText.label     : 'Kullanılan Limit'
      usedLimit              : abap.dec( 15, 2 );

      @UI.lineItem           : [ {importance : #MEDIUM} ]
//      @Semantics.amount.currencyCode: 'currencyCode'
      @EndUserText.label     : 'Bekleyen Fatura Tutarı'
      pendingInvoiceAmount   : abap.dec( 15, 2 );

      @UI.lineItem           : [ {importance : #MEDIUM} ]
//      @Semantics.amount.currencyCode: 'currencyCode'
      @EndUserText.label     : 'Garantili Fatura Tutarı'
      guarantedInvoiceAmount : abap.dec( 15, 2 );

      @UI.lineItem           : [ {importance : #MEDIUM} ]
      @EndUserText.label     : 'Aktif'
      isActive               : abap.sstring(1);

      @UI.lineItem           : [ {importance : #MEDIUM} ]
      @EndUserText.label     : 'PB'
      currencyCode           : abap.cuky(5);

      @UI.lineItem           : [ {importance : #MEDIUM} ]
      @EndUserText.label     : 'IBAN'
      linkedIban             : abap.sstring( 34 );

      @UI.lineItem           : [ {importance : #MEDIUM} ]
//      @Semantics.amount.currencyCode: 'currencyCode'
      @EndUserText.label     : 'Nakdi Risk'
      fundedExposure         : abap.dec( 15, 2 );

      @UI.lineItem           : [ {importance : #MEDIUM} ]
      @EndUserText.label     : 'Limit Log'
      showLog                : abap.char( 20 );

}
