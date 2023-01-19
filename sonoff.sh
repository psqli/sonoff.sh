#!/bin/sh

# Variables used globally
address=""
device_id=""

main() {
	device_id=""

	while getopts d:h optname; do
		case $optname in
			d) device_id="$OPTARG";;
			h) print_help; exit 0;;
			?) print_help; exit 1;;
		esac
	done

	# Skip arguments read above and get fixed arguments
	shift $(($OPTIND - 1))
	[ -z "$1" ] && exit_error; address="$1"; shift
	[ -z "$1" ] && exit_error; cmd="$1"; shift

	# Add a toggle switch option locally
	if [ "$cmd" = "switch" -a "$1" = "toggle" ]; then
		# use grep instead of `jq -r .data.switch` for portability
		send_request info | grep '"switch":"on"'
		if [ $? = 0 ]; then arg="off"; else arg="on"; fi
		set $arg "$@" # Set positional parameters
	fi

	send_request "$cmd" "$@"
}

# cmd: $1, cmd_args: ...
send_request() {
	case "$1" in
	wifi) data="{ \"ssid\": \"${2}\", \"password\": \"${3}\" }";;
	*) data="{ \"${1}\": \"${2}\" }";;
	esac
	printf '{ "deviceId": "%s", "data": %s }' "$device_id" "$data" | \
	curl --data @- "http://${address}:8081/zeroconf/$1"
}

print_help() {
	printf "Usage: sonoff.sh [OPTIONS]... <ip_addr> <cmd> [arg]...\n"
	printf "Options:\n"
	printf "  -h            Help\n"
	printf "  -d device_id  String corresponding to a unique\n"
	printf "                identifier for the device.\n"
	printf "Arguments:\n"
	printf "  ip_addr  IP address of the server/device for which the\n"
	printf "           commands will be sent.\n"
	printf "  cmd      Name of the command to send to device.\n"
	printf "  arg      Argument for the command.\n"
	printf "Commands:\n"
	printf "  info                    Info about device state.\n"
	printf "  switch [on|off|toggle]  Turn switch on or off.\n"
	printf "  startup [on|off|stay]   Set switch state on startup.\n"
	printf "  wifi <ssid> <password>  Set Wi-Fi network to connect.\n"
}
exit_error() { print_help; exit 1; }

main "$@"
