source .env

astra db cqlsh $DB_NAME -f truncate_tables.cql
echo "TRUNCATE TABLEs completed."
