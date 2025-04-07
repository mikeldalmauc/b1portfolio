module Views.Menu exposing (..)

import Dict exposing (Dict)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Entregables.Entregables exposing (..)
import Html exposing (Html, div)
import Styles exposing (..)
import Types exposing (..)
import Views.Botones as Botones exposing (..)
import Views.Footer as Footer


view : Model -> Element Msg
view model =
    let
        sideFiller =
            el [ width (fillPortion 1), height fill ] none

        mainBlock =
            column [ centerX, centerY, width (fillPortion 10), height fill, spacing 10, paddingEach { top = 10, bottom = 20, left = 0, right = 10 } ] <|
                botonHome 4001 model.hovered
                    :: (List.indexedMap (\i ( k, e ) -> botonEntregable e (2000 + i) model.hovered) <|
                            Dict.toList entregables
                       )
    in
    column
        [ moveUp 50
        , alignLeft
        , width (fill |> maximum 340)
        , height (fill |> maximum 1200)
        , Background.color blanco
        , scrollbars
        , Border.widthEach { top = 0, left = 0, bottom = 1, right = 1 }
        , Border.solid
        , Border.color negro
        , Events.onMouseLeave ScheduleClose
        , Events.onMouseEnter OpenMenu
        ]
    <|
        [ row [ centerX, centerY, width fill, height fill, paddingEach { top = 10, left = 0, bottom = 50, right = 0 } ] <|
            [ sideFiller
            , mainBlock
            , sideFiller
            ]
        ]
