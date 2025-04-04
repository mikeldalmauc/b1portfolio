module Entregables.Entregable2A exposing (..)

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
            , Just ( Entregable2A, titulo "E2A" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable2, titulo "E2" ))
            (Just ( Entregable2B, titulo "E2B" ))
        ]


content : Dimensions -> Element msg
content d =
    column [width fill, height fill, spacing 10]
        [     MarkdownThemed.renderFull
    """
# 2.A Contenido Básico

A continuación se muestra un diagrama que he enriquecido mediante la utilización de un elemento [H5P](https://h5p.org/content-types-and-applications). H5P lo componen un conjunto de componente que permiten y facilitan la definición de elemento interactivo y se puede integrar en Moodle, Drupal, Wordpress u otra web como lo hago aquí. La siguiente imagen muestra algunos ejemplos.

<br/>

![Imagen de distintos h5p](assets/2Ah5p.webp)

En mi caso he utilizado el Image Hotspots, que permite agregar puntos de interes a una imagen que he tomado de la documentación oficial de Android  se trata de un diagrama de decisión, con ejemplos de cada tipo de animación.

Es un contenido que permite una amplia visión de los casos de uso de animación y que tecnologías resuelven cada caso. Como me gusta decir, la mejor forma de resolver un problema, es haberlo resuelto antes, y tener estos conocimientos es fundamental a la hora de sentirnos seguros y tomar decisiones.

## Elige la API de animación adecuada
"""
        , el [width fill, height fill,htmlAttribute <| HtmlAttributes.id "decision-tree"] none
        , MarkdownThemed.renderFull 
    """
*Portions of this page are modifications based on work created and shared by the [Android Open Source Project](https://developers.google.com/terms/site-policies) and used according to terms described in the [Creative Commons 2.5 Attribution License](http://creativecommons.org/licenses/by/2.5/).*
"""]