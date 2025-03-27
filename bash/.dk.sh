
#
# Debugging datakit
#
__ddk() {
    os=$(__os)
    arch=$(__arch)

    DK_DEBUG_WORKDIR=~/datakit \
        DK_DEBUG_MAX_RUN_DURATION=24h \
        ./dist/datakit-$os-$arch/datakit $@
}

__ddk_lambda_ext() {
    os=$(__os)
    arch=$(__arch)

		AWS_LAMBDA_RUNTIME_API="localhost:54321" \
		AWS_LAMBDA_FUNCTION_NAME=dk \
		AWS_LAMBDA_FUNCTION_VERSION=0.1.9999 \
		AWS_REGION="dk-debug" \
		AWS_LAMBDA_FUNCTION_MEMORY_SIZE="10485760" \
		EnvLambdaInitializationType="dk-lambda-ext-testing" \
		ENV_DATAWAY=http://localhost:54321?token=tkn_xxxxxxxxxxxxxxxxxxxxxxx \
		ENV_LOG_LEVEL="debug" \
		ENV_DISABLE_LOG_COLOR=yes \
		AWS_SAM_LOCAL=true \
			DK_DEBUG_WORKDIR=~/datakit \
			DK_DEBUG_MAX_RUN_DURATION=24h \
			./dist/datakit_aws_lambda-$os-$arch/extensions/datakit $@ | tee /tmp/dkle

}

alias ddk_http_fail="ENV_DEBUG_HTTP_FAIL_RATIO=70 ENV_DEBUG_HTTP_FAIL_DURATION=2h __ddk"
alias ddk_with_expire="__ddk"
alias ddk_with_expire_no_ptpool="DK_DEBUG_NO_POINT_POOL=1 __ddk"
alias ddk_with_expire_no_ptpool_with_gc="DK_DEBUG_GC_DURATION=10s DK_DEBUG_MAX_RUN_DURATION=3m __ddk"

alias ddk="__ddk  2>&1 | tee ~/datakit/stdout-stderr"
alias dk="__ddk"
alias ddql="__ddk dql"
alias dkm="__ddk monitor -R3s --log ~/datakit/cmds.log --dump-metrics"

alias dkmv="__ddk monitor -V -R3s --log ~/datakit/cmds.log --dump-metrics"
alias dkmm="__ddk monitor -R3s --log ~/datakit/cmds.log --dump-metrics -M "

alias dkpm="curl -s http://localhost:19529/metrics | grep"
alias dkle="__ddk_lambda_ext"

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

alias ds_dk_restart='kubectl rollout restart daemonset datakit -n datakit'
alias dkpods='kubectl get pod -n datakit'

__poddk() {
	kubectl exec --stdin --tty $1 -n datakit -- /bin/bash
}

alias poddk='__poddk'

# fast path to bug report files
__br() {
	cd ~/Downloads/*$1
}

alias br='__br'

alias dklint='make lint GOLINT_BINARY=golangci-lint-v1-46-2 | tee /tmp/dklint'
alias dwlint='make lint GOLINT_BINARY=golangci-lint-v1-61-0 | tee /tmp/dwlint'
alias dklint161='make lint GOLINT_BINARY=golangci-lint-v1-61-0 | tee /tmp/dklint'
alias dwlint='make lint GOLINT_BINARY=golangci-lint-v1-61-0 | tee /tmp/dwlint'
