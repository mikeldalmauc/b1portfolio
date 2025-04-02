module Entregables.Entregable1 exposing (..)

import Element exposing (..)
import MarkdownThemed
import Types exposing (..)


title : String
title =
    "1 Compromiso profesional"


view : Dimensions -> Element msg
view d =
    el [] <|
        MarkdownThemed.renderFull
            """

# Titulo 1 B1 portfolio website

Esta es una web estilo SPA (Single Page Application) desarrollada en ELM. Visita la web en [mikeldalmau.uk](https://mikeldalmau.uk)
TOC

- [Titulo 1 B1 portfolio website](#titulo-1-b1-portfolio-website)
  - [Titulo 2 Ejecutar el entorno de desarrollo](#titulo-2-ejecutar-el-entorno-de-desarrollo)
    - [Titulo 3 Troubleshooting :wrench:](#titulo-3-troubleshooting-wrench)
      - [Titulo 4](#titulo-4)
  - [linea horizontal](#linea-horizontal)


## Titulo 2 Ejecutar el entorno de desarrollo 

El entorno de desarrollo utiliza un único contenedor Debian con node y elm. Para ejecutarlo es necesario tener instalado Docker y Docker Compose.


Codigo bash

```bash
docker compose up --build
docker compose up --build
docker compose up --build
```

Un vez que la imagen del contenedor esté construida y el contenedor esté en ejecución, se puede acceder a la web en la dirección http://localhost:8000. Ya no hace flata que agregues el el parametro --build, a menos que quieras reconstruir la imagen.

```bash
docker compose up
```

Es apropiado en este caso no usar el parametro `-d` ya que se necesita ver la salida de la consola para ver los mensajes de error del live server y de la compilación de elm. 


### Titulo 3 Troubleshooting :wrench:

Si tienes problemas con la descarga de paquetes de debian al construir el contenedor, en windows puedes intentar con el siguiente comando: `ipconfig /flushdns` para borrar el cache de la resolución de nombres DNS.

#### Titulo 4

- Lista 1
- Lista 2
- Lista 3
  - Sublista 2
  - Sublista 3
    - Subsublista1
    - Subsubslita2

1. Enumeracion1
2. Enumaeracion2
  1. Sub enumeración
  2. Sub enumeración

*Texto en italicas*

**Texto en negrita**
~~Strikethrough~~

![alt text](image.png)

linea horizontal

---

[enlace mdalmau](https://mikeldalmau.com)


| A | B | C |
| -- | -- | --|
| d1 | d3 | d 2 |


"""
