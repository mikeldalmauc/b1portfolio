module Entregables.Entregable6C exposing (..)

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
            , Just ( Entregable6C, titulo "E6C" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable6B, titulo "E6B" ))
            (Just ( Entregable6D, titulo "E6D" ))
        ]


content : Dimensions -> Element msg
content d =
    wip d
