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
      /copy pluglic_h
      /copy plugconf_h
      /copy plugxml_h

     P licXML          B                   export
     D licXML          PI
     D   rptbuf                    2048A
     D   full                         1N   value options(*nopass)
      * vars
     D i               S             10i 0
      /free
       rptbuf = *BLANKS;
       if %parms >= 2 and full = *ON;
         rptbuf = %trim(rptbuf) + %trim(xmlGetHead())+x'25';
         rptbuf = %trim(rptbuf) + '<license>'+x'25';
         rptbuf = %trim(rptbuf) + '<version>'+PLUGVER+'</version>'+x'25';
         rptbuf = %trim(rptbuf) + '<bsd>'+x'25';
       endif;
       rptbuf = %trim(rptbuf) + 
       '*****************************************************'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* '+PLUGVER+x'25';
       rptbuf = %trim(rptbuf) + 
       '* Copyright (c) 2010, IBM Corporation'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* All rights reserved.'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* Redistribution and use in source and binary forms,'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* with or without modification, are permitted provided'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* that the following conditions are met:'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* - Redistributions of source code must retain '+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   the above copyright notice, this list of conditions'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   and the following disclaimer.'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* - Redistributions in binary form must reproduce the '+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   above copyright notice, this list of conditions'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   and the following disclaimer in the documentation'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   and/or other materials provided with the distribution.'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* - Neither the name of the IBM Corporation nor the names'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   of its contributors may be used to endorse or promote'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   products derived from this software without specific'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*   prior written permission.'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE'+x'25';
       rptbuf = %trim(rptbuf) + 
       '* POSSIBILITY OF SUCH DAMAGE.'+x'25';
       rptbuf = %trim(rptbuf) + 
       '*****************************************************'+x'25';
       if %parms >= 2 and full = *ON;
         rptbuf = %trim(rptbuf) + '</bsd>'+x'25';
         rptbuf = %trim(rptbuf) + '</license>'+x'25';
       endif;
      /end-free
     P                 E

