     H AlwNull(*UsrCtl)
   
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
      /copy plugrun_h

      *****************************************************
      * global vars
      *****************************************************
     D rcb             S              1N
     D ipcfile         s           1024A   inz(*BLANKS)

     D i               s             10i 0 inz(0)
     D pCopy1          s               *   inz(*NULL)
     D myCopy1         ds                  likeds(over_t) based(pCopy1)
     D pCopy2          s               *   inz(*NULL)
     D myCopy2         ds                  likeds(over_t) based(pCopy2)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     C     *ENTRY        PLIST
     C                   PARM                    prmfile        1024
      /free
       if %parms >= 1;
         // parms, varied call clients (yuck)
         ipcfile = *BLANKS;
         pCopy1 = %addr(prmfile);
         pCopy2 = %addr(ipcfile);
         for i = 1 to 1024;
           if myCopy1.bytex = x'00' or myCopy1.bytex = x'40';
             leave;
           endif;
           myCopy2.bytex = myCopy1.bytex;
           pCopy1 += 1;
           pCopy2 += 1;
         endfor;
         rcb = runServer(ipcfile);
       endif;
       *inlr = *on;
      /end-free


