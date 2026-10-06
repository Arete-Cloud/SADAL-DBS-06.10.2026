managed implementation in class ZBP_R_ARETE_DBS_T010 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T010
persistent table zarete_dbs_t010
etag master LocalLastChangedAt
lock master
authorization master ( global )

{
  field ( mandatory : create )
  SapStatusCode;

  field ( readonly )
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( readonly : update )
  SapStatusCode;

  create;
  update;
  delete;

  mapping for zarete_dbs_t010
    {
      SapStatusCode         = sap_status_code;
      SapStatusDefinition   = sap_status_definition;
      CreatedBy             = created_by;
      CreatedAt             = created_at;
      LastChangedAt         = last_changed_at;
      LocalLastChangedBy    = local_last_changed_by;
      LocalLastChangedAt    = local_last_changed_at;
    }
}