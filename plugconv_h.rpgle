      /if defined(PLUGCONV_H)
      /eof
      /endif
      /define PLUGCONV_H
   
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
      * global
      *****************************************************

      *****************************************************
      * conversion
      *****************************************************
     D convOpen        PR            10i 0
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  conv                               likeds(ciconv_t)

     D convCall        PR            10i 0
     D  conv                               likeds(ciconv_t)
     D  buffPtr                        *
     D  buffLen                      10i 0
     D  outPtr                         *   options(*nopass)
     D  outLen                       10i 0 options(*nopass)

     D convClose       PR            10i 0
     D  conv                               likeds(ciconv_t)

     D convCCSID       PR            10i 0
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  buffPtr                        *
     D  buffLen                      10i 0
     D  outPtr                         *   options(*nopass)
     D  outLen                       10i 0 options(*nopass)

     D convCCSID2      PR            10i 0
     D  fromCCSID                    10i 0 Value
     D  toCCSID                      10i 0 Value
     D  buffPtr                        *   Value
     D  buffLen                      10i 0 Value
     D  outPtr                         *   Value options(*nopass)
     D  outLen                       10i 0 Value options(*nopass)

      * hex convert types of actions
     D CONV_HEX_ACTION_INPUT...
     D                 C                   const('I')
     D CONV_HEX_ACTION_OUTPUT...
     D                 C                   const('O')
     D CONV_HEX_ACTION_BOTH...
     D                 C                   const('B')

     D convX2B         PR             1N
     D  pTarget                        *   Value 
     D  nLength                      10i 0 Value 

     D convB2X         PR             1N
     D  pTarget                        *   Value 
     D  nLength                      10i 0 Value 

     D cpyX2Bin        PR            10I 0
     D  pTarget                        *   Value 
     D  pSource                        *   Value 
     D  nLength                      10U 0 Value 

     D cpyB2Hex        PR            10I 0
     D  pTarget                        *   Value 
     D  pSource                        *   Value 
     D  nLength                      10U 0 Value 


      *****************************************************
      * special character conversion
      *****************************************************
     D fillChar        PR             1N
     D  pTgt                           *   Value
     D  tgtMax                       10i 0 Value 
     D  pSrc                           *   Value 
     D  nLength                      10i 0 Value 
     D  trimSz                       10i 0
     D  pad                          10i 0 Value 
     D  isVary                        1A   Value 
     D  isHex                         1N   Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value
     D  rmQuote                       1N   value

     D trimChar        PR             1N
     D  pTgt                           *   Value
     D  tgtMax                       10i 0 Value
     D  pSrc                           *   Value 
     D  srcMax                       10i 0 Value 
     D  trimSz                       10i 0
     D  pad                          10i 0 Value 
     D  isVary                        1A   Value 
     D  toHex                         1N   Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value
     D  rmQuote                       1N   value
     D  addHex                        1N   value
     D  addCDATA                      1N   value

     D fullChar        PR             1N
     D  pTgt                           *   Value
     D  tgtMax                       10i 0 Value
     D  pSrc                           *   Value 
     D  srcMax                       10i 0 Value 
     D  trimSz                       10i 0
     D  pad                          10i 0 Value 
     D  isVary                        1A   Value 
     D  toHex                         1N   Value 
     D  cntCCSID                     10i 0 Value 
     D  srcCCSID                     10i 0 dim(XMLMAXATTR)
     D  tgtCCSID                     10i 0 dim(XMLMAXATTR)
     D  rmCDATA                       1N   value
     D  rmLF                          1N   value
     D  rmQuote                       1N   value
     D  addHex                        1N   value
     D  addCDATA                      1N   value
     
     D hexDump         PR
     D   piParm                        *   value
     D   piSize                      10i 0 value
     D   pxParm                        *   value
     D   pxSize                      10i 0 value
     D   pcParm                        *   value
     D   pcSize                      10i 0 value


      *****************************************************
      * conversion PASE <> ILE
      *****************************************************
     D ccsidPASE       PR
     D   myccsid                     10i 0 value

     D ccsidILE        PR
     D   myccsid                     10i 0 value

     D getccsidPASE...
     D                 PR            10i 0

     D getccsidILE...
     D                 PR            10i 0

     D convPASE        PR            10i 0
     D   buffPtr                       *   value
     D   maxLen                      10i 0 value
     D   toILE                        1N   value
     D   outPtr                        *   value options(*nopass)
     D   outLen                      10i 0 value options(*nopass)

     D convUTF16       PR            10i 0
     D   buffPtr                       *   value
     D   maxLen                      10i 0 value
     D   toILE                        1N   value
     D   outPtr                        *   value options(*nopass)
     D   outLen                      10i 0 value options(*nopass)


