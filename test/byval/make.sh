#!/bin/sh
# -------
#
# > ./make.sh [testsrvx ...]
#
# examples:
#   full build
#   > export INIRPGLIB=XMLSERVICE
#   > export INIALLOWNONE=ON
#   > export INIJOBD=QSYS/QSRVJOB
#   > ./make.sh
#
#   individual module compiles
#   > ./make.sh testsrvx
#
### RPG PTF required ###
# TGTCCSID(37)
# V7R1 - SI62954
# V7R2 - SI62956 (SI52690)
# V7R3 - SI62958
#

# ini settings

if [[ -z "$INIRPGLIB" ]]
then
  INIRPGLIB='XMLSERVICE'
fi
INIRPGLIB=$(echo $INIRPGLIB | tr [a-z] [A-Z])
echo "INIRPGLIB=$INIRPGLIB (export INIRPGLIB=XMLSERVICE)"

if [[ -z "$INIALLOWNONE" ]]
then
  INIALLOWNONE='ON'
fi
INIALLOWNONE=$(echo $INIALLOWNONE | tr [a-z] [A-Z])
echo "INIALLOWNONE=$INIALLOWNONE (export INIALLOWNONE=ON)"

if [[ -z "$INIJOBD" ]]
then
  INIJOBD='QSYS/QSRVJOB'
fi
INIJOBD=$(echo $INIJOBD | tr [a-z] [A-Z])
echo "INIJOBD=$INIJOBD (export INIJOBD=QSYS/QSRVJOB)"

# -------
RPGLIB=$INIRPGLIB
RPGFILES=''
RPGFILES=''
RPGMODS=''
RPGASYNC=''
RPGDONE=''
RPGFAIL=''
MYDIR=$(pwd)

# -------
# user input
# -------
if [[ -z "$RPGASYNC" ]]
then
  if [ "$#" -gt 0 ]
  then
    RPGFILES="$1 $2 $3 $4 $5 $6 $7 $8 $9"
  else
    RPGASYNC='ALL'
  fi
fi

if [[ $RPGASYNC == "ALL" ]]
then
  RPGFILELIST=$(ls *.rpgle | grep -v _h)
  for j in $RPGFILELIST; do
    i=$(basename "$j" .rpgle)
    RPGFILES="$RPGFILES $i"
  done
fi

# -------
# build test include
# -------
echo "      /if defined(TEST_H)" > test_h.rpgle
echo "      /eof" >> test_h.rpgle
echo "      /endif" >> test_h.rpgle
echo "      /define TEST_H" >> test_h.rpgle
echo "       dcl-c TEST_LIB const('$RPGLIB');" >> test_h.rpgle
echo "       dcl-c TEST_IPC const('/tmp/$RPGLIB');" >> test_h.rpgle
echo "       " >> test_h.rpgle

# -------
# build core modules sync (one at time)
# -------
echo "building $RPGFILES ..."
if [[ -z "$RPGASYNC" ]]
then
  for i in $RPGFILES; do
    echo '===================================='
    echo "==> $RPGLIB/$i ..."
    system "DLTMOD MODULE($RPGLIB/$i)"
    if [[ $i == *"sql"* ]]
    then
      cmd="CRTSQLRPGI OBJ($RPGLIB/$i) SRCSTMF('$i.rpgle') OBJTYPE(*MODULE) OUTPUT(*PRINT) DBGVIEW(*SOURCE) REPLACE(*YES) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(37)')"
    else
      cmd="CRTRPGMOD MODULE($RPGLIB/$i) SRCSTMF('$i.rpgle') DBGVIEW(*SOURCE) OUTPUT(*PRINT) REPLACE(*YES) TGTCCSID(37)"
    fi
    echo "$cmd"
    system "$cmd" > /dev/null
    if [[ -e "/qsys.lib/$RPGLIB.lib/$i.module" ]]
    then
      echo "==> $RPGLIB/$i.module -- ok"
    else
      system "$cmd"
      echo "==> $RPGLIB/$i.module -- failed"
      exit
    fi
    echo '===================================='
  done
# -------
# build core modules async (all at once)
# -------
else
  echo "building async $RPGASYNC... "
  rm ./ok_*
  rm ./fail_*
  for i in $RPGFILES; do
    if [[ -e "/qsys.lib/$RPGLIB.lib/$i.module" ]]
    then
      system "DLTMOD MODULE($RPGLIB/$i)"
    fi
  done
  for i in $RPGFILES; do
    echo "building script $i.sh ... "
    if [[ $i == *"sql"* ]]
    then
      cmd="CRTSQLRPGI OBJ($RPGLIB/$i) SRCSTMF('$i.rpgle') OBJTYPE(*MODULE) OUTPUT(*PRINT) DBGVIEW(*SOURCE) REPLACE(*YES) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(37)')"
    else
      cmd="CRTRPGMOD MODULE($RPGLIB/$i) SRCSTMF('$i.rpgle') DBGVIEW(*SOURCE) OUTPUT(*PRINT) REPLACE(*YES) TGTCCSID(37)"
    fi
    echo "#!/bin/sh" > "$i.sh"
    echo "system \"$cmd\" > /dev/null" >> "$i.sh"
    echo "if [[ -e '/qsys.lib/$RPGLIB.lib/$i.module' ]]" >> "$i.sh"
    echo "then" >> "$i.sh"
    echo "  echo '==> $RPGLIB/$i.module -- ok'" >> "$i.sh"
    echo "  echo '==> $RPGLIB/$i.module -- ok' > ok_$i" >> "$i.sh"
    echo "else" >> "$i.sh"
    echo "  echo '==> $RPGLIB/$i.module -- failed'" >> "$i.sh"
    echo "  system \"$cmd\" > fail_$i" >> "$i.sh"
    echo "fi" >> "$i.sh"
    echo "background run $i.sh (async) ... "
    ./$i.sh &
  done
  while [[ -z "$RPGDONE" ]]; do
    if [[ -z "$RPGFAIL" ]]
    then
      echo "waiting for build ... "
      sleep 5
    else
      break
    fi
    for i in $RPGFILES; do
      if [[ -e "./fail_$i" ]]
      then
        echo "./fail_$i"
        RPGFAIL="./fail_$i"
        break
      else
        if [[ -e "./ok_$i" ]]
        then
          RPGDONE='yes'
        else
          RPGDONE=''
          break
        fi
      fi
    done
  done
fi

# -------
# check up on fails
# -------
if [[ -z "$RPGASYNC" ]]
then
  echo "module build complete"
else
  rm ./ok_*
  if [[ -z "$RPGFAIL" ]]
  then
    echo "module build complete"
  else
    echo "error $RPGFAIL"
    cat "$RPGFAIL"
    exit
  fi
fi

# -------
# rpg files
# -------
RPGFILELIST=$(ls *.rpgle | grep -v _h)

# -------
# build pgm(s)
# -------
for i in $RPGFILES; do
  if [[ $i == *"testzsrv"* ]]
  then
    echo '===================================='
    echo "==> $RPGLIB/$i ..."
    RPGMODS="$RPGLIB/$i"
    system "DLTSRVPGM SRVPGM($RPGLIB/$i)"
    cmd="CRTSRVPGM SRVPGM($RPGLIB/$i) MODULE($RPGMODS) EXPORT(*ALL) ACTGRP(*CALLER)"
    echo "$cmd"
    system "$cmd"
  elif [[ $i == *"test"*  ]]
  then
    echo '===================================='
    echo "==> $RPGLIB/$i ..."
    RPGBND="$RPGLIB/xmlstoredp"
    system "DLTPGM PGM($RPGLIB/$i)"
    cmd="CRTPGM PGM($RPGLIB/$i) MODULE($RPGLIB/$i) BNDSRVPGM($RPGBND)"
    echo "$cmd"
    system "$cmd"
    if [[ -e "/qsys.lib/$RPGLIB.lib/$i.PGM" ]]
    then
      echo "==> $RPGLIB/$i -- ok"
    else
      echo "==> $RPGLIB/$i -- failed"
      exit
    fi
  fi
done


# -------
# authorization
# -------
echo '===================================='
echo "==> $RPGLIB"
cmd="CHGAUT OBJ('/qsys.lib/$RPGLIB.lib') USER(QTMHHTTP) DTAAUT(*RWX) OBJAUT(*ALL) SUBTREE(*ALL)"
echo "$cmd"
system "$cmd"
cmd="CHGAUT OBJ('/qsys.lib/$RPGLIB.lib') USER(QTMHHTP1) DTAAUT(*RWX) OBJAUT(*ALL) SUBTREE(*ALL)"
echo "$cmd"
system "$cmd"

