module Views.PhoneView exposing (view)

import Dict exposing (Dict)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Entregables.Entregables exposing (..)
import Html exposing (Html, div)
import Styles exposing (..)
import Types exposing (..)
import Views.Botones as Botones exposing (..)
import Views.Footer as Footer
import Views.Header as Header


view : Model -> Html Msg
view model =
    let
        phoneHeaderView =
            if model.modalVisibility == Visible then
                Header.phoneHeaderBack model

            else
                Header.phoneHeader model

        sideFiller =
            el [ width (fillPortion 1), height fill ] none

        mainBlock =
            case model.sortOrder of
                Desc ->
                    column [ centerX, centerY, width (fillPortion 10), height fill, spacing 10, paddingEach { top = 80, bottom = 20, left = 0, right = 10 } ] <|
                        List.indexedMap (\i ( k, e ) -> botonEntregable e (2000 + i) model.hovered) <|
                            Dict.toList entregables

                Categories ->
                    column [ centerX, centerY, width (fillPortion 17), height fill, spacing 10, paddingEach { top = 80, bottom = 20, left = 10, right = 10 } ] <|
                        List.indexedMap
                            (\i s ->
                                column (borderStyle ++ [ width fill, Background.color s.color, spacing 10, paddingEach { top = 20, bottom = 20, left = 10, right = 10 } ]) <|
                                    List.append [ paragraph [ Font.center, paddingEach { top = 15, bottom = 15, left = 10, right = 10 } ] [ el montserratBold (text s.titulo) ] ] <|
                                        List.indexedMap (\j e -> botonEntregable e (i * 1000 + j) model.hovered) s.entregables
                            )
                        <|
                            seccionesEnOrden
    in
    layout
        [ width fill, height fill, centerX, centerY, inFront phoneHeaderView ]
    <|
        column [ centerX, width fill, height fill ]
            [ row
                [ centerX
                , centerY
                , width fill
                , height fill
                , paddingEach { top = 40, left = 0, bottom = 50, right = 0 }
                ]
              <|
                [ sideFiller
                , if model.modalVisibility == Visible then
                    el [ centerX, centerY, width (fillPortion 17), height fill, paddingEach { top = 80, bottom = 20, left = 10, right = 10 } ] (model.modalView model.dimensions)

                  else
                    mainBlock
                , sideFiller
                ]
            , Footer.footer
            ]
