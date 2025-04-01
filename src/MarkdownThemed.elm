module MarkdownThemed exposing (lightTheme, renderFull)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html
import Html.Attributes
import Markdown.Block exposing (HeadingLevel, ListItem(..))
import Markdown.Html
import Markdown.Parser
import Markdown.Renderer
import Styles


type alias Theme =
    { defaultText : Color
    , mutedText : Color
    , grey : Color
    , lightGrey : Color
    , link : Color
    }


lightTheme : Theme
lightTheme =
    { defaultText = rgb255 30 50 46
    , mutedText = rgb255 74 94 122
    , link = Styles.linkBlue
    , lightGrey = rgb255 248 250 240
    , grey = rgb255 200 220 240
    }


renderFull : String -> Element msg
renderFull markdownBody =
    render (renderer lightTheme) markdownBody


render : Markdown.Renderer.Renderer (Element msg) -> String -> Element msg
render chosenRenderer markdownBody =
    Markdown.Parser.parse markdownBody
        -- @TODO show markdown parsing errors, i.e. malformed html?
        |> Result.withDefault []
        |> (\parsed ->
                parsed
                    |> Markdown.Renderer.render chosenRenderer
                    |> (\res ->
                            case res of
                                Ok elements ->
                                    elements

                                Err err ->
                                    [ text "Something went wrong rendering this page"
                                    , text err
                                    ]
                       )
                    |> column
                        [ width fill
                        , spacing 10
                        ]
           )


bulletPoint : List (Element msg) -> Element msg
bulletPoint children =
    row
        [ spacing 5
        , paddingEach { top = 0, right = 0, bottom = 0, left = 20 }
        , width fill
        ]
        [ paragraph
            [ alignTop ]
            (text " • " :: children)
        ]


renderer : Theme -> Markdown.Renderer.Renderer (Element msg)
renderer theme =
    { heading = \data -> row [] [ heading theme data ]
    , paragraph = paragraph [ paddingEach { left = 0, right = 0, top = 0, bottom = 20 } ]
    , blockQuote =
        \children ->
            column
                [ Font.size 20
                , Font.italic
                , Border.widthEach { bottom = 0, left = 4, right = 0, top = 0 }
                , Border.color theme.grey
                , Font.color theme.mutedText
                , padding 10
                ]
                children
    , html =
        Markdown.Html.oneOf
            [ Markdown.Html.tag "img"
                (\src width_ maxWidth_ bg_ content ->
                    let
                        attrs =
                            case maxWidth_ of
                                Just maxWidth ->
                                    [ maxWidth
                                        |> String.toInt
                                        |> Maybe.map (\w -> width (fill |> maximum w))
                                        |> Maybe.withDefault (width fill)
                                    , centerX
                                    ]

                                Nothing ->
                                    [ width_
                                        |> Maybe.andThen String.toInt
                                        |> Maybe.map (\w -> width (px w))
                                        |> Maybe.withDefault (width fill)
                                    ]
                    in
                    case bg_ of
                        Just bg ->
                            el [ Border.rounded 10, padding 20 ] <| image attrs { src = src, description = "" }

                        Nothing ->
                            image attrs { src = src, description = "" }
                )
                |> Markdown.Html.withAttribute "src"
                |> Markdown.Html.withOptionalAttribute "width"
                |> Markdown.Html.withOptionalAttribute "maxwidth"
                |> Markdown.Html.withOptionalAttribute "bg"
            , Markdown.Html.tag "br" (\_ -> html <| Html.br [] [])
            ]
    , text = \s -> el [ Styles.montserrat ] (text s)
    , codeSpan =
        \content -> html (Html.code [ Html.Attributes.style "color" "#220cb0" ] [ Html.text content ])
    , strong = \list -> paragraph [ Font.bold ] list
    , emphasis = \list -> paragraph [ Font.italic ] list
    , hardLineBreak = html (Html.br [] [])
    , link =
        \{ title, destination } list ->
            link
                [ Font.underline
                , Font.color theme.link
                ]
                { url = destination
                , label =
                    case title of
                        Just title_ ->
                            text title_

                        Nothing ->
                            paragraph [] list
                }
    , image =
        \{ alt, src, title } ->
            let
                attrs =
                    [ title |> Maybe.map (\title_ -> htmlAttribute (Html.Attributes.attribute "title" title_))
                    , width fill |> Just
                    ]
                        |> justs
            in
            image
                attrs
                { src = src
                , description = alt
                }
    , unorderedList =
        \items ->
            column
                [ spacing 15
                , width fill
                , paddingEach { top = 0, right = 0, bottom = 40, left = 0 }
                ]
                (items
                    |> List.map
                        (\listItem ->
                            case listItem of
                                ListItem _ children ->
                                    wrappedRow
                                        [ spacing 5
                                        , paddingEach { top = 0, right = 0, bottom = 0, left = 20 }
                                        , width fill
                                        ]
                                        [ paragraph
                                            [ alignTop ]
                                            (text " • " :: children)
                                        ]
                        )
                )
    , orderedList =
        \startingIndex items ->
            column [ spacing 15, width fill ]
                (items
                    |> List.indexedMap
                        (\index itemBlocks ->
                            wrappedRow
                                [ spacing 5
                                , paddingEach { top = 0, right = 0, bottom = 0, left = 20 }
                                , width fill
                                ]
                                [ paragraph
                                    [ alignTop ]
                                    (text (String.fromInt (startingIndex + index) ++ ". ") :: itemBlocks)
                                ]
                        )
                )
    , codeBlock =
        \{ body } ->
            let
                numberOfLines =
                    String.lines body
                        |> List.length
                        |> toFloat
                        |> (\x -> 1.35 * x)
                        |> round
            in
            column
                [ Font.family [ Font.monospace ]
                , Font.size 14
                , Font.color (rgb255 34 12 176)
                , Border.rounded 2
                , paddingEach { left = 0, right = 0, top = 8, bottom = 20 }
                , width fill
                , height (px <| 16 * numberOfLines + 10)
                , htmlAttribute (Html.Attributes.class "preserve-white-space")
                , htmlAttribute (Html.Attributes.style "line-height" "1.4")
                , scrollbarX
                , Background.color Styles.grisclaro5
                ]
                [ el [ centerY, padding 10 ] <| html (Html.text body) ]
    , thematicBreak = Styles.divider
    , table = \children -> column [ width fill ] children
    , tableHeader = \children -> column [] children
    , tableBody = \children -> column [] children
    , tableRow = \children -> row [ width fill ] children
    , tableCell = \_ children -> column [ width fill ] children
    , tableHeaderCell = \_ children -> column [ width fill ] children
    , strikethrough = \children -> paragraph [ Font.strike ] children
    }


heading : Theme -> { level : HeadingLevel, rawText : String, children : List (Element msg) } -> Element msg
heading theme { level, rawText, children } =
    paragraph
        ((case Markdown.Block.headingLevelToInt level of
            1 ->
                [ Font.color theme.defaultText
                , Font.size 30
                , Font.bold
                , paddingEach { top = 30, right = 0, bottom = 30, left = 0 }
                ]

            2 ->
                [ Font.color theme.defaultText
                , Font.size 28
                , Font.bold
                , paddingEach { top = 20, right = 0, bottom = 20, left = 0 }
                ]

            3 ->
                [ Font.color theme.defaultText
                , Font.size 20
                , Font.bold

                --, Font.medium
                , paddingEach { top = 10, right = 0, bottom = 10, left = 0 }
                ]

            4 ->
                [ Font.color theme.defaultText
                , Font.size 16
                , Font.bold
                , paddingEach { top = 0, right = 0, bottom = 10, left = 0 }
                ]

            _ ->
                [ Font.size 12
                , Font.bold
                , Font.center
                , paddingXY 0 20
                ]
         )
            ++ [ Styles.montserrat
               , Region.heading (Markdown.Block.headingLevelToInt level)
               , htmlAttribute
                    (Html.Attributes.attribute "name" (rawTextToId rawText))
               , htmlAttribute
                    (Html.Attributes.id (rawTextToId rawText))
               ]
        )
        children


rawTextToId : String -> String
rawTextToId rawText =
    rawText
        |> String.toLower
        |> String.replace " " "-"
        |> String.replace "." ""


justs : List (Maybe a) -> List a
justs =
    List.foldl
        (\v acc ->
            case v of
                Just el ->
                    el :: acc

                Nothing ->
                    acc
        )
        []
