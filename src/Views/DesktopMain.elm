module Views.DesktopMain exposing (view)

import Dict exposing (Dict)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import Styles exposing (..)
import Types exposing (..)
import Views.Botones as Botones exposing (..)
import Views.Footer as Footer
import Views.Header as Header
import Views.Menu as Menu
import Views.Modal as Modal
import Views.PhoneMain as PhoneMain


view : Model -> Html Msg
view model =
    let
        content =
            case model.modalVisibility of
                Hidden ->
                    contenido model

                Visible ->
                    row [ centerX, centerY, width (fill |> maximum 1150) ]
                        [ el [ width fill, height fill, paddingEach { top = 20, bottom = 80, left = 20, right = 20 } ]
                            model.modalView
                        ]

        menu =
            case model.menuVisible of
                Hidden ->
                    []

                Visible ->
                    [ inFront <| Menu.view model ]
    in
    Html.div [ class "main-container" ]
        [ Header.headerHtml
        , layout
            (menu
                ++ [ width fill
                   , height fill
                   , centerX
                   , centerY
                   , moveDown 150
                   ]
            )
          <|
            column
                [ centerX, centerY, width fill, height fill ]
                [ el [ width fill, height fill, paddingEach { top = 20, bottom = 80, left = 20, right = 20 } ]
                    content
                , Footer.footer
                ]
        ]


contenido : Model -> Element Msg
contenido model =
    row [ centerX, centerY, spacing 40, width fill ]
        [ aside model
        , mainSection model
        , asideEvidencias
        ]


aside : Model -> Element Msg
aside model =
    let
        seccion =
            getSeccionByCode "ambitoscompe"
    in
    column
        [ centerX
        , centerY
        , height fill
        , width (fill |> maximum 340)
        , padding 25
        , spacing 40
        ]
        [ paragraph [ Font.center ]
            [ el montserratBold
                (text seccion.titulo)
            ]
        , column
            [ alignLeft, alignTop, spacing 5 ]
            [ botonCompetencia (getEntregable "1" model.entregables) "1a entrega" [ 100, 1, 2, 3 ] model.hovered
            , botonCompetencia (getEntregable "2" model.entregables) "2a entrega" [ 101, 8, 10 ] model.hovered
            , botonCompetencia (getEntregable "3" model.entregables) "4a entrega" [ 102, 4, 5 ] model.hovered
            , botonCompetencia (getEntregable "4" model.entregables) "6a entrega" [ 103, 6, 18, 19 ] model.hovered
            , botonCompetencia (getEntregable "5" model.entregables) "3a entrega" [ 104, 9, 11, 12 ] model.hovered
            , botonCompetencia (getEntregable "6" model.entregables) "5a entrega" [ 105, 13, 14, 15, 16, 17 ] model.hovered
            ]
        ]


asideEvidencias : Element Msg
asideEvidencias =
    let
        iconos =
            [ "captura", "doc", "infografia", "audio", "contenido", "video" ]

        textos =
            [ "Captura de pantalla y texto", "Documento", "Infografía", "Audio", "Contenido", "Video" ]
    in
    column
        [ centerX
        , centerY
        , height fill
        , width (fill |> maximum 270)
        , padding 25
        , spacing 40
        ]
        [ paragraph [ Font.center ]
            [ el montserratBold
                (text "Formatos de Evidencia")
            ]
        , column
            [ alignRight, alignTop, spacing 20 ]
          <|
            List.map2
                (\icono texto ->
                    row [ spacing 10, alignRight ]
                        [ paragraph [ Font.center ]
                            [ el montserratSemi
                                (text texto)
                            ]
                        , image [ height (px 60) ] { src = "assets/" ++ icono ++ ".webp", description = texto }
                        ]
                )
                iconos
                textos
        ]


mainSection : Model -> Element Msg
mainSection model =
    row
        (borderStyle
            ++ [ centerX
               , centerY
               , width (fill |> maximum 1150)
               , height shrink
               , Background.color blanco
               ]
        )
        [ contextoColaborativo model
        , centro model
        , ensenanzaAprendizaje model
        ]


contextoColaborativo : Model -> Element Msg
contextoColaborativo model =
    let
        seccion =
            getSeccionByCode "concolab"
    in
    column
        [ alignLeft, alignTop, width (fillPortion 1), height fill, padding 25, Background.color seccion.color, spacing 40 ]
        [ paragraph []
            [ el montserratBold
                (text seccion.titulo)
            ]
        , column
            [ alignLeft
            , alignTop
            , spacing 20

            -- , noneexplain Debug.todo
            ]
            [ botonEntregable (getEntregable "1.A" model.entregables) 1 model.hovered
            , botonEntregable (getEntregable "1.B" model.entregables) 2 model.hovered
            , botonEntregable (getEntregable "1.C" model.entregables) 3 model.hovered
            ]
        ]


centro : Model -> Element Msg
centro model =
    column
        (innerBorder ++ [ centerX, alignTop, width (fillPortion 2), height fill, padding 25, spacing 10 ])
        [ evaluacionPrevia model
        , contenidos model
        , contenidoProfundizacion model
        , contextoColaborativoAlumnado model
        , evaluacionYRetroalimentacion model
        ]


evaluacionPrevia : Model -> Element Msg
evaluacionPrevia model =
    let
        seccion =
            getSeccionByCode "preeval"
    in
    row
        (borderStyle ++ [ Background.color seccion.color, width fill, padding 15, spacing 10 ])
        [ paragraph [ Font.center ]
            [ el montserratBold
                (text seccion.titulo)
            ]
        , botonEntregable (getEntregable "4.A" model.entregables) 6 model.hovered
        ]


contenidos : Model -> Element Msg
contenidos model =
    row
        [ width fill, centerX, spacing 10 ]
        [ preguntaFlujo model
        , contenidoBasico model
        ]


preguntaFlujo : Model -> Element Msg
preguntaFlujo model =
    column
        [ spacing 10 ]
        [ downArrowSvg [ moveRight 65 ] chicleHex
        , row [ spacing 10, paddingXY 20 0 ]
            [ paragraph [ Background.color limon, paddingXY 10 27, Font.center, centerY, Border.rounded 100, Border.solid, Border.width 1, width (px 130), height (px 130) ]
                [ el montserratSemi
                    (text "¿Tiene el conocimiento básico?")
                ]
            , rightArrowSvg [ padding 5, centerX ] chicleHex
            , el montserratLight
                (text "No")
            ]
        , downArrowSvg [ moveRight 65 ] chicleHex
        , el (montserratLight ++ [ moveRight 80 ])
            (text "Sí")
        ]


contenidoBasico : Model -> Element Msg
contenidoBasico model =
    let
        seccion =
            getSeccionByCode "conbasico"
    in
    column [ spacing 10 ]
        [ upArrowSvg [ moveRight 65 ] chicleHex
        , column
            (borderStyle ++ [ Background.color seccion.color, padding 15, spacing 10 ])
            [ paragraph [ Font.center ]
                [ el montserratBold
                    (text seccion.titulo)
                ]
            , botonEntregable (getEntregable "2.A" model.entregables) 8 model.hovered
            , botonEntregable (getEntregable "5.A" model.entregables) 9 model.hovered
            ]
        ]


contenidoProfundizacion : Model -> Element Msg
contenidoProfundizacion model =
    let
        seccion =
            getSeccionByCode "conprofund"
    in
    column
        (borderStyle ++ [ Background.color seccion.color, padding 15, spacing 10 ])
        [ paragraph [ Font.center ]
            [ el montserratBold
                (text seccion.titulo)
            ]
        , row [ spacing 20 ]
            [ botonEntregable (getEntregable "2.B" model.entregables) 10 model.hovered
            , botonEntregable (getEntregable "5.A" model.entregables) 11 model.hovered
            , botonEntregable (getEntregable "5.B" model.entregables) 12 model.hovered
            ]
        ]


contextoColaborativoAlumnado : Model -> Element Msg
contextoColaborativoAlumnado model =
    let
        seccion =
            getSeccionByCode "colabalumn"
    in
    column
        (borderStyle ++ [ Background.color seccion.color, padding 15, spacing 10 ])
        [ paragraph [ Font.center ]
            [ el montserratBold
                (text seccion.titulo)
            ]
        , row [ spacing 20 ]
            [ botonEntregable (getEntregable "6.A" model.entregables) 13 model.hovered
            , botonEntregable (getEntregable "6.B" model.entregables) 14 model.hovered
            , botonEntregable (getEntregable "6.C" model.entregables) 15 model.hovered
            ]
        , row [ spacing 20 ]
            [ botonEntregable (getEntregable "6.D" model.entregables) 16 model.hovered
            , botonEntregable (getEntregable "6.E" model.entregables) 17 model.hovered
            ]
        ]


evaluacionYRetroalimentacion : Model -> Element Msg
evaluacionYRetroalimentacion model =
    let
        seccion =
            getSeccionByCode "evlaretro"
    in
    column
        (borderStyle ++ [ Background.color seccion.color, padding 15, spacing 10, width fill ])
        [ paragraph [ Font.center ]
            [ el montserratBold
                (text seccion.titulo)
            ]
        , row [ spacing 20, centerX ]
            [ botonEntregable (getEntregable "4.B" model.entregables) 18 model.hovered
            , botonEntregable (getEntregable "4.C" model.entregables) 19 model.hovered
            ]
        ]


ensenanzaAprendizaje : Model -> Element Msg
ensenanzaAprendizaje model =
    let
        seccion =
            getSeccionByCode "ensapre"
    in
    column
        [ alignRight, alignTop, width (fillPortion 1), height fill, padding 25, Background.color seccion.color, spacing 40 ]
        [ paragraph [ Font.alignRight ]
            [ el montserratBold
                (text seccion.titulo)
            ]
        , column
            [ alignRight, alignTop, spacing 20 ]
            [ botonEntregable (getEntregable "3.A" model.entregables) 4 model.hovered
            , botonEntregable (getEntregable "3.B" model.entregables) 5 model.hovered
            ]
        ]
