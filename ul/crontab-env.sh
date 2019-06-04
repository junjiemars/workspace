#!/bin/bash
#------------------------------------------------
# require: crontab 
# target : generate crontab script
# author : junjiemars@gmail.com
#------------------------------------------------


DEP="${DEP:-$(cd `dirname ${BASH_SOURCE[0]}`; pwd -P)}"
RUN="${RUN:-${DEP%/}/run}"
CRONTAB_LIST="crontab.list"
VER="${VER:-8.5.16}"

if [ -f "${CRONTAB_LIST}" ]; then
	mv "${CRONTAB_LIST}" "${CRONTAB_LIST}.pre"
fi

cat << END > "${DEP%/}/${CRONTAB_LIST}"
# generated by crontab-env.sh
# @"https://raw.githubusercontent.com/junjiemars/kit/master/ul/crontab-env.sh"

SHELL=`which bash`
PATH=${DEP%/}${PATH:+:$PATH}
RUN=${RUN%/}
VER=$VER

# crontab list
# *minute(0-59) *hour(0-23) *day-of-month(1-31) *month(1-12) *day-of-week(0-7)

# contab examples:
# every 5 minutes  : */5 *    * * * <job>
# 5th weekday      : *   *    * * 5 <job>
# 1st or 15th hour : *   1,15 * * * <job>

# TODO:
# * * * * * <job> >> /tmp/x.log 2>&1

#------------------
# existing jobs ...
#------------------
`
if $(hash crontab &>/dev/null); then
	crontab -l 2>/dev/null
fi
`

END
