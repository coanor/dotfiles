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

		#-count=10 \

	CGO_CFLAGS=-Wno-undef-prefix \
	go test -run XXX \
	  -test.benchmem \
	  -test.v \
		-benchtime=${benchTime} \
	  -cpuprofile=/tmp/B.${shortName}.cpu.out${suffix} \
	  -memprofile=/tmp/B.${shortName}.mem.out${suffix} \
	  -bench ${fullBenchmarkName} | tee /tmp/${shortName}.bench.out${suffix}

	#echo "------------ P R E T T Y ------------"
	#cat /tmp/${shortName}.bench.out${suffix} | column -t 
}

alias gtb='LOGGER_PATH=nul LOGGER_LEVEL=info __gtb'
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
	local fullTestName=$1
	local envs=()
	local goTestFlags=()
	local prefix="Test"
	local shortTestName=""
	local out=""

	envs+=("CGO_CFLAGS=\"-Wno-undef-prefix -Wno-deprecated-declarations\"")

	while [[ $# -gt 0 ]]; do
		case "$1" in 
			-t | --test)
				fullTestName="$2"
				shortTestName=${fullTestName#"$prefix"}
				out=/tmp/$shortTestName.stdout

				shift
				shift
				;;

			-o | --out)
				shortTestName="$2"
				out=/tmp/$shortTestName.stdout
				shift
				shift
				;;

			-e | --env)
				envs+=("$2") # append envs
				shift
				shift
				# available envs:
				#  - UT_EXCLUDE_INTEGRATION_TESTING=on
				#  - LOGGER_PATH=nul
				;;
			-h|--help)
				echo "Usage: gtr [options] [go test flags...]"
				echo
				echo "A wrapper for 'go test' to simplify running a single test with profiling."
				echo
				echo "Options:"
				echo "  -t, --test <TestName>   Specify the test function name (required)."
				echo "  -e, --env 'VAR=VAL'     Add a custom environment variable. Can be used multiple times."
				echo "  -h, --help              Show this help message."
				echo
				echo "Example:"
				echo "  gtr -t TestMyFunc"
				echo "  gtr -t TestWithEnv -e 'MY_VAR=hello' -e 'DEBUG=1'"
				echo "  gtr -t TestForEscape -gcflags='-m -m' -v"
				echo
				return 0
				;;
			*)
				goTestFlags+=("$1")
				shift
				;;
	      # we can pass more flags here
			  # - for HTTP test: -httptest.serve=0.0.0.0:50000
			  # - for mem escape: -gcflags="-m"
			  # ...
		esac
	done

	# Check if a test name was provided
	if [[ -z "$fullTestName" ]]; then
		echo "Error: Test function name not specified. Use -t or --test." >&2
		__gtr --help
		return 1
	fi

	truncate -s 0 $out
	echo "----------------------------------" >> $out
	echo "Date: $(date)" >> $out
	echo "Host: $(hostname)" >> $out
	echo "Test: $fullTestName" >> "$out"
	# Use printf for safer printing of arguments that might contain special characters
	printf "Go test flags: %s\n" "${goTestFlags[*]}"
	printf "Envs: %s\n" "$envs"
	echo "----------------------------------" >> $out

	# build the command and run
	local cmd="go test -test.v -run ${fullTestName} \
-timeout 9999900m \
-cpuprofile=/tmp/T.${shortTestName}.cpu \
-memprofile=/tmp/T.${shortTestName}.mem \
-cover -coverprofile=/tmp/${shortTestName}.cover \
${goTestFlags[*]}"

	echo "Running command:" | tee -a "$out"
	echo "  ${envs[*]} ${cmd}" | tee -a "$out"

	eval "${envs[*]} ${cmd}" 2>&1 | tee -a "$out"
}

alias gtrll='__gtr'
alias gtr='__gtr -e "LOGGER_PATH=nul"' # disable code logging passed by test code
alias gtrh='go test -test.v -timeout 9999900m -httptest.serve=0.0.0.0:50000 -run' # start httptest on localhost:50000
alias gtrh='__gtr -httptest.serve=0.0.0.0:50000' # start httptest on localhost:50000

# test all code under some package
__gtra() {
		UT_EXCLUDE_INTEGRATION_TESTING=on \
		CGO_CFLAGS=-Wno-undef-prefix \
		go test -test.v -timeout 9999900m -cover -coverprofile=/tmp/coverage.out -run . | tee gtra.out # output to local gtra.out
}


alias gtra='LOGGER_PATH=nul __gtra'
alias gtrall='__gtra'

# show golang test coverage in web
__covershow() {
	go tool cover -html=$1
}

alias covershow='__covershow'

alias gdbg='LOGGER_PATH=nul dlvT'
