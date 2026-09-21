# Network Infrastructure Design

Diseño de infraestructura de red para una empresa, desarrollado como práctica de redes.

El proyecto incluye el diseño de la topología física y lógica, segmentación IPv4 mediante subnetting, asignación de direccionamiento, routing entre redes, publicación de servicios y selección de medios de transmisión.

La infraestructura fue diseñada y simulada utilizando Cisco Packet Tracer.

---

## 1. Diseño de la topología física

Se diseñó una infraestructura centralizada utilizando la **Sala de Servidores como núcleo de la red**, desde donde se distribuyen las conexiones hacia los distintos sectores de la empresa:

- Administración
- Ventas
- Sala de Reuniones
- Otros
- Depósito
- Sala de Servidores

Administración y Ventas cuentan con switches de 24 puertos para permitir crecimiento futuro.

Ventas, Sala de Reuniones y Otros incorporan Access Points para proporcionar conectividad inalámbrica.

En la Sala de Servidores se concentran los servidores Web y FTP, además del equipamiento principal encargado de interconectar las distintas redes.

También se contempla la conexión hacia una red pública mediante router y firewall.

![Topología física](images/topologia-fisica.png)

---

## 2. Segmentación y direccionamiento IPv4

La red fue dividida en distintas subredes para separar lógicamente cada sector de la organización.

Las subredes fueron dimensionadas de acuerdo con la cantidad estimada de dispositivos, utilizando diferentes prefijos para aprovechar de forma eficiente el espacio de direccionamiento disponible.

| Sector             | Red           | Prefijo | Hosts utilizables |
| ------------------ | ------------- | ------: | ----------------: |
| Administración     | 192.168.10.0  |     /27 |                30 |
| Ventas             | 192.168.10.32 |     /28 |                14 |
| Sala de Servidores | 192.168.10.48 |     /28 |                14 |
| Sala de Reuniones  | 192.168.10.64 |     /29 |                 6 |
| Otros              | 192.168.10.72 |     /29 |                 6 |
| Depósito           | 192.168.10.80 |     /29 |                 6 |

Administración utiliza una red `/27` debido a su crecimiento previsto.

Ventas y Sala de Servidores utilizan redes `/28`, mientras que Sala de Reuniones, Otros y Depósito utilizan redes `/29`.

Esto permite mantener cada área separada lógicamente y asignar a cada sector una cantidad de direcciones acorde con sus necesidades.

![Segmentación IPv4](images/segmentacion-ipv4.png)

---

## 3. Asignación de direcciones estáticas

Se utilizaron direcciones IP estáticas para aquellos dispositivos que requieren mantener una dirección conocida para su administración o para proporcionar servicios dentro de la red.

Entre ellos se encuentran:

- Servidores
- Impresoras
- Access Points
- Switches

Los equipos de usuario final pueden utilizar direccionamiento dinámico mediante DHCP.

### Administración — 192.168.10.0/27

Rango utilizable:

```text
192.168.10.1 - 192.168.10.30
```

Asignaciones:

```text
Impresora Administración → 192.168.10.2
Switch Administración    → 192.168.10.3
```

### Ventas — 192.168.10.32/28

Rango utilizable:

```text
192.168.10.33 - 192.168.10.46
```

Asignaciones:

```text
Impresora Ventas → 192.168.10.34
Access Point     → 192.168.10.35
Switch Ventas    → 192.168.10.36
```

### Sala de Servidores — 192.168.10.48/28

Rango utilizable:

```text
192.168.10.49 - 192.168.10.62
```

Asignaciones:

```text
Servidor Web     → 192.168.10.50
Servidor FTP     → 192.168.10.51
Switch Servidores → 192.168.10.52
```

### Sala de Reuniones — 192.168.10.64/29

Rango utilizable:

```text
192.168.10.65 - 192.168.10.70
```

Asignación:

```text
Access Point → 192.168.10.66
```

### Otros — 192.168.10.72/29

Rango utilizable:

```text
192.168.10.73 - 192.168.10.78
```

Asignaciones:

```text
Access Point → 192.168.10.74
Switch       → 192.168.10.75
```

### Depósito — 192.168.10.80/29

Rango utilizable:

```text
192.168.10.81 - 192.168.10.86
```

Asignaciones:

```text
Impresora → 192.168.10.82
Switch    → 192.168.10.83
```

![Direccionamiento](images/direccionamiento.png)

---

## 4. Routing y gateways

Se incorporó un **Router Core** encargado de interconectar las diferentes subredes internas.

Cada sector utiliza como gateway la primera dirección IP utilizable de su respectiva subred.

El Router Core se conecta con un router de borde mediante una subred `/30`, destinada específicamente al enlace punto a punto entre ambos dispositivos.

### Enlace Router Core ↔ Router de borde

```text
Red:              192.168.10.88/30
Router Core:      192.168.10.89
Router de borde:  192.168.10.90
Broadcast:        192.168.10.91
```

El router de borde mantiene posteriormente la conexión hacia el firewall y la salida a Internet.

![Routing](images/routing.png)

---

## 5. Publicación de servicios

Dentro de la Sala de Servidores se configuraron servicios Web y FTP.

Para representar su publicación hacia Internet se definieron las siguientes reglas de redirección de puertos:

| Servicio | Protocolo/Puerto | Destino           |
| -------- | ---------------- | ----------------- |
| HTTP     | TCP 80           | 192.168.10.50:80  |
| HTTPS    | TCP 443          | 192.168.10.50:443 |
| FTP      | TCP 21           | 192.168.10.51:21  |

De esta forma, las conexiones destinadas a esos servicios pueden ser dirigidas hacia los servidores correspondientes dentro de la red interna.

![Servicios](images/servicios.png)

---

## 6. Selección de medios

Para las conexiones internas ubicadas a distancias inferiores a 100 metros se seleccionó **cable UTP categoría 6 (Cat 6)**.

Este medio se utiliza para conectar:

- PCs
- Impresoras
- Access Points
- Switches
- Servidores

Para el enlace hacia **Depósito**, ubicado aproximadamente a 150 metros del núcleo de la red, se seleccionó **fibra óptica**.

La distancia supera el alcance recomendado para enlaces Ethernet sobre cobre, por lo que la fibra permite mantener una conexión estable y proporciona mayor capacidad para el backbone.

### Medios utilizados

```text
Cat 6
└── Conexiones internas de los sectores cercanos

Fibra óptica
└── Backbone entre la red principal y Depósito
```

La selección de los medios tuvo en cuenta:

- Distancia entre dispositivos
- Capacidad necesaria
- Crecimiento futuro
- Estabilidad de la conexión
- Función del enlace dentro de la infraestructura

![Medios de red](images/medios-red.png)

---

## 7. Inventario de infraestructura

Se elaboró un inventario con los dispositivos y medios necesarios para implementar la infraestructura propuesta.

![Inventario de infraestructura](images/inventario.png)

---

## Tecnologías y conceptos utilizados

- Cisco Packet Tracer
- IPv4
- Subnetting
- VLSM
- Routing
- Default Gateway
- LAN / WAN
- TCP/IP
- HTTP / HTTPS
- FTP
- Port Forwarding
- DHCP
- Ethernet
- Cat 6
- Fibra óptica
- Switching
- Access Points
- Firewall
- Diseño de topologías de red

---

## Aprendizajes

Este proyecto permitió aplicar conceptos fundamentales de redes en el diseño de una infraestructura empresarial.

Durante la práctica se trabajó en:

- Diseño de una topología física y lógica.
- División de una red IPv4 utilizando subnetting.
- Dimensionamiento de subredes según cantidad de hosts.
- Identificación de dirección de red, rango utilizable y broadcast.
- Asignación de direcciones estáticas a dispositivos de infraestructura.
- Definición de gateways para diferentes segmentos.
- Diseño de un enlace punto a punto utilizando una subred `/30`.
- Planificación de servicios internos y publicación mediante puertos TCP.
- Selección del medio físico según distancia y función del enlace.
- Organización de una infraestructura de red con posibilidad de crecimiento futuro.
