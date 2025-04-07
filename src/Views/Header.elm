module Views.Header exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Html exposing (Html)
import Html.Attributes as HtmlAttributes exposing (style)
import Route
import Set
import Styles exposing (..)
import Types exposing (..)
import Views.Botones exposing (..)


headerHtml : Model -> Html Msg
headerHtml model =
    Html.div
        [ HtmlAttributes.class "fixed-header" ]
        [ encabezadoFijado model ]


encabezadoFijado : Model -> Html Msg
encabezadoFijado model =
    let
        dropShadowValue =
            if Set.member 532 model.hovered then
                "drop-shadow(3px 3px 0px black)"

            else
                "none"

        onCliclMenu =
            if model.menuVisible == Visible then
                Events.onClick CloseMenu

            else
                Events.onClick OpenMenu
    in
    layout [ Background.color blanco ] <|
        row
            [ centerY
            , paddingXY 20 0
            , width fill
            , spacing 20

            --, explain Debug.todo
            ]
            [ el
                [ onCliclMenu
                , htmlAttribute <| HtmlAttributes.class "bordered"
                , padding 10
                ]
              <|
                image [ alignLeft, height (px 20) ] { src = "assets/menu.svg", description = "Boton de menu" }
            , el
                montserratTitulo
                (text "B1 Competencia digital del profesorado")
            , image
                [ alignRight
                , paddingXY 20 0
                , height (px 50)
                , inFront <|
                    Element.link
                        [ width fill, height fill ]
                        { url = Route.encode Route.HomepageRoute
                        , label = el [ alpha 0.0 ] (text "Inicio")
                        }
                , Events.onMouseEnter (HoverOn 532)
                , Events.onMouseLeave (HoverOff 532)
                , htmlAttribute (HtmlAttributes.style "filter" dropShadowValue)
                ]
                { src =
                    if model.route == Route.HomepageRoute then
                        "assets/favicon.svg"

                    else
                        "assets/esquema.webp"
                , description = "Logo de Mikel"
                }
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
