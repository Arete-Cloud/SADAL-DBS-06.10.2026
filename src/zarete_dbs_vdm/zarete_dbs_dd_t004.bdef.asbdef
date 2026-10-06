managed implementation in class zbp_arete_dbs_dd_t004 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T004 //alias <alias_name>
persistent table zarete_dbs_t004
etag master LocalLastChangedAt
lock master
authorization master ( global )
{

  field ( mandatory : create )
  ActionCode;

  field ( readonly )
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( readonly : update )
  ActionCode;

  create;
  update;
  delete;

  mapping for zarete_dbs_t004
    {
      ActionCode         = action_code;
      ActionDefinition   = action_definition;
      CreatedBy          = created_by;
      CreatedAt          = created_at;
      LastChangedAt      = last_changed_at;
      LocalLastChangedBy = local_last_changed_by;
      LocalLastChangedAt = local_last_changed_at;
    }

}