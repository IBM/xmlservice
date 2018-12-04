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
      * Contribution: Luca IDLE_TIMEOUT (ADC modified)
      * "Luca Zovi" <luca.zovi@siri-informatica.it>
      *****************************************************

      *****************************************************
      * includes
      *****************************************************
      /copy plugconf_h
      /copy plugipc_h
      /copy plugile_h
      /copy plugerr_h
      /copy plugsig_h
      /copy plugperf_h

      *****************************************************
      * globals
      *****************************************************
     D sigHandle       ds                  likeds(sigaction_t)
     D sigTime         ds                  likeds(itimerval)

     D sigTimerIsOn...
     D                 s              1N   inz(*OFF)

     D sigTickTockType...
     D                 s              1A   inz(*BLANKS)

     D sigTickTockAction...
     D                 s              1A   inz(*BLANKS)
     D sigTickTockSeconds...
     D                 s             10i 0 inz(-1)

     D sigTickTockFirstDefault...
     D                 s              1N   dim(4) inz(*OFF)
     D sigTickTockActionDefault...
     D                 s              1A   dim(4) inz(*BLANKS)
     D sigTickTockSecondsDefault...
     D                 s             10i 0 dim(4) inz(-1)

     D sigTimerOn      PR

     D sigTimerPop     PR
     D   signo                       10I 0 value

      *****************************************************
      * Luca IDLE_TIMEOUT - timer popped (occurred)
      * sigTimePop(signo)
      *****************************************************
     P sigTimerPop     B
     D sigTimerPop     PI
     D   signo                       10I 0 value
      /free
       // -------------
       // HEY - custom hook (plugconfx)
       confTimePop(signo:sigTickTockType:sigTickTockAction:sigTickTockSeconds);
      /end-free
     P                 E


      *****************************************************
      * sigTimerOn()
      * return (NA)
      *****************************************************
     P sigTimerOn      B
     D sigTimerOn      PI
      * vars
     D rc              S             10i 0 inz(0)
      /free

       perfAdd(PERF_ANY_WATCH_TIMER:*ON);

       // ---------------------------------------------------
       // Luca IDLE_TIMEOUT 
       // Tell system that the close_job() subprocedure
       // should be called whenever an alarm signal is
       // received.
       // ---------------------------------------------------
       rc = sigemptyset(sigHandle.sa_mask);
       rc = sigaddset(sigHandle.sa_mask: SIGALRM);
       sigHandle.sa_handler   = %paddr(sigTimerPop);
       sigHandle.sa_flags     = 0;
       sigHandle.sa_sigaction = *NULL;
       sigaction(SIGALRM: sigHandle: *omit);
       sigaction(SIGTERM: sigHandle: *omit);
       // ---------------------------------------------------
       // Tell system to send an alarm signal every
       // n seconds.
       // ---------------------------------------------------
       sigTime = *ALLx'00';
       sigTime.int_tv_sec = sigTickTockSeconds;
       sigTime.val_tv_sec = sigTickTockSeconds;
       sigTimerIsOn = *ON;
       rc = setitimer(ITIMER_REAL: sigTime: *omit);

       perfAdd(PERF_ANY_WATCH_TIMER:*OFF);

      /end-free
     P                 E

      *****************************************************
      * sigTimerOff()
      * return (NA)
      *****************************************************
     P sigTimerOff     B                   export
     D sigTimerOff     PI
      * vars
     D rc              S             10i 0 inz(0)
      /free

       perfAdd(PERF_ANY_WATCH_TIMER:*ON);

       // ---------------------------------------------------
       // Luca IDLE_TIMEOUT 
       // reset timer, no more signal
       // ---------------------------------------------------
       sigTime = *ALLx'00';
       rc = setitimer(ITIMER_REAL: sigTime: *omit);

       // ---------------------------------------------------
       // globals back to unknown
       // ---------------------------------------------------
       sigTimerIsOn      = *OFF;
       sigTickTockType   = *BLANKS;
       sigTickTockAction = *BLANKS;
       sigTickTockSeconds= -1;

       perfAdd(PERF_ANY_WATCH_TIMER:*OFF);

      /end-free
     P                 E

      *****************************************************
      * sigLastTimer()
      * return (*ON,*OFF)
      *****************************************************
     P sigLastTimer...
     P                 B                   export
     D sigLastTimer...
     D                 PI             1N
     D   timerType                    1A
     D   timeAction                   1A
     D   timeSeconds                 10i 0
      /free
       timerType   = sigTickTockType;
       timeAction  = sigTickTockAction;
       timeSeconds = sigTickTockSeconds;
       return sigTimerIsOn;
      /end-free
     P                 E

      *****************************************************
      * Luca IDLE_TIMEOUT
      * sigSetTimeOut(seconds)
      *****************************************************
     P sigSetTimeOut...
     P                 B                   export
     D sigSetTimeOut...
     D                 PI
     D   timerType                    1A   value
     D   timerPerm                    1A   value
     D   timeAction                   1A   value
     D   timeSeconds                 10i 0 value
      * vars
     D i               S             10i 0 inz(0)
      /free
       select;
       when timerType = SIG_TIMEOUT_CLIENT; 
         i = 1;
       when timerType = SIG_TIMEOUT_SERVER;
         i = 2;
       when timerType = SIG_TIMEOUT_CALL_CLIENT;
         i = 3;
       when timerType = SIG_TIMEOUT_CALL_SERVER;
         i = 4;
       other;
         return;
       endsl;

       // last timer type to set signal
       sigTickTockType   = timerType;

       // -------------
       // HEY - custom hook (plugconfx)
       // first time only
       if sigTickTockFirstDefault(i) = *OFF;
         sigTickTockActionDefault(i) = confAction(timerType);
         sigTickTockSecondsDefault(i) = confSeconds(timerType);
         sigTickTockFirstDefault(i) = *ON;
       endif;

       select;
       // this request current defaults
       when timerPerm = *BLANKS; 
         sigTickTockAction = timeAction;
         sigTickTockSeconds = timeSeconds;
         // valid values
         if sigTickTockAction = *BLANKS;
           sigTickTockAction = sigTickTockActionDefault(i);
         endif;
         if sigTickTockSeconds < -1;
           sigTickTockSeconds = sigTickTockSecondsDefault(i);
         endif;
       // this request and all to follow defaults
       when timerPerm = SIG_SET_PERM;
         sigTickTockActionDefault(i) = timeAction;
         sigTickTockSecondsDefault(i) = timeSeconds;
         sigTickTockAction = sigTickTockActionDefault(i);
         sigTickTockSeconds = sigTickTockSecondsDefault(i);
       // return back to factory orignal settings
       when timerPerm = SIG_SET_ORIG;
         // -------------
         // HEY - custom hook (plugconfx)
         sigTickTockActionDefault(i) = confAction(timerType);
         sigTickTockSecondsDefault(i) = confSeconds(timerType);
         sigTickTockAction = sigTickTockActionDefault(i);
         sigTickTockSeconds = sigTickTockSecondsDefault(i);
       other;
         return;
       endsl;

       // ------------
       // set timer now
       if sigTickTockSeconds = 0;
         sigTimerOff();
       else;
         sigTimerOn();
       endif;
      /end-free
     P                 E

