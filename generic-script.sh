#! /bin/sh -e

DAEMON="/usr/local/bin/mailcatcher" #software to run as a service
DAEMON_OPT="--ip=0.0.0.0 --no-quit"  #software arguments
DAEMONUSER="user" #user used to run
DAEMON_NAME="mailcatcher" #software bin name (the same as in DAEMON var)

PATH="/sbin:/bin:/usr/sbin:/usr/bin"

test -x $DAEMON || exit 0

. /lib/lsb/init-functions

d_start () {
        log_daemon_msg "Starting system $DAEMON_NAME Daemon"
        start-stop-daemon --background --name $DAEMON_NAME --start --quiet --chuid $DAEMONUSER --exec $DAEMON -- $DAEMON_OPT
        log_end_msg $?
}

d_stop () {
        log_daemon_msg "Stopping system $DAEMON_NAME Daemon"
        start-stop-daemon --name $DAEMON_NAME --stop --retry 5 --quiet --name $DAEMON_NAME
        log_end_msg $?
}

case "$1" in

        start|stop)
            d_${1}
            ;;

        restart|reload|force-reload)
                d_stop
                d_start
            ;;

        force-stop)
           d_stop
            killall -q $DAEMON_NAME || true
            sleep 2
            killall -q -9 $DAEMON_NAME || true
            ;;

        status)
            status_of_proc "$DAEMON_NAME" "$DAEMON" "system-wide $DAEMON_NAME" && exit 0 || exit $?
            ;;

        *)
            echo "Usage: /etc/init.d/$DAEMON_NAME {start|stop|force-stop|restart|reload|force-reload|status}"
            exit 1
            ;;
esac
exit 0
