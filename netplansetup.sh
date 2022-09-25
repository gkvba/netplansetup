# estructure
# network:
#   version: 2
#   ethernets:
#	dev:
# sudo netplan set network.ethernets.ens33.routes='[{"to":"deafult", "via": "192.168.46.2","metric":200}]'
# sudo netplan set network.ethernets.ens33.dhcp4=false
# sudo netplan set network.ethernets.ens33.nameservers.addresses=[1.1.1.1,8.8.8.8]
# sudo netplan set network.ethernets.ens33.addresses=[192.168.15.253/24]
# sudo netplan apply


dhcp_config(){
# Adicionar DHCP6 futuramente
clear
	echo "MENU.DHCP"
	echo "[1] DHCP4 ON"
	echo "[2] DHCP4 OFF"
	echo "[3] DHCP6 ON"
	echo "[4] DHCP6 OFF"
	echo "[0] Back <<"
	echo "Please enter your option:"
	read dhcp_option
	if test $dhcp_option = "1";
	then
		echo "DHCP4 set to ON"
#		sudo netplan set network.ethernets.$dev.dhcp4=true
		menu
	elif test $dhcp_option = "2";
	then
		echo "DHCP4 set to OFF"
#		sudo netplan set network.ethernets.$dev.dhcp4=false
		menu
	elif test $dhcp_option = "3";
	then
		echo "DHCP6 set to ON"
#		sudo netplan set network.ethernets.$dev.dhcp6=true
		menu
	elif test $dhcp_option = "4";
	then
		echo "DHCP6 set to OFF"
#		sudo netplan set network.ethernets.$dev.dhcp6=false
		menu
	elif test $dhcp_option = "0";
	then
		echo "BACK to main menu"
		menu
	else
		echo "INVALID INPUT! PLEASE ENTER AGAIN:"
		dhcp_config
fi
}

gateway_config(){
	echo "Do you wanna setup default gateway? [Y/N]"
	read default_option
	if (test $default_option = "y" -o $default_option = "Y");
	then
		echo "Please Enter Gateway4 IP:"
		read gateway4_ip
		sudo netplan set network.ethernets.ens33.routes='[{"to":"default","via":'$gateway4_ip'}]'
		menu
	elif (test $default_option = "n" -o $default_option = "N");
	then
		echo "Under Construction. Back Later."
		gateway_config
	else
		echo "invalid input"
		gateway_config
	fi
}

exit_option(){
# procedimento para ao sair do programa
	echo "Exiting Netplan Setup"
#	sudo netplan apply
}

menu(){
# Menu para selecionar opção de configuração do adaptador
echo "MENU"
echo "[1] DHCP Configure"
echo "[2] Gateway Configure"
echo "[0] Exit Netplan Setup"
echo "Please enter your option:"
read menu_option
if test $menu_option = "1";
then
	echo "DHCP selected"
	dhcp_config
elif test $menu_option = "2";
then
	echo "Gateway selected"
	gateway_config
elif test $menu_option = "0";
then
	exit_option
else
	echo "Option Not Found! Please Select Again"
	menu
fi
}



menu
