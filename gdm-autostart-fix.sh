
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

dnf install gdm
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


