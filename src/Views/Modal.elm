module Views.Modal exposing (..)


import Set exposing (Set)
import Json.Decode as Decode

import Html.Attributes as HtmlAttributes exposing (style)
import Html exposing (Html, div)
import Html.Events exposing (onClick, stopPropagationOn)

import Element.Background as Background
import Element exposing (..)
import Element.Font as Font
import Element.Events as Events
import Element.Border as Border

import Styles exposing (..)
import Types exposing (..)
import Route



viewOverlay : Model -> Html Msg
viewOverlay model =
    div
        [ style "position" "fixed"
        , style "top" "0"
        , style "left" "0"
        , style "width" "100%"
        , style "height" "100%"
        , style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        , style "background-color" "rgba(0,0,0,0.4)"
        , style "z-index" "9999"
        , onClick <| GoTo Route.HomepageRoute
        ]
        [ -- 2) El contenedor del modal en sí, centrado mediante position absolute + transform
          div
            [ style "background-color" "white"
            , style "border-radius" "8px"
            , style "box-shadow" "0 4px 6px rgba(0,0,0,0.3)"
            , style "width" "70%"
            , style "max-width" "80%"
            , style "max-height" "80%"
            , style "padding" "20px"
            , style "overflow-y" "auto"
            , stopPropagationOn "click" (Decode.succeed (NoOp, True))
            ]
            [  layout [] <| modalViewFun model
            ]
        ]


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
  ( msg, True )


modalViewFun : Model -> Element Msg
modalViewFun model =
    let 
        dropShadowValue =
            if (Set.member 99 model.hovered) then
                "drop-shadow(3px 3px 1px darkgray)"
            else
                "none"
    in
        column
            [ width fill
            , Border.rounded 8
            , Background.color blanco
            , padding 20
            ]
            [ row [ width fill ]
                [ el (montserratBold) (text model.modalTitle)
                , closeButton 
                    [ alignRight, pointer, Events.onClick <| GoTo Route.HomepageRoute  
                    , Events.onMouseEnter (HoverOn 99)
                    , Events.onMouseLeave (HoverOff 99)
                    , htmlAttribute (HtmlAttributes.style "filter" dropShadowValue)
                    ]
                ]
            , model.modalView -- aquí va el contenido real del modal
            ]
        
