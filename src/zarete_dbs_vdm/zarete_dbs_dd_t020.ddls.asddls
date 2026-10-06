@EndUserText.label: 'DBSden Alınacak Veriler Item'
define root abstract entity ZARETE_DBS_DD_T020
{
  key action_code : abap.char( 2 );
      invoices    : composition [0..*] of ZARETE_DBS_DD_T021;
}
