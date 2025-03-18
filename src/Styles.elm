module Styles exposing (..)

import Element.Font as Font
import Element exposing (Element, Attribute, rgba, rgba255, rgb255, Color, toRgb)
import Element.Border as Border
import Element.HexColor as HexColor exposing (hexa)

import Html exposing (Html)
import Svg 
import Svg.Attributes as SvgAttrs
import Element exposing (centerX)

negro : Color   
negro = rgb255 0 0 0

negroHex : String
negroHex = "#000000"


blanco : Color   
blanco = rgb255 256 256 256


grisclaro : Color
grisclaro = rgb255 170 170 170

---  Colores chicle

limon : Color
limon = rgb255 241 243 51

azul : Color
azul = rgb255 144 168 237

chicle : Color
chicle = rgb255 255 144 232

chicleHex : String
chicleHex = "#ff90e8"

naranja : Color
naranja = rgb255 255 201 0

turquesa : Color
turquesa = rgb255 35 160 148

rojo : Color
rojo = rgb255 220 52 30
--- 

oscurecer : Color -> Float -> Color
oscurecer color factor =
    let
        {red, green , blue , alpha } = toRgb color
    in
        rgba
            (red * factor)
            (green * factor)
            (blue * factor)
            (alpha)


innerBorder : List (Attribute msg)
innerBorder = 
    [ Border.solid
    , Border.widthEach
        { bottom = 0
        , left = 1
        , right = 1
        , top = 0
        }
    ]

borderStyle : List (Attribute msg)
borderStyle = 
    [ Border.rounded 5
    , Border.solid
    , Border.width 1
    ]

montserrat : Attribute msg
montserrat = Font.family
            [ Font.external
                { name = "Montserrat"
                , url = "https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
                }
            , Font.serif
            ]

-- Para textos body
montserratLight :  List (Attribute msg)
montserratLight =
        [ montserrat
        , Font.size 14
        , Font.regular
        ]

montserratSemi :  List (Attribute msg)
montserratSemi =
        [ montserrat
        , Font.size 14
        , Font.semiBold
        ]


montserratSemiBold :  List (Attribute msg)
montserratSemiBold =
        [ montserrat
        , Font.size 16
        , Font.semiBold
        ]

-- Para títulos


montserratBold :  List (Attribute msg)
montserratBold =
        [ montserrat
        , Font.size 18
        , Font.bold
        ]


montserratTitulo :  List (Attribute msg)
montserratTitulo =
        [ montserrat
        , Font.size 30
        , Font.extraBold
        ]

-- SVGs


upArrowSvg : List (Attribute msg) -> String -> Element msg
upArrowSvg attrs color =
    Element.el attrs <|Element.html <| arrowSvg color "270"

downArrowSvg : List (Attribute msg) -> String -> Element msg
downArrowSvg attrs color =
     Element.el attrs <| Element.html <| arrowSvg color "90"

leftArrowSvg : String -> Element msg
leftArrowSvg color =
    Element.html <| arrowSvg color "270"

rightArrowSvg : List (Attribute msg) -> String -> Element msg
rightArrowSvg attrs color =
    Element.el attrs <| Element.html <| arrowSvg color "0"


arrowSvg : String -> String -> Html msg
arrowSvg color rotation =
    Svg.svg
        [ SvgAttrs.width "40"
        , SvgAttrs.height "40"
        , SvgAttrs.viewBox "0 0 122.88 122.433"
        , SvgAttrs.fill color
        , SvgAttrs.transform <| "rotate(" ++ rotation ++ " 0 0)"
        ][ 
            -- Svg.path
            -- [ SvgAttrs.d 
            --     """M482.1,263.9h24.4v-15.8h-24.4V263.9z M434,263.9h32.3v-15.8H434V263.9z M386,263.9h32.3v-15.8H386V263.9z M337.9,263.9h32.3v-15.8h-32.3V263.9z M289.1,263.9h32.3v-15.8h-32.3V263.9z M241,263.9h32.3v-15.8H241V263.9z M193,263.9h32.3 v-15.8H193V263.9z M144.9,263.9h32.3v-15.8h-32.3V263.9z M96.1,263.9h32.3v-15.8H96.1V263.9z M48,263.9h32.3v-15.8H48V263.9z M0,263.9h32.3v-15.8H0V263.9z"""
            -- , SvgAttrs.fill color
            -- ]
            -- []
        -- , 
        Svg.polygon
            [ SvgAttrs.points "122.88,61.217 59.207,122.433 59.207,83.029 0,83.029 0,39.399 59.207,39.399 59.207,0 122.88,61.217"
            , SvgAttrs.fill color
            , SvgAttrs.fillRule "evenodd"
            , SvgAttrs.clipRule "evenodd"
            ]
            []
        ]


closeButton : List (Attribute msg) -> Element msg
closeButton attrs = 
    Element.el attrs <| Element.html <| closeButtonSvg negroHex

closeButtonSvg : String -> Html msg
closeButtonSvg color = 
    Svg.svg
        [ SvgAttrs.width "50"
        , SvgAttrs.height "50"
        , SvgAttrs.viewBox "0 0 24 24"
        , SvgAttrs.fill color
        ]
        [ Svg.path 
            [ SvgAttrs.d """M5.29289 5.29289C5.68342 4.90237 6.31658 4.90237 6.70711 5.29289L12 10.5858L17.2929 5.29289C17.6834 4.90237 18.3166 4.90237 18.7071 5.29289C19.0976 5.68342 19.0976 6.31658 18.7071 6.70711L13.4142 12L18.7071 17.2929C19.0976 17.6834 19.0976 18.3166 18.7071 18.7071C18.3166 19.0976 17.6834 19.0976 17.2929 18.7071L12 13.4142L6.70711 18.7071C6.31658 19.0976 5.68342 19.0976 5.29289 18.7071C4.90237 18.3166 4.90237 17.6834 5.29289 17.2929L10.5858 12L5.29289 6.70711C4.90237 6.31658 4.90237 5.68342 5.29289 5.29289Z"""
            , SvgAttrs.fill color
            , SvgAttrs.fillRule "evenodd"
            , SvgAttrs.clipRule "evenodd"
            ]
            []
        ]