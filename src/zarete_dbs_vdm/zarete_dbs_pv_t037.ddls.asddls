@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DBS VL10C Hariç Tut. Cariler PV'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZARETE_DBS_PV_T037
  provider contract transactional_query
  as projection on ZARETE_DBS_DD_T037
{
  key Customer
}
