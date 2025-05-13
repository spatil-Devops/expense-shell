rm -f /tmp/frontend.log

source common.sh


HEADING "Installing Nginx"
sudo dnf install nginx -y &>>/tmp/frontend.log
STAT $?

HEADING "Copy Expense conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/frontend.log
STAT $?

HEADING "Clean old content"
rm -rf /usr/share/nginx/html/* &>>/tmp/frontend.log
STAT $?

HEADING "Download frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/frontend.log
STAT $?

HEADING "Extract frontend content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/frontend.log
STAT $?

HEADING "Restart Nginx"
systemctl restart nginx &>>/tmp/frontend.log
systemctl enable nginx &>>/tmp/frontend.log
STAT $?