      /if defined(PLUGILE_H)
      /eof
      /endif
      /define PLUGILE_H
   
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
      * ILE callable
      *****************************************************
     D ileEZero        PR
     D ileErrno        PR            10I 0
     D ileStatus       PR            10I 0
     D ileMsgId        PR             7A
     D ileStatus2      PR            10I 0
     D ileMsgId2       PR             7A

     D ileDoTest       PR
     D  endTest                       1A   value

     D ileStatic       PR             1N
     D  allOPM                        1A   value

     D ILE_SAVE_START...
     D                 c                   const('S')
     D ILE_RESTORE_TOP...
     D                 c                   const('T')
     D ILE_RESTORE_START...
     D                 c                   const('R')
     D ILE_SAVE_END...
     D                 c                   const('E')
     D ILE_RESTORE_END...
     D                 c                   const('X')
     D ILE_RESTORE_PARM...
     D                 c                   const('P')

     D ileMark         PR
     D   op                           1A   value
     D   wrkWth                       1A   value
     D   offset                      10i 0 value options(*nopass)
     D   parmno                      10i 0 value options(*nopass)

     D ileCmdExc       PR             1N
     D   cmd                           *   value
     D   len                         10i 0 value

     D ileCmdCap       PR             1N
     D   cmd                           *   value
     D   len                         10i 0 value

     D ileSystem       PR             1N
     D   cmd                           *
     D   len                         10i 0

     D ileRexx         PR             1N
     D   setCDATA                     1N   value
     D   cmd                           *
     D   len                         10i 0
     D   datastr                  65000A

     D ileSzArgv       PR            10i 0
     D   start                         *

     D ileSzParm       PR            10i 0
     D   start                         *

     D ileSzRet        PR            10i 0
     D   start                         *

     D ilePushData     PR             1N
     D   node                              likeds(xmlNode_t)
 
     D ilePushLen      PR             1N
     D   node                              likeds(xmlNode_t)

     D ilePopData      PR             1N
     D   outPtrP                       *
     D   node                              likeds(xmlNode_t)
 
     D ilePopVal       PR            10i 0
     D   node                              likeds(xmlNode_t)

     D uintQuad        PR            20U 0
     D   start                       20U 0 value

     D ileQuad         PR              *
     D   start                         *   value
     D   offset                        *   value

     D uintAlign       PR            20U 0
     D   start                       20U 0 value
     D   align                       20u 0 value

     D ileAlign        PR              *
     D   start                         *   value
     D   offset                        *   value
     D   align                       20u 0 value

     D ileIsV5         PR             1N

     D ileRslv         PR             1N
     D  pgm2                         10A   value
     D  lib2                         10A   value
     D  pSym                           *
     D  sym2                        128A   value options(*nopass)

     D ilePGM          PR             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  piReturn                       *

     D ileSRV          PR             1N
     D  pgm1                         10A
     D  lib1                         10A
     D  sym1                        128A
     D  piReturn                       *
     D  retSize                      10i 0

     D ileAddr         PR              *
     D  isReturn                      1N   value

     D ileDup          PR
     D  isReturn                      1N   value
     D  pdupbeg                        *   value
     D  pdupend                        *   value

     D ileExec         PR             1N
     D cmd                             *   value
     D cmdLen                        10i 0 value
     D myMem                           *
     D myLen                         10i 0
     D noGet                          1N   value options(*nopass)

