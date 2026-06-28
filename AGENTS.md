# AGENTS.md

本文件为 AI 编程助手提供本仓库的工作指引。接手任务前请先通读全文。

## 项目概述

这是一个**个人技术笔记站**，使用 Hugo 静态站点生成器 + Hextra 主题搭建，部署在 Cloudflare Workers（静态资源模式）。

- **线上地址**：https://blog.mkka27834.workers.dev/
- **主开发仓库**：CNB（`cnb.cool/miaoduck/Boke`）
- **部署镜像仓库**：GitHub（`MiaoDuck/Blog`）
- **部署方式**：推送到 GitHub `main` 分支 → Cloudflare 自动构建发布

## 技术栈

| 组件 | 版本/说明 |
|------|-----------|
| Hugo | 0.163.3 extended（由 `build.sh` 自动下载，不依赖环境自带版本） |
| 主题 | Hextra（vendored 在 `themes/hextra/`，**不要改主题文件**） |
| 搜索 | FlexSearch（主题内置） |
| 图表 | Mermaid.js 11（CDN 加载，见下文） |
| 部署 | Cloudflare Workers 静态资源（`wrangler.jsonc` 配置） |

## 目录结构

```
content/
├── _index.md                          # 首页
├── docs/                              # 知识库（左侧树状导航，按主题分类）
│   ├── _index.md                      # "知识库" 根节点
│   └── <主题>/                         # 如 network/、database/、architecture/
│       ├── _index.md                  # 主题分类节点
│       └── <文章>.md                  # 具体文章
└── blog/                              # 博客（时间线，按日期倒序）
    └── <文章>.md                      # 随手记录
layouts/
├── _default/_markup/
│   └── render-codeblock-mermaid.html  # Mermaid 代码块渲染钩子
└── _partials/custom/
    └── head-end.html                  # Mermaid.js 加载（注入点）
themes/hextra/                         # 主题（vendored，勿改）
hugo.toml                              # 站点配置
build.sh                               # 构建脚本（下载 Hugo + 构建）
wrangler.jsonc                         # Cloudflare 部署配置（勿删！）
```

## 核心规则：内容该放哪里

这是本站最重要的约定，写新文章时必须先判断归属：

| 文章类型 | 放置位置 | 说明 |
|----------|----------|------|
| **系统化学习笔记**（长文、有体系） | `content/docs/<主题>/<文章>.md` | 进入左侧知识库导航树 |
| **随手记录**（短文、想法、日记） | `content/blog/<文章>.md` | 按时间线排列 |

### 新建知识库主题

如果文章属于一个**新主题**（如"数据库"），需同时创建分类节点：

```
content/docs/database/
├── _index.md    # 必需！定义分类名和排序
└── mysql.md     # 文章
```

`_index.md` 模板：
```toml
+++
title = '数据库'
linkTitle = '数据库'
weight = 2   # 控制左侧导航中的排序
+++
```

## Front Matter 约定

### 知识库文章（`content/docs/`）

```yaml
---
title: "文章标题"
linkTitle: "左侧导航显示的短标题"   # 可选，默认用 title
weight: 1                          # 控制同类文章排序
date: 2026-06-28T21:00:00+08:00
draft: false                       # true 则不发布
description: "文章摘要"
tags: ["标签1", "标签2"]
---
```

### 博客文章（`content/blog/`）

```yaml
---
title: "文章标题"
date: 2026-06-28T21:00:00+08:00
draft: false
description: "摘要"
tags: ["标签1"]
---
```

> `weight` 仅 docs 用；blog 按日期排序，不需要 weight。

## 特殊功能

### Mermaid 流程图

用 ` ```mermaid ` 代码块即可，已全局启用，无需额外配置：

````
```mermaid
flowchart TD
    A --> B
```
````

支持自动跟随明暗主题。渲染逻辑在 `layouts/_partials/custom/head-end.html`。

### Callout 提示框

Hextra 内置短代码，直接在 Markdown 中使用：

```markdown
{{< callout type="info" >}}
信息内容
{{< /callout >}}
```

`type` 可选：`info`（蓝）、`warning`（黄）、`error`（红）、`important`（紫），默认灰色。

### GitHub 风格提示（`> [!NOTE]`）

Hextra v0.9+ 也支持 GitHub 风格的引用块提示，可直接写：

```markdown
> [!NOTE]
> 这会渲染成 callout 样式
```

## 常见任务

### 1. 新增一篇文章

```bash
# 知识库文章
hugo new content/docs/<主题>/<文件名>.md

# 博客文章
hugo new content/blog/<文件名>.md
```

然后编辑 front matter 和正文，保存即可。

### 2. 本地预览

```bash
hugo server -D   # -D 包含草稿
# 访问 http://localhost:1313
```

> 生产构建用 `bash build.sh`（会下载指定版本 Hugo）。

### 3. 发布上线

```bash
git add .
git commit -m "新文章：标题"
git push origin main    # 推到 CNB（主仓库）
git push github main    # 推到 GitHub（触发 Cloudflare 部署）
```

推送到 GitHub 后，Cloudflare 1~2 分钟内自动构建发布。

### 4. 修改站点配置

编辑 `hugo.toml`：站点标题、导航菜单、主题色、搜索、页脚等都在这里。改完本地 `hugo server` 验证后再推送。

## 注意事项（重要）

1. **不要删除 `wrangler.jsonc`**！它是 Cloudflare 部署配置，删了会导致 wrangler 进入自动配置模式并构建失败。

2. **不要修改 `themes/hextra/` 里的任何文件**。主题已 vendored（内置），如需自定义样式，在 `assets/css/custom.css` 中覆盖；如需自定义布局，在项目根 `layouts/` 下创建同名文件覆盖主题。

3. **Hugo 版本必须 ≥ 0.146**。`build.sh` 已固定下载 0.163.3，本地开发也需装对应版本。apt 自带的 Hugo 版本通常太旧，不要用。

4. **生产构建不需要 PostCSS/Tailwind**。Hextra 在生产模式（`hugo.IsProduction`）下直接使用预编译的 `assets/css/compiled/main.css`，纯 Hugo 构建即可，无需 npm/node 依赖。

5. **`baseURL` 必须与实际域名一致**，否则站内链接和 RSS 会指向错误地址。当前值：`https://blog.mkka27834.workers.dev/`。换域名时同步修改。

6. **双仓库工作流**：CNB 是主开发仓库，GitHub 是部署镜像。重要改动建议同时推送到两个 remote：`origin`（CNB）和 `github`。

## 构建部署排错速查

| 症状 | 原因 | 解决 |
|------|------|------|
| Cloudflare 构建报 `npx hugo` 失败 | `wrangler.jsonc` 被删，wrangler 自动配置 | 恢复 `wrangler.jsonc` |
| Cloudflare 报 `Missing Pages project name` | 用了 `wrangler pages deploy` | 改用 `wrangler deploy`（已配好） |
| 本地 `hugo` 命令找不到 | 未装 Hugo 或版本太旧 | 用 `build.sh` 或下载 0.163.3 extended |
| 文章点进去 404 / 连接错误 | `baseURL` 域名拼错 | 核对 `hugo.toml` 的 baseURL |
| Mermaid 图不显示 | head-end.html 被删或 CDN 被墙 | 检查 `layouts/_partials/custom/head-end.html` |
| 主题样式全丢 | 改了 themes/hextra 或 Hugo 版本 < 0.146 | 还原主题文件，升级 Hugo |
