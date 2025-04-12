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
import Views.Componentes exposing (..)


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
    column [ paddingEach { top = 20, right = 0, bottom = 20, left = 0 } ]
        [ MarkdownThemed.renderFull
            """
## 6 Trabajando con el alumnado

En este vídeo se muestra que actividades propongo para trabajar con el alumnado las siguientes dimensiones de la competencia digital enfocado a alumnos del grado de multiplataforma.

- [Actividad 6A: Búsquedas eficaces](/entregable6a)
- [Actividad 6B: Definición de normas de comportamiento](/entregable6b)
- [Actividad 6C: Desarrollo de contenidos digitales](/entregable6c)
- [Actividad 6D: Uso responsable](/entregable6d)
- [Actividad 6E: Resolución de problemas digitales](/entregable6e)

<br></br>
<br></br>
--- 
<br></br>

"""
        , videoView d "https://www.youtube.com/embed/zXWcOIMMTJw?si=6m5Fplmbm-poLbe_"
        ]
