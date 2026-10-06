managed implementation in class ZBP_R_ARETE_DBS_T002 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T002
persistent table zarete_dbs_t002
etag master LocalLastChangedAt
lock master
authorization master ( global )

{
  field ( mandatory : create )
  FinteoStatusCode,
  FinteoStatusDescription,
  SapStatusCode,
  StatusIcon;

  field ( readonly )
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( readonly : update )
  FinteoStatusCode,
  FinteoStatusDescription,
  SapStatusCode,
  StatusIcon;


  create;
  update;
  delete;

  mapping for zarete_dbs_t002
    {
      FinteoStatusCode        = finteo_status_code;
      FinteoStatusDescription = finteo_status_description;
      FinteoStatusCodeText    = finteo_status_code_text;
      FinteoStatusDescText    = finteo_status_desc_text;
      SapStatusCode           = sap_status_code;
      SapStatusCodeText       = sap_status_code_text;
      StatusIcon              = status_icon;
      CreatedBy               = created_by;
      CreatedAt               = created_at;
      LastChangedAt           = last_changed_at;
      LocalLastChangedBy      = local_last_changed_by;
      LocalLastChangedAt      = local_last_changed_at;
    }
}