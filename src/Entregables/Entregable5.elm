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
import Views.ContenidosViews exposing (..)


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
    wip d
