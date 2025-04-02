module Entregables.Entregable6 exposing (..)

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
            [ Just ( Entregable6, titulo "E6" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable5B, titulo "E5B" ))
            (Just ( Entregable6A, titulo "E6A" ))
        ]


content : Dimensions -> Element msg
content d =
    wip d
