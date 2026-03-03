#!/bin/bash
# Claude Code Skills 安装脚本

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Code Skills 安装 ==="
echo ""

# 确保目标目录存在
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/commands"

# 安装 skills
echo "安装 skills..."
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    echo "  - $skill_name"
    cp -r "$skill_dir" "$CLAUDE_DIR/skills/$skill_name"
done

# 安装 .skill 打包文件
for skill_file in "$SCRIPT_DIR/skills"/*.skill; do
    [ -f "$skill_file" ] || continue
    skill_name=$(basename "$skill_file")
    echo "  - $skill_name (packaged)"
    cp "$skill_file" "$CLAUDE_DIR/skills/$skill_name"
done

# 安装 commands
if [ -d "$SCRIPT_DIR/commands" ]; then
    echo "安装 commands..."
    for cmd_file in "$SCRIPT_DIR/commands"/*; do
        [ -f "$cmd_file" ] || continue
        cmd_name=$(basename "$cmd_file")
        echo "  - $cmd_name"
        cp "$cmd_file" "$CLAUDE_DIR/commands/$cmd_name"
    done
fi

echo ""
echo "安装完成! 请重启 Claude Code 使 skills 生效。"
