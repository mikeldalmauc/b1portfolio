module Entregables.Entregable1B exposing (..)

import Element exposing (..)
import Entregables.Titulos exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttributes
import MarkdownThemed
import Route exposing (Route(..))
import Types exposing (..)
import Views.ContenidosViews exposing (..)


view : Dimensions -> Element msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable1, titulo "E1" )
            , Just ( Entregable1B, titulo "E1B" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable1A, titulo "E1A" ))
            (Just ( Entregable1C, titulo "E1C" ))
        ]


content : Dimensions -> Element msg
content d =
    let
        whatsappWidth =
            String.fromInt <|
                if d.width > 600 then
                    600

                else
                    round (toFloat d.width * 0.9)
    in
    MarkdownThemed.renderFull
        """

# 1.B Contexto de colaboración

- [Nube - Google Drive](#nube---google-drive)
- [Cuaderno del profesor](#cuaderno-del-profesor)

## Nube - Google Drive

En el centro, la herramienta que utilizamos como sistema de información y colaboración es **Google Drive**. 

Aquí, toda la información está disponible y clasificada para que el profesorado pueda acceder y coordinarse gracias a los documentos que se actualizan en vivo y al momento. 

![Captura de google drive](assets/1BDrive.webp)

## Cuaderno del profesor

Estos cuadernos son **fundamentales para la colaboración del equipo docente** y se alojan en la nube para manterse actualizados y sincronizados.

Los cuadernos se crean a nivel de modulo y por retos e incluyen aspectos como rúbricas, seguimiento de faltas, planificaciones, horarios, calificaciones, agrupamiento del alumnado etc

![alt text](assets/1BCuaderno.webp)

--- 

"""
