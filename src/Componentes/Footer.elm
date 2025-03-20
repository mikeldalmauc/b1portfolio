module Componentes.Footer exposing (..)


import Element.Background as Background
import Element exposing (..)
import Element.Font as Font
import Styles exposing (..)
import Html.Attributes as HtmlAttributes exposing (style)
import Types exposing (..)


footer : Element Msg
footer = 
    column [paddingXY 20 40, width fill, height (px 200), Background.color negro, spaceEvenly]
    [ el 
        ( montserratLight ++ [Font.color blanco, centerX]
        ) 
        (text "B1 Competencia digital del profesorado")
    , row 
        ( montserratLight ++ [Font.color blanco, centerX]
        ) 
        [ paragraph [Font.center]
          [text "Mikel Dalmau "
          , text " - "
          , link [Font.underline, padding 5] { url = "https://github.com/mikeldalmauc/b1portfolio", label = text "Código fuente de esta web"}
          , text " - "
          , link [Font.underline, padding 5] { url = "https://mikeldalmau.com", label = text "mikeldalmau.com"}
          ]
        ]

    , link [Font.underline, padding 5, centerX, paddingXY 20 0] 
        { url = "https://creativecommons.org/licenses/by-nc-sa/4.0/?ref=chooser-v1"
        , label = image [height (px 50)] {src = "assets/CC.webp", description = "Creative Commons, Non comercial, Share Alike"
        }}
    ]
