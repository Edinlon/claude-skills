---
name: xiaohongshu-benchmark
description: 小红书对标笔记/账号分析工具。当用户输入客户需求或产品信息，自动使用 MCP 浏览器工具搜索小红书网页端，抓取高热度笔记数据（点赞/收藏/评论），分析视觉风格和文笔规律，整理成结构化报告供 AI 内容生成使用。触发词：对标笔记、找参考、小红书分析、竞品笔记、爆款参考、benchmark、找对标。
---

# 小红书对标笔记分析

## 工作流程

### Step 1：解读需求 → 生成搜索词

从用户输入中提取：
- **产品/服务**：卖什么
- **目标人群**：谁会买（年龄、身份、痛点）
- **使用场景**：什么时候/什么情况下需要

基于目标人群视角，模拟他们在小红书的搜索行为，生成 **3 个搜索词**（控制在3个以内以节省资源）：
- 1 个：问题型（"怎么解决xxx"、"xxx怎么办"）
- 1 个：产品/功效型（"xxx推荐"、"xxx测评"）
- 1 个：场景/人群型（"学生党xxx"、"上班族xxx"）

先告知用户生成的搜索词，再开始浏览。

---

### Step 2：浏览器搜索抓取（低消耗模式）

> ⚠️ **反爬规则（必须遵守）**
> - 每次导航后等待 **1.5-2 秒**再操作（模拟人工浏览节奏）
> - 每次滚动后等待 **1-1.5 秒**
> - 不访问用户主页，只访问搜索结果页和笔记详情页
> - 若出现验证码/滑块，立即截图告知用户手动处理，不尝试自动绕过
> - 单次任务最多访问 **3 个搜索词 + 3 篇详情页**，不过度抓取

对每个搜索词执行以下操作：

#### 2.1 导航并确认页面
```
导航至：https://www.xiaohongshu.com/search_result?keyword=【搜索词】&source=web_search_result_notes&type=51
等待 1.5 秒
截图一次（仅用于确认页面正常加载，不用于数据提取）
```

#### 2.2 用 JS 提取笔记数据（替代 snapshot）

**不使用 `browser_snapshot`**，改用 `browser_evaluate` 直接提取结构化数据，大幅减少 token 消耗：

```javascript
// 在页面内运行，提取当前可见笔记列表
async (page) => {
  return await page.evaluate(() => {
    const items = document.querySelectorAll('section.note-item, [class*="note-item"]');
    return Array.from(items).map(el => ({
      title: el.querySelector('[class*="title"]')?.innerText?.trim() || '',
      likes: el.querySelector('[class*="like-wrapper"] [class*="count"], [class*="interactions"] span')?.innerText?.trim() || '',
      link: el.querySelector('a')?.href || '',
      author: el.querySelector('[class*="author"] [class*="name"], [class*="nickname"]')?.innerText?.trim() || ''
    })).filter(item => item.title && item.link);
  });
}
```

> 若 evaluate 返回空数组，说明选择器可能已变更，此时改用截图 + 视觉读取作为降级方案。

#### 2.3 滚动加载更多

```
滚动一次（约 800px）
等待 1-1.5 秒
再次执行 evaluate 提取数据（与上次去重后合并）
重复 1-2 次，收集 15-20 条笔记即可停止
```

**每个搜索词只截图 1 次**（Step 2.1 确认用），后续操作全用 evaluate。

---

### Step 3：筛选热度 Top 笔记

**热度分计算**（用于排序）：
```
热度分 = 点赞数 + 收藏数 × 1.5 + 评论数 × 2
```

搜索结果页通常只显示点赞数，此时热度分 = 点赞数，用于初步排序。

**参考阈值**（普通垂类）：
| 等级 | 点赞 | 判断 |
|------|------|------|
| 爆款 | > 5000 | 重点分析 |
| 优质 | 1000-5000 | 纳入参考 |
| 普通 | < 1000 | 排除 |

从所有搜索词结果中，选出热度最高的 **Top 5-8 篇**进入数据总表，其中选 **Top 2-3 篇**进行详情页深度分析。

---

### Step 4：深度分析 Top 笔记（仅 Top 2-3 篇）

> 只对热度最高的 2-3 篇进入详情页，其余笔记仅凭搜索页可见信息分析。

对每篇详情页执行：

#### 4.1 获取完整数据（用 evaluate，不用 snapshot）

```javascript
async (page) => {
  return await page.evaluate(() => {
    return {
      title: document.querySelector('#detail-title, [class*="title"]')?.innerText?.trim(),
      content: document.querySelector('#detail-desc, [class*="desc"]')?.innerText?.trim()?.slice(0, 500),
      likes: document.querySelector('[class*="like-wrapper"] [class*="count"]')?.innerText?.trim(),
      collects: document.querySelector('[class*="collect-wrapper"] [class*="count"]')?.innerText?.trim(),
      comments: document.querySelector('[class*="chat-wrapper"] [class*="count"]')?.innerText?.trim(),
      tags: Array.from(document.querySelectorAll('[class*="tag"]')).map(t => t.innerText?.trim()).filter(Boolean)
    };
  });
}
```

#### 4.2 封面视觉分析（仅此处截图）

截图一次，用于分析封面图的视觉风格：
- 主体类型：人物出镜 / 产品特写 / 场景图 / 文字卡片 / 混合
- 色调风格：暖色系 / 冷色系 / 高饱和 / 低饱和 / ins风 / 国风等
- 文字占比：无文字 / 少量标注 / 大标题文字
- 视觉第一印象（一句话）

#### 4.3 正文文笔分析（基于 evaluate 返回的 content）

- 开头钩子（前两行）：如何抓住眼球
- 内容结构：列表型 / 故事型 / 问答型 / 教程步骤型
- 语气风格：闺蜜分享 / 专家种草 / 素人真实 / 幽默吐槽
- 情感共鸣点：戳到什么痛点或欲望
- 结尾 CTA：有无引导评论/关注/购买

---

### Step 5：输出结构化报告

详见 `references/output-template.md` 的格式。

报告分三部分：
1. **数据总表**：所有收集笔记的排序数据
2. **Top 笔记深度解析**：2-3 篇详细分析 + 其余笔记简析
3. **AI 创作 Brief**：标题公式、视觉规律、文笔风格，直接用于指导 AI 产出

---

## Token 消耗控制原则

| 操作 | 原则 |
|------|------|
| `browser_snapshot` | **禁止使用**，改用 `browser_evaluate` |
| 截图 | 每个搜索词仅 1 次（确认加载）；详情页仅 1 次（封面分析） |
| 搜索词数量 | 最多 3 个 |
| 详情页访问 | 最多 3 篇 |
| evaluate 返回内容 | content 字段截取前 500 字即可，不需要全文 |
| 报告输出 | 按模板输出，不额外展开 |

---

## 安全与反爬注意事项

- 浏览器必须已登录小红书账号，未登录会触发验证
- 每次操作之间保持 1-2 秒延迟，模拟人工节奏
- 不批量访问用户主页（只访问搜索页 + 笔记详情页）
- 出现验证码/滑块：截图提示用户手动处理，不自动绕过
- evaluate 选择器失效时，降级为截图 + 视觉读取，不强行 snapshot
- 在报告中注明搜索时间（同一词不同时间结果可能不同）
