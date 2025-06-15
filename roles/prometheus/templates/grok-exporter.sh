while true ; do
  if [ -f /var/log/nginx/access.log ]; then
    break
  fi
  echo File /var/log/nginx/access.log, Does not exist for grok exporter to start.
  sleep 1
done
cd /opt/grok_exporter-0.2.8.linux-amd64
/opt/grok_exporter-0.2.8.linux-amd64/grok_exporter -config ./config.yml