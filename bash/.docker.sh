__ddk_docker() {
	ENV_RECORDER_ENCODING=v1             \
		ENV_ENABLE_RECORDER=on             \
		ENV_RECORDER_CATEGORIES=metric     \
		ENV_DEFAULT_ENABLED_INPUTS=dk      \
		ENV_PPROF_LISTEN=localhost:26060   \
		ENV_HTTP_LISTEN=localhost:29529    \
		ENV_INPUT_DK_ENABLE_ALL_METRICS=on \
		DK_DEBUG_WORKDIR=~/datakit-docker  \
		./dist/datakit-darwin-arm64/datakit run -C
}

__dkm_docker() {
	DK_DEBUG_WORKDIR=~/datakit-docker \
		./dist/datakit-darwin-arm64/datakit monitor -R3s --log ~/datakit-docker/cmds.log
}

alias ddk_docker="__ddk_docker"
alias dkm_docker="__dkm_docker"

alias dkr='sudo docker'
alias dkrps='docker ps -a --format "{{.Names}},{{.Image}},{{.Status}}" | column -s, -t | sort'
alias dkr-search='sudo docker search --no-trunc'

alias dkr-tf='sudo docker logs -f --tail 32'
alias dkrc='sudo docker-compose'

#alias dkr-stats='dkr stats $(dkr ps --format={{.Names}})'
alias dkr-stats='dkr stats --format="table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.MemPerc}}"'
alias dkr-log='dkr logs --tail 32'
alias dkr-cp='dkr cp'

