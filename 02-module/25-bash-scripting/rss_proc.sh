#!/usr/bin/env bash

set -eou pipefail

ps -eo pid,rss,user,comm --sort=-rss | head -n 11
