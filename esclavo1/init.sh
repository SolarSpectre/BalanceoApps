#!/bin/bash

# Wait until local MySQL is ready
echo "[Slave Init] Waiting for MySQL to be ready..."
until mysql -uroot -proot -e "SELECT 1;" &> /dev/null; do
  sleep 2
done

# Wait until master is ready
echo "[Slave Init] Waiting for master (maestro1)..."
until mysql -h maestro1 -uroot -proot -e "SELECT 1;" &> /dev/null; do
  sleep 2
done

echo "[Slave Init] Getting master's binlog info..."
MASTER_STATUS=$(mysql -h maestro1 -uroot -proot -e "SHOW MASTER STATUS\G")
LOG_FILE=$(echo "$MASTER_STATUS" | grep File | awk '{print $2}')
LOG_POS=$(echo "$MASTER_STATUS" | grep Position | awk '{print $2}')

# Set up replication
echo "[Slave Init] Configuring slave..."
mysql -uroot -proot <<-EOSQL
  STOP SLAVE;
  RESET SLAVE ALL;
  CHANGE MASTER TO
    MASTER_HOST='maestro1',
    MASTER_USER='replica_user',
    MASTER_PASSWORD='replica_pass',
    MASTER_LOG_FILE='$LOG_FILE',
    MASTER_LOG_POS=$LOG_POS;
  START SLAVE;
EOSQL

echo "[Slave Init] Slave started successfully."
