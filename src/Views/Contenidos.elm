module Views.Contenidos exposing (..)


import Element exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttributes

videoView : String -> Element msg
videoView src = 
    html
        <| Html.div []
            [ Html.node "iframe"
                [ HtmlAttributes.width 560
                , HtmlAttributes.height 315
                , HtmlAttributes.src src
                , HtmlAttributes.attribute "title" "YouTube video player"
                , HtmlAttributes.attribute "frameborder" "0"
                , HtmlAttributes.attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                , HtmlAttributes.attribute "referrerpolicy" "strict-origin-when-cross-origin"
                , HtmlAttributes.attribute "allowfullscreen" "true"
                ]
                []
            ]