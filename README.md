# My Docker

Ett derivat från Roots Bedrock 2019-01-29 för att exemplifiera en enkel Dockermiljö för lokal utveckling.

Krav på miljö lokalt:
* Docker (testa genom att skriva `docker version` i en terminal)
* Composer (testa genom att skriva `composer about` i en terminal)

Steg för steg:
1. Se till att du INTE har tjänster mot port 80 lokalt. Surfa mot localhost (du ska inte få upp någon webbsida)
1. Klona repot till din utv-mapp och gå in i den mappen i din terminal.
1. Kör `composer install` i maopen.
1. Kör `docker-compose up` i den klonade mappen.
1. Lägg till följande i /etc/hosts: `127.0.0.1 local.my-docker.se`
1. Kör Famous 5 minutes install i webbläsaren eller använd wp-cli, ex: `docker-compose exec web wp core install...`

**Klart!**
 
Stoppa tjänsten:
`docker-compose stop`

PHPMyAdmin når du via port 8081

## Steg för steg med en "ren" macOS
Denna guide är för en maskin som inte har Git, PHP Composer och Docker för Mac sedan tidigare.

### Git
* Installera “git”: https://sourceforge.net/projects/git-osx-installer/files/
* Öppna “termina”l I macOS.
* Kolla att git är installerat: git —version
* Klona repo: git clone https://github.com/ekandreas/my-docker
* Gå in i mappen my-docker

### Composer
* Installera php composer: https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos
* Flytta composer.phar till körbar composer: mv composer.phar /usr/local/bin/composer
* Kontrollera att composer fungerar: `composer info`
* Installera paket: `composer install`. Bland annat installeras nu grunderna för WP.

### Docker
* Installera Docker for Mac: https://docs.docker.com/docker-for-mac/ (skapa konto om du inte har ett och logga in)
* Starta “Docker” i “applications”
* Se till att Docker-applikationen är “inloggad” med ditt konto.
* Starta om din terminal så att “docker”-kommandon fungerar.
* Testa genom att skriva `docker version` i terminalen

### Bygga “images” och köra “containers” lokalt
* Gå in i mappen “my-docker” och för: `docker-compose up`.  Tar lång tid och medan du väntar tar du nästa steg.

### Hosts
* Öppna en ny terminal och ändra i filen /etc/hosts: `sudo nano /etc/hosts `
```
127.0.0.1 localunixsocket
 127.0.0.1 local.my-docker.se
```
 (spara med ctrl+o och stäng med ctrl+x)
* Surfa till sidan local.my-docker.se efter att fönstret med docker-compose up är “färdigt”.
* Installera WordPress via webbläsaren eller via WP-CLI (se intro nedan).

### Stoppa webben:
`docker-compose stop`

### Installera en plugin:
`composer require wpackagist-plugin/autodescription`

### Köra ett wp-cli-commando:
`docker-compose exec web wp --version` 


## Installera docker i Arch linux
* `pacman -S docker docker-compose` installerar de paket du behöver. 
* `sudo systemctl enable docker` ställ in docker att starta när datorn startar
* `sudo systemctl starta docker` starta upp docker-daemonen
* `sudo usermod -a -G docker USERNAME` lägg till användaren USERNAME i gruppen docker. Detta krävs för att kunna köra docker som vanlig användare. Logga in och ut för att ändringarna ska ta effekt. 


## Bonus: Deploy till Linode med Terraform (iac)
En MYCKET enkel deploy till linode finns under config/iac mot Linode för den som är experimentsugen.

1. Lägg till din Linode-token i linode.tf (https://www.linode.com/docs/platform/api/getting-started-with-the-linode-api/)
1. Lägg in din ssh-nyckel i linode.tf
1. Kör `terraform init`
1. Kör `terraform apply`
1. Ta ip-adressen i .linode_ip_address.txt och placera i /deploy.php för rätt host. 
`terraform apply` och vid uppdateringar `dep deploy production` (deploy.php måste ha rätt IP-adress).
