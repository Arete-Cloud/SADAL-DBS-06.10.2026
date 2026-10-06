managed implementation in class zbp_arete_dbs_dd_t018 unique;
strict ( 2 );

define behavior for ZARETE_DBS_DD_T018 //alias <alias_name>
persistent table zarete_dbs_t018
lock master
authorization master ( global )
//etag master <field_name>
{
  create ( authorization : global );
  update;
  delete;
//  field ( readonly ) BusinessPartner;

  mapping for zarete_dbs_t018
    {
      BusinessPartner         = business_partner;
      BusinessPartnerFullName = business_partner_full_name;
      BptaxNumber             = bptax_number;
      CreatedBy               = created_by;
      CreatedAt               = created_at;
      LastChangedAt           = last_changed_at;
      LocalLastChangedBy      = local_last_changed_by;
      LocalLastChangedAt      = local_last_changed_at;
    }
}