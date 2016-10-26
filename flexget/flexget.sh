/usr/local/bin/flexget -c $HOME/Scripts/flexget/flexget.yml --logfile $HOME/Scripts/logs/log.flexget --cron
chmod -R 777 $HOME/Downloads/
chown -R mal:mal $HOME/Downloads/
chown -R mal:mal $HOME/Scripts/flexget/
