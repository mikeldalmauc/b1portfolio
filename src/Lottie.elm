module Lottie exposing (Model, Msg(..), init, update, view)

{-| Subcomponente para mostrar la animación Lottie.
-}

import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)
import Html.Attributes
import Task



-- No necesitamos nada complejo para el Modelo


type alias Model =
    { containerId : String }



-- Mensajes internos (si tuviera eventos)


type Msg
    = NoOp
    | Play


init : String -> ( Model, Cmd Msg )
init givenId =
    ( { containerId = givenId }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Play ->
            ( model, Cmd.none )


view : Model -> Element msg
view model =
    el
        [ htmlAttribute (Html.Attributes.id model.containerId)
        , htmlAttribute (Html.Attributes.id model.containerId)
        , width (px 600)
        , height (px 600)
        , centerX
        , centerY
        , padding 10
        , moveDown 350
        , moveRight 700
        , htmlAttribute (Html.Attributes.style "filter" "saturate(2)")
        ]
        none
