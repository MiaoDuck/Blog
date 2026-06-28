# 技术笔记

基于 [Hugo](https://gohugo.io/) + [PaperMod](https://github.com/adityatelange/hugo-PaperMod) 主题搭建的个人博客。

## 功能

- 文章列表 / 归档 / 分类 / 标签
- 本地全文搜索（首页右上角"搜索"）
- 自动目录（TOC）、阅读时长、代码复制
- 明暗主题切换（跟随系统，可手动切换）
- Mermaid 流程图渲染

## 目录结构

```
content/posts/      # 文章（每篇一个文件夹，便于放图片）
layouts/            # 覆盖主题的布局（Mermaid 渲染钩子、head 注入）
themes/PaperMod/    # 主题（已内置，无需额外拉取）
hugo.toml           # 站点配置
build.sh            # 部署平台构建脚本
```

## 本地预览

需要安装 Hugo extended（≥ 0.146）。macOS 可用 `brew install hugo`，Windows 用 `scoop install hugo-extended`。

```bash
hugo server -D   # -D 包含草稿
```

浏览器打开 http://localhost:1313

## 写新文章

在 `content/posts/` 下新建文件夹和 `index.md`：

```bash
hugo new content/posts/my-post/index.md
```

编辑文件头的 front matter：

```yaml
---
title: "文章标题"
date: 2026-06-28T21:00:00+08:00
draft: false
description: "摘要"
tags: ["标签1", "标签2"]
categories: ["分类"]
---
```

正文用 Markdown。流程图用 ` ```mermaid ` 代码块即可自动渲染。

## 部署到 EdgeOne Pages

1. 把本仓库推送到 Git 托管平台（GitHub / Gitee 等）
2. 在 [EdgeOne Pages](https://edgeone.cloud.tencent.com/pages) 新建项目，连接该仓库
3. 构建配置：
   - 构建命令：`bash build.sh`
   - 输出目录：`public`
4. 部署后会得到一个 `*.edgeone.app` 免费域名
5. 拿到域名后，把 `hugo.toml` 里的 `baseURL` 改成实际域名，重新提交即可

> `build.sh` 会自动下载兼容版本的 Hugo，不依赖平台自带版本。

## 更新主题

主题已内置在 `themes/PaperMod/`。如需升级，删除该目录后重新克隆最新版即可：

```bash
rm -rf themes/PaperMod
git clone --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
rm -rf themes/PaperMod/.git
```
