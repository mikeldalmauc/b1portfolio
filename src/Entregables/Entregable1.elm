module Entregables.Entregable1 exposing (..)

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
            [ Just ( Entregable1, titulo "E1" )
            ]
        , content d
        , footerNavigation d
            (Just ( HomepageRoute, titulo "Esquema" ))
            (Just ( Entregable1A, titulo "E1A" ))
        ]


content : Dimensions -> Element msg
content d =
    column [ paddingEach { top = 20, right = 0, bottom = 20, left = 0 } ]
        [ MarkdownThemed.renderFull
            """
# 1. Entrega. Contexto colaborativo del equipo docente 🚀

En este vídeo se muestra el portfolio y los tres entregables correspondientes al contexto colaborativo del equipo docente.

--- 

<br/>
<br/>
<br/>
"""
        , videoView d "https://www.youtube.com/embed/a4ljkcniF4U?si=GBCfKhfEx-MxMFJ9"
        ]
