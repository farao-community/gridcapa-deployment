#!/bin/sh

#FILENAME="/app/dumps/dump_${HOSTNAME}_$(date +%F_%T_%Z).hprof"
#mv /app/dumps/java*.hprof "$FILENAME"
#chmod 777 $FILENAME

cd /home/farao

.minio/mc alias set gridcapa_minio $MINIO_URL $MINIO_ACCESS_KEY $MINIO_SECRET_KEY
.minio/mc ls gridcapa_minio

FILENAME="dump_${HOSTNAME}_$(date +%F_%T_%Z).hprof"

.minio/mc cp "dump.hprof" "gridcapa_minio/$MINIO_BUCKET/rao-runner-crash-data/$FILENAME"