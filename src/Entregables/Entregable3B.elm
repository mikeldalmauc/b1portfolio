module Entregables.Entregable3B exposing (..)

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
            [ Just ( Entregable3, titulo "E3" )
            , Just ( Entregable3B, titulo "E3B" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable3A, titulo "E3A" ))
            (Just ( Entregable4, titulo "E4" ))
        ]


content : Dimensions -> Element msg
content d =
    wip d
