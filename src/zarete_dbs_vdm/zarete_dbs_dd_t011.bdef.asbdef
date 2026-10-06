managed implementation in class zbp_r_arete_dbs_t011 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T011
persistent table zarete_dbs_t011
etag master LocalLastChangedAt
lock master
authorization master ( global )

{
  field ( mandatory : create )
  FinteoStatusCode,
  FinteoStatusDescription;

  field ( readonly )
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( readonly : update )
  FinteoStatusCode,
  FinteoStatusDescription;

  create;
  update;
  delete;

  mapping for zarete_dbs_t011
    {
      FinteoStatusCode        = finteo_status_code;
      FinteoStatusDescription = finteo_status_description;
      FinteoStatusCodeText    = finteo_status_code_text;
      FinteoStatusDescText    = finteo_status_desc_text;
      CreatedBy               = created_by;
      CreatedAt               = created_at;
      LastChangedAt           = last_changed_at;
      LocalLastChangedBy      = local_last_changed_by;
      LocalLastChangedAt      = local_last_changed_at;
    }
}