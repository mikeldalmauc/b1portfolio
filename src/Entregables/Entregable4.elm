module Entregables.Entregable4 exposing (..)

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
            [ Just ( Entregable3, titulo "E4" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable3B, titulo "E3B" ))
            (Just ( Entregable4A, titulo "E4A" ))
        ]


content : Dimensions -> Element msg
content d =
    column [ paddingEach { top = 20, right = 0, bottom = 20, left = 0 } ]
        [ MarkdownThemed.renderFull
            """
## 4 Evaluación y Feedback

En este vídeo se muestra

- [Actividad 4A: Evaluación Previa](/entregable4a)
- [Actividad 4B: Evaluación Formativa](/entregable4b)
- [Actividad 4C: Retroalimentación ](/entregable4c)

<br></br>
<br></br>
--- 
<br></br>

"""
        , videoView d "https://www.youtube.com/embed/IkdFbLRZMNs?si=vUKlzMbZBIi9W-a"
        ]
