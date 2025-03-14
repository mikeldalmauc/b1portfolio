module Styles exposing (..)

import Element.Font as Font

import Element exposing (Color)
import Element.HexColor as HexColor
import Element exposing (rgba)


brandFont : Attribute msg
brandFont = Font.family
            [ Font.external
                { name = "EB Garamond"
                , url = "https://fonts.googleapis.com/css2?family=EB+Garamond:wght@800&display=swap"
                }
            , Font.serif
            ]