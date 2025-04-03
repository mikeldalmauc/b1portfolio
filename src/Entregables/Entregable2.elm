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
import Views.ContenidosViews exposing (..)


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
    wip d
