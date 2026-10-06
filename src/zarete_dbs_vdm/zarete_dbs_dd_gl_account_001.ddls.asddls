@EndUserText.label: 'GL Account API Custom Entity'
@ObjectModel.query.implementedBy:'ABAP:ZARETE_DBS_CL_GL_ACCOUNT_API'
define root custom entity ZARETE_DBS_DD_GL_ACCOUNT_001
{

      @UI.lineItem   : [ {
       position      : 10 ,
       importance    : #MEDIUM,
       label         : 'Ana banka'
       } ]

      @EndUserText.label : 'Ana Hesap Numarası'
  key glaccount      : abap.char( 10 );
      @UI.lineItem   : [ {
       position      : 20 ,
       importance    : #MEDIUM,
       label         : 'Ana Hesap Adı'
       } ]

      @EndUserText.label : 'Ana Hesap Adı'
      glaccount_name : abap.char( 20 );
  
}
