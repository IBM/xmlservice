      /if defined(PLUGJSON_H)
      /eof
      /endif
      /define PLUGJSON_H
   
      *****************************************************
      * Copyright (c) 2015, IBM Corporation
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
      *************************************************************************
      * 1) call i CMD:
      * {"cmd":"name",
      *  "execute":"*CMD",
      *  "options": 
      *   {"exec:"cmd|system|rexx",
      *    "hex":"on",
      *    "before":"cc1/cc2/cc3/cc4",
      *    "after":"cc4/cc3/cc2/cc1",
      *    "error":"on|off|fast"
      *   }
      * }
      * "cmd":        - command name (id)
      * "execute":    - IBM i *CMD (5250 - cut/paste)
      * "options":
      *  "exec": 
      *     "cmd"     - qcmdexe only return true/false (default)
      *     "system"  - system utility return CPFxxxx
      *     "rexx"    - rexx output parms and return CPFxxxx
      *                 (?) character type
      *                 (?N) explicit cast numeric
      *  "hex":
      *     "on"      - input character hex (5147504C20202020)
      *  "before":
      *     "cc(n)"   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  "after":
      *     "cc(n)"   - output ccsid1->ccsid2->ccsid3->ccsid4 
      *  "error":
      *     "on"      - script stops, full error report
      *     "off"     - script continues, job error log (default)
      *     "fast"    - script continues, brief error log
      *
      * Example 1:
      *  {"cmd":"chglibl",
      *   "execute":"CHGLIBL LIBL(QTEMP XMLSER) CURLIB(XMLSER)"
      *  }
      *
      * Example 2:
      *  {"cmd":"rtvjoba,
      *   "execute":"RTVJOBA CCSID(?N) OUTQ(?)",
      *   "options":{"exec":"rexx"}
      *  }
      *************************************************************************
      * 2) call PASE utility:
      * {"sh":"name",
      *  "execute":"PASE utility",
      *  "options": 
      *   {"rows":"on|off",
      *    "hex":"on",
      *    "before":"cc1/cc2/cc3/cc4",
      *    "after":"cc4/cc3/cc2/cc1",
      *    "error":"on|off|fast"
      *   }
      * }
      * "sh":         - utility name (id)
      * "execute":    - IBM i PASE utility (call qp2term - cut/paste)
      * "options":
      *  "rows":
      *     "on"      - return rows lines
      *     "off"     - return one string (default)  
      *  "hex":
      *     "on"      - input character hex (5147504C20202020)
      *  "before":
      *     "cc(n)"   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  "after":
      *     "cc(n)"   - output ccsid1->ccsid2->ccsid3->ccsid4 
      *  "error":
      *     "on"      - script stops, full error report
      *     "off"     - script continues, job error log (default)
      *     "fast"    - script continues, brief error log
      *
      * Example 1:
      *  {"sh":"wrkactjob",
      *   "execute":"/QOpenSys/usr/bin/system -i 'wrkactjob'"
      *  }
      *
      * Example 2:
      *  {"sh":"frogs",
      *   "execute":"ls -l | grep frog",
      *   "options":{"rows":"on"}
      *  }
      *************************************************************************
      * 3) call PGM/SRVPGM:
      * ---
      * pgm name (*PGM or *SRVPGM):
      *   {"pgm":"name",
      *    "parm":["see parm"],
      *    "return":["see return"],
      *    "options": 
      *     {"lib":"library",
      *      "func":"function", 
      *      "mode":"opm|ile",
      *      "error":"on|off|fast"
      *     },
      *   }
      * "pgm":        - IBM i *PGM or *SRVPGM name (id)
      * "parm":       - ["see parm"]
      * "return":     - ["see return"]
      * "options":
      *  "lib":
      *     "library" - IBM i library name
      *  "func":
      *     "function"- IBM i *SRVPGM function name 
      *  "mode":
      *     "ile"     - ILE and PASE memory (default)"
      *     "opm"     - ILE only memory (PASE can not view)"
      *  "error":
      *     "on"      - script stops, full error report
      *     "off"     - script continues, job error log (default)
      *     "fast"    - script continues, brief error log
      *
      * ---
      * pgm parameters:
      *   {"parm":"name",
      *    "values":["see ds or data"],
      *    "options":
      *     {"io":"in|out|both|omit",
      *      "by":"val|ref"
      *     }
      *   }
      * "parm":       - parm name (id)
      * "values":     - ["see ds or data"]
      * "options":
      *  "io":
      *     "in"      - input only
      *     "out"     - output only
      *     "both"    - input/output only (default)
      *  "by":
      *     "ref"     - pass by reference (default)
      *     "val"     - pass by value (do not use, untested)
      *
      * ---
      * pgm return:
      *   {"return":"name",
      *    "values":["see ds or data"]
      *   }
      * "return":     - return name (id)
      * "values":     - ["see ds or data"]
      *
      * ---
      * pgm data structure:
      *   {"ds":"name",
      *    "options": 
      *     {"dim":"n",
      *      "dou":"label",
      *      "len":"label",
      *      "data":"records"
      *     },
      *    "values":["see ds or data"]
      *   }
      * "ds":         - data structure variable name (id)
      * "values":     - ["see ds or data"]
      * "options":
      *  "dim":
      *     "n"       - array dimension value (default "dim":"1")
      *  "dou":
      *     "label"   - match array dou terminate parm label (see data) 
      *  "len":
      *     "label"   - match calculate length of ds parm lable (see data)
      *
      * ---
      * pgm data elements:
      *   {"data":"name",
      *    "values":"value" or ["value1", "value2", ...]
      *    "type":"see data types",
      *    "options": 
      *     {"dim":"n", 
      *      "varying":"on|off|2|4", 
      *      "enddo":"label",
      *      "setlen":"label",
      *      "offset":"label",
      *      "hex":"on|off",
      *      "before":"cc1/cc2/cc3/cc4",
      *      "after":"cc4/cc3/cc2/cc1",
      *      "trim":"on|off",
      *      "next":"label"
      *     }
      *   }
      * "data":      - data value name (id)
      * "values":    - "value" or ["value1", "value2", ...],
      * "type":
      *     "3i0"                   int8/byte     D myint8   3i 0
      *     "5i0"                   int16/short   D myint16  5i 0
      *     "10i0"                  int32/int     D myint32 10i 0
      *     "20i0"                  int64/int64   D myint64 20i 0
      *     "3u0"                   uint8/ubyte   D myint8   3u 0
      *     "5u0"                   uint16/ushort D myint16  5u 0
      *     "10u0"                  uint32/uint   D myint32 10u 0
      *     "20u0"                  uint64/uint64 D myint64 20u 0
      *     "32a"                   char          D mychar  32a
      *     "32a"   {"varying":"2"} varchar       D mychar  32a   varying
      *     "32a"   {"varying":"4"} varchar4      D mychar  32a   varying(4)
      *     "12p2"                  packed        D mydec   12p 2
      *     "12s2"                  zoned         D myzone  12s 2
      *     "4f2"                   float         D myfloat  4f
      *     "8f4"                   real/double   D myfloat  8f
      *     "3b"                    binary        D mybin   (any)
      *     "40h"                   hole (no out) D myhole  (any)
      * "options":
      *  "dim":
      *     "n"       - array dimension value (default "dim":"1")
      *  "varying":
      *     "on"      - character varying data (same as "varying":"2")
      *     "off"     - character non-varying data (default)
      *     "2"       - character varying data
      *     "4"       - character varying data
      *  "enddou":
      *     "label"   - match array dou terminate parm label (see ds) 
      *  "setlen":
      *     "label"   - match calculate length of ds parm lable (see ds)
      *  "offset":
      *     "label"   - match offset label (see overlay) 
      *  "hex":
      *     "on"      - input character hex (5147504C20202020)
      *  "before":
      *     "cc(n)"   - input ccsid1->ccsid2->ccsid3->ccsid4
      *  "after":
      *     "cc(n)"   - output ccsid1->ccsid2->ccsid3->ccsid4 
      *  "trim":
      *     "on"      - trim character (default)
      *     "off"     - no trim character
      *  "next":
      *     "label"   - match next offset label (see overlay) 
      *
      * ---
      * pgm parameters/return overlay:
      *   {"overlay":"name", 
      *    "values":["see ds or data"]
      *    "options": 
      *     {"io":"in|out|both",
      *      "offset":"n|label", 
      *      "top":"on|off|n",
      *      "setnext":"nextoff"
      *     },
      *   }
      * "overlay":   - structure overlay name (id)
      * "values":     - ["see ds or data"]
      * "options":
      *  "io":
      *     "in"      - input only
      *     "out"     - output only
      *     "both"    - input/output only (default)
      *  "offset":
      *     "n"       - overlay bytes offset relative
      *     "label"   - overlay match bytes offset label (see data)
      *  "setnext":
      *     "label"   - overlay match next offset label (see data)
      *  "top":
      *     "n"       - overlay parm number (see parm)
      *     "on"      - overlay parm first (see parm)
      *     "off"     - overlay parm last seen (see parm)
      *
      * Example:
      *  {"pgm":"ZZCUST",
      *   "parm": 
      *    [
      *     {"parm":"p1","values":{"data":"d1","type":"8p0","values":"12345678"}},
      *     {"parm":"p2",{"data":"0","type:"10i0",{enddo:"plines"}}},
      *     {"parm":"p3",
      *      {"ds":"myds1",{dim:"10",dou:"plines"},
      *       {"data":"","type":"35A"},
      *       {"data":"0.0","type":"11p3"},
      *       {"data":"0.0","type":"14p4"}
      *      }
      *    ]
      *  }
      *
      * Example:
      *  {"pgm":"QSZRTXXX",
      *   {"parm":"p1",
      *    {"ds":"PRDR0XXX",
      *     {"data":"0","type":"10i0",{"offset":"myOffset"}},
      *     {"data":"0","type":"4096h"}
      *    }
      *   }
      *   {"overlay":"ov1",{"io:"out","top":"1",offset:"myOffset"},  
      *    {"ds":"ds2",
      *     {"data":" ","type":"10A"}},
      *     {"data":"0","type":"10i0",{"enddo":"prim"}},
      *     {"data":"0","type":"10i0",{"offset":"myOffset2"}},
      *    }
      *   }
      *   {"overlay":"ov2",
      *    {"io":"out","top":"1","offset":"myOffset2",
      *     "dim":"10","dou":"prim","setnext":"nextoff"},
      *    {"ds:"ds3",
      *     {"data":"0","type":"10i0",{"next":"nextoff"}},
      *     {"data":" ",type:"10A"}
      *     {"data":" ",type:"10A"}
      *    }
      *   }
      *  }
      *************************************************************************

      *****************************************************
      * global vars
      *****************************************************

     D jsonRun         PR             1N


