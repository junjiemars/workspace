#!/bin/bash
#------------------------------------------------
# author: junjiemars@gmail.com
# target: SQL*Plus Kits
# note: do not specify $ORACLE_HOME if you have 
# > multiple Oracle products running, 
# > use $ORACLE_HOME indeed.
#------------------------------------------------

export ORACLE_HOME=${ORACLE_HOME:-'/opt/oracle/instantclient_12_1/'}
export SQLPATH=${SQLPATH:-'/opt/oracle/sql'}
export NLS_LANG=${NLS_LANG:-'AMERICAN_AMERICA.UTF8'}
export LD_LIBRARY_PATH=$ORACLE_HOME/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export PATH=$ORACLE_HOME/bin:${PATH:+:$PATH}

USERNAME=${USERNAME:-'system'}
PASSWORD=${PASSWORD:-'oracle'}
HOST=${HOST:-'localhost'}
PORT=${PORT:-'1521'}
SID=${SID:-'XE'}
CONNECT_IDENTIFIER=${CONNECT_IDENTIFIER:-"${HOST}:${PORT}/${SID}"}

if [ 0 -eq `type -p rlwrap &>/dev/null; echo $?` ]; then
	RLWRAP='rlwrap'
else
	RLWRAP=''	
fi	

if [ 0 -eq $# ] ; then
	rlwrap sqlplus ${USERNAME}/${PASSWORD}@${CONNECT_IDENTIFIER}
else 
	rlwrap sqlplus $@
fi

