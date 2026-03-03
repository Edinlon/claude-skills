# Question Flow Reference

Each phase uses AskUserQuestion with card-style options. After each answer, provide brief professional feedback before moving to the next question. Use WebSearch when AI research would add value.

---

## Phase 1: Project Vision (2-3 questions)

### Q1.1 - Project Idea
"你想做一个什么项目？用一两句话描述你的想法。"
- Free text input (use AskUserQuestion with broad options as starting points)
- Options can include common project types: "Web 应用", "移动端 App", "工具/插件", "自动化流程"

### Q1.2 - Core Problem
"这个项目主要解决什么问题？或者满足什么需求？"
- Based on Q1.1 answer, generate 2-3 specific problem hypotheses as options
- Always allow free text

### Q1.3 - Target Users
"谁会用这个产品？"
- Generate user persona options based on previous answers
- Examples: "个人用户/C端", "企业/团队/B端", "开发者", "特定行业从业者"

**AI Research Point**: After Phase 1, use WebSearch to find similar products/competitors. Briefly share findings before Phase 2.

---

## Phase 2: Requirements & Features (3-4 questions)

### Q2.1 - Core Features
"你觉得这个产品最核心的 1-3 个功能是什么？"
- Based on project idea, suggest 3-4 likely core features as multiSelect options
- multiSelect: true

### Q2.2 - User Flow
"用户打开你的产品后，最主要的使用流程是怎样的？"
- Provide 2-3 user flow scenarios based on core features
- Each option should be a complete mini-scenario

### Q2.3 - Differentiation
"和市面上类似的产品相比，你的核心差异点是什么？"
- Based on AI research from Phase 1, suggest differentiation angles
- Options: "体验更简单", "功能更专注", "价格优势", "AI 加持"

### Q2.4 - MVP Scope (Optional)
"第一个版本（MVP）你想包含哪些功能？"
- From Q2.1 features, let user prioritize
- multiSelect: true

---

## Phase 3: Technical Approach (2-3 questions)

### Q3.1 - Platform
"产品的形态是什么？"
- Options based on project type: "网页应用", "桌面软件", "手机 App", "浏览器插件", "命令行工具", "API 服务"

### Q3.2 - Tech Stack
"技术栈有偏好吗？"
- Based on platform choice, suggest 2-3 appropriate stack combinations
- Use simple, non-jargon descriptions
- Example for web: "React + Next.js（主流稳定）", "Vue + Nuxt（上手简单）", "纯 HTML/JS（最轻量）"

**AI Research Point**: Use WebSearch to compare recommended tech stacks. Share a brief comparison with pros/cons in accessible language.

### Q3.3 - Data & AI
"项目需要用到数据库或 AI 能力吗？"
- Options: "需要存数据（用户信息/内容等）", "需要 AI 功能（生成/分析/识别等）", "都需要", "都不需要"
- If AI needed, follow up with specific AI capability questions

### Q3.4 - Deployment
"产品打算怎么部署/上线？"
- Options: "Vercel/Netlify（前端为主）", "云服务器", "本地运行就行", "还没想好，你建议"

---

## Phase 4: Development Plan (2-3 questions)

### Q4.1 - Timeline
"你期望的开发周期是？"
- Options: "一周内快速出原型", "2-4 周做出 MVP", "1-3 个月完整开发", "没有明确时间线"

### Q4.2 - Development Approach
"你打算怎么开发？"
- Options: "主要靠 AI 辅助我写代码", "我写需求 AI 写代码", "找开发者合作", "外包"

### Q4.3 - Priority Order
"功能开发的优先级？"
- List features from Q2.1/Q2.4, let user drag/rank or select order
- multiSelect: true, present as ordered list

---

## Between-Phase Behaviors

- **Summarize**: After each phase, output a brief summary of what was captured
- **Research**: At marked "AI Research Point" locations, use WebSearch proactively
- **Adapt**: If user answers reveal the project is simpler/more complex than expected, adjust subsequent questions accordingly
- **Skip**: If a question is clearly not applicable based on prior answers, skip it
- **Language**: Use casual, accessible Chinese. Avoid jargon; when technical terms are necessary, add brief explanations in parentheses
