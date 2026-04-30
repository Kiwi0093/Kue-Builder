package capabilities

import "../core"

#HardwareForge: core.#DaggerBase & {
	// 這裡定義編譯時需要的環境變數，例如 CFLAGS="-march=v3"
	build_env: [string]: string
	
	// 預設編譯邏輯：將微架構參數轉化為編譯器的 flag
	if hw.microarch != "" {
		build_env: "OPTIMIZE_FLAGS": "-march=\(hw.microarch)"
	}
}
