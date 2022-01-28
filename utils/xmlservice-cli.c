// Copyright 2019 IBM Busines Machines Corp.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from this
// software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <as400_protos.h>

#ifdef __64BIT__
#error MUST COMPILE IN 32 BIT MODE USE -maix32
#endif
// To build
// gcc -maix32 -o xmlservice
int main()
{
    ILEpointer xmlstoredp __attribute__ ((aligned (16)));

    unsigned long long actmark = _ILELOADX("QXMLSERV/XMLSTOREDP", ILELOAD_LIBOBJ);

    if (actmark == (unsigned long long)-1) {
        // TODO: generate error xml
        return 1;
    }

    if(_ILESYMX(&xmlstoredp, actmark, "RUNASCII") < 0) {
        // TODO: generate error xml
        return 1;
    }

#define THIRTY_TWO_K (32 * 1024)
    size_t xmlin_size = THIRTY_TWO_K;
    int xmlin_len = 0;

    char* xmlin = (char*) malloc(xmlin_size);

    while(!feof(stdin)) {
        size_t remain = xmlin_size - xmlin_len;

        if(!remain) {
            xmlin_size *= 2;
            remain = xmlin_size - xmlin_len;
            xmlin = (char*) realloc(xmlin, xmlin_size);
            if(!xmlin) {
                // TODO: better error handling
                return 1;
            }
        }

        size_t count = fread(xmlin + xmlin_len, 1, remain, stdin);
        xmlin_len += count;

        if(count < remain) {
            if(ferror(stdin)) {
                // TODO: better error handling
                return 1;
            }
            break;
        }
    }

    size_t xmlout_len = (16 * 1024 * 1024);
    char* xmlout = (char*) malloc(xmlout_len);

    if(!xmlout) {
        // TODO: better error handling
        return 1;
    }

    char* ctl = ""; //"*here *cdata";
    int ctl_len = strlen(ctl);

    char* ipc = ""; //"*na";
    int ipc_len = strlen(ipc);

    int rc;

    // These are always defined to 0, why?
    int ebcdic_ccsid = 0; //Qp2jobCCSID();
    int pase_ccsid = 1208;

    const arg_type_t signature[] = {
        ARG_MEMPTR, ARG_MEMPTR, ARG_MEMPTR, ARG_MEMPTR, ARG_MEMPTR,
        ARG_MEMPTR, ARG_MEMPTR, ARG_MEMPTR, ARG_MEMPTR, ARG_MEMPTR,
        ARG_END
    };

    struct {
        ILEarglist_base base;
        ILEpointer ppIPCSP;
        ILEpointer szIPCSP;
        ILEpointer ppCtlSP;
        ILEpointer szCtlSP;
        ILEpointer ppIClob;
        ILEpointer szIClob;
        ILEpointer ppOClob;
        ILEpointer szOClob;
        ILEpointer ccsidPASE;
        ILEpointer ccsidILE;
    } arglist __attribute__ ((aligned (16)));


    ILEpointer IPCSP __attribute__ ((aligned (16)));
    ILEpointer CtlSP __attribute__ ((aligned (16)));
    ILEpointer IClob __attribute__ ((aligned (16)));
    ILEpointer OClob __attribute__ ((aligned (16)));

    _SETSPP(&IPCSP, ipc);
    _SETSPP(&CtlSP, ctl);
    _SETSPP(&IClob, xmlin);
    _SETSPP(&OClob, xmlout);

    arglist.ppIPCSP.s.addr   = (address64_t)(intptr_t) &IPCSP;
    arglist.szIPCSP.s.addr   = (address64_t)(intptr_t) &ipc_len;
    arglist.ppCtlSP.s.addr   = (address64_t)(intptr_t) &CtlSP;
    arglist.szCtlSP.s.addr   = (address64_t)(intptr_t) &ctl_len;
    arglist.ppIClob.s.addr   = (address64_t)(intptr_t) &IClob;
    arglist.szIClob.s.addr   = (address64_t)(intptr_t) &xmlin_len;
    arglist.ppOClob.s.addr   = (address64_t)(intptr_t) &OClob;
    arglist.szOClob.s.addr   = (address64_t)(intptr_t) &xmlout_len;
    arglist.ccsidPASE.s.addr = (address64_t)(intptr_t) &pase_ccsid;
    arglist.ccsidILE.s.addr  = (address64_t)(intptr_t) &ebcdic_ccsid;

    // Ensure the ILE side doesn't write to our stdout or else
    // bad things will happen, ie. EBCDIC garbage
    int devnull = open("/dev/null", O_RDWR|O_APPEND);
    int oldout = dup(1);
    int olderr = dup(2);

    dup2(devnull, 1);
    dup2(devnull, 2);

    rc = _ILECALL(&xmlstoredp, &arglist.base, signature, RESULT_UINT8);

    if (rc != ILECALL_NOERROR) {
        return 1;
    }
    if (arglist.base.result.s_uint8.r_uint8 == 0xF0) {
        return 1;
    }


    int code;
    code = write(oldout, xmlout, strlen(xmlout));
    code = write(oldout, "\n", 1);

    return 0;
}
