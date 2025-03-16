# Script to automatic backup creating. Commands to activate script:
# chmod +x scripts/backup-mysql.sh
# .scripts/backup-mysql.sh
#!/bin/bash

# Backup connecting (write your details)
DB_HOST="3306"
DB_USER="root"
DB_PASS="psswrd"
DB_NAME="db"
BACKUP_DIR="/backups"
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql"

# Creaking backup directory
mkdir -p $BACKUP_DIR

# Creating backup
mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE

# Successfully checking
if [ $? -eq 0 ]; then
  echo "Backup successful! File: $BACKUP_FILE"
else
  echo "Backup failed!"
  exit 1
fi

# Delete old backups
find $BACKUP_DIR -type f -name "backup_*.sql" -mtime +7 -exec rm {} \;

echo "Old backups deleted."
