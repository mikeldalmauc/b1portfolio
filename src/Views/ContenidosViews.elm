module Views.ContenidosViews exposing (..)

import Element exposing (..)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes as HtmlAttributes
import Lottie
import Route exposing (..)
import String exposing (fromFloat, toInt)
import Styles exposing (..)
import Types exposing (..)


breadcrumbs : Dimensions -> List (Maybe ( Route, String )) -> Element msg
breadcrumbs d entregables =
    let
        textAttrs =
            montserratSemiBold
                ++ [ Font.color linkBlue ]

        link : Route -> String -> Element msg
        link route labelText =
            Element.link
                []
                { url = Route.encode route
                , label = el textAttrs (text labelText)
                }

        routes : List (Element msg)
        routes =
            link HomepageRoute "Esquema"
                :: List.map
                    (\entregable ->
                        case entregable of
                            Just ( r, s ) ->
                                link r s

                            Nothing ->
                                none
                    )
                    entregables

        -- Creamos el elemento de la “\” en gris.
        contrabarra : Element msg
        contrabarra =
            el
                [ Font.color (rgb255 128 128 128) ]
                (text "/")

        -- Usamos `List.intersperse` para intercalar la contrabarra entre los enlaces
        itemsConBarra : List (Element msg)
        itemsConBarra =
            List.intersperse (text "   ") <|
                List.intersperse contrabarra routes
    in
    -- wrappedRow
    --     [ spacing 10
    --     , padding 20
    --     , alignLeft
    --     ]
    --     itemsConBarra
    paragraph
        [ alignLeft
        ]
        itemsConBarra


footerNavigation : Dimensions -> Maybe ( Route, String ) -> Maybe ( Route, String ) -> Element msg
footerNavigation d prev next =
    let
        rowAttrs =
            \route -> [ width fill, height fill, spacing 20, padding 20, pointer, inFront <| Element.link [ width fill, height fill ] { url = Route.encode route, label = none } ]

        textAttrs =
            montserratBold ++ [ Font.color linkBlue, Font.underline ]

        prevLink =
            case prev of
                Just ( r, t ) ->
                    wrappedRow
                        (rowAttrs r)
                        [ leftArrowSvg [] grisclaroHex
                        , paragraph textAttrs [ text t ]
                        ]

                Nothing ->
                    none

        nextLink =
            case next of
                Just ( r, t ) ->
                    wrappedRow
                        (rowAttrs r)
                        [ paragraph (Font.alignRight :: textAttrs) [ text t ]
                        , rightArrowSvg [] grisclaroHex
                        ]

                Nothing ->
                    none
    in
    Element.wrappedRow
        [ spacing 50
        , padding 50
        , centerX
        , width (fill |> maximum (round (toFloat d.width * 0.95)))

        -- , explain Debug.todo
        ]
        [ prevLink
        , nextLink
        ]



-- view : Dimensions -> Element msg
-- view d =
--     Element.textColumn [ spacing 10, padding 10, centerX, centerY ]
--         [ paragraph [] [ text testText ]
--         , el [ alignLeft ] none
--         , el [ centerX, centerY ] <|
--             videoView "https://www.youtube.com/embed/o5Gv4_FdcYs?si=pcHtFUzWvv0IjbrM"
--         , paragraph [] [ text "lots of text ...." ]
--         ]


wip : Dimensions -> Element msg
wip d =
    column [ width fill, height fill, spacing 20 ]
        [ el [] none
        , el [] none
        , el [] none
        , el [] none
        , Lottie.viewWip
        , el [ centerX, montserrat, Font.size 22 ] (text "Work in progress...")
        , el [] none
        , el [] none
        , el [] none
        ]


videoView d src =
    let
        proportions =
            315 / 560

        maxw =
            1000

        maxH =
            round <| toFloat maxw * proportions

        w =
            round <| toFloat d.width * 0.9

        h =
            round <| toFloat w * proportions
    in
    html <|
        Html.div []
            [ Html.node "iframe"
                [ HtmlAttributes.width w
                , HtmlAttributes.style "max-width" <| String.fromInt maxw ++ "px"
                , HtmlAttributes.height h
                , HtmlAttributes.style "max-height" <| String.fromInt maxH ++ "px"
                , HtmlAttributes.src src
                , HtmlAttributes.attribute "title" "YouTube video player"
                , HtmlAttributes.attribute "frameborder" "0"
                , HtmlAttributes.attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                , HtmlAttributes.attribute "referrerpolicy" "strict-origin-when-cross-origin"
                , HtmlAttributes.attribute "allowfullscreen" "true"
                ]
                []
            ]
