INTERFACE zarete_dbs_if_log
  PUBLIC.

  TYPES: BEGIN OF ty_message ,
           id       TYPE symsgid,
           number   TYPE symsgno,
           severity TYPE if_abap_behv_message=>t_severity,
           v1       TYPE symsgv,
           v2       TYPE symsgv,
           v3       TYPE symsgv,
           v4       TYPE symsgv,
         END OF ty_message.

  DATA: sapinvoiceno TYPE zarete_dbs_t001-sapinvoiceno,
        id           TYPE zarete_dbs_t001-id,
        bankcode     TYPE zarete_dbs_t001-bankcode.

  METHODS add_log IMPORTING msgid TYPE symsgid DEFAULT 'ZARETE_DBS_MC_001'
                            msgno TYPE symsgno DEFAULT '000'
                            msgty TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-none
                            msgv1 TYPE symsgv OPTIONAL
                            msgv2 TYPE symsgv OPTIONAL
                            msgv3 TYPE symsgv OPTIONAL
                            msgv4 TYPE symsgv OPTIONAL
                            msgtx TYPE string OPTIONAL.

  METHODS : set_sapinvoiceno IMPORTING iv_sapinvoiceno TYPE zarete_dbs_t001-sapinvoiceno OPTIONAL
                                       iv_id           TYPE zarete_dbs_t001-id OPTIONAL
                                       iv_bankcode     TYPE zarete_dbs_t001-bankcode OPTIONAL,
    refresh.

ENDINTERFACE.
