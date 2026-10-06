managed implementation in class zbp_arete_dbs_dd_t014 unique;
strict ( 2 );

define behavior for ZARETE_DBS_DD_T014 //alias <alias_name>
persistent table zarete_dbs_t014
lock master
authorization master ( global )
//etag master <field_name>
{

  field ( numbering : managed )
  uuid;

  create ( authorization : global );
  update;
  delete;

  mapping for zarete_dbs_t014
    {
      UuId               = uuid;
      CompanyCode        = company_code;
      CompanyIdentifier  = company_identifier;
      CreatedAt          = created_at;
      CreatedBy          = created_by;
      LastChangedAt      = last_changed_at;
      LocalLastChangedAt = local_last_changed_at;
      LocalLastChangedBy = local_last_changed_by;
    }

}