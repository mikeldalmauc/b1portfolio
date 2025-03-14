module Styles exposing (..)

import Element.Font as Font
import Element exposing (Attribute)




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
        , Font.bold
        ]
