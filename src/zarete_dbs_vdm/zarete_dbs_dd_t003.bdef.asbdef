managed implementation in class ZBP_R_ARETE_DBS_T003 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T003
persistent table zarete_dbs_t003
etag master LocalLastChangedAt
lock master
authorization master ( global )

{
  field ( mandatory : create )
  SapStatusCode,
  ActionCode;

  field ( readonly )
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( readonly : update )
  SapStatusCode,
  ActionCode;


  create;
  update;
  delete;

  mapping for zarete_dbs_t003
    {
      SapStatusCode       = sap_status_code;
      SapStatusDefinition = sap_status_definition;
      ActionCode          = action_code;
      ActionDefinition    = action_definition;
      CreatedBy           = created_by;
      CreatedAt           = created_at;
      LastChangedAt       = last_changed_at;
      LocalLastChangedBy  = local_last_changed_by;
      LocalLastChangedAt  = local_last_changed_at;
    }
}