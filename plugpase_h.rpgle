      /if defined(PLUGPASE_H)
      /eof
      /endif
      /define PLUGPASE_H
   
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
      * PASE Parms
      *****************************************************

      * PASE Parm Signatures (meta_sig)
      * input/output parm types
      * last argument (PASE NULL)
     D ARG_END...
     D                 c                   const(0)
      * 1A
     D ARG_INT8...
     D                 c                   const(-1)
     D ARG_UINT8...
     D                 c                   const(-2)
      * 5i0 or 5u0
     D ARG_INT16...
     D                 c                   const(-3)
     D ARG_UINT16...
     D                 c                   const(-4)
      * 10i0 or 10u0
     D ARG_INT32...
     D                 c                   const(-5)
     D ARG_UINT32...
     D                 c                   const(-6)
      * 20i0 or 20u0
     D ARG_INT64...
     D                 c                   const(-7)
     D ARG_UINT64...
     D                 c                   const(-8)
      * 4f or 8f
     D ARG_FLOAT32...
     D                 c                   const(-9)
     D ARG_FLOAT64...
     D                 c                   const(-10)
      * pase addr (10u0 - Caller provides PASE memory address)
     D ARG_MEMPTR...
     D                 c                   const(-11)
      * addr (* - Caller provides tagged pointer)
     D ARG_SPCPTR...
     D                 c                   const(-12)
      * addr (* - Caller provides tagged pointer) (unused)
     D ARG_OPENPTR...
     D                 c                   const(-13)
      * pase addr (20u0 - Caller provides PASE memory address)
     D ARG_MEMTS64...
     D                 c                   const(-14)
      * addr (* - Caller provides teraspace pointer) (unused)
     D ARG_TS64PTR...
     D                 c                   const(-15)

      * PASE Return Types (meta_ret)
      * positive is an aggregate return type
      * need to set aggr_addr=pase_addr of
      * where output goes (must be PASE memory)
     D RESULT_VOID...
     D                 c                   const(0)
      * 1A
     D RESULT_INT8...
     D                 c                   const(-1)
     D RESULT_UINT8...
     D                 c                   const(-2)
      * 5i0 or 5u0
     D RESULT_INT16...
     D                 c                   const(-3)
     D RESULT_UINT16...
     D                 c                   const(-4)
      * 10i0 or 10u0
     D RESULT_INT32...
     D                 c                   const(-5)
     D RESULT_UINT32...
     D                 c                   const(-6)
      * 20i0 or 20u0
     D RESULT_INT64...
     D                 c                   const(-7)
     D RESULT_UINT64...
     D                 c                   const(-8)
      * 4f or 8f
     D RESULT_FLOAT64...
     D                 c                   const(-10)

      *****************************************************
      * PASE APi(sh)
      * - using ILE PASE enablers
      *****************************************************
     d PaseLstCCSID...
     d                 PR            10I 0

     d PaseJobCCSID...
     d                 PR            10I 0

      * rc=PaseStart32
      * return (*ON=good, *OFF=error)
     D PaseStart32     PR             1N
     D   myMax                       10i 0 value
     D   paseCtl                           likeds(paseRec_t)

     D PaseStop        PR

      * pase errno
     D PaseEZero       PR             1N
     D PaseErrno       PR            10I 0

     D PaseRslv32      PR             1N
     D  pgm2                         10A   value
     D  lib2                         10A   value
     D  pSym                           *
     D  sym2                        128A   value options(*nopass)

      * rc=PaseExec32
      * return (*ON=good, *OFF=error)
     D PaseExec32      PR             1N
     D cmd                             *   value
     D cmdLen                        10i 0 value
     D paseMem                         *
     D paseLen                       10i 0
     D noGet                          1N   value options(*nopass)

      * rc=PasePGM32
      * return (*ON=good, *OFF=error)
     D PasePGM32       PR             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  piReturn                       *
     D  allByValue                    1N

      * rc=PaseSRV32
      * return (*ON=good, *OFF=error)
     D PaseSRV32       PR             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  sym1                        128A
     D  piReturn                       *
     D  retSize                      10i 0

