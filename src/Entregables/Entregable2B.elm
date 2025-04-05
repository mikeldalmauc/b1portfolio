module Entregables.Entregable2B exposing (..)

import Browser.Events as BrowserEvents
import Element exposing (..)
import Element.Events as Events
import Entregables.Titulos exposing (..)
import Html exposing (Html, col)
import Html.Attributes as HtmlAttributes
import MarkdownThemed
import Route exposing (Route(..))
import Styles exposing (montserrat)
import Svg.Attributes exposing (fontSize)
import Types exposing (..)
import Views.Componentes exposing (..)
import Views.Modal as Modal


view : Dimensions -> Element Msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable2, titulo "E2" )
            , Just ( Entregable2B, titulo "E2B" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable2A, titulo "E2A" ))
            (Just ( Entregable3, titulo "E3" ))
        ]


content : Dimensions -> Element Msg
content d =
    column
        [ width fill, height fill, spacing 10 ]
        [ MarkdownThemed.renderFull
            """
# 2.A Contenido Avanzado

A continuación se muestra un diagrama que he enriquecido mediante la utilización de un elemento [H5P](https://h5p.org/content-types-and-applications). 

En este caso he utilizado el Image Hotspots, que permite agregar puntos de interes a una imagen que he tomado de la documentación oficial de Android  se trata de un diagrama de decisión, con ejemplos de cada tipo de animación.

Es un contenido más avanzado y que permite una amplia visión de los casos de uso de animación y que tecnologías resuelven cada caso. Como me gusta decir, la mejor forma de resolver un problema, es haberlo resuelto antes, y tener estos conocimientos es fundamental a la hora de sentirnos seguros y tomar decisiones.

## Elige la API de animación adecuada
"""
        , image
            [ alignRight
            , paddingXY 20 0
            , height (px 30)
            , Events.onClick (OpenModal "diagramaEngrande")
            ]
            { src = "assets/fullscreen.svg", description = "Icono para ampliar diagrama." }
        , el [ width fill, height fill, htmlAttribute <| HtmlAttributes.id "decision-tree" ] none
        , MarkdownThemed.renderFull
            """
*Portions of this page are modifications based on work created and shared by the [Android Open Source Project](https://developers.google.com/terms/site-policies) and used according to terms described in the [Creative Commons 2.5 Attribution License](http://creativecommons.org/licenses/by/2.5/).*
"""
        ]


diagramaEngrande : Element msg
diagramaEngrande =
    el [ width fill, height fill, htmlAttribute <| HtmlAttributes.id "decision-tree" ] none
