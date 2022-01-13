# kibiv_infra
kibiv Infra repository

# Connection settings
````
bastion_IP = 62.84.127.228
someinternalhost_IP = 10.128.0.20
````
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

# ДЗ "Деплой тестового приложения":
# Задание 1:
Данные для подключения к облачному приложению:
```
testapp_IP = 51.250.14.149
testapp_port = 9292
```
# Задание 2:
Созданы следующие скрипты (права на выполнение добавлены):
- install_ruby.sh
- install_mongodb.sh
- deploy.sh

# Дополнительное задание 3:
Создан startup script
- startup_script.sh

Команда для создания готового инстанса 
- ./create_instance.sh

Для прохождения автотестов необходимо разрешить подключаться к mongodb по всем IP-адресам

````
sudo sed 's/127.0.0.1$/0.0.0.0/g' /etc/mongod.conf
````
