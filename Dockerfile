FROM alpine:3.20.2 AS tgbotapi_build

WORKDIR /build

RUN apk update                                                                          &&\
    apk upgrade                                                                         &&\
    apk add --no-cache alpine-sdk linux-headers git zlib-dev openssl-dev gperf cmake    &&\
    git clone --recursive https://github.com/tdlib/telegram-bot-api.git                 &&\
    cd telegram-bot-api                                                                 &&\
    rm -rf build                                                                        &&\
    mkdir build                                                                         &&\
    cd build                                                                            &&\
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. ..                  &&\
    cmake --build . --target install -- -j 10                                           &&\
    cd ../..                                                                            &&\
    ls -l telegram-bot-api/bin/telegram-bot-api* 


FROM alpine:3.20.2

WORKDIR /app

ENV TG_API_ID=
ENV TG_API_HASH=
ENV TG_API_PORT=8081
ENV TG_API_DIR=/var/lib/telegram-bot-api
ENV TG_API_LOG_MAX_SIZE=100000000
ENV TG_API_LOCAL=--local

COPY --from=tgbotapi_build /build/telegram-bot-api/bin/telegram-bot-api /app/

RUN apk add --no-cache zlib openssl libstdc++-dev libgcc acl
COPY telegram-bot-api.sh /app/
RUN chmod +x /app/telegram-bot-api.sh

ENTRYPOINT [ "/app/telegram-bot-api.sh" ]