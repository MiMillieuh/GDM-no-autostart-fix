
if [ $(whoami) = "root" ]
then
        echo "Welcome to gdm autostart fix"
        echo "After installation, don't enable gdm with systemctl"
else
	echo "Please execute this script as root"
	echo "use : sudo gdm-autostart-fix"
	echo "or use your root account"
	exit 1
fi

GDMSERVICEFILE=/usr/lib/systemd/system/gdm.service
if [ -f "$GDMSERVICEFILE" ]; then
    echo "GDM is installed processing..."
else 
    echo "GDM is not installed or you aren't using systemd. Please install GDM and use systemd as your init then try again."
    echo "If you belive GDM is installed and you're using systemd type 1 if not type 0"
read installed

if [ $installed = "1" ]
then
	echo "Forced by user"
else
	    exit 1
fi

fi


rm -rf /etc/systemd/system/enablegdmfix.service
systemctl disable gdm.service
touch /etc/systemd/system/enablegdmfix.service
echo "[Unit]" >> /etc/systemd/system/enablegdmfix.service
echo "Description=GDMfixFedora" >> /etc/systemd/system/enablegdmfix.service
echo "" >> /etc/systemd/system/enablegdmfix.service
echo "[Service]" >> /etc/systemd/system/enablegdmfix.service
echo "User=root" >> /etc/systemd/system/enablegdmfix.service
echo "WorkingDirectory=/" >> /etc/systemd/system/enablegdmfix.service
echo "ExecStart=systemctl start gdm" >> /etc/systemd/system/enablegdmfix.service
echo "Restart=always" >> /etc/systemd/system/enablegdmfix.service
echo "" >> /etc/systemd/system/enablegdmfix.service
echo "[Install]" >> /etc/systemd/system/enablegdmfix.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/enablegdmfix.service
systemctl enable enablegdmfix.service

echo "Would you like to reboot now ?"
echo "1 = yes 0 = no"
read rebootask

if [ $rebootask = "1" ]
then
reboot
else
	echo "You can start it like the usual if you want (systemctl start gdm.service) if you want it"
fi


