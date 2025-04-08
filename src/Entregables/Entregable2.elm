module Entregables.Entregable2 exposing (..)

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
            [ Just ( Entregable2, titulo "E2" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable1C, titulo "E1C" ))
            (Just ( Entregable2A, titulo "E2A" ))
        ]


content : Dimensions -> Element msg
content d =
    column [ paddingEach { top = 20, right = 0, bottom = 20, left = 0 } ]
        [ MarkdownThemed.renderFull
            """
## 2 Contenidos Ditigales

En este vídeo se presentan las dos tipologías de contenidos digitales que se han creado para el alumnado.

- [Contenido básico](/entregable2a)
- [Contenido avanzado](/entregable2b)

"""
        , videoView d "https://www.youtube.com/embed/KD2d2vpqkSo?si=wI2hyvcu6D0lH2J0"
        ]
