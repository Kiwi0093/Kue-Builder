package main

import (
	"strings"
	"./core"
	"./vendors"
)

config:   core.#GlobalConfig
services: [Name=string]: #ServiceTask

// 這裡會根據 kind 自動選擇要不要抽換底層
#ServiceTask: vendors.#LSIO_OptimizedForge | core.#DaggerBase

#TagGenerator: {
	_spec: #ServiceTask
	_parts: [_spec.hw.arch, _spec.hw.microarch, _spec.ver.upstream, "ls\(_spec.ver.lsio_build)"]
	out: strings.Join([for p in _parts if p != "" {p}], "-")
}

pipeline_tasks: [
	for name, spec in services {
		spec & {
			"name": name
			hw: arch: *config.defaults.arch | _
			
			_gen: #TagGenerator & {_spec: spec}
			computed_tag: _gen.out
			full_image:   "\(config.registry)/\(config.organization)/\(name):\(computed_tag)"
		}
	}
]
