# DmitryTeplov182_infra
DmitryTeplov182 Infra repository

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

testapp_IP = 51.250.64.46
testapp_port = 9292
