@EndUserText.label: 'Business Partner için Custom Entity'
@ObjectModel.query.implementedBy:'ABAP:ZARETE_DBS_CL_BP_API'
@Metadata.allowExtensions: true
define root custom entity ZARETE_DBS_DD_BP_001
{
      @UI.lineItem               : [ {
            position             : 10 ,
            importance           : #MEDIUM,
            label                : 'Business Partner'
            } ]
      @EndUserText.label         : 'Business Partner'
  key business_partner           : abap.char( 10 );
      @UI.lineItem               : [ {
          position               : 20 ,
          importance             : #MEDIUM,
          label                  : 'Business Partner Tax Type'
          } ]
      @EndUserText.label         : 'Business Partner Tax Type'
  key bptax_type                 : abap.char( 4 );
      @UI.lineItem               : [ {
            position             : 30 ,
            importance           : #MEDIUM,
            label                : 'Customer'
            } ]
      @EndUserText.label         : 'Customer'
      customer                   : abap.char( 10 );
      @UI.lineItem               : [ {
      position                   : 40 ,
      importance                 : #MEDIUM,
      label                      : 'Supplier'
      } ]
      @EndUserText.label         : 'Supplier'
      supplier                   : abap.char( 10 );
      @UI.lineItem               : [ {
      position                   : 50 ,
      importance                 : #MEDIUM,
      label                      : 'Business Partner Full Name'
      } ]
      @EndUserText.label         : 'Business Partner Full Name'
      business_partner_full_name : abap.char( 81 );
      @UI.lineItem               : [ {
      position                   : 60 ,
      importance                 : #MEDIUM,
      label                      : 'Business Partner Name'
      } ]
      @EndUserText.label         : 'Business Partner Name'
      business_partner_name      : abap.char( 81 );
      @UI.lineItem               : [ {
      position                   : 70 ,
      importance                 : #MEDIUM,
      label                      : 'Business Partner Tax Number'
      } ]
      @EndUserText.label         : 'Business Partner Tax Number'
      bptax_number               : abap.char( 11 );
      @UI.lineItem               : [ {
      position                   : 80 ,
      importance                 : #MEDIUM,
      label                      : 'Business Partner Long Tax Number'
      } ]
      @EndUserText.label         : 'Business Partner Long Tax Number'
      bptax_long_number          : abap.char( 60 );

}
