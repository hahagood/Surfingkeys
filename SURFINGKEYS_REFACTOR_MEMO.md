# Surfingkeys 插件重构与修正备忘录

## 1. 分支与同步
- 切换到 master 分支，并同步远程仓库，确保本地代码为最新。
- 清理了本地和远程的 my-changes 分支，以及未跟踪的 clipboard.js 文件，保证仓库干净。
- 新建 my-changes 分支，作为本次重构和修正的开发分支。

## 2. manifest.json 相关修正
- 发现 src/manifest.json 缺少 version 字段，导致 Chrome 无法加载扩展。已补充 "version": "1.0.0" 字段。
- 发现 content_scripts 和 background 路径配置与实际目录结构不符，导致 Chrome 无法加载相关脚本。已将路径修正为实际打包产物的位置。
- 发现 manifest.json 版本为 v2，而 Chrome 推荐使用 v3。已将 manifest.json 升级为 manifest_version 3，并同步 dist/production/chrome/manifest.json 的内容到 src/manifest.json，确保开发和构建一致。

## 3. 构建与产物管理
- 通过 npm install 安装依赖，npm run build:prod 进行生产环境打包。
- 发现构建产物默认输出到 dist/production/chrome 目录，而不是 src 目录。
- 明确了开发应只在 src 目录下进行，dist 目录仅作为构建产物，不能直接修改。
- 遇到 content.js、background.js 等文件缺失或路径不符问题，已通过修正 manifest.json 和构建流程解决。

## 4. 手动操作与自动化
- 避免手动复制源码到 dist 目录，所有产物应由 webpack 自动生成。
- 如需调整 manifest.json 或其他配置，均在 src 目录下完成，构建后自动反映到 dist。

## 5. 插件调试与排错
- 通过 Chrome 扩展管理页面和网页控制台，排查了插件无法运行的原因（如 import/export 报错、脚本路径不符等）。
- 明确了调试流程：只加载 dist/production/chrome 目录，遇到问题优先检查 manifest.json 路径和构建产物内容。

## 6. 最终结果
- 现在插件已能在 Chrome 中成功安装、加载并正常运行。
- 所有源码和配置均已规范化，后续开发、重构和维护更加方便。

---

## 未来建议

- 所有开发和配置调整都在 src 目录下进行，避免直接修改 dist 产物。
- 每次大改动后，建议删除 dist 目录，重新构建并测试，确保所有变更都已生效。
- 保持 manifest.json 与 Chrome 最新规范同步，关注 Chrome 扩展开发相关变更。

---

如需进一步自动化构建、测试、CI/CD 或功能开发建议，欢迎随时咨询！ 