# My Docker

Ett derivat från Roots Bedrock 2019-01-29 för att exemplifiera en enkel Dockermiljö för lokal utveckling.

Steg för steg:

1. Du kan köra Docker på din maskin och den är startad.
1. Klona repot till din utv-mapp.
1. Se till att du INTE har tjänster mot port 80 lokalt.
1. Kör `docker-compose up` i den klonade mappen.
1. Lägg till följande i /etc/hosts: `127.0.0.1 local.my-docker.se`

Klart!
 