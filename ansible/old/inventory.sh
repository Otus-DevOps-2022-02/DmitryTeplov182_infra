#!/bin/bash
#Проверяем есть ли JQ
if (which jq > /dev/null)
then
appserver=$(yc compute instance list --format json | jq '.[] | select(.labels.tags=="reddit-app")' | jq .network_interfaces | jq '.[0].primary_v4_address.one_to_one_nat.address' -r)
dbserver=$(yc compute instance list --format json | jq '.[] | select(.labels.tags=="reddit-db")' | jq .network_interfaces | jq '.[0].primary_v4_address.one_to_one_nat.address' -r)

if [ "$1" == "--list" ]
then
    cat << EOM
    {
        "_meta": {
            "hostvars": {
                "appserver": {
                    "ansible_host": "$appserver"
                },
                "dbserver": {
                    "ansible_host": "$dbserver"
                }
            }
        },

        "app": {
            "hosts": [
                "appserver"
            ]
        },

        "db": {
            "hosts": [
                "dbserver"
            ]
        }
    }
EOM
exit
else
  echo "You must use --host or --list argument"
  exit
fi
else
if [ "$1" == "--list" ]
then
    cat << EOM
    {
        "_meta": {
            "hostvars": {
                "appserver": {
                    "ansible_host": "$appserver"
                },
                "dbserver": {
                    "ansible_host": "$dbserver"
                }
            }
        },

        "app": {
            "hosts": [
                "appserver"
            ]
        },

        "db": {
            "hosts": [
                "dbserver"
            ]
        }
    }
EOM
else
  echo "You must use --host or --list argument"
fi
fi

appserver=$(yc compute instance list | grep "reddit-app" | awk '{print $10}')
dbserver=$(yc compute instance list | grep "reddit-db" | awk '{print $10}')

if [ "$1" == "--list" ]
then
    cat << EOM
    {
        "_meta": {
            "hostvars": {
                "appserver": {
                    "ansible_host": "$appserver"
                },
                "dbserver": {
                    "ansible_host": "$dbserver"
                }
            }
        },

        "app": {
            "hosts": [
                "appserver"
            ]
        },

        "db": {
            "hosts": [
                "dbserver"
            ]
        }
    }
EOM
elif [ "$1" == "--host" ]
then
    cat << EOM
    {
        "_meta": {
        "hostvars": {
            "appserver": {
                "ansible_host": "$appserver"
            },
            "dbserver": {
                "ansible_host": "$dbserver"
            }
        }
    }
EOM
else
  echo "You must use --host or --list argument"
fi
