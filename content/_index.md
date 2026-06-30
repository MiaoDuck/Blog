+++
title = '技术笔记'
description = '记录与分享后端、架构与基础设施的学习笔记'
+++

<div class="series-grid">

<div class="series-card" onclick="window.location.href='/docs/network/'">
  <div class="series-icon">🌐</div>
  <div class="series-content">
    <h3 class="series-title">网络</h3>
    <p class="series-desc">涵盖 HTTP、HTTPS、TCP、UDP、IP 等协议，以及 CDN、DNS 等基础设施知识</p>
    <span class="series-count">已收录文章</span>
  </div>
</div>

<!-- {{/* 未来新增栏目时，在此处添加卡片，格式如下：
<div class="series-card" onclick="window.location.href='/docs/<栏目>/'">
  <div class="series-icon">图标</div>
  <div class="series-content">
    <h3 class="series-title">标题</h3>
    <p class="series-desc">描述文字</p>
    <span class="series-count">已收录 N 篇</span>
  </div>
</div>
*/}} -->

</div>

<style>
.series-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
}

.series-card {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.25rem 1.5rem;
  border-radius: 12px;
  border: 1px solid var(--tw-prose-body, #374151);
  background: var(--tw-prose-bg, #fff);
  cursor: pointer;
  transition: all 0.2s ease;
}

@media (prefers-color-scheme: dark) {
  .series-card {
    border-color: var(--tw-prose-body, #6b7280);
    background: var(--tw-prose-bg, #1f2937);
  }
}

.series-card:hover {
  border-color: #3b82f6;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
  transform: translateY(-2px);
}

.series-icon {
  font-size: 2rem;
  line-height: 1;
  flex-shrink: 0;
}

.series-content {
  flex: 1;
  min-width: 0;
}

.series-title {
  margin: 0 0 0.4rem;
  font-size: 1.15rem;
  font-weight: 600;
  color: inherit;
}

.series-desc {
  margin: 0 0 0.5rem;
  font-size: 0.9rem;
  color: var(--tw-prose-body, #6b7280);
  line-height: 1.5;
}

.series-count {
  font-size: 0.8rem;
  color: #3b82f6;
}
</style>
