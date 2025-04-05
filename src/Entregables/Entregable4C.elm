module Entregables.Entregable4C exposing (..)

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
            [ Just ( Entregable4, titulo "E4" )
            , Just ( Entregable4C, titulo "E4C" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable4B, titulo "E4B" ))
            (Just ( Entregable5, titulo "E5" ))
        ]


content : Dimensions -> Element msg
content d =
    wip d
