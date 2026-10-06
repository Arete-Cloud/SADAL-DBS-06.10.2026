managed implementation in class ZBP_R_ARETE_DBS_T001 unique;
strict ( 2 );
define behavior for ZARETE_DBS_DD_T001
persistent table zarete_dbs_t001
etag master LocalLastChangedAt
lock master
authorization master ( global )

{
  field ( readonly )
  LogId,
  CreatedBy,
  CreatedAt,
  LastChangedAt,
  LocalLastChangedBy,
  LocalLastChangedAt;

  field ( numbering : managed )
  LogId;


  create;
  update;
  delete;

  mapping for zarete_dbs_t001
    {
      LogId              = log_id;
      SapInvoiceNo       = sapinvoiceno;
      Id                 = id;
      BankCode           = bankcode;
      Msgid              = msgid;
      Msgno              = msgno;
      Msgty              = msgty;
      Msgv1              = msgv1;
      Msgv2              = msgv2;
      Msgv3              = msgv3;
      Msgv4              = msgv4;
      Message            = message;
      CreatedBy          = created_by;
      CreatedAt          = created_at;
      LastChangedAt      = last_changed_at;
      LocalLastChangedBy = local_last_changed_by;
      LocalLastChangedAt = local_last_changed_at;
    }
}