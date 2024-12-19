# go profile
__gtp() {
	source ~/.golang-1.20
	port=$(shuf -i 40000-50000 -n 1)

	go tool pprof -http=0.0.0.0:${port} ${1}
}
alias gtp='__gtp'

__gtb() {
	fullBenchmarkName=$1
	prefix="Benchmark"
	shortName=${fullBenchmarkName#"$prefix"} # trim `Benchmark` prefix. Tips: replace '#' as '%' for suffix trim

	suffix="$3"
	benchTime="1s"

	if [ $# -gt 1 ]; then
		benchTime=$2 # NOTE: bench time can be '10s' for run the benchmark for 10 seconds, or '1000x' to set b.N to 1000
	fi

	if [ $# -gt 2 ]; then
		suffix="."$3 # add prefix `.' before suffix
	fi

	CGO_CFLAGS=-Wno-undef-prefix \
	go test -run XXX \
	  -test.benchmem \
	  -test.v \
	  -cpuprofile=/tmp/B.${shortName}.cpu.out${suffix} \
	  -memprofile=/tmp/B.${shortName}.mem.out${suffix} \
	  -benchtime=${benchTime} -bench ${fullBenchmarkName} | tee /tmp/${shortName}.bench.out${suffix}

	#echo "------------ P R E T T Y ------------"
	#cat /tmp/${shortName}.bench.out${suffix} | column -t 
}

alias gtb='LOGGER_PATH=nul __gtb'
alias gtbll='__gtb'
alias gtba='__gtbV2 -T 100x -N'

alias gr='go run'
alias gv='go vet ./...'
alias gmodtidy='go mod tidy'

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

__gtr() {
	fullTestName=$1
	prefix="Test"
	shortTestName=${fullTestName#"$prefix"}
	out=/tmp/$shortTestName.stdout

	truncate -s 0 $out
	echo "----------------------------------" >> $out
	echo "Date: $(date)" >> $out
	echo "Host: $(hostname)" >> $out
	echo "----------------------------------" >> $out
	#UT_EXCLUDE_INTEGRATION_TESTING=on \
	CGO_CFLAGS="-Wno-undef-prefix -Wno-deprecated-declarations" \
		CGO_CFLAGS=-Wno-undef-prefix \
		go test -test.v -run $fullTestName \
			-timeout 9999900m \
			-cpuprofile=/tmp/T.${shortTestName}.cpu \
			-memprofile=/tmp/T.${shortTestName}.mem \
			-cover -coverprofile=/tmp/${shortTestName}.cover 2>&1 | tee -a $out
}

alias gtrll='__gtr'
alias gtr='LOGGER_PATH=nul __gtr' # disable code logging passed by test code

# test all code under some package
__gtra() {
	LOGGER_PATH=nul \
		UT_EXCLUDE_INTEGRATION_TESTING=on \
		CGO_CFLAGS=-Wno-undef-prefix \
		go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run . | tee gtra.out # output to local gtra.out
}


alias gtra='__gtra'

# show golang test coverage in web
__covershow() {
	go tool cover -html=$1
}

alias covershow='__covershow'
