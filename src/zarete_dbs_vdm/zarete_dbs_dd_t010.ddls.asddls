@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sap Statüleri'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define root view entity ZARETE_DBS_DD_T010
  as select from zarete_dbs_t010

{
      @ObjectModel.text.element: ['SapStatusDefinition']
  key sap_status_code       as SapStatusCode,
      sap_status_definition as SapStatusDefinition,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_at       as LastChangedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt
}
