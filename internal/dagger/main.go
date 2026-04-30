package main

import (
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"os"

	"dagger.io/dagger"
)

// 定義與 CUE 輸出的 JSON 相對應的結構
type Task struct {
    Name      string   `json:"name"`
    BaseImage string   `json:"base_image"`
    FullImage string   `json:"full_image"`
    Excludes  []string `json:"excludes"` // 確保這裡是小寫
    // ...
}

func main() {
	// 解析命令列參數取得 JSON 路徑
	configPath := flag.String("config", "pipeline.json", "Path to the pipeline JSON file")
	flag.Parse()

	ctx := context.Background()

	// 1. 讀取並解析 JSON
	data, err := os.ReadFile(*configPath)
	if err != nil {
		fmt.Printf("讀取配置失敗: %v\n", err)
		os.Exit(1)
	}

	var tasks []Task
	if err := json.Unmarshal(data, &tasks); err != nil {
		fmt.Printf("解析 JSON 失敗: %v\n", err)
		os.Exit(1)
	}

	// 2. 初始化 Dagger Client
	client, err := dagger.Connect(ctx, dagger.WithLogOutput(os.Stdout))
	if err != nil {
		fmt.Printf("Dagger 連線失敗: %v\n", err)
		os.Exit(1)
	}
	defer client.Close()

	// 3. 執行構建任務
	fmt.Println("🚀 Kue-Builder 開始執行構建任務...")
	
	for _, t := range tasks {
		fmt.Printf("📦 正在處理服務: %s (目標: %s)\n", t.Name, t.FullImage)

		// 這裡實作魔改邏輯：從你的私有 Base Image 開始
		container := client.Container().From(t.BaseImage)

		// 注入環境變數
		for k, v := range t.Env {
			container = container.WithEnvVariable(k, v)
		}

		// 這裡可以加入你的魔改步驟，例如：
		// container = container.WithExec([]string{"/bin/sh", "-c", "optimization-script.sh"})

		// 4. 推送到 Registry
		// 注意：在 GitHub Actions 中，這需要先執行 docker login
		addr, err := container.Publish(ctx, t.FullImage)
		if err != nil {
			fmt.Printf("❌ 服務 %s 推送失敗: %v\n", t.Name, err)
			continue
		}

		fmt.Printf("✅ 服務 %s 已成功推送至: %s\n", t.Name, addr)
	}
}
