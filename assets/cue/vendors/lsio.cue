package vendors

import (
	"../core"
	"../capabilities"
)

// 這裡就是你說的：寫死在 CUE 內，不可自訂的魔改底層
_lsio_refactored_base: "ghcr.io/\(core.#GlobalConfig.organization)/lsio-base-hardened:latest"

#LSIO_OptimizedForge: capabilities.#HardwareForge & {
	kind: "lsio"
	
	// 強制抽換底層：不管用戶在 YAML 寫什麼，這裡都會鎖定你的魔改版
	base_image: _lsio_refactored_base
	
	_internal_excludes: ["**/*.pdb", "/var/log/s6/*"]
}
