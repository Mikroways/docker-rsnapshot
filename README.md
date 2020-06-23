# Rsnapshot
 
Contenedor para el uso de Rspanshots basado en Alpine. Con este se podrán hacer backups tanto de archivos locales como remotos.
 
# Uso
 
* Se debe definir un volumen en donde se almacenarán los backups realizados por rsnapshot.
 * Los backups generados se almacenan en el directorio **/var/rsnapshot**
 * Es posible definir una variable de ambiente **PREFIX**, el valor indicado en esta variable será agregado como subdirectorio en **/var/rsnapshot**.
   * Ejemplo: PREFIX=databases
   * Directorio donde se almacenarán los backups **/var/rsnapshot/databases**.
* Backups de directorios:
 * Definir variable de ambiente BACKUP_DIRECTORIES, esta variable debe ser una lista de directorios a realizar backup.
 * La lista de directorios debe contener un origen y destino, y se debe especificar con el siguiente formato:
   ```yaml
   BACKUP_DIRECTORIES: source_dir1:destination_dir1;source_dir2:destination_dir2
   ```
   * Nota: cada par de valores, origen y destino a realizar backup, debe ser separado de otro par de valores por ";".
* Backups de directorios remotos:
 * Definir variable de ambiente BACKUP_REMOTE_DIRECTORIES, esta variable debe ser una lista de directorios remotos a realizar backup.
 * La lista de directorios debe contener un origen y destino, y se debe especificar con el siguiente formato:
     ```yaml
     BACKUP_REMOTE_DIRECTORIES: user@ip_soruce:source_dir1:destination_dir1;user2@ip_soruce2:source_dir2:destination_dir2
     ```
   * Nota: cada par de valores, origen y destino a realizar backup, debe ser separado de otro par de valores por ";".
* Políticas de retención, se definen a partir de las siguientes variables de ambiente:
 * **RETAIN_HOURLY**: hourly retention. Por defecto 23
 * **RETAIN_DAILY**: Daily retention. Por defecto 6
 * **RETAIN_WEEKLY**: Weekly retention. Por defecto 3
 * **RETAIN_MONTHLY**: Monthly retention. Por defecto 11
 * **RETAIN_YEARLY**: Yearly retention. Por defecto 2
* Es posible utilizar las opciones de Rsnapshot de excluir e incluir archivos/directorios.
 * Para excluir utilizar la variable de ambiente **EXCLUDE**, se puede tener múltiples excludes indicando a cada uno separados por **";"**
 * Para incluir utilizar la variable de ambiente **INCLUDE**, se puede tener múltiples includes indicando a cada uno separados por **";"**
 
# Ejemplo de uso con docker-compose:
 
```
version: '3'
services:
 rsnapshot-db:
   image: mikroways/docker-rsnapshot
   environment:
     PREFIX: backups
     RETAIN_HOURLY: 4
     RETAIN_DAILY: 7
     RETAIN_WEEKLY: 4
     RETAIN_MONTHLY: 6
     INCLUDE: "/opt/databases/mariadb/*.sql.gz"
     EXCLUDE: "/opt/databases/mariadb/*"
     BACKUP_DIRECTORIES: "/opt/databases/mariadb:."
   volumes:
   - mariadb-data:/opt/databases/mariadb
   - rsnapshot-backups:/var/rsnapshot
volumes:
 rsnapshot-backups: 
 mariadb-data:
```