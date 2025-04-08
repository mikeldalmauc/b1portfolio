module Entregables.Entregable3 exposing (..)

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
            [ Just ( Entregable2, titulo "E3" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable2B, titulo "E2B" ))
            (Just ( Entregable3A, titulo "E3A" ))
        ]


content : Dimensions -> Element msg
content d =
    column [ paddingEach { top = 20, right = 0, bottom = 20, left = 0 } ]
        [ MarkdownThemed.renderFull
            """
# 3 Contexto colaboraivo del alumnado

En este vídeo muestro cómo he puesto los contenidos creados a disposición del alumnado en la plataforma Moodle.

- [Contexto colaborativo del alumnao](/entregable3a)
- [Puesta a disposición](/entregable3b)

<br></br>
<br></br>
--- 
<br></br>

"""
        , videoView d "https://www.youtube.com/embed/60UrkJMkj9Q?si=bQawUGP1KJuL9BIH"
        ]
