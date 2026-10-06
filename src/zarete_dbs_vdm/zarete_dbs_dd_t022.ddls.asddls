@EndUserText.label: 'DBS Result Deep Structure'
define root abstract entity ZARETE_DBS_DD_T022
{
  key action_code : abap.char( 2 );
      results     : composition [0..*] of ZARETE_DBS_DD_T023;
}
