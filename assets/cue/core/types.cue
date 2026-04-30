package core

#HardwareTarget: {
	arch:       "amd64" | "arm64" | "armv7"
	microarch:  string | *""
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
	_internal_excludes: [...string] | *[]
	user_excludes:      [...string] | *[]
	excludes:           _internal_excludes + user_excludes
}

#GlobalConfig: {
	organization: string // Fork 者會填寫自己的 GitHub ID
	registry:     string | *"ghcr.io"
	defaults: arch: "amd64" | "arm64" | *"amd64"
}
