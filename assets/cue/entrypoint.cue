package main

import (
	"strings"
	"./core"
	"./vendors"
)

config:   core.#GlobalConfig
services: [Name=string]: #ServiceTask

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
			// 注入全域預設架構
			hw: arch: *config.defaults.arch | _
			
			// --- 關鍵注入：如果是 lsio，就把 organization 塞進去 ---
			if spec.kind == "lsio" {
				_base_pattern: "ghcr.io/\(config.organization)/lsio-base-hardened:latest"
			}
			
			_gen: #TagGenerator & {_spec: spec}
			computed_tag: _gen.out
			full_image:   "\(config.registry)/\(config.organization)/\(name):\(computed_tag)"
		}
	}
]
