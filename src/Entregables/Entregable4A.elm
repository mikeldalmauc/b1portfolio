module Entregables.Entregable4A exposing (..)

import Element exposing (..)
import Entregables.Titulos exposing (..)
import Html exposing (Html, col)
import Html.Attributes as HtmlAttributes
import MarkdownThemed
import Route exposing (Route(..))
import Styles exposing (montserrat)
import Svg.Attributes exposing (fontSize)
import Types exposing (..)
import Views.ContenidosViews exposing (..)


view : Dimensions -> Element msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable4, titulo "E4" )
            , Just ( Entregable4A, titulo "E4A" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable4, titulo "E4" ))
            (Just ( Entregable4B, titulo "E4B" ))
        ]


content : Dimensions -> Element msg
content d =
    column []
        [ MarkdownThemed.renderFull
            """

# 4.1 Evaluación previa para diferenciar los niveles de conocimiento

- [Tema](#tema)
- [Evaluación previa](#evaluación-previa)


## Tema
Como tema he elegido la creación de animaciones en Android usando Kotlin. Se trata de un tema interesante y relevante en el desarrollo de interfaces, ayuda a desarrollar la creatividad y la resolucion de problemas. El prompt para un reto podría ser:

- *Una empresa de desarrollo de aplicaciones de navegación, ha solicitado crear unos controles de navegación animados para su aplicación. El objetivo es crear un joystick que mejore la experiencia del usuario y haga la navegación más intuitiva. Se espera que las animaciones sean fluidas y representen el estado del joystick fielmente.*

## Evaluación previa 

La evaluación se compone por un conjunto de preguntas que determinarán el nivel de conocimiento de los alumnos sobre las herramientas y conocimientos que requiere desarrollar un joystick.

[Evaluación previa](https://docs.google.com/forms/d/e/1FAIpQLScq1jq_qpnpoM43eEsRHCM0_vL1YwFitKAdKj3A-GJHYNhwfA/viewform?usp=dialog)

## Vídeo


"""
        , videoView d "https://www.youtube.com/embed/bLqDzeTvMA4?si=a28mboA_B6l5vBeG"
        ]
