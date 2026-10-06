managed implementation in class zbp_arete_dbs_dd_t019 unique;
strict ( 2 );

define behavior for ZARETE_DBS_DD_T019 //alias <alias_name>
persistent table zarete_dbs_t019
lock master
authorization master ( global )
//etag master <field_name>
{
  create;
  update;
  delete;
  //  field ( readonly ) BankCode, BankName;
  mapping for zarete_dbs_t019
    {
      BankCode           = bank_code;
      BankName           = bank_name;
      CreatedBy          = created_by;
      CreatedAt          = created_at;
      LastChangedAt      = last_changed_at;
      LocalLastChangedBy = local_last_changed_by;
      LocalLastChangedAt = local_last_changed_at;
    }
}