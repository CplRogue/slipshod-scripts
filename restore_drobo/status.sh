echo " "
tail -n 100 ~/Scripts/logs/log.rclone | grep -A 10 Transferred | tail -n 14 | head -n 12
echo " "
