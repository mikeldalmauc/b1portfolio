module Styles exposing (..)

import Element.Font as Font
import Element exposing (Attribute, rgba255, rgb255, Color)
import Element.Border as Border


darkBlue : Color
darkBlue = rgba255 0 4 25 1.0

naranja : Color
naranja = rgba255 234 140 104 1.0

verde : Color
verde = rgba255 106 183 112 1.0

turquesa : Color
turquesa = rgba255 93 198 195 1.0

morado : Color
morado = rgba255 90 68 135 1.0

rosa : Color
rosa = rgba255 216 91 127 1.0


---  Colores chicle

limon : Color
limon = rgb255 241 243 51

azul : Color
azul = rgb255 144 168 237

chicle : Color
chicle = rgb255 255 144 232
--- 


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

borderStyleBoton : List (Attribute msg)
borderStyleBoton = 
    [ Border.rounded 10
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
        , Font.size 16
        , Font.light
        ]


-- Para títulos
montserratBold :  List (Attribute msg)
montserratBold =
        [ montserrat
        , Font.size 28
        , Font.semiBold
        ]
