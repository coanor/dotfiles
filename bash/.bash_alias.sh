##########################
# go utils
##########################

# go profile
__gtp() {
	port=":10240"
	if [ $# -gt 1 ]
	then
		port=${2}
	fi

	source ~/.golang-1.20

	go tool pprof -http=${port} ${1}
}
alias gtp='__gtp'

__gtb() {
	if [ $# -gt 1 ]
	then
		LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -test.benchmem -test.v -cpuprofile=$1.cpu.out -memprofile=$1.mem.out -benchtime=$2x -bench $1
	else
		LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -test.benchmem -test.v -cpuprofile=$1.cpu.out -memprofile=$1.mem.out  -bench $1
	fi
}

alias gtb='__gtb'

#alias gtb='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -test.benchmem -test.v -cpuprofile=cpu.out -memprofile=mem.out -bench'

alias gr='go run'
alias gv='go vet ./...'

alias gmod2vendor='GO111MODULE=on go mod vendor -v'
alias gmodinit='GO111MODULE=on go mod init'
alias gmodwhy='go mod why -m'

alias gget='GO111MODULE=on go get -v'
alias gget_noprx='GOPROXY="" GO111MODULE=on go get -v'
alias getg='GO111MODULE=off go get -v'
alias dlvT='dlv test -- -test.v'

# go build
alias gb='go build -o a.out'
alias ggb='GO111MODULE=on go build -o a.out'
alias gbwin64='GO111MODULE=on GOOS=windows GOARCH=amd64 go build'

# datakit make for testing
alias tmk='TESTING_METRIC_PATH=/tmp/testing.metrics DOCKER_REMOTE_HOST=10.200.14.142 make'

# go test ...
alias dwut='UT_EXCLUDE_INTEGRATION_TESTING=on make ut DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=tkn_2af4b19d7f5a489fa81f0fff7e63b588"'
alias ut='UT_EXCLUDE_INTEGRATION_TESTING=on make ut | tee /tmp/ut'
alias it='DOCKER_REMOTE_HOST=10.200.14.142 make ut DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=tkn_2af4b19d7f5a489fa81f0fff7e63b588"'
alias docker_gtr='CGO_CFLAGS=-Wno-undef-prefix TESTING_METRIC_PATH=/tmp/testing.metrics REMOTE_HOST=10.200.14.142 LOGGER_PATH=nul go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
alias docker_gtr='CGO_CFLAGS=-Wno-undef-prefix TESTING_METRIC_PATH=/tmp/testing.metrics REMOTE_HOST=10.200.14.142 LOGGER_PATH=nul go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
alias gtr='CGO_CFLAGS="-Wno-undef-prefix -Wno-deprecated-declarations" LOGGER_PATH=nul UT_EXCLUDE_INTEGRATION_TESTING=on CGO_CFLAGS=-Wno-undef-prefix go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
alias gtrnolog='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
alias wingtr='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix GOOS=windows go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
alias gta='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -timeout 9999900m -cover -coverprofile=/tmp/coverage.out ./...'
alias gtf='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -test.v -run=XXX -cover -fuzztime 1m -fuzz'

__gtra() {
	LOGGER_PATH=nul \
		UT_EXCLUDE_INTEGRATION_TESTING=on \
		CGO_CFLAGS=-Wno-undef-prefix \
		go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run . | tee gtra.out # output to local gtra.out
}


alias gtra='__gtra'

alias gtrall='CGO_CFLAGS=-Wno-undef-prefix go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run .'
alias gtrb='CGO_CFLAGS=-Wno-undef-prefix go test -test.v -timeout 9999900m -run -bench'
alias gtrll='CGO_CFLAGS=-Wno-undef-prefix go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'

# bench with time 10s
alias gtbt='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -test.benchmem -benchtime=10s -test.v -bench'
# bench with count 1000
alias gtbx='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -test.benchmem -benchtime=1000x -test.v -bench'

alias gtcover='CGO_CFLAGS=-Wno-undef-prefix go test -cover'
alias gtcovershow='CGO_CFLAGS=-Wno-undef-prefix go test -v -timeout 9999900m -cover . -coverprofile=/tmp/coverage.out ; go tool cover -html=/tmp/coverage.out'
alias covershow='go tool cover -html=/tmp/coverage.out'
alias ggtr='CGO_CFLAGS=-Wno-undef-prefix GO111MODULE=off go test -test.v -timeout 9999900m -run'
alias wgtr='CGO_CFLAGS=-Wno-undef-prefix GOOS=windows GOARCH=amd64 go test -test.v -timeout 9999900m -run'

alias gtc='CGO_CFLAGS=-Wno-undef-prefix go test -c'
alias gtc_win64='CGO_CFLAGS=-Wno-undef-prefix GOOS=windows GOARCH=amd64 go test -c'
alias gtc_win32='CGO_CFLAGS=-Wno-undef-prefix GOOS=windows GOARCH=386 go test -c'
alias gtc_linux64='CGO_CFLAGS=-Wno-undef-prefix GOOS=linux GOARCH=amd64 go test -c'
alias gtc_linux32='CGO_CFLAGS=-Wno-undef-prefix GOOS=linux GOARCH=386 go test -c'

alias gbwin64t='CGO_CFLAGS=-Wno-undef-prefix GO111MODULE=on GOOS=windows GOARCH=amd64 go test -c'
alias gtbcpu='CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -cpuprofile=cpu.out -bench'
alias gtbmem='CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -memprofile=mem.out -bench'

# git related
alias githist='git log --follow -p --stat --'
alias git-cmt-cnt='git rev-list HEAD --count'
alias gitbr='git branch --sort=-committerdate'
alias gpo='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias fgpo='git push -f origin $(git rev-parse --abbrev-ref HEAD)'
alias gbo='git pull origin $(git rev-parse --abbrev-ref HEAD)'

alias v='vim'
alias vv='sudo vim'
alias vx='vim /tmp/x'
alias vy='vim /tmp/y'
alias vz='vim /tmp/z'
alias ll='ls -alth'
alias lsdata='ls -alth'
alias lsm='stat -c "%a %n"'
alias mk='make'
alias tf='tail -f'
alias p='python3'
alias pt='python3 test.py --case'
alias cs='clear'
alias s='sudo'
alias psg='ps -ef | grep'
alias agw='ag -w'
alias ccat='pygmentize -g -O style=colorful,linenos=1'
alias w3='watch -n 3'

# golang project grep to ignore vendor dirs
alias gag='ag -w --ignore-dir={vendor,}'

alias dkr='sudo docker'
alias dkrps='docker ps -a --format "{{.Names}},{{.Image}},{{.Status}}" | column -s, -t | sort'
alias dkr-search='sudo docker search --no-trunc'
#alias dkr-stats='dkr stats $(dkr ps --format={{.Names}})'
alias dkr-stats='dkr stats --format="table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.MemPerc}}"'
alias dkr-log='dkr logs --tail 32'
alias dkr-cp='dkr cp'
alias dkr-tf='sudo docker logs -f --tail 32'
alias dkrc='sudo docker-compose'

alias agi='sudo apt-get install --yes'

alias cdcoanor='cd ~/go/src/github.com/coanor/'
alias cdcsos='cd ~/git/csos'
alias cddocs='cd ~/git/dataflux-doc'
alias cdtem='cd ~/git/dataflux-template'
alias ccc='cd ~/go/src/gitlab.jiagouyun.com/cloudcare-tools'
alias ccliutils='cd ~/go/src/github.com/GuanceCloud/cliutils'
alias cdkodo='cd ~/go/src/gitlab.jiagouyun.com/cloudcare-tools/kodo/'
alias cditos='cd ~/go/src/gitlab.jiagouyun.com/cloudcare-tools/itos/'
alias cdfrog='cd ~/go/src/gitlab.jiagouyun.com/cloudcare-tools/frog/'
alias cdftagent='cd ~/go/src/gitlab.jiagouyun.com/cloudcare-tools/ftagent/'
alias cdinflux='cd ~/go/src/github.com/influxdata/'
alias cdifcli='cd ~/go/src/github.com/coanor/ifcli'
alias cdf='cd /usr/local/cloudcare/DataFlux'
alias cdk='cd ~/go/src/gitlab.jiagouyun.com/cloudcare-tools/datakit/'
alias cdw='cd ~/go/src/gitlab.jiagouyun.com/cloudcare-tools/dataway/'
alias cdemo='cd ~/go/src/demo'
alias cdguance='cd ~/go/src/gitlab.jiagouyun.com/guance'
alias ..='cd ../'
alias zh_idoc='vim internal/man/doc/zh/inputs'
alias en_idoc='vim internal/man/doc/en/inputs'

alias zh_idashboard='vim internal/man/dashboard/zh/'
alias en_idashboard='vim internal/man/dashboard/en/'

alias zh_imonitor='vim internal/man/monitor/zh/'
alias en_imonitor='vim internal/man/monitor/en/'

alias venv='python3.6 -m venv'
alias lua='lua5.1'
alias rb='rustc'

alias hdate='date +%Y-%m-%d_%H-%M-%S'
alias tagdate='date +%Y%m%d_%H.%M.%S'

#alias rm='trash'
#alias rmlist='trash-list'
#alias mr='restore-trash'
alias tree='tree -tCh'
alias rmrf='rm -rf'

alias slog='journalctl -u'
alias md='glow -p'
#alias slog='journalctl -n 100 --no-pager'
alias sudo_user='sudo usermod -aG sudo'

alias lsoftop='sudo lsof -n | cut -f1 -d" " | uniq -c | sort | tail'

alias server_mode='sudo nvram boot-args="serverperfmode=1 $(nvram boot-args 2>/dev/null | cut -f 2-)"'
# turn back to normal mode:
# 	sudo nvram boot-args="$(nvram boot-args 2>/dev/null | sed -e $'s/boot-args\t//;s/serverperfmode=1//')"

alias cls='clear'

alias dklog="sudo tail -f /var/log/datakit/log"
alias vdklog="sudo vim /var/log/datakit/log"
alias dkcnf="sudo vim /usr/local/datakit/conf.d/datakit.conf"
alias dkglog="sudo tail -f /var/log/datakit/gin.log"
alias dk="sudo datakit"

alias ta='tmux att'

#
# Debugging datakit
#
__ddk() {
	DK_DEBUG_WORKDIR=~/datakit \
		DK_DEBUG_MAX_RUN_DURATION=24h \
		./dist/datakit-darwin-arm64/datakit 2>&1 | tee ~/datakit/stdout-stderr
}

alias ddk_http_fail="ENV_DEBUG_HTTP_FAIL_RATIO=70 ENV_DEBUG_HTTP_FAIL_DURATION=2h __ddk"
alias ddk_with_expire="__ddk"
alias ddk_with_expire_no_ptpool="DK_DEBUG_NO_POINT_POOL=1 __ddk"
alias ddk_with_expire_no_ptpool_with_gc="DK_DEBUG_GC_DURATION=10s DK_DEBUG_MAX_RUN_DURATION=3m __ddk"

alias ddk="__ddk"
alias pbddk="ENV_POINT_PROTOBUF=1 __ddk"
alias dk_dbginput="DK_DEBUG_WORKDIR=~/datakit __ddk_flag_debug ./dist/datakit-darwin-arm64/datakit debug --input-conf"

alias ddql="DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-darwin-arm64/datakit dql"
alias dk="DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-darwin-arm64/datakit"
alias dkm="DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-darwin-arm64/datakit monitor -R3s --log ~/datakit/cmds.log --dump-metrics"
alias dkmv="DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-darwin-arm64/datakit monitor -V -R3s --log ~/datakit/cmds.log --dump-metrics"
alias dkmm="DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-darwin-arm64/datakit monitor -R3s --log ~/datakit/cmds.log --dump-metrics -M "
alias dkpm="curl -s http://localhost:19529/metrics | grep"
alias ddw="DW_DEBUG_WORKDIR=~/dataway ./build/dataway-darwin-arm64/dataway -cfg ~/dataway/dw.yaml"
alias ddw_docker="DW_DEBUG_WORKDIR=~/dataway DW_HTTP_CLIENT_TRACE=on DW_BIND=0.0.0.0:9528 DW_PROM_LISTEN=0.0.0.0:9091 DW_LOG_LEVEL=debug DW_REMOTE_HOST=https://kodo.guance.com:443 DW_UUID=not-set DW_TOKEN=tkn_2af4b19d7f5a489fa81f0fff7e63b588 DW_DEBUG_WORKDIR=~/dataway ./build/dataway-darwin-arm64/dataway --docker"

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

alias pj='python -m json.tool'
alias rmf='rm -rf'

__watch_dk_metrics() {
	sleep=3
	if [ $# -gt 1 ]
	then
		sleep=${2}
	fi

	host="localhost:19529"
	if [ $# -gt 2 ]
	then
		host=$3
	fi

	watch -n ${sleep} "curl -s http://${host}/metrics | grep -a ${1}"
}

alias wdk='__watch_dk_metrics'

alias mkdocs='/System/Volumes/Data/Users/tanbiao/Library/Python/3.8/bin/mkdocs'
alias nproc="sysctl -n hw.logicalcpu"

alias until='while $@; do :; done'

alias mdlint='markdown-link-check -p'

# ssh nodes: 123.com
alias ssh721='ssh tan@10.200.7.21'
alias sshvm='ssh root@10.200.14.131'
alias aliecs='ssh root@47.98.119.69'
alias ssh141='ssh root@10.200.14.141'
alias ssh142='ssh root@10.200.14.142'
alias ssh143='ssh root@10.200.14.143'

# file server via python3
alias fs='python3 -mhttp.server 8888'
alias entrans='trans -e bing -no-autocorrect :en'

# k8s
alias kc='kubectl'

alias ds_dk_restart='kubectl rollout restart daemonset datakit -n datakit'
alias dkpods='kubectl get pod -n datakit'

__poddk() {
	kubectl exec --stdin --tty $1 -n datakit -- /bin/bash
}

alias poddk='__poddk'

alias ctags="`brew --prefix`/bin/ctags"
