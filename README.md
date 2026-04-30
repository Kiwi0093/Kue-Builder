# 🥝 Kue-Builder

**Kue-Builder** (Kiwi + CUE) 是一個現代化的、硬體感知型容器構建框架。它拋棄了傳統的 Dockerfile，改用 **CUE** 進行強型別配置管理，並使用 **Dagger** 作為構建引擎。

### ✨ 核心特性

- **無 Dockerfile 設計**：全程式化構建，邏輯更透明、更易於維護。
- **微架構優化**：原生支持 `amd64-v3`、`arm64-v8a` 等細粒度硬體參數標籤。
- **LSIO 風格繼承**：自動生成符合 LinuxServer.io 規範的語義化 Tag。
- **去識別化架構**：透過 CUE 相對路徑匯入，輕鬆 Fork 並建立自有品牌。
- **環境無關性**：本地執行與 GitHub Actions 表現完全一致。

### 🚀 快速開始

1. **Fork 本倉庫**。
2. **修改配置**：編輯 `config/config.yml` 中的 `organization` 為你的 GitHub ID。
3. **準備底層**：確保你的 GHCR 中存在 `lsio-base-hardened:latest` 鏡像。
4. **推送代碼**：Push 到 `main` 分支，GitHub Actions 將自動啟動構建。

### 🛠️ 技術棧

- **配置語言**: [CUE](https://cuelang.org/)
- **構建引擎**: [Dagger](https://dagger.io/)
- **自動化**: GitHub Actions (作為執行 VM)
