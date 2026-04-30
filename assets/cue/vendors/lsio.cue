package vendors

import (
	"../capabilities"
)

// 這裡定義一個「佔位符」，具體路徑由 entrypoint.cue 注入
#LSIO_OptimizedForge: capabilities.#HardwareForge & {
	kind: "lsio"
	
	// 這裡先定義結構，不寫死 organization，交給 entrypoint 處理
	_base_pattern: string 
	base_image:    _base_pattern
	
	_internal_excludes: ["**/*.pdb", "/var/log/s6/*"]
}
