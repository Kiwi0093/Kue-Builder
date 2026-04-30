package vendors

import "../core"

#LSIO_OptimizedForge: core.#DaggerBase & {
	kind: "lsio"
	
	// 動態指向該組織下的魔改底層
	// 例如：ghcr.io/user-a/lsio-base-hardened:latest
	// 這樣 Fork 的人只需要在自己的倉庫也建一個同名的 base 即可
	base_image: "ghcr.io/\(core.#GlobalConfig.organization)/lsio-base-hardened:latest"
	
	_internal_excludes: ["**/*.pdb", "/var/log/s6/*"]
}
