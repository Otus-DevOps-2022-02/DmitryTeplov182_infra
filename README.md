# DmitryTeplov182_infra
DmitryTeplov182 Infra repository

## Полезное

```bash
git update-index --chmod=+x script.sh
```
Фикс прав, если глючит из - за винды.

```bash
cat output.json | jq -r ' .builds[0].artifact_id'
```
простой выбор из json без кавычек

## ДЗ 3
Команда для прыжка через бастион во внутренную машину с передачей ключа:
```bash
ssh -t -i <KEYFILE> -A <BASTION_USER>@<BASTION_IP> 'ssh <INTERNAL_IP>'
```
**-t**      Force pseudo-tty allocation.

**-i** identity_file

**-A**      Enables forwarding of the authentication agent connection.

**Либо можно использовать ключ** **-J**

Настроим SSH для подключеня сразу к внутренней машине используя алиасы ssh:

```bash
cat ~/.ssh/config
Host bastion
        Hostname <BASTION_IP>
        User <BASTION_IP>
        IdentityFile <KEYFILE>
        ForwardAgent yes
Host someinternalhost
        Hostname <INTERNAL_IP>
        User <INTERNAL_USER>
        ProxyJump bastion
```

bastion_IP = 217.28.228.16
someinternalhost_IP = 10.129.0.24

Для ssl:
В настройках сервера VPN указать Let's Encrypt Domain - 217.28.228.16.sslip.io

## ДЗ 4

Скрипты для разворачивания тестового приложения

1. Файл install_ruby.sh - ставит руби
2. Файл install_mongodb.sh - ставит монгу
3. Файл deploy.sh - делает деплой
4. Файл startup_script.sh - общий скрипт для деплоя
5. Файл metadata.yaml - метадата для яндекса. Автоматически запускает деплой при разворачивании.


Command for Yandex CLI. Run in commandline.
```bash
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file user-data=metadata.yaml \
  --metadata serial-port-enable=1
```

testapp_IP = 51.250.2.189
testapp_port = 9292

## ДЗ 4

- Поработал с Packer
- Запек immutable образ с приложением, которое стартует при разворачивании VM (immutable.json)
- Создал скрипт create-reddit-vm.sh в директории config-scripts, который из шаблона immutable.json создает образ и поднимает виртуалку на базе этого диска.
- Попробовал выгружать значения с помощью jq

## ДЗ 5

- Поработал с terraform
- Научился описывать инфраструктуру, планировать изменения, применять изменения, пересоздавать необходимые компоненты и удалять их.
- Создал балансировщик нагрузки в облаке и привязал к нему две виртуалки с приложением.
- Сократил код, добавив возможность указывать количество виртуалок.

По поводу недостатков такого подхода: пока, мне кажется что использовать проверку по tcp для web приложения не лучшая идея. Порт может быть доступен, но само приложение нет. Надо использовать хелчеки, но я их не нашел в приложении.


## ДЗ 6

- Поработал с модулями teraform
- Выполнил сложные задания. Научился хранить состояния в s3
- Дополнил код деплоем приложения.

Хотел использовать data чтобы получать адрес сервера БД, но не разобрался как. Ввел переменную, создалась зависимость и с ней все заработало.

Для отключения провижинера используем null ресурс, который является виртуальным ресурсом и через count выполняется или нет. Конекшн указывает на ранее созданную виртуалку.

## ДЗ 7

- Установил Ansible через apt, развернул окружение stage
- Создал ansible.cfg, куда вынес параметры ключа
- Создал инвентори файлы.
- Потестил ansible
- Запустил плейбук для клона репозитория. В первый раз он не сработал, т.к. ансибл понял что репозиторий уже склонирован. После удаления репозитория ансибл его склонировал.
 - Создал скрипт для изучения работы с динамическим inventory. Попробовал его сделать через jq, но не был уверен что jq есть в тестах и еще один через awk.
