XMLSERVICE Errors
=================
`Goto Main Page`_

.. _Goto Main Page: index.html


Common errors
-------------

::

      <errnoile>3401</errnoile>
      <errnoilemsg><![CDATA[Permission denied.]]></errnoilemsg>
      <errnoxml>1301011</errnoxml>
      <xmlerrmsg><![CDATA[IPC shmat fail 1]]></xmlerrmsg>
      <xmlhint><![CDATA[/tmp/packers3]]></xmlhint>
      </error>

errnoile 3401 -- usually means another process with a different user profile is using IPC (/tmp/packers3)

::

      <errnoile>3021</errnoile>
      <errnoxml>1301009</errnoxml>
      <xmlerrmsg>IPC getshm fail</xmlerrmsg>
      <xmlhint><![CDATA[/tmp/ ]]></xmlhint>

'Hung' semaphores/shared memory associated with a user never suppose to happen, but have seen in rare occasion. The following commands can be used to remove "hung" semaphores/shared memory associated with a user assuming you have appropriate authority to run like SECOFR, etc. (Ranger welcomes you to Unix geek-ville).

Example::

      grep -i qtm means ipcrm for (QTM)HHTTP ...

      endTCPSVR SERVER(*HTTP) INSTANCE(ZENDSVR)                               -- suggest end web server

      call qp2term
      > ipcs | grep -i qtm | awk '{print "ipcrm -" tolower($1) " "$2}'        -- show action, but NOT do  action
      > ipcs | grep -i qtm | awk '{print "ipcrm -" tolower($1) " "$2}' | sh   -- remove semaphores/shared memory

      strTCPSVR SERVER(*HTTP) INSTANCE(ZENDSVR)                               -- suggest start web server


::

      <errnoxml>1000005</errnoxml>
      <xmlerrmsg>PASE resolve failed</xmlerrmsg>
      <xmlhint><![CDATA[MYPGM]]></xmlhint>

The program you tried to call, shown here as "MYPGM" (in the CDATA tag), was not found. Make sure you specified the library and program correctly, including upper or lower case (usually upper case).

::

      <errnoxml>1480002</errnoxml>
      <xmlerrmsg>XMLCGI invalid</xmlerrmsg>
      <xmlhint>*NONE</xmlhint>

\*NONE requires a special compile of the RPG source and is NOT enabled in production versions of the toolkit by default. 
It is most useful for demos with custom security like this site, if you try on your machine you will likely get 1480002 
error XMLCGI. You can find details in plugerr_h.


ILE errno
---------

Errno Values for UNIX-Type Functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Programs using the UNIX(R)-type functions may receive error information as errno values.
The possible values returned are listed here in ascending errno value sequence.

::

      Name 	        Value 	Text
      EDOM 	        3001 	A domain error occurred in a math function.
      ERANGE 	        3002 	A range error occurred.
      ETRUNC  	3003 	Data was truncated on an input, output, or update operation.
      ENOTOPEN        3004 	File is not open.
      ENOTREAD        3005 	File is not opened for read operations.
      EIO 	        3006 	Input/output error.
      ENODEV 	        3007 	No such device.
      ERECIO 	        3008 	Cannot get single character for files opened for record I/O.
      ENOTWRITE       3009 	File is not opened for write operations.
      ESTDIN 	        3010 	The stdin stream cannot be opened.
      ESTDOUT         3011 	The stdout stream cannot be opened.
      ESTDERR         3012 	The stderr stream cannot be opened.
      EBADSEEK        3013 	The positioning parameter in fseek is not correct.
      EBADNAME        3014 	The object name specified is not correct.
      EBADMODE        3015 	The type variable specified on the open function is not correct.
      EBADPOS         3017 	The position specifier is not correct.
      ENOPOS 	        3018 	There is no record at the specified position.
      ENUMMBRS        3019 	Attempted to use ftell on multiple members.
      ENUMRECS        3020 	The current record position is too long for ftell.
      EINVAL 	        3021 	The value specified for the argument is not correct.
      EBADFUNC        3022 	Function parameter in the signal function is not set.
      ENOENT 	        3025 	No such path or directory.
      ENOREC  	3026 	Record is not found.
      EPERM 	        3027 	The operation is not permitted.
      EBADDATA        3028 	Message data is not valid.
      EBUSY 	        3029 	Resource busy.
      EBADOPT         3040 	Option specified is not valid.
      ENOTUPD         3041 	File is not opened for update operations.
      ENOTDLT         3042 	File is not opened for delete operations.
      EPAD 	        3043 	The number of characters written is shorter than the expected record length.
      EBADKEYLN       3044 	A length that was not valid was specified for the key.
      EPUTANDGET      3080 	A read operation should not immediately follow a write operation.
      EGETANDPUT      3081 	A write operation should not immediately follow a read operation.
      EIOERROR        3101 	A nonrecoverable I/O error occurred.
      EIORECERR       3102 	A recoverable I/O error occurred.
      EACCES 	        3401 	Permission denied.
      ENOTDIR         3403 	Not a directory.
      ENOSPC 	        3404 	No space is available.
      EXDEV 	        3405 	Improper link.
      EAGAIN 	        3406 	Operation would have caused the process to be suspended.
      EWOULDBLOCK     3406 	Operation would have caused the process to be suspended.
      EINTR 	        3407 	Interrupted function call.
      EFAULT 	        3408 	The address used for an argument was not correct.
      ETIME 	        3409 	Operation timed out.
      ENXIO 	        3415 	No such device or address.
      EAPAR 	        3418 	Possible APAR condition or hardware failure.
      ERECURSE        3419 	Recursive attempt rejected.
      EADDRINUSE      3420 	Address already in use.
      EADDRNOTAVAIL   3421 	Address is not available.
      EAFNOSUPPORT    3422 	The type of socket is not supported in this protocol family.
      EALREADY        3423 	Operation is already in progress.
      ECONNABORTED    3424 	Connection ended abnormally.
      ECONNREFUSED    3425 	A remote host refused an attempted connect operation.
      ECONNRESET      3426 	A connection with a remote socket was reset by that socket.
      EDESTADDRREQ    3427 	Operation requires destination address.
      EHOSTDOWN       3428 	A remote host is not available.
      EHOSTUNREACH    3429 	A route to the remote host is not available.
      EINPROGRESS     3430 	Operation in progress.
      EISCONN         3431 	A connection has already been established.
      EMSGSIZE        3432 	Message size is out of range.
      ENETDOWN        3433 	The network currently is not available.
      ENETRESET       3434 	A socket is connected to a host that is no longer available.
      ENETUNREACH     3435 	Cannot reach the destination network.
      ENOBUFS         3436 	There is not enough buffer space for the requested operation.
      ENOPROTOOPT     3437 	The protocol does not support the specified option.
      ENOTCONN        3438 	Requested operation requires a connection.
      ENOTSOCK        3439 	The specified descriptor does not reference a socket.
      ENOTSUP         3440 	Operation is not supported.
      EOPNOTSUPP      3440 	Operation is not supported.
      EPFNOSUPPORT    3441 	The socket protocol family is not supported.
      EPROTONOSUPPORT 3442 	No protocol of the specified type and domain exists.
      EPROTOTYPE      3443 	The socket type or protocols are not compatible.
      ERCVDERR        3444 	An error indication was sent by the peer program.
      ESHUTDOWN       3445 	Cannot send data after a shutdown.
      ESOCKTNOSUPPORT 3446 	The specified socket type is not supported.
      ETIMEDOUT       3447 	A remote host did not respond within the timeout period.
      EUNATCH         3448 	The protocol required to support the specified address family is not available at this time.
      EBADF 	        3450 	Descriptor is not valid.
      EMFILE 	        3452 	Too many open files for this process.
      ENFILE 	        3453 	Too many open files in the system.
      EPIPE 	        3455 	Broken pipe.
      ECANCEL         3456 	Operation cancelled.
      EEXIST 	        3457 	File exists.
      EDEADLK         3459 	Resource deadlock avoided.
      ENOMEM 	        3460 	Storage allocation request failed.
      EOWNERTERM      3462 	The synchronization object no longer exists because the owner is no longer running.
      EDESTROYED      3463 	The synchronization object was destroyed, or the object no longer exists.
      ETERM 	        3464 	Operation was terminated.
      ENOENT1         3465 	No such file or directory.
      ENOEQFLOG       3466 	Object is already linked to a dead directory.
      EEMPTYDIR       3467 	Directory is empty.
      EMLINK 	        3468 	Maximum link count for a file was exceeded.
      ESPIPE 	        3469 	Seek request is not supported for object.
      ENOSYS 	        3470 	Function not implemented.
      EISDIR 	        3471 	Specified target is a directory.
      EROFS 	        3472 	Read-only file system.
      EUNKNOWN        3474 	Unknown system state.
      EITERBAD        3475 	Iterator is not valid.
      EITERSTE        3476 	Iterator is in wrong state for operation.
      EHRICLSBAD      3477 	HRI class is not valid.
      EHRICLBAD       3478 	HRI subclass is not valid.
      EHRITYPBAD      3479	HRI type is not valid.
      ENOTAPPL        3480 	Data requested is not applicable.
      EHRIREQTYP      3481 	HRI request type is not valid.
      EHRINAMEBAD     3482 	HRI resource name is not valid.
      EDAMAGE         3484 	A damaged object was encountered.
      ELOOP 	        3485 	A loop exists in the symbolic links.
      ENAMETOOLONG    3486 	A path name is too long.
      ENOLCK 	        3487 	No locks are available.
      ENOTEMPTY       3488 	Directory is not empty.
      ENOSYSRSC       3489 	System resources are not available.
      ECONVERT        3490 	Conversion error.
      E2BIG 	        3491 	Argument list is too long.
      EILSEQ 	        3492 	Conversion stopped due to input character that does not belong to the input codeset.
      ETYPE 	        3493 	Object type mismatch.
      EBADDIR         3494 	Attempted to reference a directory that was not found or was destroyed.
      EBADOBJ         3495 	Attempted to reference an object that was not found, was destroyed, or was damaged.
      EIDXINVAL       3496 	Data space index used as a directory is not valid.
      ESOFTDAMAGE     3497 	Object has soft damage.
      ENOTENROLL      3498 	User is not enrolled in system distribution directory.
      EOFFLINE        3499 	Object is suspended.
      EROOBJ 	        3500 	Object is a read-only object.
      EEAHDDSI        3501 	Hard damage on extended attribute data space index.
      EEASDDSI        3502 	Soft damage on extended attribute data space index.
      EEAHDDS         3503 	Hard damage on extended attribute data space.
      EEASDDS         3504 	Soft damage on extended attribute data space.
      EEADUPRC        3505 	Duplicate extended attribute record.
      ELOCKED         3506 	Area being read from or written to is locked.
      EFBIG 	        3507 	Object too large.
      EIDRM 	        3509 	The semaphore, shared memory, or message queue identifier is removed from the system.
      ENOMSG 	        3510 	The queue does not contain a message of the desired type and (msgflg logically ANDed with IPC_NOWAIT).
      EFILECVT        3511 	File ID conversion of a directory failed.
      EBADFID         3512 	A file ID could not be assigned when linking an object to a directory.
      ESTALE 	        3513 	File handle was rejected by server.
      ESRCH 	        3515 	No such process.
      ENOTSIGINIT     3516 	Process is not enabled for signals.
      ECHILD 	        3517 	No child process.
      EBADH 	        3520 	Handle is not valid.
      ETOOMANYREFS    3523 	The operation would have exceeded the maximum number of references allowed for a descriptor.
      ENOTSAFE        3524 	Function is not allowed.
      EOVERFLOW       3525 	Object is too large to process.
      EJRNDAMAGE      3526 	Journal is damaged.
      EJRNINACTIVE    3527 	Journal is inactive.
      EJRNRCVSPC      3528 	Journal space or system storage error.
      EJRNRMT         3529 	Journal is remote.
      ENEWJRNRCV      3530 	New journal receiver is needed.
      ENEWJRN         3531 	New journal is needed.
      EJOURNALED      3532 	Object already journaled.
      EJRNENTTOOLONG  3533 	Entry is too large to send.
      EDATALINK       3534 	Object is a datalink object.
      ENOTAVAIL       3535 	IASP is not available.
      ENOTTY 	        3536 	I/O control operation is not appropriate.
      EFBIG2 	        3540 	Attempt to write or truncate file past its sort file size limit.
      ETXTBSY         3543 	Text file busy.
      EASPGRPNOTSET   3544 	ASP group not set for thread.
      ERESTART        3545 	A system call was interrupted and may be restarted.
      ESCANFAILURE    3546 	An object has been marked as a scan failure due to processing by an exit program associated with the scan-related integrated file system exit points.




..
      [--Author([[http://youngiprofessionals.com/wiki/index.php/XMLSERVICE/XMLSERVICEError?action=expirediff | s ]])--]
      [--Tony "Ranger" Cairns - IBM i PHP / PASE--]
