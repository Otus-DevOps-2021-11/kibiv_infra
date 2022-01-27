# kibiv_infra
kibiv Infra repository

# Connection settings
````
bastion_IP = 62.84.127.228
someinternalhost_IP = 10.128.0.20
````
# Configuration files
vim /etc/hosts
````
62.84.127.228	bastion
10.128.0.20	someinternalhost
````
vim ~/.ssh/config
````
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
````

# **Лекция №6: Основные сервисы Yandex Cloud**
> _cloud-testapp_
<details>
  <summary>Практика управления ресурсами yandex cloud через yc.</summary>

# Задание 1:
Данные для подключения к облачному приложению:
````bash
testapp_IP = 51.250.8.21
testapp_port = 9292
````
# Задание 2:
Созданы следующие скрипты (права на выполнение добавлены):
```
- install_ruby.sh
- install_mongodb.sh
- deploy.sh
```


# Дополнительное задание 3:
Создан startup script
- `startup_script.sh`

Команда для создания инстанса с запущенным приложением
- `./create_instance.sh`

Для прохождения автотестов необходимо разрешить подключаться к mongodb по всем IP-адресам

````bash
sudo sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
````
</details>


# **Лекция №7: Модели управления инфраструктурой. Подготовка образов с помощью Packer**
> _packer-base_
<details>
  <summary>Подготовка базового образа VM при помощи Packer</summary>

## **Задание:**
Подготовка базового образа VM при помощи Packer.

Цель:
В данном дз студент произведет сборку готового образа с уже установленным приложением при помощи Packer. Задеплоит приложение в Yandex compute cloud при помощи ранее подготовленного образа.
В данном задании тренируются навыки: работы с Packer, работы с YC.

Все действия описаны в методическом указании.

Критерии оценки:
0 б. - задание не выполнено
1 б. - задание выполнено
2 б. - выполнены все дополнительные задания

---

## **Выполнено:**

1. Установлен Packer:

````bash
$ packer -v
1.7.8
````

2.1. Создан сервисный аккаунт:
````bash
name: sa-user
````

2.2. Делегированы права editor сервисному аккаунту для Packer

2.3. Создан service account key file

3. Созданы файлы-шаблоны Packer 
````bash
ubuntu16.json
ubuntu20.json
````
4. Созданы скрипты для provisioners 
````bash
install_ruby.sh
install_mongodb.sh
````

5. Выполнено параметризирование шаблона с применением 
````bash
variables.json.example
````
6. Выполнена проверка на ошибки

7. Выполнен запуск сборки образа
````bash
packer build -var-file=./variables.json ./ubuntu16.json
````

8. Создана ВМ с использованием созданного образа

9. Выполнено "дожаривание" ВМ для запуска приложения:
````bash
sudo apt-get update
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
````

10. Построение bake-образа `*`
- Создан immutable.json
- Создан systemd unit puma.service
- Запущена сборка
````bash
packer build -var-file=./variables.json immutable.json
````
- Проверка созданных образов:
````bash
reddit-base
reddit-full
````

11. Выполнена автоматизация создания ВМ `*`
- Создан 
`create-instance.sh`

````bash
#!/bin/bash
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id="yc_folder_id",image-family=reddit-full,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./metadata.yaml \
````
</details>
# **Лекция №8: Знакомство с Terraform**
> _terraform1_
<details>
  <summary>Декларативное описание в виде кода инфраструктуры YC, требуемой для запуска тестового приложения, при помощи Terraform</summary>

## **Задание:**
Декларативное описание в виде кода инфраструктуры YC, требуемой для запуска тестового приложения, при помощи Terraform.
Цель:
В данном дз студент опишет всю инфраструктуру в Yandex Cloud при помощи Terraform. 
В данном задании тренируются навыки: создания и описания инфраструктуры при помощи Terraform. Принципы и подходы IaC.
Все действия описаны в методическом указании.

Критерии оценки:
0 б. - задание не выполнено
1 б. - задание выполнено
2 б. - выполнены все дополнительные задания


---

## **Выполнено:**

1. Установлен Terrafofrm switcher выполнено переключение на требуемую версию terraform:

````bash
$ terraform -v
Terraform v0.12.8
+ provider.yandex v0.56.0
````

2. В файл-.gitignore добавлены строки
````bash
*.tfstate
*.tfstate.*.backup
*.tfstate.backup
*.tfvars
```` 
3. Опрделена секция Provider в main.tf
````bash
provider "yandex" {
  token     = "<OAuth или статический ключ сервисного аккаунта>"
  cloud_id  = "<идентификатор облака>"
  folder_id = "<идентификатор каталога>"
  zone      = "ru-central1-a"
}
````
4.1. Создан сервисный аккаунт:
````bash
name: sa-terraform
````

4.2. Делегированы права editor сервисному аккаунту для Terraform
4.3. Создан service account key file

5. В файле main.tf добавлен ресурс reddit-app для создания инстанса VM в YC

6. Создана VM согласно описанию в файле main.tf

7. Дополнительно определен SSH ключ в метаданных инстанса в файле main.tf

8. Создан файл outputs.tf

9. Добавлены секции провижинера типа file для описания сервиса systemd и выполнения скрипта deploy.sh

10. Проверена работа провижинеров и приложения
11. Создан файл variables.tf для определения переменных
12. Создан файл terraform.tfvars в котором определены переменные.
13. Создан файл terraform.tfvars.example в котором определены псевдопеременные для прохождения автотестов
</details>
