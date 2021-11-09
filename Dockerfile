FROM metabase/metabase:latest
ADD --chown=2000 https://github.com/enqueue/metabase-clickhouse-driver/releases/download/0.7.5/clickhouse.metabase-driver.jar /plugins/
