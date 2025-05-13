HEADING() {
  echo -e "\e[35m$*\e[0m"
}

STAT() {
  if [ $1 -eq 0 ];then
    echo SUCCESS
  else
    echo Failure
    exit 2
fi
}