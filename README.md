# 技术笔记

基于 [Hugo](https://gohugo.io/) + [Hextra](https://github.com/imfing/hextra) 主题搭建的个人技术笔记站，部署在 Cloudflare Workers。

**线上地址**：https://blog.mkka27834.workers.dev/

> 🤖 **AI 助手请先阅读 [AGENTS.md](./AGENTS.md)** —— 它包含完整的项目约定、内容管理规则和常见任务指引。

## 功能

- **知识库 + 博客双区**：`docs/` 按主题树状组织，`blog/` 按时间线排列
- 左侧自动生成主题导航树，右侧文章目录（TOC）
- FlexSearch 全文搜索
- 彩色 callout 提示框（info / warning / error / important）
- Mermaid 流程图渲染
- 明暗主题切换（跟随系统，可手动切换）
- 代码一键复制、图片点击缩放

## 快速开始

### 本地预览

需要 Hugo extended ≥ 0.146（推荐用 `build.sh` 自带的版本）：

```bash
bash build.sh          # 构建到 public/
hugo server -D         # 本地预览（-D 含草稿），访问 http://localhost:1313
```

### 写新文章

```bash
# 知识库文章（系统化笔记）
hugo new content/docs/<主题>/<文件名>.md

# 博客文章（随手记录）
hugo new content/blog/<文件名>.md
```

编辑 front matter 和正文，保存。详见 [AGENTS.md](./AGENTS.md) 的"内容管理规则"章节。

### 发布

```bash
git add .
git commit -m "新文章：标题"
git push github main    # 触发 Cloudflare 自动部署
```

## 目录结构

```
content/
├── docs/      # 知识库（按主题分类，左侧树状导航）
├── blog/      # 博客（按时间线）
layouts/       # 自定义覆盖（Mermaid 渲染钩子、head 注入）
themes/hextra/ # 主题（vendored，勿改）
hugo.toml      # 站点配置
build.sh       # 构建脚本（自动下载 Hugo）
wrangler.jsonc # Cloudflare 部署配置（勿删）
AGENTS.md      # AI 助手工作指引
```

## 部署

推送 `main` 分支到 GitHub（`MiaoDuck/Blog`）→ Cloudflare 自动构建发布。

- Build command：`bash build.sh`
- Deploy command：`npx wrangler deploy`
- 输出目录：`public`
