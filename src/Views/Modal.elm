module Views.Modal exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Html exposing (Html, div)
import Html.Attributes as HtmlAttributes exposing (style)
import Html.Events exposing (onClick, stopPropagationOn)
import Json.Decode as Decode
import Route
import Set exposing (Set)
import Styles exposing (..)
import Types exposing (..)


modalViewFun : Element Msg -> Element Msg
modalViewFun view =
    let
        close =
            closeButton
                [ alignRight
                , pointer
                , Events.onClick <| CloseModal
                , Events.onMouseEnter (HoverOn 99)
                , Events.onMouseLeave (HoverOff 99)
                , htmlAttribute (HtmlAttributes.style "filter" "drop-shadow(3px 3px 1px darkgray)")
                ]
    in
    column
        [ width fill
        , Border.rounded 8
        , Background.color blanco
        , padding 20
        ]
        [ row [ width fill, inFront close ]
            [ view -- aquí va el contenido real del modal
            ]
        ]
