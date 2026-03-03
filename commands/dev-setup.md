当用户在一个项目中运行此命令时，自动为当前项目配置多实例隔离环境。

## 步骤

### 1. 读取注册表
读取 `~/.claude/dev-registry.json`，了解已注册项目和已分配的端口。

### 2. 检查当前项目
确认当前工作目录是否已在注册表中。如果已注册，显示当前配置信息并询问是否需要修改。

### 3. 如果是新项目，执行以下操作：

#### 3a. 分配端口
- 从注册表的 `nextFrontendPort` 取前端端口（默认 3500 起，每次 +100）
- 如果项目有后端服务，从 `nextBackendPort` 取后端端口（默认 8082 起，每次 +1）

#### 3b. 创建 `.mcp.json`
在项目根目录创建 `.mcp.json`，内容为：
```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest", "--user-data-dir", "/tmp/pw-<项目名>"]
    }
  }
}
```

#### 3c. 配置前端端口
查找 vite.config.ts/js（也检查 frontend/ 子目录），在 server 配置中添加：
- `port: <分配的端口>`
- `strictPort: true`

如果没有 vite 配置（可能是 Next.js、Nuxt 等），根据项目类型在 package.json 的 dev script 中添加 `--port` 参数。

#### 3d. 更新注册表
将新项目信息写入 `~/.claude/dev-registry.json`，更新 `nextFrontendPort` 和 `nextBackendPort`。

### 4. 完成后显示摘要
显示配置结果，包括分配的端口、创建的文件等。提醒用户需要重启 Claude Code 才能让 .mcp.json 生效。

## 重要提醒
- 端口间隔 100（3000, 3100, 3200...），留出空间给 HMR 等
- 所有前端都要 strictPort: true
- Playwright user-data-dir 必须每个项目不同
- 如果是 monorepo 或子目录项目，注意路径
