@EndUserText.label: 'House Bank API Custom Entity'
@ObjectModel.query.implementedBy:'ABAP:ZARETE_DBS_CL_HOUSE_BANK_API'
define root custom entity ZARETE_DBS_DD_HOUSE_BANK_001
{
@UI.lineItem       : [ {
       position          : 10 ,
       importance        : #MEDIUM,
       label             : 'Şirket Kodu ID'
       } ]

      @EndUserText.label : 'Şirket Kodu ID'
  key company_code       : abap.char(4);
      @UI.lineItem       : [ {
      position           : 20 ,
      importance         : #MEDIUM,
      label              : 'Ana Banka'
      } ]

      @EndUserText.label : 'Ana Banka'
  key house_bank         : abap.char(5);
      @UI.lineItem       : [ {
      position           : 30 ,
      importance         : #MEDIUM,
      label              : 'Ana Banka Hesabı'
      } ]

      @EndUserText.label : 'Ana Banka Hesabı'
  key house_bank_account : abap.char(5);
      @UI.lineItem       : [ {
      position           : 40 ,
      importance         : #MEDIUM,
      label              : 'Ana Hesap Numarası'
      } ]

      @EndUserText.label : 'Ana Hesap Numarası'
  key glaccount          : abap.char(10);
      @UI.lineItem       : [ {
      position           : 50 ,
      importance         : #MEDIUM,
      label              : 'Iban'
      } ]

      @EndUserText.label : 'Iban'
      iban               : abap.char(34);

      //      bank_account_internal_id : abap.char(10);
      //      bank_internal_id         : abap.char(15);
      //      bank_country             : abap.char(3);
      //      swiftcode                : abap.char(11);
      //      bank_name                : abap.char(60);
      //      bank_number              : abap.char(15);
      //      bank_account             : abap.char(18);
      //      bank_account_alternative : abap.char(24);
      //      reference_info           : abap.char(27);
      //      bank_control_key         : abap.char(2);
      //      bank_account_currency    : abap.char(5);
      //      bank_account_description : abap.char(60);
      //      bank_account_holder_name : abap.char(60);
      //      bank_account_number      : abap.char(40);

  
}
