#!/usr/bin/env bash
# EdgeOne Pages / 任意 Linux 构建环境通用构建脚本
# 固定下载指定版本 Hugo extended，避免平台自带版本过旧导致主题不兼容
set -euo pipefail

HUGO_VERSION="0.163.3"
HUGO_BIN="${HUGO_BIN:-/tmp/hugo-bin}"

if [ ! -x "$HUGO_BIN/hugo" ] || ! "$HUGO_BIN/hugo" version 2>/dev/null | grep -q "$HUGO_VERSION"; then
  echo "==> 下载 Hugo v${HUGO_VERSION} (extended)"
  mkdir -p "$HUGO_BIN"
  curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" -o /tmp/hugo.tgz
  tar -xzf /tmp/hugo.tgz -C "$HUGO_BIN" hugo
  chmod +x "$HUGO_BIN/hugo"
fi

echo "==> Hugo 版本"
"$HUGO_BIN/hugo" version

echo "==> 构建站点"
"$HUGO_BIN/hugo" --gc --minify
