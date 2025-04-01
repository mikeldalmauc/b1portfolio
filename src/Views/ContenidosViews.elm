module Views.ContenidosViews exposing (..)

import Element exposing (..)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes as HtmlAttributes
import Route exposing (..)
import Styles exposing (..)
import Types exposing (..)


breadcrumbs : List (Maybe Entregable) -> Element msg
breadcrumbs entregables =
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
            link HomepageRoute "Inicio"
                :: List.map
                    (\entregable ->
                        case entregable of
                            Just e ->
                                link e.route e.tituloModal

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
            List.intersperse contrabarra routes
    in
    row
        [ spacing 10
        , padding 20
        , alignLeft
        ]
        itemsConBarra


footerNavigation : Maybe Entregable -> Maybe Entregable -> Element msg
footerNavigation prev next =
    let
        rowAttrs =
            \route -> [ width fill, height fill, spacing 20, padding 20, pointer, inFront <| Element.link [ width fill, height fill ] { url = Route.encode route, label = none } ]

        textAttrs =
            montserratBold ++ [ Font.color linkBlue, Font.underline ]

        prevLink =
            case prev of
                Just e ->
                    row
                        (rowAttrs e.route)
                        [ leftArrowSvg [] grisclaroHex
                        , el textAttrs (text e.tituloModal)
                        ]

                Nothing ->
                    none

        nextLink =
            case next of
                Just e ->
                    row
                        (rowAttrs e.route)
                        [ el textAttrs (text e.tituloModal)
                        , rightArrowSvg [] grisclaroHex
                        ]

                Nothing ->
                    none
    in
    Element.row
        [ spacing 50, padding 50, centerX ]
        [ prevLink
        , nextLink
        ]


videoView : String -> Element msg
videoView src =
    html <|
        Html.div []
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
