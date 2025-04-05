module Entregables.Entregable1A exposing (..)

import Element exposing (..)
import Entregables.Titulos exposing (..)
import MarkdownThemed
import Route exposing (Route(..))
import Types exposing (..)
import Views.Componentes exposing (..)


view : Dimensions -> Element msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable1, titulo "E1" )
            , Just ( Entregable1A, titulo "E1A" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable1, titulo "E1" ))
            (Just ( Entregable1B, titulo "E1B" ))
        ]


content : Dimensions -> Element msg
content d =
    let
        whatsappWidth =
            String.fromInt <|
                if d.width > 400 then
                    400

                else
                    round (toFloat d.width * 0.9)
    in
    MarkdownThemed.renderFull
        ("""

# 1.A Contexto para la comunicación

- [Correo electrónico - Gmail](#correo-electrónico---gmail)
- [Chats - Whatsapp](#chats---whatsapp)
- [Web del centro](#web-del-centro)

## Correo electrónico - Gmail

El correo electrónico es una de las herramientas principales que utilizamos en el centro para la comunicación entre el profesorado.

En nuestro caso, utilizamos **Gmail** en vez de otro proveedor por simplicidad operativa y porque utilizamos otros servicios de google como **Google Drive**.

Al tratarse de una herramienta de comunicación **asíncrona**, generalemente utilizamos el correo para:

- Comunicaciones generales a todo el profesorado por parte del equipo directivo.
- Comunicaciones generales a los profesores de un departamento por parte del jefe de departamento.
- Comunicaciones generales a los docentes de un ciclo.
- Comunicaciones individuales que no requieran de respuesta inmediata.
- Comunicaciones individuales con el alumnado.


Cómo puede apreciarse en la captura, clasifico el correo con etiquetas para tenerlo más ordenado y sea más clara la lectura.

![Captura de la bandeja de entrada de gmail en la que se ven las etiquetas de los correos.](assets/1Agmail.webp)

---

## Chats - Whatsapp 

Las chat son también una herramienta de comunicación importante en el centro, aunque no tanto como el correo electrónico. 

Dado que principalmente accedemos al **Whatsapp** mediante móvil, se trata de un medio de comunicación más intrusivo y utilizado más para **comunicaciones síncronas** y que requieran de **inmediatez o urgencia**. Por ello, se procura hacer un uso más comedido de los chats y respetando los horarios laborales siempre que es posible.

Los usos incluyen:

- Avisos al grupo del departamento; para cubrir un retraso por tráfico, cubrir una falta, profesores que se han olvidado algo, inicidencias, etc
- Comunicaciones uno a uno entre profesores.
- Cambios de última hora que requieran inmediatez en su comunicación.
- Publicación de noticias o enlaces de interes relativos al trabajo y que atañen al departamento.

A continuación, se muestra una captura del grupo de whatsapp del departamento al que pertenezco:

<img src="assets/1Awhatsapp.webp" width='"""
            ++ whatsappWidth
            ++ """'/>


---

## Web del centro

La web del centro es otro canal de comunicación que suele utilizarse para publicar eventos. Además incluye una sección privada para el profesorado donde se enlaza documentos de Drive para que estos sean más accesibles y también una herramienta para la gestion de faltas y guardias del profesorado.

![Captura de seccion de noticias de la web del centro](assets/1AWeb.webp)

---

"""
        )
