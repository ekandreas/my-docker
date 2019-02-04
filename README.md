# My Docker

Ett derivat från Roots Bedrock 2019-01-29 för att exemplifiera en enkel Dockermiljö för lokal utveckling.

Krav på miljö lokalt:
* Docker (testa genom att skriva `docker version` i en terminal)
* Composer (testa genom att skriva `composer about` i en terminal)

Steg för steg:
1. Se till att du INTE har tjänster mot port 80 lokalt.
1. Klona repot till din utv-mapp och gå in i den mappen i din terminal.
1. Kör `composer update` 
1. Kör `docker-compose up` i den klonade mappen.
1. Lägg till följande i /etc/hosts: `127.0.0.1 local.my-docker.se`

**Klart!**
 
Stoppa tjänsten:
`docker-compose stop`

PHPMyAdmin når du via port 8081

## Installera docker samt composer på MacOS
* https://docs.docker.com/docker-for-mac/install/
* https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos

## Installera docker i Arch linux
* `pacman -S docker docker-compose` installerar de paket du behöver. 
* `sudo systemctl enable docker` ställ in docker att starta när datorn startar
* `sudo systemctl starta docker` starta upp docker-daemonen
* `sudo usermod -a -G docker USERNAME` lägg till användaren USERNAME i gruppen docker. Detta krävs för att kunna köra docker som vanlig användare. Logga in och ut för att ändringarna ska ta effekt. 
