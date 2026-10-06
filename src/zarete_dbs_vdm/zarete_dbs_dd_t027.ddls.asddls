@EndUserText.label: 'DBS Fatura Seçilen Satırlar Header'
@UI.headerInfo: {
    typeName: 'DBS',
    typeNamePlural: 'DBS',
    title: {
        type: #STANDARD,
        value: 'request_time'
    },
    description: {
        type: #STANDARD,
        value: 'request_time'
    }
}
@ObjectModel.query.implementedBy: 'ABAP:ZARETE_DBS_CL_CUST_EN_API_CALL'
define root custom entity ZARETE_DBS_DD_T027
{
      @UI.facet    : [
      { id         :'idSAP' ,
                 type            : #COLLECTION ,
                 label           : 'DBS' ,
                 position        : 10 } ,

                  { type         : #IDENTIFICATION_REFERENCE ,
                 label           : 'DBS',
                 parentId        : 'idSAP',
                 id: 'idSAPKayit' ,
                 position        : 10 },
      {
          id       : 'Item-ID',
          purpose  : #STANDARD,
          position : 20,
          label    : 'Faturalar',
          type     :  #LINEITEM_REFERENCE,
          targetElement          : '_invoices'
      }]

      @UI.lineItem : [ { importance : #MEDIUM } ]
      @UI.identification: [ {
      position     : 10 ,
      label        : 'İstek Zamanı'
      } ]
      @EndUserText.label   : 'İstek Zamanı'
  key request_time : timestamp;
  key action_code  : abap.char(1);
      @ObjectModel.filter.enabled: false
      _invoices    : composition [0..*] of ZARETE_DBS_DD_T024;

}
