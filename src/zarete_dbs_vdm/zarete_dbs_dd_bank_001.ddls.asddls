@EndUserText.label: 'Bank API Custom Entity'
@ObjectModel.query.implementedBy:'ABAP:ZARETE_DBS_CL_BANK_API'
define root custom entity ZARETE_DBS_DD_BANK_001
{
 @UI.lineItem       : [ {
       position          : 10 ,
       importance        : #MEDIUM,
       label             : 'BankCountry'
       } ]

      @EndUserText.label : 'BankCountry'
  key bank_country          : abap.char( 3 );
   @UI.lineItem       : [ {
       position          : 20 ,
       importance        : #MEDIUM,
       label             : 'BankInternalID'
       } ]

      @EndUserText.label : 'BankInternalID'
  key bank_internal_id      : abap.char( 15 );
   @UI.lineItem       : [ {
       position          : 30 ,
       importance        : #MEDIUM,
       label             : 'StreetName'
       } ]

      @EndUserText.label : 'StreetName'
      street_name        : abap.char( 60 );
       @UI.lineItem       : [ {
       position          : 40 ,
       importance        : #MEDIUM,
       label             : 'HouseNumber'
       } ]

      @EndUserText.label : 'HouseNumber'
      house_number      : abap.char( 10 );
       @UI.lineItem       : [ {
       position          : 50 ,
       importance        : #MEDIUM,
       label             : 'HouseNumberSupplementText'
       } ]

      @EndUserText.label : 'HouseNumberSupplementText'
      house_number_supplement_te             : abap.char( 10 );
       @UI.lineItem       : [ {
       position          : 60 ,
       importance        : #MEDIUM,
       label             : 'CityName'
       } ]

      @EndUserText.label : 'CityName'
      city_name : abap.char( 40 );
       @UI.lineItem       : [ {
       position          : 70 ,
       importance        : #MEDIUM,
       label             : 'PostalCode'
       } ]

      @EndUserText.label : 'PostalCode'
      postal_code           : abap.char( 10 );




}
