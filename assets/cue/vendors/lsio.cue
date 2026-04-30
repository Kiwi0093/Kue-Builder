package vendors

import (
	"../capabilities"
)

// 這裡定義結構，base_image 先留空，由 entrypoint 注入
#LSIO_OptimizedForge: capabilities.#HardwareForge & {
	kind: "lsio"
	
	// 這裡定義一個內部變數，用來接收 entrypoint 傳進來的組織名稱
	_org: string 
	base_image: "ghcr.io/\(_org)/lsio-base-hardened:latest"
	
	_internal_excludes: ["**/*.pdb", "/var/log/s6/*"]
}
