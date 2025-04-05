module Entregables.Entregable6A exposing (..)

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
            , Just ( Entregable6A, titulo "E6A" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable6, titulo "E6" ))
            (Just ( Entregable6B, titulo "E6B" ))
        ]


content : Dimensions -> Element msg
content d =
    wip d
