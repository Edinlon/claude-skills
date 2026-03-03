---
name: pp
description: >
  Interactive project planning and documentation tool. Guides users through a
  step-by-step card-based Q&A flow to transform a rough project idea into a
  structured project document covering: project overview, requirements analysis,
  technical approach, and development plan. Proactively researches competitors
  and tech stacks via WebSearch during the process. Outputs both an in-chat
  summary and a saved Markdown file. Designed for AI power users who may not
  have a traditional dev background.
  Triggers: project planning, new project, project document, project setup,
  梳理项目, 项目规划, 项目文档, 新项目, 开始一个项目, 做个项目.
---

# Project Planner

Interactive Q&A flow that turns a project idea into a clear, actionable project document.

## Workflow

On trigger, immediately start the Q&A flow. Do not ask "are you ready" — just begin.

### Phase 1: Project Vision

Use AskUserQuestion to ask 2-3 questions about the project idea, problem it solves, and target users. See [references/question-flow.md](references/question-flow.md) for detailed question templates.

After this phase: use WebSearch to research competitors and similar products. Share a brief 2-3 sentence summary of findings before continuing.

### Phase 2: Requirements & Features

Ask 3-4 questions about core features, user flow, differentiation, and MVP scope. Adapt questions based on Phase 1 answers. Use multiSelect for feature selection questions.

### Phase 3: Technical Approach

Ask 2-3 questions about platform, tech stack, and infrastructure needs. Use WebSearch to compare tech stack options and present pros/cons in simple language. Avoid jargon — when technical terms are needed, add brief explanations in parentheses.

After this phase: provide a brief professional recommendation for the tech stack with reasoning.

### Phase 4: Development Plan

Ask 2-3 questions about timeline, development approach, and feature priority.

### Output

After all phases complete:

1. Generate the full project document following the template in [references/doc-template.md](references/doc-template.md)
2. Display the complete document in chat
3. Save as `PROJECT.md` in the current working directory (or `[project-name].md` if a name was established)

## Key Behaviors

- **Language**: Chinese for all questions and document output. Casual and accessible tone.
- **Adaptive**: Skip questions that are clearly not applicable. Add follow-up questions when answers reveal complexity.
- **Research**: Use WebSearch proactively at marked research points. Share findings briefly — don't overwhelm.
- **Feedback**: After each user answer, give a brief (1-2 sentence) professional comment or insight before the next question.
- **Progressive**: Each question's options should be informed by all previous answers.

## References

- [references/question-flow.md](references/question-flow.md) — Detailed question templates and flow logic for each phase
- [references/doc-template.md](references/doc-template.md) — Final document structure template
