module Entregables.Entregable5B exposing (..)

import Chart as C
import Chart.Attributes as CA
import Chart.Events as CE
import Chart.Item as CI
import Dict exposing (Dict)
import Element exposing (..)
import Element.Font as Font
import Entregables.Titulos exposing (..)
import Html exposing (Html, col)
import Html.Attributes as HtmlAttributes
import MarkdownThemed
import Route exposing (Route(..))
import String exposing (fromInt)
import Styles exposing (montserrat)
import Svg as S
import Svg.Attributes exposing (fontSize)
import Types exposing (..)
import Views.Componentes exposing (..)


view : Dimensions -> Element msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable5, titulo "E5" )
            , Just ( Entregable5B, titulo "E5B" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable5A, titulo "E5A" ))
            (Just ( Entregable6, titulo "E6" ))
        ]


content : Dimensions -> Element msg
content d =
    column []
        [ MarkdownThemed.renderFull
            """
# 5.B Personalización del aprendizaje en base al rastro digital

- [Introducción](#introducción)
- [Análisis de los datos](#analisis-de-los-datos)
- [Propuesta de aprendizaje adaptada](#propuesta-de-aprendizaje-adaptada)

## Introducción

Supongamos que, en función del rastro digital que el contenido de profundización ofrecido a tus alumnos ha dejado en la plataforma de aprendizaje, el número de visitas que cada alumno o alumna ha necesitado para asimilar ese contenido es el siguiente.
    """
        , table
        , MarkdownThemed.renderFull
            """
## Analisis de los datos

A simple vista podemos ver que hay un alumno que ha necesitado 42 visitas para asimilar el contenido, lo que nos indica que ha tenido problemas para entenderl o un error en la plataforma de aprendizaje.

La mayoria de alumnos han necesitado entre 2 y 5 visitas para asimilar el contenido, lo que nos indica que el contenido es adecuado y ha sido bien diseñado. Sin embargo, 4 han superado la decena, lo que supone un 20 % de la clse.

Por lo tanto, la clase estaría dividida en 2 grupos generales en una proporción de 80% y 20% y una diferencia de velocidad considerable entre ellos.

- **Grupo A:** 2-5 visitas, 80% de la clase.
- **Grupo B:** 6-15 visitas, 20% de la clase, velocidad 3 veces menor que el grupo 1.
- **Grupo C:** 42 visitas, 1 alumno/a, velocidad 21 veces menor que el grupo 1. Puede ser un error o un alumno con problemas de aprendizaje.

## Propuesta de aprendizaje adaptada

Teniendo en cuenta los datos analizados, la mayoría de la clase puede emprender tareas más autónomas,menos guiadas, y más autoevaluadas, mientras que el grupo B necesita un ritmo más lento por lo que es posible que requieran de contenido más guiado e interactivo.

- **Grupo A:** Avance autónomo y autoevaluación continua, foro, insignias y logros, mini proyectos de desarrollo.
- **Grupo B:** Avance más guiado, enfocado a microlecciones y aumento del feedback instantaneo.
- **Grupo C:** Tutoría individualizada, seguimiento y apoyo continuo.

Entonces, podríamos adaptar el contenido de la siguiente manera:

- **Contenido Básico:** Aumentar el número de microlecciones y aumentar el numero de componentes de feedback instantáneo. Tal vez crear una especie de recorrido visual, como el viaje del héroe, donde el alumno/a pueda ver su progreso y los pasos que le quedan por completar.

- **Contenido Avanzado:** Añadir propuestas de mini-proyectos de desarrollo, donde el alumno/a pueda elegir entre diferentes opciones y avanzar a su ritmo. Mostrar otros contenidos de interes sobre el tema, integraciones, frameworks, proyectos, etc. que puedan ser de su interés y que le ayuden a avanzar en su aprendizaje.
"""

        ---  , el [ width fill, height (fill |> maximum 500), centerX, centerY ] <| Element.html chart
        ]


type alias Row =
    { num : Float
    , visitas : Float
    }


rows : List Row
rows =
    [ { num = 1.0, visitas = 2.0 }
    , { num = 2.0, visitas = 5.0 }
    , { num = 3.0, visitas = 2.0 }
    , { num = 4.0, visitas = 2.0 }
    , { num = 5.0, visitas = 2.0 }
    , { num = 6.0, visitas = 15.0 }
    , { num = 7.0, visitas = 5.0 }
    , { num = 8.0, visitas = 3.0 }
    , { num = 9.0, visitas = 4.0 }
    , { num = 10.0, visitas = 3.0 }
    , { num = 11.0, visitas = 42.0 }
    , { num = 12.0, visitas = 10.0 }
    , { num = 13.0, visitas = 2.0 }
    , { num = 14.0, visitas = 2.0 }
    , { num = 15.0, visitas = 2.0 }
    , { num = 16.0, visitas = 2.0 }
    , { num = 17.0, visitas = 2.0 }
    , { num = 18.0, visitas = 4.0 }
    , { num = 19.0, visitas = 2.0 }
    , { num = 20.0, visitas = 2.0 }
    , { num = 21.0, visitas = 3.0 }
    , { num = 22.0, visitas = 2.0 }
    , { num = 23.0, visitas = 3.0 }
    , { num = 24.0, visitas = 11.0 }
    , { num = 25.0, visitas = 6.0 }
    ]


headerRow : Element msg
headerRow =
    row [ spacing 16 ]
        [ el [ width (px 100), Font.bold ] (text "Alumno/a")
        , el [ width (px 40), Font.bold ] (text "Nº")
        , el [ width (px 60), Font.bold ] (text "Visitas")
        ]


rowView : Row -> Element msg
rowView r =
    row [ spacing 16 ]
        [ el [ width (px 100) ] (text "Alumno/a")
        , el [ width (px 40) ] (text (String.fromInt (round r.num)))
        , el [ width (px 60) ]
            (text (String.fromInt (round r.visitas)))
        ]


table : Element msg
table =
    column [ spacing 8, padding 16 ]
        (headerRow :: List.map rowView rows)


type alias VisitGroup =
    { visitas : Float
    , alumnos : Float
    }


groupedVisits : List Row -> List VisitGroup
groupedVisits rs =
    let
        filledDict =
            Dict.fromList <|
                List.indexedMap (\i zero -> ( toFloat i, toFloat zero )) <|
                    List.repeat 0 24
    in
    rs
        |> List.foldl
            (\r acc ->
                Dict.update r.visitas
                    (\maybeCount ->
                        Just <| Maybe.withDefault 0.0 maybeCount + 1.0
                    )
                    acc
            )
            filledDict
        |> Dict.toList
        |> List.map (\( k, v ) -> { visitas = k, alumnos = v })


chart : Html.Html msg
chart =
    let
        groups =
            groupedVisits rows
    in
    C.chart
        [ CA.height 300
        , CA.width 300
        , CA.range
            [ CA.lowest 0 CA.exactly

            -- Makes sure that your x-axis begins at -5 or lower, no matter
            -- what your data is like.
            , CA.highest 45 CA.exactly

            -- Makes sure that your x-axis ends at 10 or higher, no matter
            -- what your data is like.
            ]
        ]
        [ C.xLabels [ CA.amount 13, CA.fontSize 12 ]
        , C.yLabels [ CA.amount 8, CA.withGrid, CA.fontSize 12 ]
        , C.bars
            []
            [ C.bar .y [ CA.gradient [ CA.purple, CA.pink ] ]
            ]
          <|
            List.map (\v -> { x = v.visitas, y = v.alumnos }) groups
        ]
