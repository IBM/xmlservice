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
      /copy plugbug_h
      /copy plugile_h

      *****************************************************
      * global vars
      *****************************************************

     D QMHSNDM         PR                  ExtPgm('QMHSNDM')
     D   MsgID                        7A   const
     D   QualMsgF                    20A   const
     D   MsgTxt                   32767A   const options(*varsize)
     D   MsgTxtLen                   10I 0 const
     D   MsgType                     10A   const
     D   MsgQueues                   20A   const dim(50) options(*varsize)
     D   NumQueues                   10I 0 const
     D   RpyQueue                    20A   const
     D   MsgKey                       4A
     D   ErrorCode                 8000A   options(*varsize)
     D   CCSID                       10I 0 const options(*nopass)

     D QMHRCVPM        PR                  ExtPgm('QMHRCVPM')
     D   MsgInfo                  32767A   options(*varsize)
     D   MsgInfoLen                  10I 0 const
     D   Format                       8A   const
     D   StackEntry                  10A   const
     D   StackCount                  10I 0 const
     D   MsgType                     10A   const
     D   MsgKey                       4A   const
     D   WaitTime                    10I 0 const
     D   MsgAction                   10A   const
     D   ErrorCode                 8000A   options(*varsize)


      *****************************************************
      * DebugMe
      * Send message to qsysopr and wait for response
      * to allow for debug. 
      * return NA
      *****************************************************
     P DebugMe         B                   export
     D DebugMe         PI
     D Message                      100A   value varying

     D RCVM0100        DS                  qualified
     D   BytesRtn                    10I 0
     D   BytesAvail                  10I 0
     D   MsgSev                      10I 0
     D   MsgID                        7A
     D   MsgType                      2A
     D   MsgKey                       4A
     D                                7A
     D   CCSID_status                10I 0
     D   CCSID                       10I 0
     D   MsgDtaLen                   10I 0
     D   MsgDtaAvail                 10I 0
     D   MsgDta                    8000A

     D ErrorCode       ds                  qualified
     D   BytesProv                   10I 0 inz(0)
     D   BytesAvail                  10I 0 inz(0)

     D MsgKey          s              4A
     D MsgQ            s             20A   dim(1) inz('*SYSOPR')
     D Reply           s            100A

     D cmd             s            100A   inz(*BLANKS)
     D rcb             s              1N   inz(*OFF)
     D rc              s             10i 0 inz(0)
     D jobName         s             10A   inz(*BLANKS)
     D jobUserID       s             10A   inz(*BLANKS)
     D jobNbr          s              6A   inz(*BLANKS)
     D jobInfo         ds                  likeds(myJob_t)
      /free
         rcb = ileJob(jobName:jobUserID:jobNbr:jobInfo);
         Message = Message
              + ' '+%trim(jobNbr)
              + '/'+%trim(jobUserID)
              + '/'+%trim(jobName);
          QMHSNDM( *blanks
                   : *blanks
                   : Message
                   : %len(Message)
                   : '*INQ'
                   : MsgQ
                   : %elem(MsgQ)
                   : '*PGMQ'
                   : MsgKey
                   : ErrorCode );

          // Wait up to 1 hour (3600 seconds) for a reply to the
          // above message. If you change the value of 3600 below to
          // a value of -1, it will wait indefinitely.
          QMHRCVPM( RCVM0100
                    : %size(RCVM0100)
                    : 'RCVM0100'
                    : '*'
                    : 0
                    : '*RPY'
                    : MsgKey
                    : 3600
                    : '*REMOVE'
                    : ErrorCode );
          Reply = %subst(RCVM0100.MsgDta: 1: RCVM0100.MsgDtaLen);
      /end-free
     P                 E

     P DebugErrno      B                   export
     D DebugErrno      PI
     D isServ                         1N   value
      * vars
     D ErrorNo         S             10I 0 Based(pErrorNo)
     D pErrorTxt       S               *
     D ErrorTxt        S            132A   Inz(*blank)
      /free
       pErrorNo = GetErrNo();
       if isServ = *ON;
         ErrorTxt = 'Server '+%str(StrError(ErrorNo):132);
       else;
         ErrorTxt = 'Client '+%str(StrError(ErrorNo):132);
       endif;
       DebugMe(ErrorTxt);
      /end-free
     P                 E

