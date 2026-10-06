managed implementation in class ZBP_R_ARETE_DBS_T005 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T005
persistent table zarete_dbs_t005
etag master LocalLastChangedAt
lock master
authorization master ( global )

{
  field ( mandatory : create )
  BelgeTuru;

  field ( readonly )
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( readonly : update )
  BelgeTuru;


  create;
  update;
  delete;


  mapping for zarete_dbs_t005
    {
      BelgeTuru            = belge_turu;
      BelgeTuruDescription = belge_turu_description;
      CreatedBy            = created_by;
      CreatedAt            = created_at;
      LastChangedAt        = last_changed_at;
      LocalLastChangedBy   = local_last_changed_by;
      LocalLastChangedAt   = local_last_changed_at;
    }
}