module Componentes.Botones exposing (..)


import Set exposing (Set)

import Html exposing (Html)
import Html.Attributes as HtmlAttributes exposing (style)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font

import Styles exposing (..)
import Types exposing (..)


botonEntregable : Entregable -> Int -> Set Int -> Element Msg
botonEntregable entregable id hovered= 
  let
    (shadowStyle, dropShadowValue) =
        if (Set.member id hovered) then
            ([Border.shadow
                { offset = (4, 4)
                , size = 2
                , blur = 0
                , color = negro
                }
            ], "drop-shadow(3px 3px 0px black)")
        else
            ([], "none")
    
    iconoEvidencia = case entregable.tipoEvidencia of 
        Just icono  -> image [height (px 40), alignRight, moveRight 20, moveDown 20, htmlAttribute (HtmlAttributes.style "filter" dropShadowValue)] {src = "assets/" ++ icono ++ ".webp", description = "icono de evidencia"}
        Nothing -> none
  in
    row (borderStyle ++ shadowStyle ++
        [ Background.color <| colorFromCode entregable.codigo, width fill, height (px 60), padding 10, spacing 5, pointer
        , Events.onMouseEnter (HoverOn id)
        , Events.onMouseLeave (HoverOff id)
        , inFront iconoEvidencia
        , Events.onClick <| OpenModal entregable.tituloModal entregable.vistaModal
        ])
        <| 
        [el (montserratBold ++ []) (text entregable.codigo), paragraph (montserratLight ++ [paddingEach {top = 0, right = 20, bottom = 0, left = 0}]) [text entregable.descripcionEntregable]]


botonCompetencia : Entregable -> String -> List Int -> Set Int -> Element Msg
botonCompetencia entregable entrega ids hovered= 
  let
    (shadowStyle, factor, dropShadowValue) = 
        case (List.head ids) of
            Nothing -> ([], 0.7, "none")
            Just id -> 
                if (Set.member id hovered) then
                    ([Border.shadow
                        { offset = (2, 2)
                        , size = 2
                        , blur = 0
                        , color = negro
                        }
                    ], 0.0, "drop-shadow(3px 3px 0px black)")
                else
                    ([], 0.7, "none")
    color = colorFromCode entregable.codigo
  in
    row (
        [ width fill, height (px 70), padding 7, spacing 30, pointer
        , Events.onMouseEnter (HoverOnMany ids)
        , Events.onMouseLeave (HoverOffMany ids)
        , Events.onClick <| OpenModal entregable.tituloModal entregable.vistaModal
        ])
        [el (shadowStyle ++ montserratBold ++ [Font.center, centerX, centerY, width <| px 50, height <| px 50, Background.color color, Border.width 1, Border.solid, Border.rounded 50, padding 15]) (text entregable.codigo)
        , column [alignLeft, width (fill), spacing 10] 
            [ paragraph (montserratSemiBold ++ [ Font.color color, Font.shadow { offset = ( 1, 1 ), blur = 0, color = oscurecer color factor}]) [text entregable.descripcionEntregable]
            , paragraph (montserratLight ++ [ Font.shadow { offset = ( 0.5, 0.5 ), blur = 0, color = oscurecer grisclaro factor}]) [text entrega]
            ]
        , image [height (px 50), htmlAttribute (HtmlAttributes.style "filter" dropShadowValue)] {src = "assets/" ++ "video" ++ ".webp", description = "icono de video"}
        ]

