#!/bin/sh

# Be strict
set -e
set -u


###
### Globals
###
ARG_CI=     # Wrapper flag --ci
ARG_D=      # gofmt flag -d
ARG_E=      # gofmt flag -d
ARG_L=      # gofmt flag -l
ARG_R=      # gofmt flag -r
ARG_S=      # gofmt flag -s
ARG_W=      # gofmt flag -w
ARG_PATH=   # Path argument
ARGS=       # Concatenated arguments


###
### Show Usage
###
print_usage() {
	>&2 echo "Usage: cytopia/gofmt [flags] [path...]"
	>&2 echo "       cytopia/gofmt [--ci] [-r rule] [-se] [path...]"
	>&2 echo "       cytopia/gofmt --help"
	>&2 echo
	>&2 echo "Dockerized version of gofmt with an addition to fail (exit 1) in case of file changes."
	>&2 echo
	>&2 echo "Additional wrapper features:"
	>&2 echo "----------------------------"
	>&2 echo " --ci     This option will print the diff to stdout (similar to '-d') and if a diff"
	>&2 echo "          exists it will fail with exit 1."
	>&2 echo "          Can only be combined with '-r rule', '-s' and '-e'."
	>&2 echo "          To be used in continuous integration with explicit failing."
	>&2 echo
	>&2 echo "Default gofmt flages:"
	>&2 echo "----------------------------"
	>&2 echo " -d       Do not print reformatted sources to standard output."
	>&2 echo "          If a file's formatting is different than gofmt's, print diffs"
	>&2 echo "          to standard output."
	>&2 echo " -e       Print all (including spurious) errors."
	>&2 echo " -l       Do not print reformatted sources to standard output."
	>&2 echo "          If a file's formatting is different from gofmt's, print its name"
	>&2 echo "          to standard output."
	>&2 echo " -r rule  Apply the rewrite rule to the source before reformatting."
	>&2 echo " -s       Try to simplify code (after applying the rewrite rule, if any)."
	>&2 echo " -w       Do not print reformatted sources to standard output."
	>&2 echo "          If a file's formatting is different from gofmt's, overwrite it"
	>&2 echo "          with gofmt's version. If an error occurred during overwriting,"
	>&2 echo "          the original file is restored from an automatic backup."
}


###
### Validate Go file(s)
###
### @param  string gofmt arguments.
### @param  string Path to file(s).
### @return int    Success (0: success, >0: Failure)
###
_gofmt_ci() {
	_args="${1}"
	_path="${2}"
	_ret=0
	_out=
	_cmd="gofmt -d ${_args} ${_path}"

	# Show and execute command
	echo "${_cmd}"
	_out="$( eval "${_cmd}" )"

	# evaluate command
	if [ -n "${_out}" ]; then
		_ret=$(( _ret + 1 ))
	fi

	echo "${_out}"
	return "${_ret}"
}


###
### Arguments appended?
###
if [ "${#}" -gt "0" ]; then

	while [ "${#}" -gt "0"  ]; do
		case "${1}" in
			# Show Help and exit
			--help)
				print_usage
				exit 0
				;;
			# Use gofmt wrapper
			--ci)
				if [ -n "${ARG_D}" ]; then
					>&2 echo "Error, ${1} can not be used together with -d".
					exit 1;
				fi
				if [ -n "${ARG_L}" ]; then
					>&2 echo "Error, ${1} can not be used together with -l".
					exit 1;
				fi
				if [ -n "${ARG_W}" ]; then
					>&2 echo "Error, ${1} can not be used together with -w".
					exit 1;
				fi
				ARG_CI=1
				shift
				;;
			# Add gofmt argument (-s)
			-s)
				ARG_S="-s"
				ARGS="${ARGS} ${ARG_S}"
				shift
				;;
			# Add gofmt argument (-e)
			-e)
				ARG_E="-e"
				ARGS="${ARGS} ${ARG_E}"
				shift
				;;
			# Add gofmt argument (-r <rule>)
			-r)
				if [ "${#}" -lt "2" ]; then
					>&2 echo "Error, ${1} requires an argument."
				fi
				ARG_R="${1} ${2}"
				ARGS="${ARGS} ${ARG_R}"
				shift
				shift
				;;
			# Add gofmt argument (-d)
			-d)
				if [ -n "${ARG_CI}" ]; then
					>&2 echo "Error, ${1} can not be used together with --ci".
					exit 1
				fi
				ARG_D="-d"
				ARGS="${ARGS} ${ARG_D}"
				shift
				;;
			# Add gofmt argument (-l)
			-l)
				if [ -n "${ARG_CI}" ]; then
					>&2 echo "Error, ${1} can not be used together with --ci".
					exit 1
				fi
				ARG_L="-l"
				ARGS="${ARGS} ${ARG_L}"
				shift
				;;
			# Add gofmt argument (-w)
			-w)
				if [ -n "${ARG_CI}" ]; then
					>&2 echo "Error, ${1} can not be used together with --ci".
					exit 1
				fi
				ARG_W="-w"
				ARGS="${ARGS} ${ARG_W}"
				shift
				;;
			# Invalid option
			-*)
				>&2 echo "Error, '${1}' is an invalid option."
				exit 1
				;;
			# Anything else is handled here
			*)
				if [ -n "${ARG_PATH}" ]; then
					>&2 echo "Error, path has already been specified: ${ARG_PATH}"
					exit 1
				fi
				ARG_PATH="${1}"
				shift
				;;
		esac
	done

###
### No arguments appended
###
else
	print_usage
	exit 0
fi


###
### Pre-flight check
###
if [ -z "${ARG_PATH}" ]; then
	>&2 echo "Error, path is required but not specified"
	exit 1
fi


###
### Entrypoint
###
if [ -n "${ARG_CI}" ]; then
	_gofmt_ci "${ARGS}" "${ARG_PATH}"
else
	eval "gofmt ${ARGS} ${ARG_PATH}"
fi
