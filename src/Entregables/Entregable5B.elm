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

Supongamos que, en función del rastro digital que el contenido de profundización ofrecido a tus alumnos ha dejado en la plataforma de aprendizaje, el número de visitas que cada alumno o alumna ha necesitado para asimilar ese contenido es el siguiente
    """
        , table
        , MarkdownThemed.renderFull
            """

## Análisis de los datos

"""
        , el [ width fill, height (fill |> maximum 500), centerX, centerY ] <| Element.html chart
        , MarkdownThemed.renderFull
            """ 

"""
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
