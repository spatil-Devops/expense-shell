rm -rf /tmp/mysql.log
source common.sh

if [-z "$1"]; then
  echo Mysql password is missing
  exit 1
fi 

HEADING "Installing Mysql"
dnf install mysql-server -y &>>/tmp/mysql.log
STAT $?

HEADING "Star Mysql Service"
systemctl enable mysqld &>>/tmp/mysql.log
systemctl start mysqld &>>/tmp/mysql.log
STAT $?

HEADING "Set Root Password"
mysql_secure_installation --set-root-pass $1
STAT $?