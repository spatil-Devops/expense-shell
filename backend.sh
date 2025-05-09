rm -rf /tmp/backend.log
source common.sh
MYSQL_SERVER_IPADDRESS=172.31.29.13

HEADING "Diable NodeJS default version"
dnf module disable nodejs -y &>>/tmp/backend.log
STAT $?

HEADING "Enable NodeJS 20 version"
dnf module enable nodejs:20 -y &>>/tmp/backend.log
STAT $?

HEADING "Install NodeJS"
dnf install nodejs -y &>>/tmp/backend.log
STAT $?

HEADING "Add User Expense"
id expense &>>/tmp/backend.log
if [$? -ne 0]; then
  useradd expense &>>/tmp/backend.log
fi
STAT $?

HEADING "Setup Backend Service"
cp backend.service /etc/systemd/system/backend.service
STAT $?

HEADING "Delete Existing App directory"
rm -rf /app
STAT $?

HEADING "Create App directory"
mkdir -p /app
STAT $?

HEADING "Download Backend Code"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/backend.log
STAT $?

HEADING "Extract Backend Code"
cd /app
unzip /tmp/backend.zip &>>/tmp/backend.log
STAT $?

HEADING "Install Dependencies"
cd /app
npm install &>>/tmp/backend.log
STAT $?

HEADING "Install Mysql"
dnf install mysql -y
STAT $?

HEADING "Create Sql schema"
mysql -h $MYSQL_SERVER_IPADDRESS -uroot -p$1 < /app/schema/backend.sql
STAT $?

HEADING "Start Backend serive"
systemctl daemon-reload &>>/tmp/backend.log
systemctl enable backend &>>/tmp/backend.log
systemctl restart backend &>>/tmp/backend.log
STAT $?