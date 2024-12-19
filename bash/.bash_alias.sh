source ~/.go.sh
source ~/.dk.sh
source ~/.docker.sh

# datakit make for testing
alias tmk='TESTING_METRIC_PATH=/tmp/testing.metrics DOCKER_REMOTE_HOST=10.200.14.142 make'

# go test ...
alias dwut='UT_EXCLUDE_INTEGRATION_TESTING=on make ut DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=tkn_2af4b19d7f5a489fa81f0fff7e63b588"'
alias ut='UT_EXCLUDE_INTEGRATION_TESTING=on make ut | tee /tmp/ut'
alias it='DOCKER_REMOTE_HOST=10.200.14.142 make ut DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=tkn_2af4b19d7f5a489fa81f0fff7e63b588"'
alias docker_gtr='CGO_CFLAGS=-Wno-undef-prefix TESTING_METRIC_PATH=/tmp/testing.metrics REMOTE_HOST=10.200.14.142 LOGGER_PATH=nul go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
alias docker_gtr='CGO_CFLAGS=-Wno-undef-prefix TESTING_METRIC_PATH=/tmp/testing.metrics REMOTE_HOST=10.200.14.142 LOGGER_PATH=nul go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
#alias wingtr='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix GOOS=windows go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'
#alias gta='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -timeout 9999900m -cover -coverprofile=/tmp/coverage.out ./...'
#alias gtf='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -test.v -run=XXX -cover -fuzztime 1m -fuzz'
#
#alias gtrb='CGO_CFLAGS=-Wno-undef-prefix go test -test.v -timeout 9999900m -run -bench'
#alias gtrll='CGO_CFLAGS=-Wno-undef-prefix go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run'

# bench with time 10s
alias gtbt='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -test.benchmem -benchtime=10s -test.v -bench'
# bench with count 1000
alias gtbx='LOGGER_PATH=nul CGO_CFLAGS=-Wno-undef-prefix go test -run XXX -test.benchmem -benchtime=1000x -test.v -bench'

#alias gtcover='CGO_CFLAGS=-Wno-undef-prefix go test -cover'
#alias gtcovershow='CGO_CFLAGS=-Wno-undef-prefix go test -v -timeout 9999900m -cover . -coverprofile=/tmp/coverage.out ; go tool cover -html=/tmp/coverage.out'
#alias ggtr='CGO_CFLAGS=-Wno-undef-prefix GO111MODULE=off go test -test.v -timeout 9999900m -run'
#alias wgtr='CGO_CFLAGS=-Wno-undef-prefix GOOS=windows GOARCH=amd64 go test -test.v -timeout 9999900m -run'

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

__arch() {
    arch="arm64"

    # Detect real OS/Arch
    case $(uname -m) in
        "x86_64")
            arch="amd64"
            ;;
        "i386" | "i686")
            arch="386"
            ;;
        "aarch64")
            arch="arm64"
            ;;
        "arm" | "armv7l")
            arch="arm"
            ;;
        "arm64")
            arch="arm64"
            ;;
        *)
            # shellcheck disable=SC2059
            printf "${RED}[E] Unsupported arch $(uname -m) ${CLR}\n"
            exit 1
            ;;
    esac

    echo $arch
}


__os() {
    os="linux"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        os="darwin"
    fi

    echo $os
}

alias ddw="DW_DEBUG_WORKDIR=~/dataway ./build/dataway-darwin-arm64/dataway -cfg ~/dataway/dw.yaml"
alias ddw_docker="DW_DEBUG_WORKDIR=~/dataway DW_HTTP_CLIENT_TRACE=on DW_BIND=0.0.0.0:9528 DW_PROM_LISTEN=0.0.0.0:9091 DW_LOG_LEVEL=debug DW_REMOTE_HOST=https://kodo.guance.com:443 DW_UUID=not-set DW_TOKEN=tkn_2af4b19d7f5a489fa81f0fff7e63b588 DW_DEBUG_WORKDIR=~/dataway ./build/dataway-darwin-arm64/dataway --docker"

alias pj='python -m json.tool'
alias rmf='rm -rf'

alias mkdocs='/System/Volumes/Data/Users/tanbiao/Library/Python/3.8/bin/mkdocs'
alias nproc="sysctl -n hw.logicalcpu"

# preview markdown docs under mkdocs
__md_preview() {
	cwd=$(pwd)
	mkdocs_demo_dir=/Users/tanbiao/git/mkdocs-demo
	md_doc=$1
	as=$1

	if [ $# -gt 1 ]
	then
		as=$2
	fi

	port=$(shuf -i 40000-50000 -n 1)
	echo "> date: $(date)" > $mkdocs_demo_dir/docs/en/$(basename $as)
	cat $md_doc >> $mkdocs_demo_dir/docs/en/$(basename $as)
	cd $mkdocs_demo_dir
	./serve.sh
	cd $cwd
}

alias mdv='__md_preview'

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
#alias ctags="`brew --prefix`/bin/ctags"
