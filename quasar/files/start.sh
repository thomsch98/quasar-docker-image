#!/usr/bin/env ash

set -x

CONFIG_DIR=$HOME/.config/quasar
CONFIG_FILE=$CONFIG_DIR/quasar-config.json

export PORT=8080
export MOUNT=/local/
export CONNECTION=mongodb://mongodb/lxr

mkdir -p "$CONFIG_DIR"

envsubst < template.quasar-config.json > $CONFIG_FILE

JAVA_OPT=-Dlog4j.configuration=file:./log4j.properties ${JAVA_OPT}

APP=${APP:-web}

#java ${JAVA_OPT} -jar quasar-${APP}-assembly.jar initUpdateMetaStore
#java ${JAVA_OPT} -jar quasar-${APP}-assembly.jar -P plugins/
java ${JAVA_OPT} -jar quasar-${APP}-assembly.jar initUpdateMetaStore --backend:quasar.physical.mongodb.MongoDb\$=plugins/quasar-mongodb-internal-assembly.jar
java ${JAVA_OPT} -jar quasar-${APP}-assembly.jar --backend:quasar.physical.mongodb.MongoDb\$=plugins/quasar-mongodb-internal-assembly.jar
