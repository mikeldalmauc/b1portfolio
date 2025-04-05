module Entregables.Entregable1C exposing (..)

import Element exposing (..)
import Entregables.Titulos exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttributes
import MarkdownThemed
import Route exposing (Route(..))
import Types exposing (..)
import Views.Componentes exposing (..)


view : Dimensions -> Element msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable1, titulo "E1" )
            , Just ( Entregable1B, titulo "E1C" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable1A, titulo "E1B" ))
            (Just ( Entregable2, titulo "E2" ))
        ]


content : Dimensions -> Element msg
content d =
    MarkdownThemed.renderFull
        """

# 1.C Normas de netiqueta

![infografia netiqueta](assets/1CInfografia.svg)

"""
