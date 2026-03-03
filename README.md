# Claude Code Skills Collection

团队共享的 Claude Code Skills 合集。

## Skills 一览

| Skill | 说明 | 类型 |
|-------|------|------|
| **frontend-design** | 高品质前端界面设计，避免 AI 通用风格 | Skill |
| **pp** | 交互式项目规划工具，通过 Q&A 生成项目文档 | Skill |
| **skill-creator** | Skill 创建指南与工具 | Skill |
| **xiaohongshu-benchmark** | 小红书对标笔记/账号分析 | Skill |
| **ui-ux-pro-max** | UI/UX 设计知识库（50+ 风格、97 色板、57 字体搭配等） | Skill |
| **dev-setup** | 多实例隔离环境配置（端口分配、Playwright 隔离） | Command |

## 安装方法

### 方式一：一键安装（推荐）

```bash
# 克隆仓库
git clone git@github.com:Edinlon/claude-skills.git /tmp/claude-skills-install

# 运行安装脚本
bash /tmp/claude-skills-install/install.sh

# 清理
rm -rf /tmp/claude-skills-install
```

### 方式二：手动安装

```bash
# 克隆仓库
git clone git@github.com:Edinlon/claude-skills.git /tmp/claude-skills-install

# 复制 skills 到 Claude Code 目录
cp -r /tmp/claude-skills-install/skills/* ~/.claude/skills/

# 复制 commands（可选）
cp -r /tmp/claude-skills-install/commands/* ~/.claude/commands/

# 清理
rm -rf /tmp/claude-skills-install
```

### 安装单个 Skill

如果只需要某个 skill：

```bash
git clone git@github.com:Edinlon/claude-skills.git /tmp/claude-skills-install

# 例如只安装 pp
cp -r /tmp/claude-skills-install/skills/pp ~/.claude/skills/

rm -rf /tmp/claude-skills-install
```

## 安装后

重启 Claude Code 即可使用。在对话中可以通过 `/skill-name` 触发。

## 更新

```bash
git clone git@github.com:Edinlon/claude-skills.git /tmp/claude-skills-install
bash /tmp/claude-skills-install/install.sh
rm -rf /tmp/claude-skills-install
```
