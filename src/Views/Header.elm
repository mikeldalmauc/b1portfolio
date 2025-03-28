module Views.Header exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Html exposing (Html)
import Html.Attributes as HtmlAttributes exposing (style)
import Styles exposing (..)
import Types exposing (..)
import Views.Botones exposing (..)


headerHtml : Html Msg
headerHtml =
    Html.div
        [ HtmlAttributes.class "fixed-header" ]
        [ encabezadoFijado ]


encabezadoFijado : Html Msg
encabezadoFijado =
    layout [ Background.color blanco ] <|
        row [ centerY, paddingXY 20 0, width fill, spacing 20
        --, explain Debug.todo
            ]
            [ 
            el [ htmlAttribute <| HtmlAttributes.class "bordered", padding 10] <| image [ alignLeft, height (px 20) ] { src = "assets/menu.svg", description = "Boton de menu" }
            , el
                montserratTitulo
                (text "B1 Competencia digital del profesorado")
            , image [ alignRight, paddingXY 20 0, height (px 50) ] { src = "assets/favicon.svg", description = "Logo de Mikel" }
            ]


phoneHeader : Model -> Element Msg
phoneHeader model =
    header <| sortOrderButton model


phoneHeaderBack : Model -> Element Msg
phoneHeaderBack model =
    header <| backButton model


header : Element Msg -> Element Msg
header button =
    row [ alignTop, width fill, spacing 10, height (fill |> maximum 70), Background.color blanco, paddingXY 20 0, Border.widthEach { top = 0, left = 0, bottom = 1, right = 0 }, Border.solid ]
        [ image [ paddingXY 0 0, height (px 40) ] { src = "assets/favicon.svg", description = "Logo de Mikel" }
        , el
            montserratBold
            (text "   B1 Digitalizazioa")
        , button
        ]
