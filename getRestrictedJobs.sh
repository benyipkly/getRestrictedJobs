#!/bin/sh
print_usage ()
{
	echo "Usage : $0 [-d|--date <YYYY-mm-dd>]"
}
DATE=$(date -d "-1 day" +%Y-%m-%d)
while [[ $# -gt 0 ]]
do
	case "$1" in
		-d | --date)
		if [[ -z $2 ]]
		then
			print_usage
			exit 1
		fi
		DATE="$2"
		shift 2
			;;
		-h | --help)
			print_usage
			exit 0
			;;
		--)
			shift
			break
			;;
		-*)
			print_usage
			exit 1
			;;
		*)
			break
			shift
			;;
	esac
done
echo "Select j.jobid, j.system, j.username, j.groupname, j.account, j.cput_sec from Jobs as j where j.end_date = '$DATE'" | mysql -hdbsys01.infra -uwebapp pbsacct > jobs.csv
$(python match.py)
