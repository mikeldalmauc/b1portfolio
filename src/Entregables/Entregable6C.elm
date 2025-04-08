module Entregables.Entregable6C exposing (..)

import Element exposing (..)
import Entregables.Titulos exposing (..)
import Html exposing (Html, col)
import Html.Attributes as HtmlAttributes
import MarkdownThemed
import Route exposing (Route(..))
import Styles exposing (montserrat)
import Svg.Attributes exposing (fontSize)
import Types exposing (..)
import Views.Componentes exposing (..)


view : Dimensions -> Element msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable6, titulo "E6" )
            , Just ( Entregable6C, titulo "E6C" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable6B, titulo "E6B" ))
            (Just ( Entregable6D, titulo "E6D" ))
        ]


content : Dimensions -> Element msg
content d =
    MarkdownThemed.renderFull
        """ 
# 6.C Desarrollo de contenidos digitales

![Gente creando contenido digital.](assets/6Ccontent.webp)

- [Actividad. Creacion de contenido digital](#actividad-creacion-de-contenido-digital)
- [1. Competencia](#1-competencia)
- [2. Herramientas y recursos necesarios](#2-herramientas-y-recursos-necesarios)
- [3. Descripción de la actividad](#3-descripcion-de-la-actividad)
- [3.1. Inspiración y diseño](#31-inspiracion-y-diseño)
- [3.2. Creación y publicación](#32-creacion-y-publicacion)
- [4. Evidencias](#4-evidencias)
- [5. Indicadores de logro](#5-indicadores-de-logro)


<br></br>
<br></br>

## Actividad. Creacion de contenido digital
Esta actividad se puede realizar en dos sesiones de 2 horas. Está diseñada para fomentar la creación de contenido digital interactivo a partir de un tema, los alumnos tendrán libertad para elegir el tipo de formato (presentación, vídeo, mapa conceptual, gráfico…). Se trabajará la síntesis, la creatividad y la capacidad de comunicar con claridad temas complejos.
La actividad está diseñada para ser desarrollada a mitad del itinerario formativo, cuando el alumnado va comenzar a cerar el contenido.
---
<br></br>
<br></br>
<br></br>
### 1. Competencia

La competencia que se trabajará será:  
*"Crear y compartir contenidos digitales originales en diferentes formatos (presentaciones, gráficos, mapas conceptuales, vídeos…) que sean adecuados, claros y adaptados al propósito comunicativo."*

El nivel en el que se trabajará será **medio**, con especial atención a la organización, diseño visual y claridad en la transmisión de información técnica.

### 2. Herramientas y recursos necesarios

- **OBS Studio**: para grabar vídeos breves con voz.
- **Excalidraw, Canva, Genially, ...**: Para diseñanr, para esquemas o mapas conceptuales, o contenido interactivo.
- **Moodle**: Para entregar la tarea y ver ejemplos.
- **GitHub o YouTube**: Publicación del contenido digital creado.
- **VSCode + Markdown**: Para documentar el proceso o enlazar contenidos.

### 3. Descripcion de la actividad

#### 3.1. Inspiracion y diseño

1. Presentación interactiva inicial con ejemplos de contenidos visuales atractivos y eficaces: mapas, vídeos cortos, infografías, guías técnicas, etc.

2. Reflexionamos con los alumnos sobre la presentación:
   - ¿Qué hace que un contenido técnico sea aburrido?
   - ¿Cómo podemos explicar algo técnico de forma visual y atractiva?

3. Se propone a cada alumno/a que elija uno de los siguientes temas técnicos que ya han trabajado en clase (o estén trabajando).

4. Cada alumno/a elige un formato para el contenido digital que va a crear:
   - Mapa conceptual visual.
   - Presentación tipo carrusel.
   - Mini vídeo explicativo (máx. 3 minutos).
   - Infografía o cartel digital.
   - 
5. Se da un tiempo de 90 minutos para diseñar un borrador del contenido en la herramienta elegida. Puede ser individual o en parejas si se prefiere trabajo cooperativo.

6. Se hace una **revisión cruzada rápida** entre compañeros/as:  
   - ¿Se entiende bien?
   - ¿Es atractivo visualmente?
   - ¿Falta algo esencial?
  
#### 3.2. Creacion y publicacion

1. Los alumnos dedican alrededor de una hora y media a terminar el contenido digital.
2. Cada alumno/a publica su contenido en el formato elegido (GitHub, YouTube, Genially, etc.) y de forma que el resto de la clase tenga acceso libre a el.
3. Se publica un enlace al contenido en Moodle.

### 4. Evidencias

Esta tarea se evidenciará mediante la publicación de un enlace funcional al Moodle.

### 5. Indicadores de logro

1. El contenido es comprensible, bien estructurado y visualmente atractivo.
2. Se adapta al formato elegido y se entiende sin necesidad de explicación adicional.
3. La información técnica es precisa y adecuada al nivel.
4. Se utilizan recursos gráficos, texto y voz de forma equilibrada.
"""
