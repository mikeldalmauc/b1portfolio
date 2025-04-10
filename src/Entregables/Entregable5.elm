module Entregables.Entregable5 exposing (..)

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
            [ Just ( Entregable3, titulo "E5" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable4C, titulo "E4C" ))
            (Just ( Entregable5A, titulo "E5A" ))
        ]


content : Dimensions -> Element msg
content d =
    column [ paddingEach { top = 20, right = 0, bottom = 20, left = 0 } ]
        [ MarkdownThemed.renderFull
            """
## 5 Empoderando al alumnado

En este vídeo se presentan las medidas de accesibilidad y personalización que se han implementado en los contenidos digitales para el alumnado.

- [Accesibilidad de los contenidos digitales](/entregable5a)
- [Personalización del aprendizaje en base al rastro digital](/entregable5b)

<br></br>
<br></br>
--- 
<br></br>

"""
        , videoView d "https://www.youtube.com/embed/IkdFbLRZMNs?si=vUKlzMbZBIi9W-a"
        ]
