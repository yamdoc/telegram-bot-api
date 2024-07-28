#!/bin/sh

mkdir -p ${TG_API_DIR}

/app/telegram-bot-api                               \
    "--api-id"=${TG_API_ID}                         \
    "--api-hash"=${TG_API_HASH}                     \
    "--log-max-file-size" ${TG_API_LOG_MAX_SIZE}    \
    "-p" ${TG_API_PORT}                             \
    "-d" ${TG_API_DIR}                              \
    ${TG_API_LOCAL}                                 