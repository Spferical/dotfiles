address="00:23:01:27:D6:3A"
case "$1" in
	"connect" )
		echo -e "connect $address \nquit" | bluetoothctl
		;;
	"disconnect" )
		echo -e "disconnect $address \nquit" | bluetoothctl
		;;
esac

