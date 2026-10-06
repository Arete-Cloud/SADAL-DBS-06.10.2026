managed implementation in class ZBP_R_ARETE_DBS_T006 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T006
persistent table zarete_dbs_t006
etag master LocalLastChangedAt
lock master
authorization master ( global )

{
  field ( mandatory : create )
  SapAlanAdi,
  SapKayitOrnegi;

  field ( readonly )
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( readonly : update )
  SapAlanAdi,
  SapKayitOrnegi;


  create;
  update;
  delete;

  mapping for zarete_dbs_t006
    {
      SapAlanAdi         = sap_alan_adi;
      SapKayitOrnegi     = sap_kayit_ornegi;
      SapAlanDegeri      = sap_alan_degeri;
      CreatedBy          = created_by;
      CreatedAt          = created_at;
      LastChangedAt      = last_changed_at;
      LocalLastChangedBy = local_last_changed_by;
      LocalLastChangedAt = local_last_changed_at;
    }
}