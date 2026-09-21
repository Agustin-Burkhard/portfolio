# Linux Labs

Prácticas realizadas en Linux orientadas a administración básica del sistema, gestión de permisos, control de acceso, configuración del entorno Bash y uso de herramientas de línea de comandos.

Las prácticas fueron realizadas principalmente sobre CentOS en un entorno virtualizado.

---

## 1. Permisos y permisos especiales

### Permisos de archivos

Se creó el archivo `script.sh` y se configuraron sus permisos utilizando notación simbólica y octal.

Notación simbólica:

```bash
chmod u=rwx,g=rx,o=rx script.sh
```

Notación octal:

```bash
chmod 755 script.sh
```

En ambos casos el resultado fue:

```text
-rwxr-xr-x
```

Esto representa:

- Propietario: lectura, escritura y ejecución (`rwx`)
- Grupo: lectura y ejecución (`r-x`)
- Otros: lectura y ejecución (`r-x`)

![Configuración de permisos](images/permisos.png)

### Sticky bit

Se creó el directorio `shareall` y se configuró el sticky bit:

```bash
mkdir shareall
chmod 1777 shareall
```

El sticky bit permite utilizar un directorio compartido limitando la eliminación de archivos según su propietario.

### Inmutabilidad

Se creó el directorio `/mnt/windows` y se aplicó el atributo inmutable:

```bash
chattr +i /mnt/windows
```

La configuración se verificó mediante:

```bash
lsattr
```

![Sticky bit e inmutabilidad](images/sticky-inmutabilidad.png)

---

## 2. Permisos específicos y herencia mediante ACL

Se trabajó con Access Control Lists (ACL) para asignar permisos adicionales a usuarios y grupos.

El directorio `/proyecto` fue configurado con `a_burkhard` como propietario y `root` como grupo:

```bash
chown a_burkhard:root /proyecto
```

Se otorgaron permisos específicos al grupo `devs` y al usuario `auditoria`:

```bash
setfacl -m g:devs:rwx /proyecto
setfacl -m u:auditoria:rx /proyecto
```

Luego se configuraron ACL por defecto para que los nuevos archivos y directorios creados dentro de `/proyecto` heredaran estos permisos:

```bash
setfacl -d -m g:devs:rwx /proyecto
setfacl -d -m u:auditoria:rx /proyecto
```

La configuración fue verificada mediante:

```bash
getfacl /proyecto
```

Resultado:

- `a_burkhard`: propietario del directorio.
- `root`: grupo propietario.
- Grupo `devs`: permisos `rwx`.
- Usuario `auditoria`: permisos `r-x`.
- ACL por defecto configuradas para los nuevos archivos y directorios.

![Configuración de ACL](images/acl.png)

---

## 3. Configuración y mantenimiento básico de una estación Linux

### Objetivo

Configurar un sistema CentOS como estación de trabajo, aplicando personalización del entorno Bash, actualización del sistema, instalación de herramientas adicionales y validación de su funcionamiento.

### Personalización de Bash

Se configuraron aliases personalizados dentro de `.bashrc` para agilizar tareas frecuentes desde la terminal.

Ejemplos:

```bash
alias docs='cd ~/Documents'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -l'
alias ..='cd ..'
alias repo='cd /repo'
```

Después de modificar `.bashrc`, se aplicaron los cambios al entorno.

![Configuración de Bash](images/bashrc.png)

### Actualización del sistema

Se actualizaron los paquetes instalados utilizando el gestor de paquetes de CentOS:

```bash
dnf upgrade -y
```

![Actualización del sistema](images/dnf-upgrade.png)

### Instalación de herramientas

Se instalaron herramientas adicionales mediante `dnf`.

Como prueba de funcionamiento se utilizó Nmap para realizar un escaneo sobre `localhost`:

```bash
nmap localhost
```

El escaneo permitió comprobar que la herramienta estaba correctamente instalada y detectar los servicios disponibles localmente.

![Escaneo de localhost con Nmap](images/nmap-localhost.png)

### Resultado

Se personalizó el entorno de trabajo mediante aliases y configuración de Bash, se actualizó el sistema, se incorporaron herramientas adicionales y se verificó el funcionamiento de Nmap mediante un escaneo local.

Estas tareas permiten practicar operaciones básicas relacionadas con administración de sistemas, redes y ciberseguridad.

---

## 4. Redirecciones, pipes y filtros

Se realizaron ejercicios de procesamiento y automatización desde la terminal utilizando comandos encadenados.

### Manejo de nombres con espacios

Se utilizó `find` junto con `xargs` para trabajar con archivos cuyos nombres contienen espacios.

![Find y xargs](images/find-xargs.png)

### Análisis de un archivo CSV

Se utilizaron pipes para encadenar distintos comandos y obtener la frecuencia de valores dentro de un archivo CSV:

```bash
cut -d ',' -f2 visitas.csv | sort | uniq -c | sort -rn
```

El pipeline:

1. selecciona una columna del archivo;
2. ordena sus valores;
3. cuenta las repeticiones;
4. ordena los resultados por frecuencia.

![Análisis de CSV mediante pipes](images/pipes-csv.png)

### Automatización con un bucle `for`

Se utilizó un bucle para generar múltiples archivos desde la terminal.

```bash
for numero in {1..9}; do
    cp disk.vdi disco-$numero.vdi
done
```

![Automatización con for](images/for-loop.png)

---

## Herramientas y conceptos utilizados

- CentOS
- Bash
- Permisos Linux
- `chmod`
- `chown`
- Sticky bit
- `chattr` / `lsattr`
- ACL (`setfacl` / `getfacl`)
- `.bashrc`
- `dnf`
- Nmap
- `find`
- `xargs`
- `cut`
- `sort`
- `uniq`
- Pipes
- Bucles `for`

---

## Aprendizajes

Estas prácticas permitieron trabajar con tareas fundamentales de administración Linux:

- interpretar y modificar permisos;
- configurar permisos específicos mediante ACL;
- aplicar herencia de permisos;
- personalizar el entorno Bash;
- mantener y actualizar paquetes;
- instalar y validar herramientas;
- procesar información utilizando pipes y filtros;
- automatizar tareas sencillas desde la terminal.
