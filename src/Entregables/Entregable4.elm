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
import Views.ContenidosViews exposing (..)


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
    wip d
