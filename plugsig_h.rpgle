      /if defined(PLUGSIG_H)
      /eof
      /endif
      /define PLUGSIG_H

      *****************************************************
      * Copyright (c) 2006 Scott C. Klement                                         +
      * All rights reserved.                                                        +
      *                                                                             +
      * Redistribution and use in source and binary forms, with or without          +
      * modification, are permitted provided that the following conditions          +
      * are met:                                                                    +
      * 1. Redistributions of source code must retain the above copyright           +
      *    notice, this list of conditions and the following disclaimer.            +
      * 2. Redistributions in binary form must reproduce the above copyright        +
      *    notice, this list of conditions and the following disclaimer in the      +
      *    documentation and/or other materials provided with the distribution.     +
      *                                                                             +
      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
      * SUCH DAMAGE.                                                                +
      *****************************************************
      *****************************************************
      * Contribution: Luca IDLE_TIMEOUT
      * "Luca Zovi" <luca.zovi@siri-informatica.it>
      *****************************************************

      *--------------------------------------------------------
      * Available signals
      *--------------------------------------------------------
     D SIGABRT         C                   const(1)
     D SIGIOT          C                   const(1)
     D SIGLOST         C                   const(1)
     D SIGFPE          C                   const(2)
     D SIGILL          C                   const(3)
     D SIGINT          C                   const(4)
     D SIGSEGV         C                   const(5)
     D SIGTERM         C                   const(6)
     D SIGUSR1         C                   const(7)
     D SIGUSR2         C                   const(8)
     D SIGIO           C                   const(9)
     D SIGAIO          C                   const(9)
     D SIGPTY          C                   const(9)
     D SIGALL          C                   const(10)
     D SIGOTHER        C                   const(11)
     D SIGKILL         C                   const(12)
     D SIGPIPE         C                   const(13)
     D SIGALRM         C                   const(14)
     D SIGHUP          C                   const(15)
     D SIGQUIT         C                   const(16)
     D SIGSTOP         C                   const(17)
     D SIGTSTP         C                   const(18)
     D SIGCONT         C                   const(19)
     D SIGCHLD         C                   const(20)
     D SIGCLD          C                   const(20)
     D SIGTTIN         C                   const(21)
     D SIGTTOU         C                   const(22)
     D SIGURG          C                   const(23)
     D SIGIOINT        C                   const(23)
     D SIGPOLL         C                   const(24)
     D SIGPCANCEL      C                   const(25)
     D SIGPALRM        C                   const(26)
     D SIGBUS          C                   const(32)
     D SIGDANGER       C                   const(33)
     D SIGPRE          C                   const(34)
     D SIGSYS          C                   const(35)
     D SIGTRAP         C                   const(36)
     D SIGPROF         C                   const(37)
     D SIGVTALRM       C                   const(38)
     D SIGXCPU         C                   const(39)
     D SIGXFSZ         C                   const(40)

      *--------------------------------------------------------
      * flags
      *--------------------------------------------------------
     D SA_NOCLDSTOP    c                   const(1)
     D SA_NODEFER      c                   const(2)
     D SA_RESETHAND    c                   const(4)
     D SA_SIGINFO      c                   const(8)

      *--------------------------------------------------------
      * sigprocmask() "how" argument
      *--------------------------------------------------------
     D SIG_BLOCK       c                   const(0)
     D SIG_UNBLOCK     c                   const(1)
     D SIG_SETMASK     c                   const(2)

      *--------------------------------------------------------
      * setitimer() "which" argument
      *--------------------------------------------------------
     D ITIMER_REAL     C                   1
     D ITIMER_VIRTUAL  C                   2
     D ITIMER_PROF     C                   2

      *--------------------------------------------------------
      *  sigset_t: signal set data structure
      *  ===================================
      *
      *  Note: There's not much point in trying to copy the
      *        way this is done in the ILE C header files,
      *        since RPG doesn't support integers that are
      *        1-bit long. Instead, I've defined the mask as
      *        one big field, and you can test/set bits with
      *        the %bitand() and %bitor() BIFs
      *--------------------------------------------------------
      /if not defined(SIGSET_T)
     D sigset_t        s             20U 0 based(TEMPLATE)
      /define SIGSET_T
      /endif

      *--------------------------------------------------------
      * sigaction_t: signal action data structure
      *
      * Prototype for signal handler (only if not SA_SIGINFO)
      *   D sa_handler      PR
      *   D   signo                       10I 0 value
      *
      * Prototype for signal action handler (only if SA_SIGINFO)
      *
      *   D sa_sigaction    PR
      *   D   signo                       10I 0 value
      *   D   info                              likeds(siginfo_t)
      *   D   context                       *   value
      *--------------------------------------------------------
     D sigaction_t     ds                  qualified
     D                                     align
     D                                     based(TEMPLATE)
     D   sa_handler                    *   procptr
     D   sa_mask                           like(sigset_t)
     D   sa_flags                    10I 0
     D   sa_sigaction                  *   procptr


      *--------------------------------------------------------
      * siginfo_t: signal information data structure
      *--------------------------------------------------------
     D siginfo_t       ds                  qualified
     D                                     align
     D                                     based(TEMPLATE)
     D   si_signo                    10I 0
     D   si_bits                      5U 0
     D   si_data_size                 5I 0
     D   si_time                      8A
     D   si_job                      10A
     D   si_user                     10A
     D   si_jobno                     6A
     D                                4A
     D   si_code                     10I 0
     D   si_errno                    10I 0
     D   si_pid                      10I 0
     D   si_uid                      10U 0
     D   si_data                      1A

      *--------------------------------------------------------
      * itimerval: interval timer value
      *--------------------------------------------------------
     D it_timeval      ds                  qualified
     D                                     based(template)
     D    tv_sec                     10I 0
     D    tv_usec                    10I 0
     D itimerval       ds                  qualified
     D                                     based(template)
     D    int_tv_sec                 10I 0
     D    int_tv_usec                10I 0
     D    val_tv_sec                 10I 0
     D    val_tv_usec                10I 0

      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * alarm(): Send an alarm signal after XX seconds
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D alarm           PR            10U 0 extproc('alarm')
     D   secs                        10U 0 value

      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * Qp0sEnableSignals():  Enable a process for signals
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0sEnableSignals...
     D                 PR            10I 0 extproc('Qp0sEnableSignals')

      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * Qp0sDisableSignals(): Disable signals
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0sDisableSignals...
     D                 PR            10I 0 extproc('Qp0sEnableSignals')

      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * default signal handlers
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D C_sig_err       PR                  extproc('_C_sig_err')
     D   signal                      10I 0 value
     D SIG_ERR         S               *   procptr inz(%paddr(C_sig_err))

     D C_sig_dfl       PR                  extproc('_C_sig_dfl')
     D   signal                      10I 0 value
     D SIG_DFL         S               *   procptr inz(%paddr(C_sig_dfl))

     D C_sig_ign       PR                  extproc('_C_sig_ign')
     D   signal                      10I 0 value
     D SIG_IGN         S               *   procptr inz(%paddr(C_sig_ign))

      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigaction():  Set signal action
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigaction       PR                  extproc('sigaction')
     D   sig                         10I 0 value
     D   act                               likeds(sigaction_t) const
     D                                     options(*omit)
     D   oact                              likeds(sigaction_t)
     D                                     options(*omit)

      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigaddset():  add signal to signal set
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigaddset       PR            10I 0 extproc('sigaddset')
     D   set                               like(sigset_t)
     D   signo                       10I 0 value


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigdelset():  remove signal from signal set
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigdelset       PR            10I 0 extproc('sigdelset')
     D   set                               like(sigset_t)
     D   signo                       10I 0 value


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigemptyset(): initialize an empty signal set
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigemptyset     PR            10I 0 extproc('sigemptyset')
     D   set                               like(sigset_t)


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigfillset(): initialize a full signal set
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigfillset      PR            10I 0 extproc('sigfillset')
     D   set                               like(sigset_t)


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigismember(): test if signal is in signal set
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigismember     PR            10I 0 extproc('sigismember')
     D   set                               like(sigset_t)
     D   signo                       10I 0 value


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * signal(): set signal action (simplified version of
      *           sigaction() API)
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D signal          PR              *   procptr
     D                                     extproc('signal')
     D   sig                         10I 0 value
     D   handler                       *   procptr value


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigpending(): examine pending signals
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigpending      PR            10I 0 extproc('sigpending')
     D   set                               like(sigset_t)


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigprocmask(): Examine and change blocked signals
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigprocmask     PR            10I 0 extproc('sigprocmask')
     D   how                         10I 0 value
     D   set                               like(sigset_t)
     D                                     const
     D   oset                              like(sigset_t)


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigsuspend(): replace signal mask and suspend
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigsuspend      PR            10I 0 extproc('sigsuspend')
     D   mask                              like(sigset_t)   const


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigwait(): wait for a signal in a set
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigwait         PR            10I 0 extproc('sigwait')
     D   set                               like(sigset_t)   const


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * setitimer(): set value for interval timer
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D setitimer       PR            10I 0 extproc('setitimer')
     D   which                       10I 0 value
     D   value                             like(itimerval) const
     D   ovalue                            like(itimerval) options(*omit)


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * getitimer(): Get value of interval timer
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D getitimer       PR            10I 0 extproc('getitimer')
     D   which                       10I 0 value
     D   value                             like(itimerval)

      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * sigtimedwait(): Wait for X seconds for a pending
      *                 signal to appear
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D sigtimedwait    PR            10I 0 extproc('sigtimedwait')
     D   set                               like(sigset_t) const
     D   info                              likeds(siginfo_t) options(*omit)
     D   timeout                      8a   const options(*omit)

      *****************************************************
      * Timer interface - modified ADC (Luca IDLE_TIMEOUT)
      *****************************************************
      * time out types of alarms
     D SIG_TIMEOUT_CLIENT...
     D                 C                   const('C')
     D SIG_TIMEOUT_SERVER...
     D                 C                   const('S')
     D SIG_TIMEOUT_CALL_CLIENT...
     D                 C                   const('1')
     D SIG_TIMEOUT_CALL_SERVER...
     D                 C                   const('2')
      * time out types of actions
     D SIG_ACTION_BUSY...
     D                 C                   const('B')
     D SIG_ACTION_KILL...
     D                 C                   const('K')
     D SIG_ACTION_USER...
     D                 C                   const('U')
      * time out setting persistence
     D SIG_SET_PERM...
     D                 C                   const('P')
     D SIG_SET_ORIG...
     D                 C                   const('O')

      * timer pop will call confTimePop (see plugconf)
     D sigSetTimeOut...
     D                 PR
     D   timerType                    1A   value
     D   timerPerm                    1A   value
     D   timeAction                   1A   value
     D   timeSeconds                 10i 0 value

      * turn timer off
     D sigTimerOff     PR

      * last timer status (see plugconf_h)
     D sigLastTimer...
     D                 PR             1N
     D   timerType                    1A
     D   timeAction                   1A
     D   timeSeconds                 10i 0


