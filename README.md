# rsnapshot

Contenedor para el uso de Rspanshots basado en Alpine. Con este se podrán hacer backups tanto de archivos locales como remotos.

# Uso

* Se debe definir un volumen en donde se almacenarán los backups realizados por rsnapshot.
* Definir una variable de entorno llamada BACKUP_DIRECTORIES, esta debe ser una lista de directorios a realizar backups.

# Ejemplo de uso con docker-compose:

```
rsnapshot:
  container_name: rsnapshot
  image: gafonso21/docker-rsnapshot
  volumes:
    - rsnapshot-keys:/root/.ssh #Volumen con las claves ssh
    - rnapshots-bkp:/var/rsnapshot #Volumen que contiene los bkps
  environment:
    BACKUP_DIRECTORIES: |
                 /directory1  ./
                 /directory2  ./
                 /directory3  ./
  command: ["rsnapshot", "hourly"]
  
```
En el caso de la variable BACKUP_DIRECTORIES: tanto directory1, directory2 o directory3 pueden ser carpetas locales, montadas a través de un volumen por ejemplo, o un servidor remoto. Estas localizaciones serán a las que se le realizara el backup
  
  Segun el archivo de configuración que se genere, en nuestro caso con command se pueden pasar las siguientes opciones:
  * command: ["rsnapshot", "hourly"]
  * command: ["rsnapshot", "daily"]
  * command: ["rsnapshot", "weekly"]
