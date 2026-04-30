package core

#HardwareTarget: {
	arch:       "amd64" | "arm64" | "armv7"
	microarch:  string | *"" // 這裡的 v3, v4 會被 Dagger 讀取並轉為編譯參數
}

#VersionInfo: {
	upstream:   string
	lsio_build: int | *1
}

#DaggerBase: {
	kind:       string
	base_image: string
	hw:         #HardwareTarget
	ver:        #VersionInfo
	
	// 編譯指令：Dagger 會在 Builder 容器內執行這些
	build_cmd: [...string] | *[] 
	
	// 排除清單
	_internal_excludes: [...string] | *[]
	user_excludes:      [...string] | *[]
	excludes:           _internal_excludes + user_excludes
}

#GlobalConfig: {
	organization: string
	registry:     string | *"ghcr.io"
	defaults: arch: "amd64" | "arm64" | *"amd64"
}
