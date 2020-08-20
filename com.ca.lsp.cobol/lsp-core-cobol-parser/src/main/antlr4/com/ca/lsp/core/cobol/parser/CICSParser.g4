/*
 * Copyright (c) 2020 Broadcom.
 * The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
 *
 * This program and the accompanying materials are made
 * available under the terms of the Eclipse Public License 2.0
 * which is available at https://www.eclipse.org/legal/epl-2.0/
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *   Broadcom, Inc. - initial API and implementation
 */
parser grammar CICSParser;
options {tokenVocab = CobolLexer;}

allRules: cics_abend | cics_acquire | cics_add | cics_address | cics_allocate | cics_asktime | cics_assign | cics_bif |
          cics_build | cics_cancel | cics_change | cics_change_task | cics_check | cics_connect | cics_converttime |
          cics_define | cics_delay | cics_delete | cics_deleteq | cics_deq | cics_document | cics_dump | cics_endbr |
          cics_endbrowse | cics_enq | cics_enter | cics_extract | cics_force | cics_formattime | cics_free |
          cics_freemain | cics_gds | cics_get | cics_getmain | cics_getnext | cics_handle | cics_ignore | cics_inquire |
          cics_invoke | cics_issue | cics_link | cics_load | cics_monitor | cics_move | cics_point | cics_pop |
          cics_post | cics_purge | cics_push | cics_put | cics_query | cics_read | cics_readnext | cics_readprev |
          cics_readq | cics_release | cics_remove | cics_reset | cics_resetbr | cics_resume | cics_retrieve |
          cics_return | cics_rewind | cics_rewrite | cics_route | cics_run | cics_signal | cics_signoff | cics_signon |
          cics_soapfault | cics_spoolclose | cics_spoolopen | cics_spoolread | cics_spoolwrite | cics_start |
          cics_startbr | cics_startbrowse | cics_suspend | cics_syncpoint | cics_test | cics_transform | cics_unlock |
          cics_update | cics_verify | cics_wait | cics_waitcics | cics_web | cics_write | cics_writeq | cics_wsacontext |
          cics_wsaepr | cics_xctl
        ;

//resp_options: RESP LPARENCHAR IDENTIFIER RPARENCHAR resp2_option?;
//resp2_option: RESP2 LPARENCHAR IDENTIFIER RPARENCHAR;


/** ABEND: */
cics_abend: ABEND (ABCODE cics_name)? CANCEL? NODUMP?;

/** ACQUIRE */
cics_acquire: (PROCESS cics_data_value PROCESSTYPE cics_data_value |
              ACTIVITYID cics_data_value);

/** ADD SUBEVENT */
cics_add: ADD SUBEVENT cics_data_value EVENT cics_data_value;

/** ADDRESS / ADDRESS SET */
cics_address: ADDRESS (cics_address_null | cics_address_set);
cics_address_null: (ACEE cics_ref)? (COMMAREA cics_ref)?
                   (CWA cics_ref)? (EIB cics_ref)?
                   (TCTUA cics_ref)? (TWA cics_ref)?;
cics_address_set: (SET cics_data_area USING cics_ref |
                  SET cics_ref USING cics_data_area);

/** ALLOCATE (all of them) */
cics_allocate: ALLOCATE (cics_allocate_sysid | cics_allocate_session | cics_allocate_partner);
cics_allocate_sysid: SYSID cics_system (PROFILE cics_name)? NOQUEUE? (STATE cics_cvda)?;
cics_allocate_session: SESSION  cics_name (PROFILE cics_name)? NOQUEUE?;
cics_allocate_partner: PARTNER cics_name NOQUEUE? (STATE cics_cvda)?;

/** ASKTIME */
cics_asktime: ASKTIME (ABSTIME cics_data_area)?;

/** ASSIGN */
cics_assign: ASSIGN (ABCODE cics_data_area | ABDUMP cics_data_area | ABPROGRAM cics_data_area | ACTIVITY cics_data_area |
             ACTIVITYID cics_data_area | ALTSCRNHT cics_data_area | ALTSCRNWD cics_data_area | APLKYBD cics_data_area |
             APLTEXT cics_data_area | APPLID cics_data_area | ASRAINTRPT cics_data_area | ASRAKEY cics_cvda |
             ASRAPSW cics_data_area | ASRAREGS cics_data_area | ASRASPC cics_cvda | ASRASTG cics_cvda |
             BRIDGE cics_data_area | BTRANS cics_data_area | CHANNEL cics_data_area | CMDSEC cics_data_area |
             COLOR cics_data_area | CWALENG cics_data_area | DEFSCRNHT cics_data_area | DEFSCRNWD cics_data_area |
             DELIMITER cics_data_area | DESTCOUNT cics_data_area | DESTID cics_data_area | DESTIDLENG cics_data_area |
             DSSCS cics_data_area | DS3270 cics_data_area | EWASUPP cics_data_area | EXTDS cics_data_area |
             FACILITY cics_data_area | FCI cics_data_area | GCHARS cics_data_area | GCODES cics_data_area |
             GMMI cics_data_area | HILIGHT cics_data_area | INITPARM cics_data_area | INITPARMLEN cics_data_area |
             INPARTN cics_data_area | INVOKINGPROG cics_data_area | KATAKANA cics_data_area | LANGINUSE cics_data_area |
             LDCMNEM cics_data_area | LDCNUM cics_data_area | MAPCOLUMN cics_data_area | MAPHEIGHT cics_data_area)*
             (MAPLINE cics_data_area | MAPWIDTH cics_data_area | MSRCONTROL cics_data_area | NATLANGINUSE cics_data_area |
             NETNAME cics_data_area | NEXTTRANSID cics_data_area | NUMTAB cics_data_area | OPCLASS cics_data_area |
             OPERKEYS cics_data_area | OPID cics_data_area | OPSECURITY cics_data_area | ORGABCODE cics_data_area |
             OUTLINE cics_data_area | PAGENUM cics_data_area | PARTNPAGE cics_data_area | PARTNS cics_data_area |
             PARTNSET cics_data_area | PRINSYSID cics_data_area | PROCESS cics_data_area | PROCESSTYPE cics_data_area |
             PROGRAM cics_data_area | PS cics_data_area | QNAME cics_data_area | RESSEC cics_data_area |
             RESTART cics_data_area | RETURNPROG cics_data_area | SCRNHT cics_data_area | SCRNWD cics_data_area |
             SIGDATA cics_data_area | SOSI cics_data_area | STARTCODE cics_data_area | STATIONID cics_data_area |
             SYSID cics_data_area | TASKPRIORITY cics_data_area | TCTUALENG cics_data_area | TELLERID cics_data_area |
             TERMCODE cics_data_area | TERMPRIORITY cics_data_area | TEXTKYBD cics_data_area | TEXTPRINT cics_data_area |
             TRANPRIORITY cics_data_area | TWALENG cics_data_area | UNATTEND cics_data_area | USERID cics_data_area |
             USERNAME cics_data_area | USERPRIORITY cics_data_area | VALIDATION cics_data_area)*;

/** BIF DEEDIT / BIF DIGEST */
cics_bif: BIF (cics_bif_deedit | cics_bif_digest);
cics_bif_deedit: DEEDIT FIELD cics_data_area (LENGTH cics_data_value)?;
cics_bif_digest: DIGEST RECORD cics_data_value RECORDLEN cics_data_value (HEX | BINARY | BASE64 | DIGESTTYPE cics_cvda)?
                 RESULT cics_data_area;

/** BUILD ATTACH (both of them) */
cics_build: BUILD ATTACH ATTACHID cics_name (PROCESS cics_name)? (RESOURCE cics_name)? (RPROCESS cics_name)?
            (RRESOURCE cics_name)? (QUEUE cics_name)? (IUTYPE cics_data_value)? (DATASTR cics_data_value)?
            (RECFM cics_data_value)?;

/** CANCEL (both of them) */
cics_cancel: CANCEL (ACTIVITY cics_data_value | ACQACTIVITY | ACQPROCESS | cics_cancel_reqid)?;
cics_cancel_reqid: REQID cics_name (SYSID cics_system)?
                   (TRANSID cics_name)?;

/** CHANGE PHRASE / PASSWORD / TASK */
cics_change: CHANGE (cics_change_phrase | cics_change_password);
cics_change_phrase: PHRASE cics_data_area PHRASELEN cics_data_value NEWPHRASE cics_data_area NEWPHRASELEN cics_data_value
                    USERID cics_data_value (ESMREASON cics_data_area)? (ESMRESP cics_data_area)?;
cics_change_password: PASSWORD cics_data_value NEWPASSWORD cics_data_value USERID cics_data_value
                      (ESMREASON cics_data_area)? (ESMRESP cics_data_area)?;
cics_change_task: TASK (PRIORITY cics_data_value)?;

/** CHECK ACQPROCESS / ACTIVITY / TIMER */
cics_check: CHECK (cics_check_activity | cics_check_timer);
cics_check_activity: (ACQPROCESS | ACTIVITY cics_data_value | ACQACTIVITY) COMPSTATUS cics_cvda (ABCODE cics_data_area)?
                     (ABPROGRAM cics_data_area)? (MODE cics_cvda)? (SUSPSTATUS cics_cvda)?;
cics_check_timer: TIMER cics_data_value STATUS cics_cvda;

/** CONNECT PROCESS */
cics_connect: CONNECT PROCESS (CONVID cics_name | SESSION cics_name) (PROCNAME cics_data_area
              (PROCLENGTH cics_data_value)? | PARTNER cics_name) cics_connect_piplist? SYNCLEVEL
               cics_data_value (STATE cics_cvda)?;
cics_connect_piplist: PIPLIST cics_data_area (PIPLENGTH cics_data_value)?;

/** CONVERSE */
/** CONVERTTIME */
cics_converttime: CONVERTTIME DATESTRING cics_data_area ABSTIME cics_data_area;

/** DEFINE (all of them) */
cics_define: DEFINE (cics_define_activity | cics_define_composite | cics_define_counter | cics_define_dcounter |
             cics_define_input | cics_define_process | cics_define_timer);
cics_define_activity: ACTIVITY cics_data_value (EVENT cics_data_value)? TRANSID cics_data_value
                      (PROGRAM cics_data_value)? (USERID cics_data_value)? (ACTIVITYID cics_data_area)?;
cics_define_composite: COMPOSITE EVENT cics_data_value (AND | OR) SUBEVENT FIRST_EIGHT_DIGIT cics_data_value*;
cics_define_counter: COUNTER cics_name (POOL cics_name)? cics_define_value? (MAXIMUM cics_data_value)?;
cics_define_value: VALUE cics_data_value (MINIMUM cics_data_value)?;
cics_define_dcounter: DCOUNTER cics_name (POOL cics_name)? cics_define_value? (MAXIMUM cics_data_area)?;
cics_define_input: INPUT EVENT cics_data_value;
cics_define_process: PROCESS cics_data_value PROCESSTYPE cics_data_value TRANSID cics_data_value
                     (PROGRAM cics_data_value)? (USERID cics_data_value)? NOCHECK?;
cics_define_timer: DEFINE TIMER cics_data_value (EVENT cics_data_value)? (cics_define_after | cics_define_at);
cics_define_after: AFTER (DAYS cics_data_value | HOURS cics_data_value | MINUTES cics_data_value |
                   SECONDS cics_data_value)+;
cics_define_at: AT (HOURS cics_data_value | MINUTES cics_data_value | SECONDS cics_data_value)+ (today | cics_define_on)?;
cics_define_on: ON YEAR cics_data_value (MONTH cics_data_value DAYOFMONTH cics_data_value | DAYOFYEAR cics_data_value);

/** DELAY */
cics_delay: DELAY (INTERVAL(ZERO_DIGITAL) | INTERVAL cics_hhmmss | TIME cics_hhmmss | cics_delay_for)? (REQID cics_name)?;
cics_delay_for: (FOR | UNTIL) (HOURS cics_data_value | MINUTES cics_data_value | SECONDS cics_data_value)+;

/** DELETE (all of them) */
cics_delete: DELETE (cics_delete_file | ACTIVITY cics_data_value | cics_delete_container |cics_delete_counter |
             EVENT cics_data_value | TIMER cics_data_value);
cics_delete_file: FILE cics_mama (TOKEN cics_data_area | cics_delete_ridfld)? (SYSID cics_system)? NOSUSPEND?
                  (RBA | RRN)?;
cics_delete_ridfld: RIDFLD cics_data_area cics_delete_keylength?;
cics_delete_keylength: KEYLENGTH cics_data_value cics_delete_generic?;
cics_delete_generic: GENERIC (NUMREC cics_data_area)?;
cics_delete_container: CONTAINER cics_data_value (ACTIVITY cics_data_value | ACQACTIVITY | PROCESS | ACQPROCESS |
                       CHANNEL cics_data_value)?;
cics_delete_counter: (COUNTER cics_name | DCOUNTER cics_name) (POOL cics_name)?;

/** DELETEQ TD/TS */
cics_deleteq: DELETEQ (TD QUEUE cics_name | cics_deleteq_ts) (SYSID cics_system)?;
cics_deleteq_ts: TS? (QUEUE cics_name | QNAME cics_name);

/** DEQ */
cics_deq: DEQ RESOURCE cics_data_area (LENGTH cics_data_value)?
          (UOW | MAXLIFETIME cics_cvda | TASK)?;

/** DOCUMENT CREATE / DELETE / INSERT / RETRIEVE / SET */
cics_document: DOCUMENT (cics_document_create | DELETE DOCTOKEN cics_data_area | cics_document_insert |
               cics_document_retrieve | cics_document_set);
cics_document_create: CREATE DOCTOKEN cics_data_area (cics_document_ftb LENGTH cics_data_area | FROMDOC cics_data_area |TEMPLATE cics_name)?
                      cics_document_create_symbollist?  (DOCSIZE cics_data_area)? (HOSTCODEPAGE cics_name)?;
cics_document_ftb: (FROM cics_data_area | TEXT cics_data_area | BINARY cics_data_area);
cics_document_create_symbollist: SYMBOLLIST cics_data_area LISTLENGTH cics_data_value (DELIMITER cics_data_value)? UNESCAPED?;
cics_document_insert: INSERT DOCTOKEN cics_data_area (cics_document_ftb LENGTH cics_data_value | SYMBOL cics_name |TEMPLATE cics_name |
                      FROMDOC cics_data_area | BOOKMARK cics_name) (DOCSIZE cics_data_value)? (HOSTCODEPAGE cics_name)? cics_document_at?;
cics_document_at: AT cics_name (TO cics_name)?;
cics_document_retrieve: RETRIEVE DOCTOKEN cics_data_area INTO cics_data_area LENGTH cics_data_value (MAXLENGTH cics_data_value)?
                        (CHARACTERSET cics_name)? DATAONLY?;
cics_document_set: SET DOCTOKEN cics_data_area (SYMBOL cics_name VALUE cics_data_area | cics_document_set_symbollist)
                   LENGTH cics_data_value UNESCAPED?;

/** DUMP TRANSACTION */
cics_dump: DUMP TRANSACTION DUMPCODE cics_name cics_dump_from? COMPLETE? TRT? cics_dump_segmentlist?
           TASK? STORAGE? PROGRAM? TERMINAL? TABLES? FCT? PCT? PPT? SIT? TCT? (DUMPID cics_data_area)?;
cics_dump_from: FROM cics_data_area (LENGTH cics_data_value | FLENGTH cics_data_value);
cics_dump_segmentlist: SEGMENTLIST cics_data_area LENGTHLIST cics_data_area NUMSEGMENTS cics_data_area;

/** ENDBR */
cics_endbr: ENDBR FILE cics_mama (REQID cics_data_value)? (SYSID cics_system)?;

/** ENDBROWSE (all of them) */
cics_endbrowse: ENDBROWSE (ACTIVITY | CONTAINER | EVENT | PROCESS) BROWSETOKEN cics_data_value;

/** ENQ */
cics_enq: ENQ RESOURCE cics_data_area (LENGTH cics_data_value)? (UOW | TASK | MAXLIFETIME cics_cvda)? NOSUSPEND?;

/** ENTER TRACENUM */
cics_enter: ENTER TRACENUM cics_data_value cics_enter_from? (RESOURCE cics_name)? EXCEPTION?;
cics_enter_from: FROM cics_data_area (FROMLENGTH cics_data_area)?;

/** EXTRACT (all of them) */
cics_extract: EXTRACT (cics_extract_attach | cics_extract_attributes | cics_extract_certificate |
              cics_extract_logonmsg | cics_extract_process | cics_extract_tcpip | cics_extract_tct | cics_extract_web);
cics_extract_attach: ATTACH (ATTACHID cics_name | CONVID cics_name | SESSION cics_name)? (PROCESS cics_data_area)?
                     (RESOURCE cics_data_area)? (RPROCESS cics_data_area)? (RRESOURCE cics_data_area)?
                     (QUEUE cics_data_area)? (IUTYPE cics_data_area)? (DATASTR cics_data_area)? (RECFM cics_data_area)?;

cics_extract_attributes: ATTRIBUTES (CONVID cics_name | SESSION cics_name)? STATE cics_cvda;

cics_extract_certificate: CERTIFICATE cics_ref (LENGTH cics_data_area)? (SERIALNUM cics_ref)? (SERIALNUMLEN cics_data_area)?
                          (USERID cics_data_area)? (OWNER | ISSUER)? (COMMONNAME cics_ref)? (COMMONNAMLEN cics_data_area)?
                          (COUNTRY cics_ref)? (COUNTRYLEN cics_data_area)? (STATE cics_ref)? (STATELEN cics_data_area)?
                          (LOCALITY cics_ref)? (LOCALITYLEN cics_data_area)? (ORGANIZATION cics_ref)?
                          (ORGANIZATLEN cics_data_area)? (ORGUNIT cics_ref)? (ORGUNITLEN cics_data_area)?;

cics_extract_logonmsg: LOGONMSG (INTO cics_data_area | SET cics_ref) LENGTH cics_data_area;
cics_extract_process: PROCESS cics_extract_procname? (CONVID cics_name)? (SYNCLEVEL cics_data_area)? cics_extract_piplist?;
cics_extract_procname: PROCNAME cics_data_area PROCLENGTH cics_data_area (MAXPROCLEN cics_data_value)?;
cics_extract_piplist: PIPLIST cics_ref PIPLENGTH cics_data_area;
cics_extract_tcpip: TCPIP (AUTHENTICATE cics_cvda)? cics_extract_clientname? cics_extract_servername? cics_extract_clientaddr?
                    (CLNTIPFAMILY cics_cvda)? (CLIENTADDRNU cics_data_area)? (CLNTADDR6NU cics_data_area)?
                     cics_extract_serveraddr? (SRVRIPFAMILY cics_cvda)? SERVERADDRNU cics_data_area SRVRADDR6NU
                    cics_data_area SSLTYPE cics_cvda (TCPIPSERVICE cics_data_area)? (PORTNUMBER cics_data_area)?
                    (PORTNUMNU cics_data_area)? (PRIVACY cics_cvda)? (MAXDATALEN cics_cvda)?;
                    
cics_extract_clientname: CLIENTNAME cics_data_area CNAMELENGTH cics_data_area;
cics_extract_servername: SERVERNAME cics_data_area SNAMELENGTH cics_data_area;
cics_extract_clientaddr: CLIENTADDR cics_data_area CADDRLENGTH cics_data_area;
cics_extract_serveraddr: SERVERADDR cics_data_area SADDRLENGTH cics_data_area;

cics_extract_tct: TCT NETNAME cics_name (SYSID cics_system | TERMID cics_data_area)?;
cics_extract_web: WEB (SCHEME cics_cvda)? cics_extract_host? cics_extract_httpmethod? cics_extract_httpversion?
                  cics_extract_path? (PORTNUMBER cics_data_area)? cics_extract_querystring? REQUESTTYPE cics_cvda;
cics_extract_host: HOST cics_data_area HOSTLENGTH cics_data_value (HOSTTYPE cics_cvda)?;
cics_extract_httpmethod: HTTPMETHOD cics_data_area METHODLENGTH cics_data_value;
cics_extract_httpversion: HTTPVERSION cics_data_area VERSIONLEN cics_data_area;
cics_extract_path: PATH cics_data_area PATHLENGTH cics_data_area;
cics_extract_querystring: QUERYSTRING cics_data_area QUERYSTRLEN cics_data_area;

/** FORCE TIMER */
cics_force: FORCE TIMER cics_data_value (ACQUACTIVITY | ACQPROCESS)?;

/** FORMATTIME */
cics_formattime: FORMATTIME ABSTIME cics_data_area (DATE cics_data_area)? (FULLDATE cics_data_area)? (DATEFORM cics_data_area)?
                 DATESEP(data_value?)? (DAYCOUNT cics_data_area)? (DAYOFMONTH cics_data_area)? (DAYOFWEEK cics_data_area)?
                 (DDMMYY cics_data_area)? (DDMMYYYY cics_data_area)? (MILLISECONDS cics_data_area)? (MMDDYY cics_data_area)?
                 (MMDDYYYY cics_data_area)? (MONTHOFYEAR cics_data_area)? cics_formattime_time? (YEAR cics_data_area)?
                 (YYDDD cics_data_area)? (YYDDMM cics_data_area)? (YYYYDDD cics_data_area)? (YYYYDDMM cics_data_area)?
                 (YYYYMMDD cics_data_area)? (DATESTRING cics_data_area)? (STRINGFORMAT cics_cvda)?;
cics_formattime_time: TIME cics_data_area TIMESEP(data_value?)?;

/** FREE (all of them) */
cics_free: FREE (CONVID cics_name | SESSION cics_name)? (STATE cics_cvda)?;

/** FREEMAIN */
cics_freemain: FREEMAIN (DATA cics_data_area | DATAPOINTER cics_value);

/** GDS (all) */
cics_gds: GDS (cics_gds_allocate | cics_gds_assign | cics_gds_connect | cics_gds_extract | cics_gds_free |
          cics_gds_issue | cics_gds_receive | cics_gds_send | cics_gds_wait);
cics_gds_allocate: ALLOCATE (SYSID cics_system (MODENAME cics_name)? | PARTNER cics_name) CONVID cics_data_area
                   RETCORD cics_data_area NOQUEUE? (STATE cics_cvda)?;
cics_gds_assign: ASSIGN (PRINCONVID cics_data_area)? (PRINSYSID cics_data_area)? RETCODE cics_data_area;
cics_gds_connect: CONNECT PROCESS CONVID cics_name (PROCNAME cics_name (PROCLENGTH cics_data_value)? | PARTNER cics_name)
                  cics_gds_piplist? SYNCLEVEL cics_data_value CONVDATA cics_data_area RETCODE cics_data_area (STATE cics_cvda)?;
cics_gds_piplist: PIPLIST cics_data_area (PIPLENGTH cics_data_value)?;
cics_gds_extract: EXTRACT (cics_gds_attributes | cics_gds_process);
cics_gds_attributes: ATTRIBUTES CONVID cics_name (STATE cics_cvda)? CONVDATA cics_data_area RETCODE cics_data_area;
cics_gds_process: PROCESS CONVID cics_name cics_extract_procname? (SYNCLEVEL cics_data_area)?
                  cics_extract_piplist? RETCODE cics_data_area;
cics_gds_free: FREE CONVID cics_name CONVDATA cics_data_area RETCODE cics_data_area (STATE cics_cvda)?;
cics_gds_issue: ISSUE (ABEND | CONFIRMATION | ERROR | PREPARE | SIGNAL) CONVID cics_name CONVDATA cics_data_area
                RETCODE cics_data_area (STATE cics_cvda)?;
cics_gds_receive: RECEIVE CONVID cics_name (INTO cics_data_area | SET cics_ref) FLENGTH cics_data_area (MAXFLENGTH
                  cics_data_value)? (BUFFER | LLID) CONVDATA cics_data_area RETCODE cics_data_area (STATE cics_cvda)?;
cics_gds_send: SEND CONVID cics_name cics_gds_from? (INVITE | LAST)? (CONFIRM | WAIT)? CONVDATA cics_data_area RETCODE
               cics_data_area (STATE cics_cvda)?;
cics_gds_from: FROM cics_data_area (FLENGTH cics_data_value)?;
cics_gds_wait: WAIT CONVID cics_name CONVDATA cics_data_area RETCODE cics_data_area (STATE cics_cvda)?;

/** GET CONTAINER (both of them) / GET COUNTER / GET DCOUNTER */
cics_get: GET (cics_get_container | cics_get_counter | cics_get_dcounter);
cics_get_container: CONTAINER cics_data_value (cics_get_bts | cics_get_channel);
cics_get_bts: (ACTIVITY cics_data_value | ACQACTIVITY | PROCESS | ACQPROCESS)? (INTO cics_data_area | SET cics_ref |
               NODATA) (FLENGTH cics_data_area)?;
cics_get_channel: (CHANNEL cics_data_value)? (INTO cics_data_area (FLENGTH cics_data_area)? | SET cics_ref FLENGTH cics_data_area |
                  NODATA FLENGTH cics_data_area) (INTOCCSID cics_data_value | INTOCODEPAGE cics_data_value | cics_get_convertst)?;
cics_get_convertst: CONVERTST cics_cvda (CCSID cics_data_area)?;
cics_get_counter: COUNTER cics_name (POOL cics_name)? VALUE cics_data_area cics_get_increment? WRAP?
                  (COMPAREMIN cics_data_value)? (COMPAREMAX cics_data_value)?;
cics_get_increment: INCREMENT cics_data_value REDUCE?;
cics_get_dcounter: DCOUNTER cics_name (POOL cics_name)? VALUE cics_data_area cics_get_dincrement? WRAP?
                   (COMPAREMIN cics_data_area)? (COMPAREMAX cics_data_area)?;
cics_get_dincrement: INCREMENT cics_data_area REDUCE?;

/** GETMAIN */
cics_getmain: GETMAIN SET cics_ref (FLENGTH cics_data_value BELOW? | LENGTH cics_data_value) (INITIMG cics_data_value)?
              SHARED? NOSUSPEND? (USERDATAKEY | CICSDATAKEY)?;

/** GETNEXT ACTIVITY / CONTAINER / EVENT / PROCESS */
cics_getnext: GETNEXT (cics_getnext_activity | CONTAINER cics_data_area BROWSETOKEN cics_data_value |
              cics_getnext_event | cics_getnext_process);
cics_getnext_activity: ACTIVITY cics_data_area BROWSETOKEN cics_data_value (ACTIVITYID cics_data_area)?
                       (LEVEL cics_data_area)?;
cics_getnext_event: EVENT cics_data_area BROWSETOKEN cics_data_value (COMPOSITE cics_data_area)? (EVENTTYPE cics_cvda)? (FIRESTATUS cics_cvda)?
                    (PREDICATE cics_cvda)? (TIMER cics_data_area)?;
cics_getnext_process: PROCESS cics_data_area BROWSETOKEN cics_data_value (ACTIVITYID cics_data_area)?;

/** HANDLE CONDITION / HANDLE AID / HANDLE ABEND: */
cics_handle: HANDLE (cics_handle_abend | cics_handle_aid | cics_handle_condition);
cics_handle_abend: ABEND (CANCEL | PROGRAM cics_name | LABEL cics_label | RESET)?;
cics_handle_aid: AID (ANYKEY (cics_label)? | CLEAR (cics_label)? | CLRPARTN (cics_label)? | ENTER (cics_label)? |
                 LIGHTPEN (cics_label)? | OPERID  (cics_label)? | PA firstThreeDigits (cics_label)? | PF first24Digits
                 (cics_label)? | TRIGGER  (cics_label)?)*;
cics_handle_condition: CONDITION (condition label?)+;

/** IGNORE CONDITION */
cics_ignore: IGNORE CONDITION condition+;

/** INQUIRE ACTIVITYID / CONTAINER / EVENT / PROCESS / TIMER */
cics_inquire: INQUIRE (cics_inquire_activityid | cics_inquire_container | cics_inquire_event | cics_inquire_process |
              cics_inquire_timer);
cics_inquire_activityid: ACTIVITYID cics_data_value (ABCODE cics_data_area)? (ABPROGRAM cics_data_area)?
                         (ACTIVITY cics_data_area)? (COMPSTATUS cics_cvda)? (EVENT cics_data_area)? (MODE cics_cvda)?
                         (PROCESS cics_data_area)? (PROCESSTYPE cics_data_area)? (PROGRAM cics_data_area)?
                         (SUSPSTATUS cics_cvda)? (TRANSID cics_data_area)? (USERID cics_data_area)?;
cics_inquire_container: CONTAINER cics_data_value (ACTIVITYID cics_data_value | PROCESS cics_data_value PROCESSTYPE
                        cics_data_value)? (DATALENTH cics_data_area)? (SET cics_data_area)?;
cics_inquire_event: EVENT cics_data_value (ACTIVITYID cics_data_value)? (EVENTTYPE cics_cvda)? (FIRESTATUS cics_cvda)?
                    (COMPOSITE cics_data_area)? (PREDICATE cics_cvda)? (TIMER cics_data_area)?;
cics_inquire_process: PROCESS cics_data_value PROCESSTYPE cics_data_value (ACTIVITYID cics_data_area)?;
cics_inquire_timer: TIMER cics_data_value (ACTIVITYID cics_data_value)? (EVENT cics_data_area)? (STATUS cics_cvda)?
                    (ABSTIME cics_data_area)?;

/** INVOKE SERVICE */
cics_invoke: INVOKE SERVICE cics_data_value CHANNEL cics_data_value OPERATION cics_data_value (URI cics_data_value |
             URIMAP cics_data_value)? cics_invoke_scope?;
cics_invoke_scope: SCOPE cics_data_value (SCOPELEN cics_data_value)?;

/** ISSUE (all of them) */
cics_issue: ISSUE (cics_issue_abend | cics_issue_abort | cics_issue_add | cics_issue_confirmation | cics_issue_copy |
            cics_issue_disconnect | cics_issue_endfile | cics_issue_endoutput | EODS | cics_issue_erase |
            cics_issue_eraseaup | cics_issue_load | cics_issue_note | cics_issue_pass | PRINT | cics_issue_query |
            cics_issue_receive | cics_issue_replace |  cics_issue_send | cics_issue_signal);
	/** ISSUE ABEND, ISSUE ERROR and ISSUE PREPARE are combined into one as they have the same syntax */
cics_issue_abend: (ABEND | ERROR | PREPARE) (CONVID cics_name)? (STATE cics_cvda)?;
	/** ISSUE ABORT, ISSUE END and ISSUE WAIT are combined into one as they have the same syntax */
cics_issue_abort: (ABORT | END | WAIT) (cics_issue_destid | cics_issue_subaddr)? cics_issue_volume?;
cics_issue_destid: DESTID cics_data_value (DESTIDLENG cics_data_value)?;
cics_issue_subaddr: SUBADDR cics_data_value (CONSOLE | PRINT | CARD | WPMEDIA FIRST_FOUR_DIGITS)?;
cics_issue_volume: VOLUME cics_data_value (VOLUMELENG cics_data_value)?;
cics_issue_add: ADD cics_issue_destid cics_issue_volume FROM cics_data_value (LENGTH cics_data_value)?
                (NUMREC cics_data_value)? DEFRESP? NOWAIT? cics_issue_ridfld?;
cics_issue_ridfld: RIDFLD cics_data_area RRN;
cics_issue_confirmation: CONFIRMATION (CONVID cics_name)? (STATE cics_cvda)?;
cics_issue_copy: COPY TERMID cics_name (CTLCHAR cics_data_value)? WAIT?;
cics_issue_disconnect: DISCONNECT (SESSION cics_name)?;
cics_issue_endfile: ENDFILE ENDOUTPUT?;
cics_issue_endoutput: ENDOUTPUT ENDFILE?;
cics_issue_erase: ERASE cics_issue_destid cics_issue_volume RIDFLD cics_data_area (KEYLENGTH cics_data_value
                  (KEYNUMBER cics_data_value)? | RRN) (NUMREC cics_data_value)? DEFRESP? NOWAIT?;
cics_issue_eraseaup: ERASEAUP WAIT?;
cics_issue_load: LOAD PROGRAM cics_name CONVERSE?;
cics_issue_note: NOTE cics_issue_destid cics_issue_volume cics_issue_ridfld;
cics_issue_pass: PASS LUNAME cics_name cics_issue_from? (LOGMODE cics_data_value | LOGONLOGMODE)? NOQUIESCE?;
cics_issue_from: FROM cics_data_area LENGTH cics_data_value;
cics_issue_query: QUERY cics_issue_destid cics_issue_volume?;
cics_issue_receive: RECEIVE (INTO cics_data_area | SET cics_ref) (LENGTH cics_data_area)?;
cics_issue_replace: REPLACE cics_issue_destid cics_issue_volume? FROM cics_data_area (LENGTH cics_data_value)? RIDFLD
                    cics_data_area (KEYLENGTH cics_data_value (KEYNUMBER cics_data_value)? | RRN) DEFRESP? NOWAIT?;
cics_issue_send: SEND (cics_issue_destid | cics_issue_subaddr)? cics_issue_volume? FROM cics_data_area
                 (LENGTH cics_data_value)? NOWAIT? DEFRESP?;
cics_issue_signal: SIGNAL (cics_issue_convid | SESSION cics_name | STATE cics_cvda)?;
cics_issue_convid: CONVID cics_name (STATE cics_cvda)?;

/** LINK / LINK ACQPROCESS / LINK ACTIVITY: */
cics_link: LINK (cics_link_program | cics_link_acqprocess | cics_link_activity);
cics_link_program: PROGRAM  cics_name (cics_link_commarea | CHANNEL cics_name)? (cics_link_inputmsg |
                   (SYSID cics_system)? SYNCONRETURN? (TRANSID cics_name)?)?;
cics_link_commarea: COMMAREA cics_data_area (LENGTH cics_data_value)? (DATALENGTH cics_data_value)?;
cics_link_inputmsg: INPUTMSG cics_data_area (INPUTMSGLEN cics_data_value)?;
cics_link_acqprocess: ACQPROCESS (INPUTEVENT cics_data_value)?;
cics_link_activity: (ACTIVITY  cics_data_value | ACQACTIVITY) (INPUTEVENT cics_data_value)?;

/** LOAD */
cics_load: LOAD PROGRAM cics_name (SET cics_ref)? (LENGTH cics_data_area | FLENGTH cics_data_area)? (ENTRY cics_ref)? HOLD?;

/** MONITOR */
cics_monitor: MONITOR POINT cics_data_value DATA1 cics_data_area? DATA2 cics_data_area? (ENTRYNAME cics_data_area)?;

/** MOVE CONTAINER (both) */
cics_move: MOVE CONTAINER cics_data_value AS cics_data_value (cics_move_bts | cics_move_channel)?;
cics_move_bts: (FROMPROCESS | FROMACTIVITY cics_data_value)? (TOPROCESS | TOACTIVITY cics_data_value)?;
cics_move_channel: (CHANNEL cics_data_value)? (TOCHANNEL cics_data_value)?;

/** POINT */
cics_point: POINT (CONVID cics_name | SESSION cics_name)?;

/** POP HANDLE */
cics_pop: POP HANDLE;

/** POST */
cics_post: POST (INTERVAL(ZERO_DIGIT) | INTERVAL cics_hhmmss | TIME cics_hhmmss | cics_post_after)? SET cics_ref (REQID cics_name)?;
cics_post_after: (AFTER | AT) (HOURS cics_data_value | MINUTES cics_data_value | SECONDS cics_data_value)+;

/** PURGE MESSAGE */
cics_purge: PURGE MESSAGE;

/** PUSH HANDLE */
cics_push: PUSH HANDLE;

/** PUT CONTAINER (both of them): */
cics_put: PUT CONTAINER cics_data_value (cics_put_bts | cics_put_channel);
cics_put_bts: (ACTIVITY cics_data_value | ACQACTIVITY | PROCESS | ACQPROCESS)? FROM cics_data_area (FLENGTH cics_data_value)?;
cics_put_channel: (CHANNEL cics_data_value)? FROM cics_data_area (FLENGTH cics_data_value)? (BIT | DATATYPE cics_cvda | CHAR)?
                  (FROMCCSID cics_data_value | FROMCODEPAGE cics_data_value)?;

/** QUERY COUNTER / DCOUNTER / SECURITY */
cics_query: QUERY (cics_query_counter | cics_query_security);
cics_query_counter: (COUNTER cics_name | DCOUNTER cics_name) (POOL cics_name)? (VALUE cics_data_area)? (MINIMUM cics_data_area)?
                    (MAXIMUM cics_data_area)?;
cics_query_security: SECURITY (RESTYPE cics_data_value | RESCLASS cics_data_value RESIDLENGTH cics_data_value) RESID cics_data_value
                     (LOGMESSAGE cics_cvda)? (READ cics_cvda)? (UPDATE cics_cvda)? (CONTROL cics_cvda)? (ALTER cics_cvda)?;
/** READ */
cics_read: READ FILE cics_mama (UNCOMMITTED | CONSISTENT | REPEATABLE | cics_read_update)? (INTO cics_data_area |
           SET cics_ref) RIDFLD cics_data_area cics_read_keylength? (SYSID cics_system LENGTH cics_data_area |
           LENGTH cics_data_area)? (DEBKEY | DEBREC | RBA | RBN | XRBA)? (EQUAL | GTEC)? NOSUSPEND?;
cics_read_update: UPDATE (TOKEN cics_data_area)?;
cics_read_keylength: KEYLENGTH cics_data_value GENERIC?;

/** READNEXT */
cics_readnext: READNEXT FILE cics_mama (INTO cics_data_area | SET cics_ref) (UNCOMMITTED | CONSISTENT | REPETABLE |
               UPDATE TOKEN cics_data_area)? RIDFLD cics_data_area (KEYLENGTH cics_data_value)? (REQID cics_data_value)?
               (cics_readnext_sysid | LENGTH cics_data_area)? (RBA | RRN | XRBA)? NOSUSPEND?;
cics_readnext_sysid: SYSID cics_system (LENGTH cics_data_area)?;

/** READPREV */
cics_readprev: READPREV FILE cics_mama (INTO cics_data_area | SET cics_ref) (UNCOMMITTED | CONSISTENT | REPETABLE |
               UPDATE TOKEN cics_data_area)? RIDFLD cics_data_area (KEYLENGTH cics_data_value)? (REQID cics_data_value)?
               cics_readnext_sysid? LENGTH cics_data_area (RBA | RRN | XRBA)? NOSUSPEND?;

/** READQ TD / TS */
cics_readq: READQ (cics_readq_td | cics_readq_ts);
cics_readq_td: TD QUEUE cics_name (INTO cics_data_area | SET cics_ref) (LENGTH cics_data_area)? (SYSID cics_system)? NOSUSPEND?;
cics_readq_ts: TS? (QUEUE cics_name | QNAME cics_name) (INTO cics_data_area | SET cics_ref) (LENGTH cics_data_area)?
               (NUMITEMS cics_data_area)? (NEXT | ITEM cics_data_value)? (SYSID cics_system)?;

/** RECEIVE */
/** RELEASE */
cics_release: RELEASE PROGRAM cics_name;

/** REMOVE SUBEVENT */
cics_remove: REMOVE SUBEVENT cics_data_value EVENT cics_data_value;

/** RESET ACQPROCESS / ACTIVITY */
cics_reset: RESET (ACQPROCESS | ACTIVITY cics_data_value);

/** RESETBR */
cics_resetbr: RESETBR FILE cics_mama RIDFLD cics_data_area cics_resetbr_keylength? (REQID cics_data_value)?
              (SYSID cics_system)? (GTEQ | EQUAL)? (RBA | RRN |XRBA)?;
cics_resetbr_keylength: KEYLENGTH cics_data_value GENERIC?;

/** RESUME */
cics_resume: RESUME (ACQACTIVITY | ACQPROCESS | ACTIVITY cics_data_value);

/** RETRIEVE - / REATTACH EVENT / SUBEVENT */
cics_retrieve: RETRIEVE (cics_retrieve_null | cics_retrieve_event);
cics_retrieve_null: (INTO cics_data_area | SET cics_ref) (LENGTH cics_data_area)? (RTRANSID cics_data_area)?
                    (RTERMID cics_data_area)? (QUEUE cics_data_area)? WAIT?;
cics_retrieve_event: (REATTACH | SUBEVENT cics_data_area) EVENT cics_data_area (EVENTTYPE cics_cvda)?;



/** RETURN */
cics_return: RETURN cics_return_transid? cics_return_inputmsg? ENDACTIVITY?;
cics_return_transid: TRANSID cics_name (CHANNEL cics_name | cics_return_commarea)? IMMEDIATE?;
cics_return_commarea: COMMAREA cics_data_area (LENGTH cics_data_value)?;
cics_return_inputmsg: INPUTMSG cics_data_area (INPUTMSGLEN cics_data_value)?;

/** REWIND COUNTER / DCOUNTER */
cics_rewind: REWIND (cics_rewind_counter | cics_rewind_dcounter);
cics_rewind_counter: COUNTER cics_name (POOL cics_name)? (INCREMENT cics_data_value)?;
cics_rewind_dcounter: DCOUNTER cics_name (POOL cics_name)? (INCREMENT cics_data_area)?;

/** REWRITE: */
cics_rewrite: REWRITE FILE cics_mama (TOKEN cics_data_area)? FROM cics_data_area (SYSID cics_system
              LENGTH cics_data_value | LENGTH cics_data_value)? NOSUSPEND?;

/** ROUTE */
cics_route: ROUTE (INTERVAL(ZERO_DIGIT) | INTERVAL cics_hhmmss | TIME cics_hhmmss | cics_post_after)? ERRTERM(name?)?
            (TITLE cics_data_area)? (LIST cics_data_area)? (OPCLASS cics_data_area)? (REQID cics_name)? (LDC cics_name)? NLEOM?;

/** RUN */
cics_run: RUN (ACTIVITY cics_data_value | ACQACTIVITY | ACQPROCESS) (SYNCHRONOUS | cics_run_asynchronous)
          (INPUTEVENT cics_data_value)?;
cics_run_asynchronous: ASYNCHRONOUS (FACILITYTOKN cics_data_value)?;

/** SEND */
/** SIGNAL EVENT */
cics_signal: SIGNAL EVENT cics_data_value (FROMCHANNEL cics_data_value | cics_signal_from)?;
cics_signal_from: FROM cics_data_area (FROMLENGTH cics_data_value)?;

/** SIGNOFF */
cics_signoff: SIGNOFF;

/** SIGNON */
cics_signon: SIGNON USERID cics_data_value (ESMREASON cics_data_area)? (ESMRESP cics_data_area)? (GROUPID cics_data_value)?
             (LANGUAGECODE cics_data_value | NATLANG cics_data_value)? (LANGINUSE cics_data_area)? (NATLANGINUSE cics_data_area)?
             (cics_signon_password | cics_signon_phrase)? (OIDCARD cics_data_value)?;
cics_signon_password: PASSWORD  cics_data_value (NEWPASSWORD cics_data_value)?;
cics_signon_phrase: PHRASE cics_data_area PHRASELEN cics_data_value cics_signon_newphrase?;
cics_signon_newphrase: NEWPHRASE cics_data_area NEWPHRASELEN cics_data_value;

/** SOAPFAULT ADD / CREATE / DELETE */
cics_soapfault: SOAPFAULT (cics_soapfault_add | cics_soapfault_create | DELETE);
cics_soapfault_add: ADD (cics_soapfault_faultstring | cics_soapfault_subcodestr) (FROMCCSID cics_data_value)?;
cics_soapfault_faultstring: FAULTSTRING cics_data_value (FAULTSTRLEN cics_data_value)? (NATLANG cics_data_value)?;
cics_soapfault_subcodestr: SUBCODESTR cics_data_value (SUBCODELEN cics_data_value)?;
cics_soapfault_create: CREATE (FAULTCODE cics_cvda | CLIENT | SERVER | SENDER | RECEIVER | cics_soapfault_faultcodestr)
                       cics_soapfault_faultstring cics_soapfault_role? cics_soapfault_faultactor?
                       cics_soapfault_detail? (FROMCCSID cics_data_value)?;
cics_soapfault_faultcodestr: FAULTCODESTR cics_data_value (FAULTCODELEN cics_data_value)?;
cics_soapfault_role: ROLE cics_data_value (ROLELENGTH cics_data_value)?;
cics_soapfault_faultactor: FAULTACTOR cics_data_value (FAULTACTLEN cics_data_value)?;
cics_soapfault_detail: DETAIL cics_data_value (DETAILLENGTH cics_data_value)?;

/** SPOOLCLOSE */
cics_spoolclose: SPOOLCLOSE TOKEN cics_data_area (KEEP | DELETE)? (NOHANDLE | cics_spoolclose_resp)+;
cics_spoolclose_resp: RESP RESP2?;

/** SPOOLOPEN INPUT / OUTPUT */
cics_spoolopen: SPOOLOPEN (cics_spoolopen_input | cics_spoolopen_output);
cics_spoolopen_input: INPUT TOKEN cics_data_area USERID cics_data_value (CLASS cics_data_value)? (NOHANDLE | cics_spoolclose_resp)+;
cics_spoolopen_output: OUTPUT TOKEN cics_data_area USERID cics_data_value NODE cics_data_value (CLASS cics_data_value)?
                       (OUTDESCR cics_ref)? (NOCC | ASA | MCC)? (cics_spoolopen_print | PUNCH)?
                       (NOHANDLE | cics_spoolclose_resp)+;
cics_spoolopen_print: PRINT (RECORDLENGTH cics_data_value)?;

/** SPOOLREAD */
cics_spoolread: SPOOLREAD TOKEN cics_data_area INTO cics_data_area (MAXFLENGTH cics_data_value)? (TOFLENGTH cics_data_area)?
                (NOHANDLE | cics_spoolclose_resp)+;

/** SPOOLWRITE */
cics_spoolwrite: SPOOLWRITE TOKEN cics_data_area FROM cics_data_area (FLENGTH cics_data_value)? (LINE | PAGE)?
                 (NOHANDLE | cics_spoolclose_resp)+;

/** START - / ATTACH / BREXIT / CHANNEL */
cics_start: START (cics_start_transid | cics_start_attach | cics_start_brexit);
cics_start_transid: TRANSID cics_name (cics_start_null | cics_start_channel);
cics_start_null: (INTERVAL(ZERO_DIGIT) | INTERVAL cics_hhmmss | TIME cics_hhmmss | cics_post_after)? (REQID cics_name)? cics_start_from?
                 (TERMID cics_name | USERID cics_data_value)? (SYSID cics_system)? (RTRANSID cics_name)? (RTERMID cics_name)?
                 (QUEUE cics_name)? NOCHECK? PROTECT?;
cics_start_from: FROM cics_data_area LENGTH cics_data_value FMH?;
cics_start_channel: CHANNEL cics_name (TERMID cics_name | USERID cics_data_value)? (SYSID cics_system)?;
cics_start_attach: ATTACH TRANSID cics_name cics_start_afrom?;
cics_start_afrom: FROM cics_data_area (LENGTH cics_data_value)?;
cics_start_brexit: BREXIT(name?) TRANSID cics_name cics_start_brdata? (USERID cics_data_value)?;
cics_start_brdata: BRDATA cics_data_area (BRDATALENGTH cics_data_value)?;

/** STARTBR */
cics_startbr: STARTBR FILE cics_mama RIDFLD cics_data_area cics_startbr_keylength? (REQID cics_data_value)?
              (SYSID cics_system)? (DEBKEY | DEBREC | RBA | RBN | XRBA)? (GTEQ | EQUAL)?;
cics_startbr_keylength: KEYLENGTH cics_data_value GENERIC?;

/** STARTBROWSE ACTIVITY / CONTAINER / EVENT / PROCESS */
cics_startbrowse: STARTBROWSE (cics_startbrowse_activity | cics_startbrowse_container | cics_startbrowse_event |
                  cics_startbrowse_process);
cics_startbrowse_activity: ACTIVITY (ACTIVITYID cics_data_value | PROCESS cics_data_value PROCESSTYPE cics_data_value)?
                           BROWSETOKEN cics_data_area;
cics_startbrowse_container: CONTAINER (ACTIVITYID cics_data_value | PROCESS cics_data_value PROCESSTYPE cics_data_value |
                            CHANNEL cics_data_value)? BROWSETOKEN cics_data_area;
cics_startbrowse_event: EVENT BROWSETOKEN cics_data_area (ACTIVITYID cics_data_value)?;
cics_startbrowse_process: PROCESS PROCESSTYPE cics_data_value BROWSETOKEN cics_data_area;

/** SUSPEND (both) */
cics_suspend: SUSPEND (ACQACTIVITY | ACQPROCESS | ACTIVITY cics_data_value)?;

/** SYNCPOINT / SYNCPOINT ROLLBACK */
cics_syncpoint: SYNCPOINT ROLLBACK?;

/** TEST EVENT */
cics_test: TEST EVENT cics_data_value FIRESTATUS cics_cvda;

/** TRANSFORM DATATOXML / XMLTODATA */
cics_transform: TRANSFORM (cics_transform_datatoxml | cics_transform_xmltodata);
cics_transform_datatoxml: DATATOXML CHANNEL cics_data_value DATCONTAINER cics_data_value cics_transform_elemname?
                          cics_transform_elemns? cics_transform_typenamens? (XMLCONTAINER cics_data_value)?
                          XMLTRANSFORM cics_name;
cics_transform_elemname: ELEMNAME cics_data_area ELEMNAMELEN cics_data_area;
cics_transform_elemns: ELEMNS cics_data_area ELEMNSLEN cics_data_area;
cics_transform_typenamens: cics_transform_typename cics_transform_typens;
cics_transform_typename: TYPENAME cics_data_area TYPENAMELEN cics_data_area;
cics_transform_typens: TYPENS cics_data_area TYPENSLEN cics_data_area;
cics_transform_xmltodata: XMLTODATA CHANNEL cics_data_value (DATCONTAINER cics_data_value)? cics_transform_elemname?
                          cics_transform_elemns? (NSCONTAINER cics_data_value)? cics_transform_typename?
                          cics_transform_typens? XMLCONTAINER cics_data_value (XMLTRANSFORM cics_name)?;

/** UNLOCK */
cics_unlock: UNLOCK FILE cics_mama (TOKEN cics_data_area)? (SYSID cics_system)?;

/** UPDATE COUNTER / DCOUNTER */
cics_update: UPDATE (cics_update_counter | cics_update_dcounter);
cics_update_counter: COUNTER cics_name (POOL cics_name)? VALUE cics_data_value (COMPAREMIN cics_data_value)? (COMPAREMAX cics_data_value)?;
cics_update_dcounter: DCOUNTER cics_name (POOL cics_name)? VALUE cics_data_area (COMPAREMIN cics_data_area)? (COMPAREMAX cics_data_area)?;
/** VERIFY PASSWORD / PHRASE */
cics_verify: VERIFY (PASSWORD cics_data_value | PHRASE cics_data_area PHRASELEN cics_data_value) USERID cics_data_value
             (CHANGETIME cics_data_area)? (DAYSLEFT cics_data_area)? (ESMREASON cics_data_area)? (ESMRESP cics_data_area)?
             (EXPIRYTIME cics_data_area)? (INVALIDCOUNT cics_data_area)? (LASTUSETIME cics_data_area)?;

/** WAIT CONVID / EVENT / EXTERNAL / JOURNALNAME / JOURNALNUM / SIGNAL / TERMINAL */
cics_wait: WAIT (cics_wait_convid | cics_wait_event | cics_wait_external | cics_wait_journalname |
           SIGNAL | cics_wait_terminal);
cics_wait_convid: CONVID cics_name (STATE cics_cvda)?;
cics_wait_event: EVENT ECADDR cics_value (NAME cics_name)?;
cics_wait_external: EXTERNAL ECBLIST cics_value NUMEVENTS cics_data_value (PURGEABLE | BURGEABILITY cics_cvda | NOTPURGEABLE)?
                    (NAME cics_name)?;
cics_wait_journalname: JOURNALNAME cics_data_value (REQID cics_data_value)?;
cics_wait_terminal: TERMINAL (CONVID cics_name | SESSION cics_name)?;

/** WAITCICS */
cics_waitcics: WAITCICS ECBLIST cics_value NUMEVENTS cics_data_value (PURGEABLE | BURGEABILITY cics_cvda | NOTPURGEABLE)?
               (NAME cics_name)?;

/** WEB (all) */
cics_web: WEB (cics_web_close | cics_web_converse | cics_web_endbrowse | cics_web_extract | cics_web_open |
          cics_web_parse | cics_web_read | cics_web_readnext | cics_web_receive | cics_web_retrieve | cics_web_send |
          cics_web_startbrowse | cics_web_write);
cics_web_close: CLOSE SESSTOKEN cics_data_value;
cics_web_converse: CONVERSE SESSTOKEN cics_data_value (PATH cics_data_area PATHLENGTH cics_data_value | URIMAP cics_data_value)?
                   (GET | HEAD | POST | PUT | TRACE | OPTIONS | DELETE | METHOD cics_cvda) (MEDIATYPE cics_data_area)?
                   cics_web_querystring? cics_web_body? (ACTION cics_cvda | EXPECT)? (CLOSE | CLOSESTATUS cics_cvda | NOCLOSE)?
                   cics_web_credentials? (INTO cics_data_area | SET cics_ref | cics_web_tocontainer) TOLENGTH cics_data_area
                   (MAXLENGTH cics_data_value)? NOTRUNCATE? (STATUSCODE cics_data_area)? cics_web_statustext?
                   cics_web_translation? (BODYCHARSET cics_data_area)?;
cics_web_querystring: QUERYSTRING cics_data_area QUERYSTRLEN cics_data_value;
cics_web_tocontainer: TOCONTAINER cics_data_value (TOCHANNEL cics_data_value)?;
cics_web_statustext: STATUSTEXT cics_data_area STATUSLEN cics_data_value;
cics_web_body: (cics_web_doctoken | cics_web_from | cics_web_container);
cics_web_doctoken: DOCTOKEN cics_data_value (NODOCDELETE | DOCDELETE | DOCSTATUS cics_cvda)?;
cics_web_from: FROM cics_data_area FROMLENGTH cics_data_value;
cics_web_container: CONTAINER cics_data_value (CHANNEL cics_data_value)?;
cics_web_credentials: cics_web_username? PASSWORD cics_data_value (PASSWORDLEN cics_data_value)?;
cics_web_username: (NONE | BASICAUTH | AUTHENTICATE cics_cvda) USERNAME cics_data_value (USERNAMELEN cics_data_value)?;
cics_web_translation: (CHARACTERSET cics_data_value)?
                      (CLICONVERT | NOINCONVERT | NOOUTCONERT | NOCLICONVERT | CLIENTCONV cics_cvda)?;
cics_web_endbrowse: ENDBROWSE (FORMFIELD | cics_web_ehttpheader | QUERYPARM);
cics_web_ehttpheader: HTTPHEADER (SESSTOKEN cics_data_value)?;
cics_web_extract: EXTRACT (SCHEME cics_cvda)? cics_web_host? cics_web_httpmethod? cics_web_httpversion? cics_web_path?
                  PORTNUMBER cics_data_area cics_web_querystring? (REQUESTTYPE cics_cvda)?;
cics_web_host: HOST cics_data_area HOSTLENGTH cics_data_value (HOSTTYPE cics_cvda)?;
cics_web_httpmethod: HTTPMETHOD cics_data_area METHODLENGTH cics_data_area;
cics_web_httpversion: HTTPVERSION cics_data_area VERSIONLEN cics_data_area;
cics_web_path: PATH cics_data_area PATHLENGTH cics_data_area;
cics_web_open: OPEN (URIMAP cics_data_value | cics_web_ohost) (CERTIFICATE cics_data_value)? cics_web_ciphers?
               (CODEPAGE cics_data_value)? SESSTOKEN cics_data_area cics_web_httpvnum?;
cics_web_ohost: HOST cics_data_value HOSTLENGTH cics_data_value PORTNUMBER cics_data_value (SCHEME cics_cvda)?;
cics_web_ciphers: CIPHERS cics_data_value NUMCIPHERS cics_data_value;
cics_web_httpvnum: HTTPVNUM cics_data_area HTTPRNUM cics_data_area;
cics_web_parse: PARSE URL cics_data_value URLLENGTH cics_data_value (SCHEMENAME cics_data_area)? cics_web_host?
                (PORTNUMBER cics_data_area)? cics_web_path? cics_web_querystring?;
cics_web_read: READ (cics_web_rformfield | cics_web_rhttpheader | cics_web_rqueryparm);
cics_web_rformfield: FORMFIELD cics_data_area (NAMELENGTH cics_data_value)? (VALUE cics_data_area | SET cics_ref)
                     VALUELENGTH cics_data_area (CHARACTERSET cics_data_value)? (HOSTCODEPAGE cics_data_value)?;
cics_web_rhttpheader: HTTPHEADER cics_data_area NAMELENGTH cics_data_value (SESSTOKEN cics_data_area)? VALUE cics_data_area
                      VALUELENGTH cics_data_area;
cics_web_rqueryparm: QUERYPARM cics_data_value (NAMELENGTH cics_data_value)? (VALUE cics_data_area | SET cics_ref)
                     VALUELENGTH cics_data_area HOSTCODEPAGE cics_data_value;
cics_web_readnext: READNEXT (cics_web_rnformfield | cics_web_rnhttpheader);
cics_web_rnformfield: (FORMFIELD cics_data_area | QUERYPARM cics_data_area) NAMELENGTH cics_data_area
                      VALUE cics_data_area VALUELENGTH cics_data_area;
cics_web_rnhttpheader: HTTPHEADER cics_data_area NAMELENGTH cics_data_area (SESSTOKEN cics_data_value)?
                      VALUE cics_data_area VALUELENGTH cics_data_area;
cics_web_receive: RECEIVE (cics_web_rserver | cics_web_rtocontainer | cics_web_rsesstoken);
cics_web_rserver: (INTO cics_data_area | SET cics_ref) LENGTH cics_data_area (MAXLENGTH cics_data_value)? NOTRUNCATE? (TYPE cics_cvda)?
                  (SRVCONVERT | NOSRVCONVERT | SERVERCONV cics_cvda)? (CHARACTERSET cics_data_value)? (HOSTCODEPAGE cics_data_value)?
                  (BODYCHARSET cics_data_area)? (MEDIATYPE cics_data_value)?;
cics_web_rtocontainer: TOCONTAINER cics_data_value (TOCHANNEL cics_data_value)? (TYPE cics_cvda)? (CHARACTERSET cics_data_value)?
                       (BODYCHARSET cics_data_area)? (MEDIATYPE cics_data_value)?;
cics_web_rsesstoken: SESSTOKEN cics_data_value (MEDIATYPE cics_data_area)? (cics_web_rcbuffers | cics_web_rccontainers);
cics_web_rcbuffers: cics_web_statuscode? (INTO cics_data_area | SET cics_ref) LENGTH cics_data_area (MAXLENGTH cics_data_value)?
                    NOTRUNCATE? (CLICONVERT | NOCLICONVERT | CLIENTCONV cics_cvda)? (BODYCHARSET cics_data_area)?;
cics_web_statuscode: STATUSCODE cics_data_value cics_web_statustext;
cics_web_rccontainers: cics_web_statustext? TOCONTAINER cics_data_value (TOCHANNEL cics_data_value)? (BODYCHARSET cics_data_area)?;
cics_web_retrieve: RETRIECE DOCTOKEN cics_data_area;
cics_web_send: SEND (cics_web_sserver | cics_web_sclient);
cics_web_sserver: (cics_web_doctoken | cics_web_ssfrom | cics_web_container) (MEDIATYPE cics_data_value)?
                  (SRVCONVERT | NOSRVCONVERT | SERVERCONV cics_cvda)? (CHARACTERSET cics_data_value)? cics_web_ssstatuscode?
                  (IMMEDIATE | EVENTUAL | ACTION cics_cvda)? (NOCLOSE | CLOSE | CLOSESTATUS cics_cvda)?;
cics_web_sfrom: FROM cics_data_area FROMLENGTH cics_data_value (CHUNKNO | CHUNKYES | CHUNKEND | CHUNKING cics_cvda)?;
cics_web_ssfrom: cics_web_sfrom (HOSTCODEPAGE cics_data_value)?;
cics_web_ssstatuscode: STATUSCODE cics_data_value STATUSTEXT cics_data_area (STATUSLEN cics_data_value | LENGTH cics_data_value);
cics_web_sclient: SESSTOKEN cics_data_value (GET | HEAD | POST | PUT | TRACE | OPTIONS | DELETE | METHOD cics_cvda)
                  (cics_web_path | URIMAP cics_data_value)? cics_web_querystring? cics_web_scbody?
                  (CLICONVERT | NOCLICONVERT | CLIENTCONV cics_cvda)? (CHARACTERSET cics_data_value)? (EXPECT | ACTION cics_cvda)?
                   (NOCLOSE | CLOSE | CLOSESTATUS cics_cvda)? cics_web_scauth?;
cics_web_scbody: MEDIATYPE cics_data_value (cics_web_doctoken | cics_web_sfrom | cics_web_container)?;
cics_web_scauth: (NONE | BASICAUTH | AUTHENTICATE cics_cvda)? cics_web_sccredentials?;
cics_web_sccredentials: USERNAME cics_data_value (USERNAMELEN cics_data_value)? PASSWORD cics_data_value (PASSWORDLEN cics_data_value)?;
cics_web_startbrowse: STARTBROWSE (cics_web_sbformfield | cics_web_sbhttpheader | cics_web_sbqueryparm);
cics_web_sbformfield: FORMFIELD(data_area?) (NAMELENGTH cics_data_area)? (CHARACTERSET cics_data_value)? (HOSTCODEPAGE cics_data_value)?;
cics_web_sbhttpheader: HTTPHEADER (SESSTOKEN cics_data_area)?;
cics_web_sbqueryparm: QUERYPARM(data_area?) (NAMELENGTH cics_data_area)? (HOSTCODEPAGE cics_data_value)?;
cics_web_write: WRITE HTTPHEADER cics_data_area (NAMELENGTH cics_data_value)? (SESSTOKEN cics_data_value)?
                VALUE cics_data_area (VALUELENGTH cics_data_value)?;

/** WRITE / WRITE JOURNALNAME / WRITE OPERATOR */
cics_write: WRITE (cics_write_file | cics_write_journalname | cics_write_operator);
cics_write_file: FILE cics_mama MASSINSERT? FROM cics_data_area RIDFLD cics_data_area (KEYLENGTH cics_data_value)?
                 (SYSID cics_system LENGTH cics_data_value | LENGTH cics_data_value)? (RBA | RBN | XRBA)? NOSUSPEND?;
cics_write_journalname: JOURNALNAME cics_data_value JTYPEID cics_data_value FROM cics_data_area (FLENGTH cics_data_value)?
                        (REQID cics_data_area)? cics_write_prefix? WAIT? NOSUSPEND?;
cics_write_prefix: PREFIX cics_data_value (PFXLENG cics_data_value)?;
cics_write_operator: OPERATOR TEXT cics_data_value (TEXTLENGTH cics_data_value)? cics_write_routecodes?
                     (EVENTUAL | ACTION cics_cvda | CRITICAL | IMMEDIATE | cics_write_reply)?;
cics_write_routecodes: ROUTECODES cics_data_value NUMROUTES cics_data_value;
cics_write_reply: REPLY cics_data_area MAXLENGTH cics_data_value (REPLYLENGTH cics_data_area)? (TIMEOUT cics_data_value)?;

/** WRITEQ TD/TS */
cics_writeq: WRITEQ (cics_writeq_td | cics_writeq_ts);
cics_writeq_td: TD QUEUE cics_name FROM cics_data_area (LENGTH cics_data_value)? (SYSID cics_system)?;
cics_writeq_ts: TS? (QUEUE cics_name | QNAME cics_name) FROM cics_data_area (LENGTH cics_data_value)?
                (NUMITEMS cics_data_area | cics_writeq_item)? (SYSID cics_system)? (AUXILIARY | MAIN)? NOSUSPEND?;
cics_writeq_item: ITEM cics_data_area REWRITE?;

/** WSACONTEXT BUILD / DELETE / GET */
cics_wsacontext: WSACONTEXT (cics_wsacontext_build | cics_wsacontext_delete | cics_wsacontext_get);
cics_wsacontext_build: BUILD (CHANNEL cics_data_value)? (ACTION cics_data_value | MESSAGEID cics_data_value |
                       cics_wsacontext_relatesuri | cics_wsacontext_eprtype)+ (FROMCCSID cics_data_value |
                       FROMCODEPAGE cics_data_value)?;
cics_wsacontext_relatesuri: RELATESURI cics_data_value (RELATESTYPE cics_data_value)?;
cics_wsacontext_eprtype: EPRTYPE cics_cvda EPRFIELD cics_cvda EPRFROM cics_cvda EPRLENGTH cics_data_value;
cics_wsacontext_delete: DELETE CHANNEL cics_data_value;
cics_wsacontext_get: GET CONTEXTTYPE cics_cvda (CHANNEL cics_data_value)? (ACTION cics_data_area | MESSAGEID cics_data_area |
                     cics_wsacontext_grelatesuri | cics_wsacontext_geprtype)+ (INTOCCSID cics_data_value |
                     INTOCODEPAGE cics_data_value)?;
cics_wsacontext_grelatesuri: RELATESURI cics_data_area (RELATESTYPE cics_data_area)? (RELATESINDEX cics_data_value)?;
cics_wsacontext_geprtype: EPRTYPE cics_cvda EPRFIELD cics_cvda (EPRINTO cics_data_area | EPRSET cics_ref) EPRLENGTH cics_data_area;
/** WSAEPR CREATE */
cics_wsaepr: WSAEPR CREATE (EPRINTO cics_data_area | EPRSET cics_data_area) EPRLENGTH cics_data_area (ADDRESS cics_data_value |
             REFPARMS cics_data_value REFPARMSLEN cics_data_value | METADATA cics_data_value | METADATALEN cics_data_value)+
             (FROMCCSID cics_data_value | FROMCODEPAGE cics_data_value)?;
/** XCTL: */
cics_xctl: XCTL PROGRAM cics_name (cics_xctl_commarea | CHANNEL cics_name)? cics_xctl_inputmsg?;
cics_xctl_commarea: COMMAREA cics_data_area (LENGTH cics_data_value)?;
cics_xctl_inputmsg: INPUTMSG cics_data_area (INPUTMSGLEN cics_data_value)?;

cicsWords:  ABCODE | ABDUMP | ABEND | ABORT | ABPROGRAM | ABSTIME | ACEE | ACQACTIVITY | ACQPROCESS | ACQUACTIVITY |
            ACTION | ACTIVITY | ACTIVITYID | ADD | ADDRESS | AFTER | AID | ALLOCATE | ALTER | ALTSCRNHT | ALTSCRNWD |
            AND | ANYKEY | APLKYBD | APLTEXT | APPLID | AS | ASA | ASKTIME | ASRAINTRPT | ASRAKEY | ASRAPSW |
            ASRAREGS | ASRASPC | ASRASTG | ASSIGN | ASYNCHRONOUS | AT | ATTACH | ATTACHID | ATTRIBUTES | AUTHENTICATE |
            AUXILIARY | BASE64 | BASICAUTH | BELOW | BIF | BINARY | BIT | BODYCHARSET | BOOKMARK | BRDATA |
            BRDATALENGTH | BREXIT | BRIDGE | BROWSETOKEN | BTRANS | BUFFER | BUILD | BURGEABILITY | CADDRLENGTH |
            CANCEL | CARD | CCSID | CERTIFICATE | CHANGE | CHANGETIME | CHANNEL | CHAR | CHARACTERSET | CHECK |
            CHUNKEND | CHUNKING | CHUNKNO | CHUNKYES | CICSDATAKEY | CIPHERS | CLASS | CLEAR | CLICONVERT | CLIENT |
            CLIENTADDR | CLIENTADDRNU | CLIENTCONV | CLIENTNAME | CLNTADDR6NU | CLNTIPFAMILY | CLOSE | CLOSESTATUS |
            CLRPARTN | CMDSEC | CNAMELENGTH | CODEPAGE | COLOR | COMMAREA | COMMONNAME | COMMONNAMLEN | COMPAREMAX |
            COMPAREMIN | COMPLETE | COMPOSITE | COMPSTATUS | CONDITION | CONFIRM | CONFIRMATION | CONNECT |
            CONSISTENT | CONSOLE | CONTAINER | CONTEXTTYPE | CONTROL | CONVDATA | CONVERSE | CONVERTST | CONVERTTIME |
            CONVID | COPY | COUNTER | COUNTRY | COUNTRYLEN | CREATE | CRITICAL | CTLCHAR | CWA | CWALENG | DATA |
            DATA1 | DATA2 | DATALENGTH | DATALENTH | DATAONLY | DATAPOINTER | DATASTR | DATATOXML | DATATYPE |
            DATCONTAINER | DATE | DATEFORM | DATESEP | DATESTRING | DAYCOUNT | DAYOFMONTH | DAYOFWEEK | DAYOFYEAR |
            DAYS | DAYSLEFT | DCOUNTER | DDMMYY | DDMMYYYY | DEBKEY | DEBREC | DEEDIT | DEFINE | DEFRESP | DEFSCRNHT |
            DEFSCRNWD | DELAY | DELETE | DELETEQ | DELIMITER | DEQ | DESTCOUNT | DESTID | DESTIDLENG | DETAIL |
            DETAILLENGTH | DIGEST | DIGESTTYPE | DISCONNECT | DOCDELETE | DOCSIZE | DOCSTATUS | DOCTOKEN | DOCUMENT |
            DS3270 | DSSCS | DUMP | DUMPCODE | DUMPID | ECADDR | ECBLIST | EIB | ELEMNAME | ELEMNAMELEN | ELEMNS |
            ELEMNSLEN | END | ENDACTIVITY | ENDBR | ENDBROWSE | ENDFILE | ENDOUTPUT | ENQ | ENTER | ENTRY | ENTRYNAME |
            EODS | EPRFIELD | EPRFROM | EPRINTO | EPRLENGTH | EPRSET | EPRTYPE | EQUAL | ERASE | ERASEAUP | ERROR |
            ERRTERM | ESMREASON | ESMRESP | EVENT | EVENTTYPE | EVENTUAL | EWASUPP | EXCEPTION | EXPECT | EXPIRYTIME |
            EXTDS | EXTERNAL | EXTRACT | FACILITY | FACILITYTOKN | FAULTACTLEN | FAULTACTOR | FAULTCODE | FAULTCODELEN |
            FAULTCODESTR | FAULTSTRING | FAULTSTRLEN | FCI | FCT | FIELD | FILE | FIRESTATUS | FLENGTH | FMH | FOR |
            FORCE | FORMATTIME | FORMFIELD | FREE | FREEMAIN | FROM | FROMACTIVITY | FROMCCSID | FROMCHANNEL |
            FROMCODEPAGE | FROMDOC | FROMLENGTH | FROMPROCESS | FULLDATE | GCHARS | GCODES | GDS | GENERIC | GET |
            GETMAIN | GETNEXT | GMMI | GROUPID | GTEC | GTEQ | HANDLE | HEAD | HEX | HILIGHT | HOLD | HOST |
            HOSTCODEPAGE | HOSTLENGTH | HOSTTYPE | HOURS | HTTPHEADER | HTTPMETHOD | HTTPRNUM | HTTPVERSION | HTTPVNUM |
            IGNORE | IMMEDIATE | INCREMENT | INITIMG | INITPARM | INITPARMLEN | INPARTN | INPUT | INPUTEVENT |
            INPUTMSG | INPUTMSGLEN | INQUIRE | INSERT | INTERVAL | INTO | INTOCCSID | INTOCODEPAGE | INVALIDCOUNT |
            INVITE | INVOKE | INVOKINGPROG | ISSUE | ISSUER | ITEM | IUTYPE | JOURNALNAME | JTYPEID | KATAKANA |
            KEEP | KEYLENGTH | KEYNUMBER | LABEL | LANGINUSE | LANGUAGECODE | LAST | LASTUSETIME | LDC | LDCMNEM |
            LDCNUM | LENGTH | LENGTHLIST | LEVEL | LIGHTPEN | LINE | LINK | LIST | LISTLENGTH | LLID | LOAD | LOCALITY |
            LOCALITYLEN | LOGMESSAGE | LOGMODE | LOGONLOGMODE | LOGONMSG | LUNAME | MAIN | MAPCOLUMN | MAPHEIGHT |
            MAPLINE | MAPWIDTH | MASSINSERT | MAXDATALEN | MAXFLENGTH | MAXIMUM | MAXLENGTH | MAXLIFETIME | MAXPROCLEN |
            MCC | MEDIATYPE | MESSAGE | MESSAGEID | METADATA | METADATALEN | METHOD | METHODLENGTH | MILLISECONDS |
            MINIMUM | MINUTES | MMDDYY | MMDDYYYY | MODE | MODENAME | MONITOR | MONTH | MONTHOFYEAR | MOVE |
            MSRCONTROL | NAME | NAMELENGTH | NATLANG | NATLANGINUSE | NETNAME | NEWPASSWORD | NEWPHRASE | NEWPHRASELEN |
            NEXT | NEXTTRANSID | NLEOM | NOCC | NOCHECK | NOCLICONVERT | NOCLOSE | NODATA | NODE | NODOCDELETE |
            NODUMP | NOHANDLE | NOINCONVERT | NONE | NOOUTCONERT | NOQUEUE | NOQUIESCE | NOSRVCONVERT | NOSUSPEND |
            NOTE | NOTPURGEABLE | NOTRUNCATE | NOWAIT | NSCONTAINER | NUMCIPHERS | NUMEVENTS | NUMITEMS | NUMREC |
            NUMROUTES | NUMSEGMENTS | NUMTAB | OIDCARD | ON | OPCLASS | OPEN | OPERATION | OPERATOR | OPERID |
            OPERKEYS | OPID | OPSECURITY | OPTIONS | OR | ORGABCODE | ORGANIZATION | ORGANIZATLEN | ORGUNIT |
            ORGUNITLEN | OUTDESCR | OUTLINE | OUTPUT | OWNER | PA | PAGE | PAGENUM | PARSE | PARTNER | PARTNPAGE |
            PARTNS | PARTNSET | PASS | PASSWORD | PASSWORDLEN | PATH | PATHLENGTH | PCT | PF | PFXLENG | PHRASE |
            PHRASELEN | PIPLENGTH | PIPLIST | POINT | POOL | POP | PORTNUMBER | PORTNUMNU | POST | PPT | PREDICATE |
            PREFIX | PREPARE | PRINCONVID | PRINSYSID | PRINT | PRIORITY | PRIVACY | PROCESS | PROCESSTYPE |
            PROCLENGTH | PROCNAME | PROFILE | PROGRAM | PROTECT | PS| PUNCH | PURGE | PURGEABLE | PUSH | PUT | QNAME |
            QUERY | QUERYPARM | QUERYSTRING | QUERYSTRLEN | QUEUE | RBA | RBN | READ | READNEXT | READPREV | READQ |
            REATTACH | RECEIVE | RECEIVER | RECFM | RECORD | RECORDLEN | RECORDLENGTH | REDUCE | REFPARMS |
            REFPARMSLEN | RELATESINDEX | RELATESTYPE | RELATESURI | RELEASE | REMOVE | REPEATABLE | REPETABLE |
            REPLACE | REPLY | REPLYLENGTH | REQID | REQUESTTYPE | RESCLASS | RESET | RESETBR | RESID | RESIDLENGTH |
            RESOURCE | RESP | RESP2 | RESSEC | RESTART | RESTYPE | RESULT | RESUME | RETCODE | RETCORD | RETRIECE |
            RETRIEVE | RETURN | RETURNPROG | REWIND | REWRITE | RIDFLD | ROLE | ROLELENGTH | ROLLBACK | ROUTE |
            ROUTECODES | RPROCESS | RRESOURCE | RRN | RTERMID | RTRANSID | RUN | SADDRLENGTH | SCHEME | SCHEMENAME |
            SCOPE | SCOPELEN | SCRNHT | SCRNWD | SECONDS | SECURITY | SEGMENTLIST | SEND | SENDER | SERIALNUM |
            SERIALNUMLEN | SERVER | SERVERADDR | SERVERADDRNU | SERVERCONV | SERVERNAME | SERVICE | SESSION |
            SESSTOKEN | SET | SHARED | SIGDATA | SIGNAL | SIGNOFF | SIGNON | SIT | SNAMELENGTH | SOAPFAULT | SOSI |
            SPOOLCLOSE | SPOOLOPEN | SPOOLREAD | SPOOLWRITE | SRVCONVERT | SRVRADDR6NU | SRVRIPFAMILY | SSLTYPE |
            START | STARTBR | STARTBROWSE | STARTCODE | STATE | STATELEN | STATIONID | STATUS | STATUSCODE | STATUSLEN |
            STATUSTEXT | STORAGE | STRINGFORMAT | SUBADDR | SUBCODELEN | SUBCODESTR | SUBEVENT | SUSPEND | SUSPSTATUS |
            SYMBOL | SYMBOLLIST | SYNCHRONOUS | SYNCLEVEL | SYNCONRETURN | SYNCPOINT | SYSID | TABLES | TASK |
            TASKPRIORITY | TCPIP | TCPIPSERVICE | TCT | TCTUA | TCTUALENG | TD | TELLERID | TEMPLATE | TERMCODE |
            TERMID | TERMINAL | TERMPRIORITY | TEST | TEXT | TEXTKYBD | TEXTLENGTH | TEXTPRINT | TIME | TIMEOUT |
            TIMER | TIMESEP | TITLE | TO | TOACTIVITY | TOCHANNEL | TOCONTAINER | TOFLENGTH | TOKEN | TOLENGTH |
            TOPROCESS | TRACE | TRACENUM | TRANPRIORITY | TRANSACTION | TRANSFORM | TRANSID | TRIGGER | TRT | TS |
            TWA | TWALENG | TYPE | TYPENAME | TYPENAMELEN | TYPENS | TYPENSLEN | UNATTEND | UNCOMMITTED | UNESCAPED |
            UNLOCK | UNTIL | UOW | UPDATE | URI | URIMAP | URL | URLLENGTH | USERDATAKEY | USERID | USERNAME |
            USERNAMELEN | USERPRIORITY | USING | VALIDATION | VALUE | VALUELENGTH | VERIFY | VERSIONLEN | VOLUME |
            VOLUMELENG | WAIT | WAITCICS | WEB | WPMEDIA | WRAP | WRITE | WRITEQ | WSACONTEXT | WSAEPR | XCTL |
            XMLCONTAINER | XMLTODATA | XMLTRANSFORM | XRBA | YEAR | YYDDD | YYDDMM | YYYYDDD | YYYYDDMM | YYYYMMDD |
            ZERO_DIGITAL;

cics_data_area: LPARENCHAR data_area RPARENCHAR;
cics_data_value: LPARENCHAR data_value RPARENCHAR;
cics_cvda: LPARENCHAR cvda RPARENCHAR;
cics_name: LPARENCHAR name RPARENCHAR;
cics_ref: LPARENCHAR ptr_ref RPARENCHAR;
cics_system: LPARENCHAR systemName RPARENCHAR;
cics_mama: LPARENCHAR mama RPARENCHAR;
cics_hhmmss: LPARENCHAR hhmmss RPARENCHAR;
cics_label: LPARENCHAR label RPARENCHAR;
cics_value: LPARENCHAR ptr_value RPARENCHAR;

cicsWord: cicsWords | IDENTIFIER;

name: cicsWord;
data_value: cicsWord;
data_area: cicsWord;
cvda: cicsWord;
systemName: cicsWord;
ptr_ref: cicsWord;
ptr_value: cicsWord;
cics_document_set_symbollist: cicsWord;
mama: cicsWord;
label: cicsWord;
hhmmss: cicsWord;
today: cicsWord;
condition: cicsWord;

firstThreeDigits: FIRST_THREE_DIGITS;
first24Digits: FIRST_24_DIGITS;
