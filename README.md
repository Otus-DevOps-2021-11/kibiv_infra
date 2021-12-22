# kibiv_infra
kibiv Infra repository

# Connection settings
bastion_IP = 62.84.127.228
someinternalhost_IP = 10.128.0.20

# Configuration files
vim /etc/hosts
62.84.127.228	bastion
10.128.0.20	someinternalhost

vim ~/.ssh/config
Host bastion
	HostName bastion
	IdentityFile ~/.ssh/appuser
	User appuser

Host someinternalhost
	HostName someinternalhost
	IdentityFile ~/.ssh/appuser
	Port 22
	User appuser
	ProxyJump bastion

