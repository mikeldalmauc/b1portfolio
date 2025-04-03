module Lottie exposing (..)

{-| Subcomponente para mostrar la animación Lottie.
-}

import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)
import Html.Attributes
import Task


animationids : List String
animationids =
    [ "student-animation"
    , "teaching-animation"
    , "wip-animation"
    ]


viewTeaching : Element msg
viewTeaching =
    el
        [ centerX
        , centerY
        , padding 10
        , moveDown 350
        , moveLeft 650
        , htmlAttribute (Html.Attributes.style "filter" "saturate(2)")
        ]
    <|
        el
            [ htmlAttribute (Html.Attributes.style "transform" "rotateY(180deg)")
            , htmlAttribute (Html.Attributes.id "teaching-animation")
            , width (px 550)
            , height (px 550)
            ]
            none


viewStudent : Element msg
viewStudent =
    el
        [ centerX
        , centerY
        , padding 10
        , moveDown 290
        , moveRight 650
        , htmlAttribute (Html.Attributes.style "filter" "saturate(1.1)")
        ]
    <|
        el
            [ htmlAttribute (Html.Attributes.id "student-animation")
            , width (px 500)
            , height (px 500)
            , htmlAttribute (Html.Attributes.style "filter" "hue-rotate(30deg)")
            ]
            none


viewWip : Element msg
viewWip =
    el
        [ centerX
        , centerY
        , padding 10
        , htmlAttribute (Html.Attributes.style "filter" "saturate(1.1)")
        ]
    <|
        el
            [ htmlAttribute (Html.Attributes.id "wip-animation")
            , width (px 400)
            , height (px 400)
            ]
            none
