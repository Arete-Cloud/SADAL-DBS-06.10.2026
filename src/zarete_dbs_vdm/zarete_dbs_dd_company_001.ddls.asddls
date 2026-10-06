@EndUserText.label: 'Company Code API Custom Entity'
@ObjectModel.query.implementedBy:'ABAP:ZARETE_DBS_CL_COMPANY_API'
define root custom entity ZARETE_DBS_DD_COMPANY_001
{
      @UI.lineItem      : [ {
            position    : 10 ,
            importance  : #MEDIUM,
            label       : 'CompanyCode'
            } ]

      @EndUserText.label: 'CompanyCode'
  key company_code      : abap.char( 4 );
      @UI.lineItem      : [ {
        position        : 10 ,
        importance      : #MEDIUM,
        label           : 'CompanyCodeName'
        } ]

      @EndUserText.label: 'CompanyCodeName'
      company_code_name : abap.char( 25 );
      @UI.lineItem      : [ {
      position          : 10 ,
      importance        : #MEDIUM,
      label             : 'VATRegistration'
      } ]

      @EndUserText.label: 'VATRegistration'
      vatregistration   : abap.char( 20 );

}
