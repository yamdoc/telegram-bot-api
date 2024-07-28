# Telegram Bot API (Docker)

## FAQ

* Why would I need this over https://api.telegram.org?
* To send/recieve files over misarble `20MB` quota standard bots are offered. `2GB` as the limit sounds way better. Or to use any **local** IP/port for your webhooks (up to 100k).
---
* Is there any tradeoffs I have to take for these features?
* Yes, sure, your infrastructure now has to have 1 more moving part. This package designed to make it as simple and straightforward as possible.
---
* How much shall it cost me?
* 0$, that's for sure. And like 5% CPU, 20mb RAM and 70mb of hard disk space.
---
* How to make my bot use this API?
* Usually, your library has something like URL parameter, when creating the bot, paste in there `http://127.0.0.1:8081` (or with your's port, or with your's IP, thoght local usage is prefered). That's basically it.

All of this is official, for more info: https://github.com/tdlib/telegram-bot-api

## Setup

> Note: creds below are obtained here https://core.telegram.org/api/obtaining_api_id

There's two ways, the one-liner just to get the test of the medicine and `compose.yml` (recommended for the long run).

### The one line drug
```shell
docker run -e TG_API_ID=<YOUR_APP_ID> -e TG_API_HASH=<TG_API_HASH> -e TG_API_DIR="$PWD/tgapi_data" -d -p 8081:8081 --name=telegram-bot-api yam0/telegram-bot-api
```

### The good boy's way

1. Setup 
```shell
git clone https://github.com/yamdoc/telegram-bot-api
cd telegram-bot-api
vi .env
```
2. Start and forget
```shell
docker compose up -d
```

### How to test everything is OK

```shell
curl http://127.0.0.1:8081/bot<YOUR_BOT_TOKEN>/getMe
```

## Caveats

1. If you are downloading any files, they are getting stored as local API cache, you might want to handle them specifically.
2. If your API and a bot aren't on the same machine, only file uploading shall work.
3. If you get Docker errors about credeintials, stop API server, remove TG_API_DIR, mkdir it back, and restart API server. 