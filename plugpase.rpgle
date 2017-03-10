     H NOMAIN
     H AlwNull(*UsrCtl)
     H BNDDIR('QC2LE')
   
      *****************************************************
      * Copyright (c) 2010, IBM Corporation
      * All rights reserved.
      *
      * Redistribution and use in source and binary forms, 
      * with or without modification, are permitted provided 
      * that the following conditions are met:
      * - Redistributions of source code must retain 
      *   the above copyright notice, this list of conditions 
      *   and the following disclaimer. 
      * - Redistributions in binary form must reproduce the 
      *   above copyright notice, this list of conditions 
      *   and the following disclaimer in the documentation 
      *   and/or other materials provided with the distribution.
      * - Neither the name of the IBM Corporation nor the names 
      *   of its contributors may be used to endorse or promote 
      *   products derived from this software without specific 
      *   prior written permission. 
      *
      * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
      * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
      * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
      * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
      * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
      * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
      * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
      * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
      * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
      * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
      * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
      * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
      * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
      * POSSIBILITY OF SUCH DAMAGE.
      *****************************************************

      *****************************************************
      * includes
      *****************************************************
      /copy plugconf_h
      /copy plugmri_h
      /copy plugpase_h
      /copy plugxml_h
      /copy plugile_h
      /copy plugbug_h
      /copy plugipc_h
      /copy plugerr_h
      /copy plugcach_h
      /copy plugconv_h
      /copy plugperf_h

      *****************************************************
      * global vars
      *****************************************************
     D sPaseMsg        S             10i 0 inz(0)
     D sLib            S             20U 0 inz(0)
     D sPaseAdopt      S              1N   inz(*OFF)

     d QP2_ARG_END...
     d                 c                   const(0)
     d QP2_ARG_WORD...
     d                 c                   const(-1)
     d QP2_ARG_DWORD...
     d                 c                   const(-2)
     d QP2_ARG_FLOAT32...
     d                 c                   const(-3)
     d QP2_ARG_FLOAT64...
     d                 c                   const(-4)
     d QP2_ARG_PTR32...
     d                 c                   const(-5)
     d QP2_ARG_PTR64...
     d                 c                   const(-6)

     d QP2_RESULT_VOID...
     d                 c                   const(0)
     d QP2_RESULT_WORD...
     d                 c                   const(-1)
     d QP2_RESULT_DWORD...
     d                 c                   const(-2)
     d QP2_RESULT_FLOAT64...
     d                 c                   const(-4)
     d QP2_RESULT_PTR32...
     d                 c                   const(-5)
     d QP2_RESULT_PTR64...
     d                 c                   const(-6)

     D paAlloc         s             20u 0 inz(0)
     D piAlloc         s               *   inz(*NULL)
     D piCallPase      s               *   inz(*NULL)
     D piSig           s               *   inz(*NULL)
     D piBase          s               *   inz(*NULL)
     D piArgv          s               *   inz(*NULL)

      *****************************************************
      * PASE job log noise for Alan (1.6.7)
      *****************************************************
     d QP2_JOBLOG_DSPOBJD_PGM...
     d                 c                   const('P')
     d QP2_JOBLOG_DSPOBJD_SRVPGM...
     d                 c                   const('S')
     D PaseGenLog      PR
     D  op                            1A   value
     D  pgm1                         10A   value
     D  lib1                         10A   value

      *****************************************************
      * PASE
      *****************************************************
      *  int _RSLOBJ2(ILEpointer      *sysptr,
      *               unsigned short  type_subtype,
      *               const char      *objname,
      *               const char      *libname);
     DpiRSLOBJ2Parms...
     D                 S               *
     D SZRSLOBJ2       c                   const(256)
     Dr2Args           DS                  qualified based(piRSLOBJ2Parms)
     D r2SysPtr                      10U 0
     D r2Pad                          5U 0
     D r2SubType                      2A
     D r2ObjName                     10U 0
     D r2LibName                     10U 0
     D r2SysPtr1                       *
     D r2ObjName1                    11A
     D r2LibName1                    11A
     D r2Pad1                         5U 0
     D r2Me                          10U 0
     Dr2ArgSig         DS
     D r2Sig1                         5i 0 inz(QP2_ARG_PTR32)
     D r2Sig2                         5i 0 inz(QP2_ARG_WORD)
     D r2Sig3                         5i 0 inz(QP2_ARG_PTR32)
     D r2Sig4                         5i 0 inz(QP2_ARG_PTR32)
     D r2SigEnd                       5i 0 inz(0)
     D r2RetSig        S             10i 0 inz(QP2_RESULT_WORD)
     D r2Name          S             10A   inz('_RSLOBJ2')
     D r2Toc           S               *

      * int _PGMCALL(const ILEpointer *target,
      *              void             **argv,
      *              unsigned         flags)
     D PGMCALL_NOMAXARGS...
     D                 c                   const(8)
     D PGMCALL_DIRECTARGS...
     D                 c                   const(1)
     DpiPGMCALLParms...
     D                 S               *
     D SZPGMCALL       c                   const(256)
     DpcArgs           DS                  qualified based(piPGMCALLParms)
     D pcTarget                      10U 0
     D pcArgv                        10U 0
     D pcFlags                       10U 0
     D pcPad                         10U 0
     D pcTarget1                       *
     D pcMe                          10U 0
     DpcArgSig         DS
     D pcSig1                         5i 0 inz(QP2_ARG_PTR32)
     D pcSig2                         5i 0 inz(QP2_ARG_PTR32)
     D pcSig3                         5i 0 inz(QP2_ARG_WORD)
     D pcSigEnd                       5i 0 inz(0)
     D pcRetSig        S             10i 0 inz(QP2_RESULT_WORD)
     D pcName          S             10A   inz('_PGMCALL')
     D pcToc           S               *

      * int _ILELOAD(const void  *id, unsigned int flags)
      *
     D ILELOAD_PATH    c                   const(0)
     D ILELOAD_LIBOBJ  c                   const(1)
     D ILELOAD_PGMPTR  c                   const(2)
     DpiILELOADParms...
     D                 S               *
     D SZILELOAD       c                   const(256)
     DloArgs           DS                  qualified based(piILELOADParms)
     D loId                          10u 0
     D loFlags                       10i 0
     D loPad1                        10U 0
     D loPad2                        10U 0
     D loTarget1                       *
     D loPad                          5U 0
     D loMe                          10U 0
     DloArgSig         DS
     D loSig1                         5i 0 inz(QP2_ARG_PTR32)
     D loSig2                         5i 0 inz(QP2_ARG_WORD)
     D loSigEnd                       5i 0 inz(0)
     D loRetSig        S             10i 0 inz(QP2_RESULT_WORD)
     D loName          S             10A   inz('_ILELOAD')
     D loToc           S               *

      * int _ILESYM(ILEpointer *export,
      *             int actmark, const char  *symbol);
      *
     DpiILESYMParms...
     D                 S               *
     D SZILESYM        c                   const(256)
     DsyArgs           DS                  qualified based(piILESYMParms)
     D syExport                      10U 0 
     D syActMark                     10i 0
     D sySymb                        10U 0
     D syPad                         10U 0
     D syExport1                       * 
     D sySymb1                      128A
     D syMe                          10U 0
     DsyArgSig         DS
     D sySig1                         5i 0 inz(QP2_ARG_PTR32)
     D sySig2                         5i 0 inz(QP2_ARG_WORD)
     D sySig3                         5i 0 inz(QP2_ARG_PTR32)
     D sySigEnd                       5i 0 inz(0)
     D syRetSig        S             10i 0 inz(QP2_RESULT_WORD)
     D syName          S             10A   inz('_ILESYM')
     D syToc           S               *

      * int _ILECALL(const ILEpointer *target,
      *              ILEarglist_base  *ILEarglist,
      *              const arg_type_t *signature,
      *              result_type_t    result_type)
     D ILECALL_NOERROR...
     D                 c                   const(0)
     DpiILECALLParms...
     D                 S               *
     D SZILECALL       c                   const(256)
     DieArgs           DS                  qualified based(piILECALLParms)
     D ieTarget                      10U 0 
     D ieBase                        10U 0
     D ieSig                         10U 0
     D ieRet                         10i 0
     D ieTarget1                       * 
     D ieMe                          10U 0
     DieArgSig         DS
     D ieSig1                         5i 0 inz(QP2_ARG_PTR32)
     D ieSig2                         5i 0 inz(QP2_ARG_PTR32)
     D ieSig3                         5i 0 inz(QP2_ARG_PTR32)
     D ieSig4                         5i 0 inz(QP2_ARG_WORD)
     D ieSigEnd                       5i 0 inz(0)
     D ieRetSig        S             10i 0 inz(QP2_RESULT_WORD)
     D ieName          S             10A   inz('_ILECALL')
     D ieToc           S               *

      * FILE * popen(const char *cmd, const char *mode);
     DpiPOPENParms...
     D                 S               *
     D SZPOPEN         c                   const(256)
     DpoArgs           DS                  qualified based(piPOPENParms)
     D poCmd                         10U 0 
     D poMode                        10U 0
     D poFd                          10U 0
     D poMode1                        2A
     D poRsv                          6A
     D poMe                          10U 0
     DpoArgSig         DS
     D poSig1                         5i 0 inz(QP2_ARG_PTR32)
     D poSig2                         5i 0 inz(QP2_ARG_PTR32)
     D poSigEnd                       5i 0 inz(0)
     D poRetSig        S             10i 0 inz(QP2_RESULT_PTR32)
     D poName          S             10A   inz('popen')
     D poToc           S               *

      * char *fgets(char *s, int n, FILE *stream);
     DpiFGETSParms...
     D                 S               *
     D SZFGETS         c                   const(256)
     DfgArgs           DS                  qualified based(piFGETSParms)
     D fgS                           10U 0 
     D fgN                           10i 0
     D fgStream                      10U 0
     D fgMe                          10U 0
     DfgArgSig         DS
     D fgSig1                         5i 0 inz(QP2_ARG_PTR32)
     D fgSig2                         5i 0 inz(QP2_ARG_WORD)
     D fgSig3                         5i 0 inz(QP2_ARG_PTR32)
     D fgSigEnd                       5i 0 inz(0)
     D fgRetSig        S             10i 0 inz(QP2_RESULT_PTR32)
     D fgName          S             10A   inz('fgets')
     D fgToc           S               *

      * int pclose (FILE *stream);
     DpiPCLOSEParms...
     D                 S               *
     D SZPCLOSE        c                   const(16)
     DclArgs           DS                  qualified based(piPCLOSEParms)
     D clStream                      10U 0 
     D clMe                          10U 0
     DclArgSig         DS
     D clSig1                         5i 0 inz(QP2_ARG_PTR32)
     D clSigEnd                       5i 0 inz(0)
     D clRetSig        S             10i 0 inz(QP2_RESULT_WORD)
     D clName          S             10A   inz('pclose')
     D clToc           S               *

      * ILEarglist_base
     D PaseArgListBase...
     D                 ds                  qualified based(piBase)
     D   base_desc                     *
     D   base_aggr                     *
     D PaseReturnAggregate...
     D                 ds                  qualified based(piBase)
     D   aggr_desc                     *
     D   aggr_fill                    8A
     D   aggr_addr                   20U 0
     D PaseReturn8...
     D                 ds                  qualified based(piBase)
     D   a8_desc                       *
     D   a8_fill                      7A
     D   a8_data                      3U 0
     D PaseReturn16...
     D                 ds                  qualified based(piBase)
     D   a16_desc                      *
     D   a16_fill                     6A
     D   a16_data                     5U 0
     D PaseReturn32...
     D                 ds                  qualified based(piBase)
     D   a32_desc                      *
     D   a32_fill                     4A
     D   a32_data                    10U 0
     D PaseReturn64...
     D                 ds                  qualified based(piBase)
     D   a64_desc                      *
     D   a64_data                    20U 0
     D PaseReturnReal...
     D                 ds                  qualified based(piBase)
     D   f64_desc                      *
     D   f64_data                     8f


      *****************************************************
      * ILE c PASE enablers
      *****************************************************
     d Qp2RunPase      pr            10I 0 extproc('Qp2RunPase')
     d  ppathName                      *   value options(*string)
     d  psymName                       *   value options(*string)
     d  psymlDat                       *   value options(*string)
     d  psymDataL                    10U 0 value
     d  pccsid                       10I 0 value
     d  pargv                          *   value
     d  penvp                          *   value

     d Qp2malloc       pr              *   extproc('Qp2malloc')
     d  pmem_size                    20U 0 value
     d  pmem_pase                      *   value

     d Qp2free         pr                  extproc('Qp2free')
     d  pmem_pase                      *   value

     d Qp2dlopen       pr            20U 0 extproc('Qp2dlopen')
     d  ppath                          *   value options(*string)
     d  pflags                       10I 0 value
     d  pccsid                       10I 0 value

     d Qp2dlsym        pr              *   extproc('Qp2dlsym')
     d  pid                          20U 0 value
     d  pname                          *   value options(*string)
     d  pccsid                       10I 0 value
     d  psym_Pase                      *   value

      * PASE procedure ran to completion 
      * and its function result stored
     d QP2CALLPASE_NORMAL...
     d                 c                   const(0)
      * PASE procedure ran to completion, 
      * but its function result could not be stored
     d QP2CALLPASE_RESULT_ERROR...
     d                 c                   const(1)
      * no i5/OS PASE program is running in the job
     d QP2CALLPASE_ENVIRON_ERROR...
     d                 c                   const(2)
      * One or more values in the signature array are not valid.
     d QP2CALLPASE_ARG_ERROR...
     d                 c                   const(4)
      * The i5/OS PASE program is terminating. 
      * No function result was returned.
     d QP2CALLPASE_TERMINATING...
     d                 c                   const(6)
      * The i5/OS PASE program returned without exiting
     d QP2CALLPASE_RETURN_NOEXIT...
     d                 c                   const(7)

     d Qp2CallNow      pr            10I 0 extproc('Qp2CallPase')
     d  ptarget                        *   value
     d  parglist                       *   value
     d  psignature                     *   value
     d  presult                       5I 0 value
     d  pbuf                           *   value

     d Qp2CallPase     pr            10I 0
     d  ptarget                        *   value
     d  parglist                       *   value
     d  psignature                     *   value
     d  presult                       5I 0 value
     d  pbuf                           *   value

     d Qp2EndPase      pr            10I 0 extproc('Qp2EndPase')

     d Qp2SignalPase...
     d                 pr            10I 0 extproc('Qp2SignalPase')
     d  sig                          10I 0 value

     d Qp2errnop       pr              *   extproc('Qp2errnop')

     d Qp2paseCCSID...
     d                 pr            10I 0 extproc('Qp2paseCCSID')

     d Qp2jobCCSID...
     d                 pr            10I 0 extproc('Qp2jobCCSID')


      *****************************************************
      * dynamic call
      *****************************************************
     D AnyDS           ds                  qualified based(Template)
     D   AnyProc                       *   Procptr
     D anyProc         s               *   inz(*NULL)

      *****************************************************
      * dynamic JVM start (1.9.2)
     D sJVMPortSy      S               *   inz(*NULL)
     D sJVMPortRs      s               *   inz(*NULL)
     D sJVMPortDS      ds                  likeds(AnyDS) based(sJVMPortRs)
     D jvmPort         PR            10I 0
     D   type                        10i 0 value
     D   port                        10i 0 value

     D sJVMSQLSy       S               *   inz(*NULL)
     D jvmSQL          PR            10I 0

     D jvmRPG          PR            10I 0

      *****************************************************
      * Pase job log - force job log information
      *****************************************************
     P PaseGenLog      B
     D PaseGenLog      PI
     D  op                            1A   value
     D  pgm1                         10A   value
     D  lib1                         10A   value
      * vars
     D rcb             s              1N   inz(*ON)
     D cmdstr          s           3000A   inz(*BLANKS)
     D cmdp            s               *   inz(%addr(cmdstr))
     D cmdlen          s             10i 0 inz(0)
      /free
       select;
       when op = QP2_JOBLOG_DSPOBJD_PGM;
         cmdstr = 'DSPOBJD'
                + ' OBJ('+%trim(lib1)+'/'+%trim(pgm1)+')'
                + ' OBJTYPE(*PGM)';
         cmdlen = %len(%trim(cmdstr));
         rcb = ileCmdExc(cmdp:cmdlen);
       when op = QP2_JOBLOG_DSPOBJD_SRVPGM;
         cmdstr = 'DSPOBJD'
                + ' OBJ('+%trim(lib1)+'/'+%trim(pgm1)+')'
                + ' OBJTYPE(*SRVPGM)';
         cmdlen = %len(%trim(cmdstr));
         rcb = ileCmdExc(cmdp:cmdlen);
       other;
       endsl;
      /end-free
     P                 E

      *****************************************************
      * Pase errno
      *****************************************************
     P PaseEZero       B                   export
     D PaseEZero       PI             1N
      * vars
     D rcb             S              1N   inz(*OFF)
     d paErrnop        S               *   inz(*NULL)
     d Errno_t         ds                  based(paErrnop)
     d  paErrno                      10I 0
      /free
       Monitor;
         // errno address
         paErrnop = Qp2errnop();
         if paErrnop <> *NULL;
           paErrno = 0;
           rcb = *ON;
         endif;
       On-error;
       Endmon;
       return rcb;
      /end-free
     P                 E

     P PaseErrno       B                   export
     D PaseErrno       PI            10I 0
      * vars
     d paErrnop        S               *   inz(*NULL)
     d Errno_t         ds                  based(paErrnop)
     d  paErrno                      10I 0
      /free
       Monitor;
         // errno address
         paErrnop = Qp2errnop();
         if paErrnop <> *NULL;
           return paErrno;
         endif;
       On-error;
       Endmon;
       return 0;
      /end-free
     P                 E

      *****************************************************
      * Pase last set ccsid
      *****************************************************
     P PaseLstCCSID...
     P                 B                   export
     d PaseLstCCSID...
     d                 PI            10I 0
      * vars
     D rcb             s              1N   inz(*ON)
      /free
       // pase really alive ...
       rcb = PaseEZero();
       if rcb = *OFF;
         return 0;
       endif;
       return Qp2paseCCSID();
      /end-free
     P                 E

      *****************************************************
      * Pase job set ccsid
      *****************************************************
     P PaseJobCCSID...
     P                 B                   export
     d PaseJobCCSID...
     d                 PI            10I 0
      * vars
     D rcb             s              1N   inz(*ON)
      /free
       // pase really alive ...
       rcb = PaseEZero();
       if rcb = *OFF;
         return 0;
       endif;
       return Qp2jobCCSID();
      /end-free
     P                 E


      *****************************************************
      * JVM the RPG way
      *****************************************************
     P jvmRPG          B
     D jvmRPG          PI            10I 0
      *
     d rc              s             10i 0 inz(-1)
     D myfunc          S             10A   inz(*BLANKS)
     D propstr         S               O   CLASS(*JAVA:'java.lang.String')
     D makeString      PR              O   EXTPROC(*JAVA:'java.lang.String':
     D                                      *CONSTRUCTOR)
     D    bytes                    4096A   CONST VARYING
      /free
       Monitor;

       myfunc = 'jvmRPG';
       propstr = makeString('java.class.path');
       rc = 0;

       On-error;
         errsSevere(QP2_ERROR_ILECALL_FAIL:myfunc);
       Endmon;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * dynamic call QSYS/QSQLEJEXT
      * JVM in debug mode (start JVM)
      *   type = 1
      *   port = 30000
      *****************************************************
     P jvmPort         B
     D jvmPort         PI            10I 0
     D   type                        10i 0 value
     D   port                        10i 0 value
      * vars
     d rc              s             10i 0 inz(-1)
     d rcb             s              1N   inz(*OFF)
     D mypgm           S             10A   inz(*BLANKS)
     D mylib           S             10A   inz(*BLANKS)
     D myfunc          S            128A   inz(*BLANKS)
      *
     D procPtr         S               *   ProcPtr
     D jvmPort2        Pr            10i 0 ExtProc(procPtr)
     D  pargv1                         *   value
     D  pargv2                         *   value
      /free
       Monitor;
       mypgm = 'QSQLEJEXT';
       mylib = 'QSYS';
       myfunc = 'getJVMtypeAndPort';

       rcb = ileRslv(mypgm:mylib:sJVMPortSy:myfunc);
       if rcb = *OFF;
         return rc;
       endif;

       sJVMPortRs = %addr(sJVMPortSy);

       procPtr = sJVMPortDS.AnyProc;
       rc = jvmPort2(%addr(type):%addr(port));

       On-error;
         errsSevere(QP2_ERROR_ILECALL_FAIL:myfunc);
       Endmon;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * dynamic call  QSYS/QSQSTPC
      * jvmSQL stored proc call (start JVM)
      *   int            callType
      *   char         * externalName
      *   struct sqlda * sqldaInOut
      *   struct sqlca * sqlca 
      *   int            resultSets
      *   char         * schemaName
      *   char         * procedureName
      *   char         * specificName
      *****************************************************
     P jvmSQL          B
     D jvmSQL          PI            10I 0
      * vars
     d rc              s             10i 0 inz(-1)
     d rcb             s              1N   inz(*OFF)
     D mypgm           S             10A   inz(*BLANKS)
     D mylib           S             10A   inz(*BLANKS)
     D myfunc          S            128A   inz(*BLANKS)
      *
     d i               s             10i 0 inz(0)
     D mcall           s             10i 0 inz(0)
     D mext            s             80A   inz(*BLANKS)
     D msqda           s               *   inz(*NULL)
     D msqca           s             10U 0 dim(256)
     D mres            s             10i 0 inz(0)
     D mschm           s            129A   inz(*BLANKS)
     D mproc           s            129A   inz(*BLANKS)
     D mspec           s            129A   inz(*BLANKS)
      *
     D argc            S             10I 0 inz(0)
     D argv            s               *   dim(256) inz(*NULL)
      /free
       Monitor;

       mypgm = 'QSQSTPJC';
       mylib = 'QSYS';

       rcb = ileRslv(mypgm:mylib:sJVMSQLSy);
       if rcb = *OFF;
         return rc;
       endif;

       //   00000     000000F0 00000170 00000000 E6E2D8C7
       msqca(1)   = x'000000F0';
       msqca(2)   = x'00000170';
       msqca(3)   = x'00000000';
       msqca(4)   = x'E6E2D8C7';
       //   00010     C4C9C1F0 0000002C 00000007 00000001
       msqca(5)   = x'C4C9C1F0';
       msqca(6)   = x'0000002C';
       msqca(7)   = x'00000007';
       msqca(8)   = x'00000001';
       //   00020     00000000 00000000 00000000 00000000
       msqca(9)   = x'00000000';
       msqca(10)  = x'00000000';
       msqca(11)  = x'00000000';
       msqca(12)  = x'00000000';
       //   00030     00000000 00000000 00000000 00000000
       msqca(13)  = x'00000000';
       msqca(14)  = x'00000000';
       msqca(15)  = x'00000000';
       msqca(16)  = x'00000000';
       //   00040     00000000 00000000 00000000 00000000
       msqca(17)  = x'00000000';
       msqca(18)  = x'00000000';
       msqca(19)  = x'00000000';
       msqca(20)  = x'00000000';
       //   00050     D5000000 00000001 00000000 00000000
       msqca(21)  = x'D5000000';
       msqca(22)  = x'00000001';
       msqca(23)  = x'00000000';
       msqca(24)  = x'00000000';
       //   00060     00000002 0000000F 00016000 00000000
       msqca(25)  = x'00000002';
       msqca(26)  = x'0000000F';
       msqca(27)  = x'00016000';
       msqca(28)  = x'00000000';
       //   00070     00000000 00000000 00000000 00000000
       msqca(29)  = x'00000000';
       msqca(30)  = x'00000000';
       msqca(31)  = x'00000000';
       msqca(32)  = x'00000000';
       //   00080     00000000 00000000 00000000 00000000
       msqca(33)  = x'00000000';
       msqca(34)  = x'00000000';
       msqca(35)  = x'00000000';
       msqca(36)  = x'00000000';
       //   00090     00000000 00000000 00000000 00000000
       msqca(37)  = x'00000000';
       msqca(38)  = x'00000000';
       msqca(39)  = x'00000000';
       msqca(40)  = x'00000000';
       //   000A0     00000000 00000000 00000000 000000F0
       msqca(41)  = x'00000000';
       msqca(42)  = x'00000000';
       msqca(43)  = x'00000000';
       msqca(44)  = x'000000F0';
       //   000B0     00000000 00000000 00000000 00000000
       msqca(45)  = x'00000000';
       msqca(46)  = x'00000000';
       msqca(47)  = x'00000000';
       msqca(48)  = x'00000000';
       //   000C0     00000000 00000000 00000000 00000000
       msqca(49)  = x'00000000';
       msqca(50)  = x'00000000';
       msqca(51)  = x'00000000';
       msqca(52)  = x'00000000';
       //   000D0     00000000 00000000 00000000 00000000
       msqca(53)  = x'00000000';
       msqca(54)  = x'00000000';
       msqca(55)  = x'00000000';
       msqca(56)  = x'00000000';
       //   000E0     00000000 00000000 00000000 00000000
       msqca(57)  = x'00000000';
       msqca(58)  = x'00000000';
       msqca(59)  = x'00000000';
       msqca(60)  = x'00000000';
       //   000F0     00000080 00000000 E6E2D8C7 C3D6D5F0
       msqca(61)  = x'00000080';
       msqca(62)  = x'00000000';
       msqca(63)  = x'E6E2D8C7';
       msqca(64)  = x'C3D6D5F0';
       //   00100     00000000 00000000 00000000 00000000
       msqca(65)  = x'00000000';
       msqca(66)  = x'00000000';
       msqca(67)  = x'00000000';
       msqca(68)  = x'00000000';
       //   00110     F0F0F0F0 F0000000 00000000 00000000
       msqca(69)  = x'F0F0F0F0';
       msqca(70)  = x'F0000000';
       msqca(71)  = x'00000000';
       msqca(72)  = x'00000000';
       //   00120     00000000 00000000 00000000 00000000
       msqca(73)  = x'00000000';
       msqca(74)  = x'00000000';
       msqca(75)  = x'00000000';
       msqca(76)  = x'00000000';
       //   00130     00000000 00000000 00000000 00000000
       msqca(77)  = x'00000000';
       msqca(78)  = x'00000000';
       msqca(79)  = x'00000000';
       msqca(80)  = x'00000000';
       //   00140     00000000 00000000 00000000 00000000
       msqca(81)  = x'00000000';
       msqca(82)  = x'00000000';
       msqca(83)  = x'00000000';
       msqca(84)  = x'00000000';
       //   00150     00000000 00000000 00000000 00000000
       msqca(85)  = x'00000000';
       msqca(86)  = x'00000000';
       msqca(87)  = x'00000000';
       msqca(88)  = x'00000000';
       //   00160     00000000 00000000 00000000 00000000
       msqca(89)  = x'00000000';
       msqca(90)  = x'00000000';
       msqca(91)  = x'00000000';
       msqca(92)  = x'00000000';
       //   00170     00000000 00000000 00000000 00000000
       msqca(93)  = x'00000000';
       msqca(94)  = x'00000000';
       msqca(95)  = x'00000000';
       msqca(96)  = x'00000000';
       //   00180     00000000 00000000 00000000 00000000
       msqca(97)  = x'00000000';
       msqca(98)  = x'00000000';
       msqca(99)  = x'00000000';
       msqca(100) = x'00000000';
       //   00190     00000000 00000000 00000000 00000000
       msqca(101) = x'00000000';
       msqca(102) = x'00000000';
       msqca(103) = x'00000000';
       msqca(104) = x'00000000';
       //   001A0     00000080 00000000 E6E2D8C7 C3D6D5F0
       msqca(105) = x'00000080';
       msqca(106) = x'00000000';
       msqca(107) = x'E6E2D8C7';
       msqca(108) = x'C3D6D5F0';
       //   001B0     00000000 00000000 00000000 00000000
       msqca(109) = x'00000000';
       msqca(110) = x'00000000';
       msqca(111) = x'00000000';
       msqca(112) = x'00000000';
       //   001C0     F0F0F0F0 F0000000 00000000 00000000
       msqca(113) = x'F0F0F0F0';
       msqca(114) = x'F0000000';
       msqca(115) = x'00000000';
       msqca(116) = x'00000000';
       //   001D0 ...
       for i = 117 to 256;
         msqca(i) = x'00000000';
       endfor;

       mcall  = 2;
       mext   = 'java.lang.System.gc' + x'00';
       msqda  = *NULL;
       // msqca above
       mres   = 0;
       mschm  = 'QGPL' + x'00';
       mproc  = 'GC' + x'00';
       mspec  = 'GC' + x'00';

       rc = 0;
       argc = 8;
       argv(1) = %addr(mcall);
       argv(2) = %addr(mext);
       argv(3) = %addr(msqda);
       argv(4) = %addr(msqca);
       argv(5) = %addr(mres);
       argv(6) = %addr(mschm);
       argv(7) = %addr(mproc);
       argv(8) = %addr(mspec);
       callpgmv(sJVMSQLSy:argv:argc);

       On-error;
         errsSevere(QP2_ERROR_ILECALL_FAIL:mypgm);
         rc = -1;
       Endmon;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * Pase start 32 bit
      *****************************************************
     P PaseStart32     B                   export
     D PaseStart32     PI             1N
     D   myMax                       10i 0 value
     D   paseCtl                           likeds(paseRec_t)
      * vars
     Diarg             DS
     D ipgm                          30A   inz('/usr/lib/start32')
     D iarg1                           *   inz(*NULL)
     D iargend                         *   inz(*NULL)
     Dienv             DS
     D iatt                          30A   inz('PASE_THREAD_ATTACH=Y')
     D ienv1                           *   inz(*NULL)
     D ienvend                         *   inz(*NULL)
     D rc              S             10I 0 inz(0)
     D rcb             S              1N   inz(*OFF)
     D paQuad          s             20u 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D oneByte         s              1A   inz(*BLANKS)
     D paseCCSID       S             10i 0 inz(0)
     D jvm             S              1N   inz(*OFF)
     D jvmSQLa         S              1N   inz(*OFF)
     D jvmDbga         S              1N   inz(*OFF)
      /free
       perfAdd(PERF_ANY_WATCH_PASESTART:*ON);

       // PASE already started
       // touch memory to make sure
       if sLib > 0 and paAlloc > 0;
         Monitor;
           pCopy = piAlloc;
           oneByte = myCopy.bytex;
           myCopy.bytex = *BLANKS;
           myCopy.bytex = oneByte;
         On-error;
           PaseStop();
         Endmon;
       endif;

       // copy out memory allocation
       // as PASE is dead (no memory)
       paseCtl.paseOrig   = 0;
       paseCtl.paseResv   = *BLANKS;
       paseCtl.paseOrigP  = *NULL;
       paseCtl.paseCallP  = *NULL;
       paseCtl.paseSigP   = *NULL;
       paseCtl.paseArgvP  = *NULL;

       // PASE not available
       if sLib = 0;
         // PASE already usable in this process ???
         // load PASE common libraries libc.a (0=bad, !0=good)
         Monitor;
           sLib = Qp2dlopen(*NULL: X'00000002': 0);
         On-error;
         Endmon;
         // adopting already running PASE
         if sLib > 0;
           sPaseAdopt = *ON;
         else;
           sPaseAdopt = *OFF;
           PaseStop();
         endif;

         // PASE still not available,
         // if not running stateless (*here),
         // try to start PASE
         if sPaseAdopt = *OFF;
           piAlloc = *NULL;
           paAlloc = 0;

           // init parms
           iarg1 = %ADDR(ipgm);
           ienv1 = %ADDR(iatt);
           ipgm = %trim(ipgm) + x'00';
           iatt = %trim(iatt) + x'00';
           // return (0==good, -1==bad, -2=exit PASE alive)
           Monitor;
             // running JVM in process (1.9.2)
             jvm = ipcDoJVM();
             if jvm = *OFF;
               // @ADC remove 819 hard code value 
               // in favour of user ctl *pase value (1.7.6)
               paseCCSID = getccsidPASE();
               if paseCCSID <= 0;
                 paseCCSID = 819;
               endif;
               rc = Qp2RunPase(iarg1: *NULL: *NULL: 0: paseCCSID: 
                       %ADDR(iarg1): %ADDR(ienv1));
             else;
               // JVM in my QSQ process 
               // (peanut butter on my chocolate)
               jvmSQLa = ipcDoSQLJVM();
               // JVM SQL stored proc start
               if jvmSQLa = *ON;
                 rc = jvmSQL();
               // alternate JVM start
               else;
                 jvmDbga = ipcDoDbgJVM();
                 // debug JVM SQL mode
                 if jvmDbga = *ON;
                   rc = jvmPort(1:30000);
                 // normal classpath RPG JVM
                 else;
                   rc = jvmRPG();
                 endif;
               endif;
             endif;
           On-error;
             rc = -1;
             PaseStop();
           Endmon;
           if rc = -1;
             errsCritical(QP2_ERROR_START32_FAIL:ipgm);
             perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
             return *OFF;
           endif;

           // load PASE common libraries libc.a (0=bad, !0=good)
           Monitor;
             sLib = Qp2dlopen(*NULL: X'00000002': 0);
           On-error;
             PaseStop();
           Endmon;
           if sLib = 0;
             errsCritical(QP2_ERROR_LOAD_LIBC_FAIL:ipgm);
             perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
             return *OFF;
           endif;
         endif;

         // PASE call buffer memory
         if piAlloc = *NULL or paAlloc = 0;
           Monitor;
             paAlloc = 0;
             piAlloc = Qp2malloc(myMax:%addr(paAlloc));
           On-error;
             PaseStop();
           Endmon;
           if paAlloc = 0;
             errsCritical(QP2_ERROR_MALLOC_FAIL:%char(myMax));
             perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
             return *OFF;
           endif;
         endif;

         // set all PASE library functions
         Monitor;

         // move to quad align
         paQuad = uintQuad(paAlloc);
         piCallPase = piAlloc + (paQuad-paAlloc);
         piSig = piCallPase + SZCALLPASE;
         piBase = piSig + SZSIG;
         piArgv = piBase + SZBASE;

         // _RSLOBJ2
         piRSLOBJ2Parms = piCallPase;
         r2Name = %trim(r2Name) + x'00';
         r2Toc = Qp2dlsym(sLib: %ADDR(r2Name): 0: *NULL);
         if r2Toc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:r2Name);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         // _PGMCALL
         piPGMCALLParms = piRSLOBJ2Parms + SZRSLOBJ2;
         pcName = %trim(pcName) + x'00';
         pcToc = Qp2dlsym(sLib: %ADDR(pcName): 0: *NULL);
         if pcToc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:pcName);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         // _ILELOAD
         piILELOADParms = piPGMCALLParms + SZPGMCALL;
         loName = %trim(loName) + x'00';
         loToc = Qp2dlsym(sLib: %ADDR(loName): 0: *NULL);
         if loToc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:loName);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         // _ILESYM
         piILESYMParms = piILELOADParms + SZILELOAD;
         syName = %trim(syName) + x'00';
         syToc = Qp2dlsym(sLib: %ADDR(syName): 0: *NULL);
         if syToc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:syName);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         // _ILECALL
         piILECALLParms = piILESYMParms + SZILESYM;
         ieName = %trim(ieName) + x'00';
         ieToc = Qp2dlsym(sLib: %ADDR(ieName): 0: *NULL);
         if ieToc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:ieName);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         // popen
         piPOPENParms = piILECALLParms + SZILECALL;
         poName = %trim(poName) + x'00';
         poToc = Qp2dlsym(sLib: %ADDR(poName): 0: *NULL);
         if poToc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:poName);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         // fgets
         piFGETSParms = piPOPENParms + SZPOPEN;
         fgName = %trim(fgName) + x'00';
         fgToc = Qp2dlsym(sLib: %ADDR(fgName): 0: *NULL);
         if fgToc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:fgName);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         // pclose
         piPCLOSEParms = piFGETSParms + SZFGETS;
         clName = %trim(clName) + x'00';
         clToc = Qp2dlsym(sLib: %ADDR(clName): 0: *NULL);
         if clToc = *NULL;
           errsCritical(QP2_ERROR_SYMB_FAIL:clName);
           perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
           return *OFF;
         endif;

         On-error;
           PaseStop();
         Endmon;

       endif;


       // copy out memory allocation
       paseCtl.paseOrig   = paAlloc;
       paseCtl.paseResv   = *BLANKS;
       paseCtl.paseOrigP  = piAlloc;
       paseCtl.paseCallP  = piCallPase;
       paseCtl.paseSigP   = piSig;
       paseCtl.paseArgvP  = piArgv;

       // ok 
       perfAdd(PERF_ANY_WATCH_PASESTART:*OFF);
       return *ON;
      /end-free
     P                 E


      *****************************************************
      * PaseStop
      *****************************************************
     P PaseStop        B                   export
     D PaseStop        PI
      * vars
     D rc              S             10I 0
     D i               S             10I 0
     D rcb             S              1N   inz(*OFF)
      /free
       // clear all
       // free memory 1.6.8
       rcb = PaseEZero();
       if rcb = *ON;
         Monitor;
           if piAlloc <> *NULL;
             Qp2free(piAlloc);
           endif;
         On-error;
         Endmon;
       endif;
       // PASE not available
       if sLib = 0;
         // PASE already usable in this process ???
         // load PASE common libraries libc.a (0=bad, !0=good)
         Monitor;
           sLib = Qp2dlopen(*NULL: X'00000002': 0);
         On-error;
         Endmon;
         // adopting already running PASE
         if sLib > 0;
           sPaseAdopt = *ON;
         else;
           sPaseAdopt = *OFF;
         endif;
       endif;
       sLib        = 0;
       sPaseMsg    = 0;
       paAlloc     = 0;
       piAlloc     = *NULL;
       piCallPase  = *NULL;
       piSig       = *NULL;
       piBase      = *NULL;
       piArgv      = *NULL;
       // you cannot end PASE in adopt
       if sPaseAdopt = *OFF;
         Monitor;
         // SIGKILL PASE (just in case)
         rc=Qp2SignalPase(-9);
         // end PASE (!0=bad, 0=good)
         rc=Qp2EndPase();
         On-error;
         Endmon;
       endif;
      /end-free
     P                 E


      *****************************************************
      * Pase Call
      *****************************************************
     P Qp2CallPase     B
     d Qp2CallPase     PI            10I 0
     d  ptarget                        *   value
     d  parglist                       *   value
     d  psignature                     *   value
     d  presult                       5I 0 value
     d  pbuf                           *   value
      * vars
     D rc              S             10I 0
     D i               S             10I 0
      /free
       Monitor;

       // call pase now
       rc = Qp2CallNow(ptarget:parglist:psignature:presult:pbuf);

       On-error;
       Endmon;

       // PASE death
       if rc = QP2CALLPASE_TERMINATING;
         PaseStop();
       endif;

       return rc;
      /end-free
     P                 E

      *****************************************************
      * rc=PaseRslv32(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling ILE and call argument buffer
      * was prepared by plugile using "ILE memory" 
      * (not pase memory)
      *
      * ptr = rslvsp(objType:pgm1:lib1:x'0000');
      *
      * actmark = ileload(srvpgm, errno_ile)
      * QleActBndPgmLong(srvpgm,
      *         0, // don't need by-address actmark
      *         0, // don't need activation info
      *         0, //  no activation info length
      *         0); // don't return error code
      *
      * rc = ilesym(actmark, symbolName, exportPtr, errno_ile);
      * QleGetExpLong(&actmark,
      *         0, // don't need export id
      *         0, // name is null-terminated string
      *         (char*)symbolName, // proto not const-correct
      *         exportPtr,
      *         &exportType,
      *         0); // don't return error code
      *****************************************************
     P PaseRslv32      B                   export
     D PaseRslv32      PI             1N
     D  pgm2                         10A   value
     D  lib2                         10A   value
     D  pSym                           *
     D  sym2                        128A   value options(*nopass)
      * vars
     D rcb             S              1N   inz(*OFF)
     D rc              S             10I 0 inz(0)
     D pgm1            s             10A   inz(*BLANKS)
     D lib1            s             10A   inz(*BLANKS)
     D sym1            s            128A   inz(*BLANKS)
     D len1            S             10I 0 inz(0)
     D typ1            S             10I 0 inz(0)
     D pILEChk         S               *   inz(*NULL)
     D pILESym         S               *   inz(*NULL)
     D deadPtr         S               *   Procptr inz(*NULL)
     D AnyDS           ds                  qualified based(Template)
     D   AnyPtr                        *   Procptr
     D myPtr           s               *   inz(*NULL)
     D myDS            ds                  likeds(AnyDS) based(myPtr)
      * more
     D objType         S              2A   inz(RSLOBJ_TS_PGM)
     D objPase         S              1A   inz(QP2_JOBLOG_DSPOBJD_PGM)
     D actmark         S             10i 0 inz(0)
     D actmark1        S             20i 0 inz(0)
     D paseRc          S             10I 0 inz(0)
     D sym0            S            128A   inz(*BLANKS)
      /free
       Monitor;

       if %parms >= 4;
         sym1 = sym2;
       endif;

       pSym = *NULL;
       myPtr = %addr(pILESym);

       if sym1 <> *BLANKS;
         objType = RSLOBJ_TS_SRVPGM;
         objPASE = QP2_JOBLOG_DSPOBJD_SRVPGM;
       endif;

       // convert 
       pgm1 = pgm2;
       rcb = toUpperSafe(%addr(pgm1):%size(pgm1));
       lib1 = lib2;
       rcb = toUpperSafe(%addr(lib1):%size(lib1));

       // library list (1.6.8)
       if lib1 = *BLANKS;
          lib1 = '*LIBL';
       endif;

       // _RSLOBJ2/rslvsp cache
       rcb = cacScanPgm(CAC_QP2_RSLOBJ2:pgm1:lib1:sym0:
                      pILESym:actmark);
       if rcb = *OFF;
         // rc = _RSLOBJ2(pILESym, objType, pgm1, lib1)
         r2Args.r2Me = paAlloc+(piRSLOBJ2Parms-piAlloc);
         r2Args.r2SysPtr  = paAlloc+(%addr(r2Args.r2SysPtr1)-piAlloc);
         r2Args.r2SubType = objType;
         r2Args.r2Pad = 0;
         r2Args.r2ObjName = paAlloc+(%addr(r2Args.r2ObjName1)-piAlloc);
         r2Args.r2LibName = paAlloc+(%addr(r2Args.r2LibName1)-piAlloc);
         r2Args.r2ObjName1 = %trim(pgm1) + x'00';
         rc = convPASE(%addr(r2Args.r2ObjName1)
                      :%len(r2Args.r2ObjName1):*OFF);
         r2Args.r2LibName1 = %trim(lib1) + x'00';
         rc = convPASE(%addr(r2Args.r2LibName1)
                      :%len(r2Args.r2LibName1):*OFF);
         r2Args.r2SysPtr1 = *NULL;
         r2Args.r2Pad1 = 0;
         rc = Qp2CallPase(r2Toc:piRSLOBJ2Parms:
                          %ADDR(r2ArgSig):r2RetSig:
                          %addr(paseRc));
         // _RSLOBJ2 ok
         if rc = QP2CALLPASE_NORMAL and paseRc > -1;
           pILESym = r2Args.r2SysPtr1;
           cacAddPgm(CAC_QP2_RSLOBJ2:pgm1:lib1:sym0:
                 pILESym:actmark);
         else;
           PaseGenLog(objPASE:pgm1:lib1);
           errsSevere(QP2_ERROR_RSLOBJ2_FAIL:pgm1);
           return *OFF;
         endif;
       endif;

       // ------------
       // *PGM
       if sym1 = *BLANKS;
         pSym = pILESym;
         return *ON;
       endif;

       // ------------
       // *SRVPGM

       // _ILELOAD cache;
       rcb = cacScanPgm(CAC_QP2_ILELOAD:pgm1:lib1:sym1:
                    pILESym:actmark);
       if rcb = *OFF;
         // QleActBndPgmLong API to activate bound program
         // actmark = _ILELOAD(ile_svrpgm, ILELOAD_PGMPTR);
         loArgs.loMe = paAlloc+(piILELOADParms-piAlloc);
         loArgs.loId = paAlloc+(%addr(loArgs.loTarget1)-piAlloc);
         loArgs.loFlags = ILELOAD_PGMPTR;
         loArgs.loPad1 = 0;
         loArgs.loPad2 = 0;
         loArgs.loTarget1 = pILESym;
         rc = Qp2CallPase(loToc:piILELOADParms:
                        %ADDR(loArgSig):loRetSig:
                        %addr(paseRc));
         // _ILELOAD ok
         if rc = QP2CALLPASE_NORMAL and paseRc > -1;
           actmark = paseRc;
           cacAddPgm(CAC_QP2_ILELOAD:pgm1:lib1:sym1:
                   pILESym:actmark);
         else;
           PaseGenLog(QP2_JOBLOG_DSPOBJD_SRVPGM:pgm1:lib1);
           errsSevere(QP2_ERROR_ILELOAD_FAIL:sym1);
           return *OFF;
         endif;
       endif;

       // _ILESYM cache;
       rcb = cacScanPgm(CAC_QP2_ILESYM:pgm1:lib1:sym1:
                    pILESym:actmark);
       if rcb = *OFF;
         // QleGetExpLong API to find symbol
         // rc = _ILESYM(pILESym, actmark, func);
         syArgs.syMe = paAlloc+(piILESYMParms-piAlloc);
         syArgs.syExport = paAlloc+(%addr(syArgs.syExport1)-piAlloc);
         syArgs.syActMark = actmark;
         syArgs.sySymb = paAlloc+(%addr(syArgs.sySymb1)-piAlloc);
         syArgs.sySymb1 = %trim(sym1) + x'00';
         rc = convPASE(%addr(syArgs.sySymb1):%len(syArgs.sySymb1):*OFF);
         syArgs.syExport1 = *NULL;
         rc = Qp2CallPase(syToc:piILESYMParms:
                        %ADDR(syArgSig):syRetSig:
                        %addr(paseRc));
         // _ILESYM ok
         if rc = QP2CALLPASE_NORMAL and paseRc > -1;
           pILESym = syArgs.syExport1;
           cacAddPgm(CAC_QP2_ILESYM:pgm1:lib1:sym1:
                   pILESym:actmark);
         else;
           errsSevere(QP2_ERROR_ILESYM_FAIL:sym1);
           return *OFF;
         endif;
       endif;

       // --------------
       // procedure pointer
       pSym = pILESym;

       On-error;
         errsSevere(QP2_ERROR_RSLOBJ2_FAIL:pgm1);
         return *OFF;
       Endmon;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * rc=PasePGM32(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling ILE and call argument buffer
      * was prepared by plugile using "ILE memory" 
      * (not pase memory) 
      *****************************************************
     P PasePGM32       B                   export
     D PasePGM32       PI             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  piReturn                       *
     D  allByValue                    1N
      * vars
     D i               S             10I 0 inz(0)
     D j               S             10I 0 inz(0)
     D rcb             S              1N   inz(*OFF)
     D rc              S             10I 0 inz(0)
     D paseRc          S             10I 0 inz(0)
     D min             S             10U 0 inz(X'FFFFFFFF')
     D pILESym         S               *   inz(*NULL)
     D actmark         S             10I 0 inz(0)
     D pCopy           s               *   inz(*NULL)
     D myCopy          ds                  likeds(over_t) based(pCopy)
      * debug
     D tBenArgSz       s             10i 0 inz(0)
     D tBenArgP        S               *   inz(*NULL)
     D tBenPrmSz       s             10i 0 inz(0)
     D tBenPrmP        S               *   inz(*NULL)
     D tBenRetSz       s             10i 0 inz(0)
     D tBenRetP        S               *   inz(*NULL)
      /free
       Monitor;

       tBenArgSz = ileSzArgv(tBenArgP);
       tBenPrmSz = ileSzParm(tBenPrmP);
       tBenRetSz = ileSzRet(tBenRetP);

       rcb = ileRslv(pgm1:lib1:pILESym);
       if rcb = *OFF;
         return *OFF;
       endif;

       // rc=_PGMCALL(pILESym, (void**)arglist,
       //             PGMCALL_NOMAXARGS|PGMCALL_DIRECT_ARGS);
       pcArgs.pcMe = paAlloc+(piPGMCALLParms-piAlloc);
       pcArgs.pcTarget = paAlloc+(%addr(pcArgs.pcTarget1)-piAlloc);
       pcArgs.pcArgv = paAlloc+(piArgv-piAlloc);
       if allByValue = *ON;
         pcArgs.pcFlags = PGMCALL_DIRECTARGS;
       else;
         pcArgs.pcFlags = PGMCALL_NOMAXARGS;
       endif;
       pcArgs.pcPad = 0;
       pcArgs.pcTarget1 = pILESym;
       rc = Qp2CallPase(pcToc:piPGMCALLParms:
                      %ADDR(pcArgSig):pcRetSig:
                      %addr(paseRc));
       // pgmcall ok
       if rc = QP2CALLPASE_NORMAL and paseRc > -1;
         if piReturn <> *NULL;
           pCopy = piReturn;
           myCopy.intx = paseRc;
         endif;
         return *ON;
       else;
         errsSevere(QP2_ERROR_PGMCALL_FAIL:pgm1);
         return *OFF;
       endif;

       On-error;
         errsSevere(QP2_ERROR_PGMCALL_FAIL:pgm1);
         return *OFF;
       Endmon;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * rc=PaseSRV32(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling ILE and call argument buffer
      * was prepared by plugile using "ILE memory" 
      * (not pase memory) 
      *****************************************************
     P PaseSRV32       B                   export
     D PaseSRV32       PI             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  sym1                        128A
     D  piReturn                       *
     D  retSize                      10i 0
      * vars
     D j               S             10I 0 inz(0)
     D mixOPM          S              1N   inz(*OFF)
     D rcb             S              1N   inz(*OFF)
     D rc              S             10I 0 inz(0)
     D paseRc          S             10I 0 inz(0)
     D min             S             10U 0 inz(X'FFFFFFFF')
     D pILESym         S               *   inz(*NULL)
     D pCopy           s               *
     D myCopy          ds                  likeds(over_t) based(pCopy)
     D myBuf           S          65000A   inz(*BLANKS)
     D myPtr           S               *   inz(*NULL)
      * debug
     D tBenArgSz       s             10i 0 inz(0)
     D tBenArgP        S               *   inz(*NULL)
     D tBenPrmSz       s             10i 0 inz(0)
     D tBenPrmP        S               *   inz(*NULL)
     D tBenRetSz       s             10i 0 inz(0)
     D tBenRetP        S               *   inz(*NULL)
     D tBenBaseP       S               *   inz(*NULL)
     D tBenSigP        S               *   inz(*NULL)
      /free

       Monitor;

       tBenArgSz = ileSzArgv(tBenArgP);
       tBenPrmSz = ileSzParm(tBenPrmP);
       tBenRetSz = ileSzRet(tBenRetP);
       tBenBaseP = piBase;
       tBenSigP = piSig;

       rcb = ileRslv(pgm1:lib1:pILESym:sym1);
       if rcb = *OFF;
         return *OFF;
       endif;

       // rc = _ILECALL(pILESym, &arguments->base, 
       //               signature, RESULT_VOID );
       pCopy = piBase;
       myCopy.ulonglongx = 0;
       pCopy += 8;
       myCopy.ulonglongx = 0;
       pCopy += 8;
       myCopy.ulonglongx = 0;
       pCopy += 8;
       myCopy.ulonglongx = 0;
       ieArgs.ieMe = paAlloc+(piILECALLParms-piAlloc);
       ieArgs.ieTarget = paAlloc+(%addr(ieArgs.ieTarget1)-piAlloc);
       ieArgs.ieBase = paAlloc+(piBase-piAlloc);
       ieArgs.ieSig = paAlloc+(piSig-piAlloc);
       // return PASE API limit (data beyond will actually return)
       if retSize > 32767;
         ieArgs.ieRet = 32767;
       else;
         ieArgs.ieRet = retSize;
       endif;
       if retSize > 0 and piReturn <> *NULL;
         // expect to call OPM programs (V5R4)
         if mixOPM = *ON;
           PaseReturnAggregate.aggr_addr 
             = ieArgs.ieBase + SZBASE + tBenArgSz;
         else;
           PaseReturnAggregate.aggr_addr 
             = paAlloc + ( piReturn - piAlloc );
         endif;
       endif;
       ieArgs.ieTarget1 = pILESym;
       rc = Qp2CallPase(ieToc:piILECALLParms:
                        %ADDR(ieArgSig):ieRetSig:
                        %addr(paseRc));
       // ILECALL ok
       if rc = QP2CALLPASE_NORMAL and paseRc = ILECALL_NOERROR;
         // if not an aggregate we need to copy rc
         // from PASE ILE BASE to the return area
         // xml is expecting as output
         if piReturn <> *NULL;
           pCopy = piReturn;
           select;
           when retSize = RESULT_INT8;
             myCopy.chrx = PaseReturn8.a8_data; 
           when retSize = RESULT_UINT8;
             myCopy.uchrx = PaseReturn8.a8_data; 
           when retSize = RESULT_INT16;
             myCopy.shortx = PaseReturn16.a16_data; 
           when retSize = RESULT_UINT16;
             myCopy.ushortx = PaseReturn16.a16_data; 
           when retSize = RESULT_INT32;
             myCopy.intx = PaseReturn32.a32_data; 
           when retSize = RESULT_UINT32;
             myCopy.uintx = PaseReturn32.a32_data; 
           when retSize = RESULT_INT64;
             myCopy.longlongx = PaseReturn64.a64_data; 
           when retSize = RESULT_UINT64;
             myCopy.ulonglongx = PaseReturn64.a64_data;
           when retSize = RESULT_FLOAT64;
             myCopy.doublex = PaseReturnReal.f64_data;
           other;
             if retSize > 0;
               // expect to call OPM programs (V5R4)
               if mixOPM = *ON;
                 myPtr = piBase + SZBASE + tBenArgSz;
                 cpybytes(piReturn:myPtr:retSize);
               endif;
             endif;
           endsl;
         endif;
         return *ON;
       else;
         errsSevere(QP2_ERROR_ILECALL_FAIL:sym1);
         return *OFF;
       endif;

       On-error;
         errsSevere(QP2_ERROR_ILECALL_FAIL:sym1);
         return *OFF;
       Endmon;

       return *ON;
      /end-free
     P                 E

      *****************************************************
      * rc=PaseExec32(...)
      * return (*ON=good, *OFF=error)
      * Note: 
      * calling PASE popen(cmd), therefore using
      * PASE memory (Qp2malloc memory), that needs
      * copyout back into ILE memory used by
      * ILE stored procedure or RPG alloc()
      *****************************************************
     P PaseExec32      B                   export
     D PaseExec32      PI             1N
     D cmd                             *   value
     D cmdLen                        10i 0 value
     D paseMem                         *
     D paseLen                       10i 0
     D noGet                          1N   value options(*nopass)
      * vars
     D doGet           S              1N   inz(*ON)
     D rcb             S              1N   inz(*OFF)
     D rc              S             10I 0 inz(0)
     D paseRc          S             10I 0 inz(0)
     D paseAd          S             10U 0 inz(0)
     D pTmp            s               *
     D myDat           s          32766A   based(pTmp)
      /free

       Monitor;
       if %parms >= 5;
         doGet = noGet;
       endif;

       // output
       paseMem = piArgv; // current buffer ptr
       paseLen = 0;

       // filePtr = popen("cmd","r")
       pTmp = piArgv;
       myDat = %str(cmd:cmdLen)  + x'00';
       poArgs.poMe = paAlloc+(piPOPENParms-piAlloc);
       poArgs.poCmd  = paAlloc+(piArgv-piAlloc);
       poArgs.poMode = poArgs.poMe + 
         (%addr(poArgs.poMode1)-%addr(poArgs.poCmd));
       poArgs.poFd   = 0;
       poArgs.poMode1= x'72' + x'00';
       poArgs.poRsv  = *BLANKS;
       rc = convPASE(%addr(myDat):cmdLen:*OFF);
       rc = Qp2CallPase(poToc:piPOPENParms:
                        %ADDR(poArgSig):poRetSig:
                        %addr(paseAd));
       // popen ok
       if rc = QP2CALLPASE_NORMAL and paseAd > 0;
         poArgs.poFd = paseAd;
       else;
         errsSevere(QP2_ERROR_POPEN_FAIL:%str(cmd:cmdLen));
         return *OFF;
       endif;

       if doGet = *ON;
       // buffPtr = fgets(char *s, int n, FILE *stream);
       fgArgs.fgMe = paAlloc+(piFGETSParms-piAlloc);
       fgArgs.fgS  = paAlloc+(piArgv-piAlloc); // PASE pTmp
       fgArgs.fgN  = 32766;
       fgArgs.fgStream = poArgs.poFd;
       paseAd = 1;
       pTmp = piArgv; // current buffer ptr
       rc = QP2CALLPASE_NORMAL;
       dow paseAd > 0 and rc = QP2CALLPASE_NORMAL;
         // paseAd null (0) is EOF
         rc = Qp2CallPase(fgToc:piFGETSParms:
                        %ADDR(fgArgSig):fgRetSig:
                        %addr(paseAd));
         // fgets ok
         if rc = QP2CALLPASE_NORMAL and paseAd > 0;
           paseRc = strlen(pTmp);
           pTmp += paseRc;
           fgArgs.fgS += paseRc;
         else;
           if rc <> QP2CALLPASE_NORMAL;
             errsSevere(QP2_ERROR_FGETS_FAIL:%str(cmd:cmdLen));
             return *OFF;
           endif;
         endif;
       enddo;
       endif;

       // rc = pclose (FILE *stream);
       clArgs.clMe = paAlloc+(piPCLOSEParms-piAlloc);
       clArgs.clStream  = poArgs.poFd;
       rc = Qp2CallPase(clToc:piPCLOSEParms:
                        %ADDR(clArgSig):clRetSig:
                        %addr(paseRc));
       if rc <> QP2CALLPASE_NORMAL;
         errsSevere(QP2_ERROR_PCLOSE_FAIL:%str(cmd:cmdLen));
         return *OFF;
       endif;

       // how big???
       if doGet = *ON;
         paseLen = (pTmp - piArgv);
       endif;

       On-error;
         errsSevere(QP2_ERROR_PCLOSE_FAIL);
         return *OFF;
       Endmon;

       // good
       return *ON;
      /end-free
     P                 E

