module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Set exposing (Set)
import Dict exposing (Dict)
import Task

import Browser exposing (UrlRequest(..))
import Browser.Events exposing (onResize)
import Browser.Dom

import Browser.Navigation as Navigation
import Url exposing (Url)

import Html exposing (Html, div)
import Html.Attributes as HtmlAttributes

import Element exposing (..)
import Element.Font as Font
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events

import Styles exposing (..)
import Types exposing (..)
import Views.Header as Header
import Views.Footer as Footer
import Views.Modal as Modal
import Views.Botones as Botones exposing (..)
import Route

-- MAIN

main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        }


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onResize 
            (\width height ->
                DeviceClassified { width = width, height = height })
        ]


init : Dimensions -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init dimensions url key =
    let
        route =
            Route.decode url
    in
    ({  key = key  
      , route = route
      , device = classifyDevice dimensions
      , dimensions = dimensions
      , hovered = Set.empty
      , modalVisibility = Hidden
      , modalView = none
      , modalTitle = ""
      , entregables = entregables
      , sortOrder = Categories
    }
    , Cmd.none
    )


-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =

  case msg of
    UrlClicked urlRequest ->
        case urlRequest of
            Internal url ->
                case  getEntregableFromRoute (Route.decode url) of
                    Just entregable ->
                        ( model, Cmd.batch [
                              Navigation.pushUrl model.key (Url.toString url)
                            , Task.perform (\_ -> OpenModal entregable) (Task.succeed ())])

                    Nothing ->
                        (  model 
                        , Navigation.pushUrl model.key (Url.toString url)
                        )

            External url ->
                ( model , Navigation.load url)

    UrlChanged url ->
        case  getEntregableFromRoute  (Route.decode url) of
            Just entregable ->
                ( { model | route = Route.decode url}, Cmd.batch [Task.perform (\_ -> OpenModal entregable) (Task.succeed ())])

            Nothing ->
                ( { model | route = Route.decode url}, Cmd.none)


    DeviceClassified dimensions ->
        ( { model | device = (classifyDevice dimensions), dimensions = dimensions, modalView = none}, Cmd.none)
                
    HoverOn id ->
        ( { model | hovered = Set.insert id model.hovered }
        , Cmd.none
        )

    HoverOff id ->
        ( { model | hovered = Set.remove id model.hovered  }
        , Cmd.none
        )

    HoverOffAll ->
        ( { model | hovered = Set.empty}
        , Cmd.none
        )

    HoverOnMany ids ->
        let
            nuevos = List.foldl Set.insert model.hovered ids
        in
            ( { model | hovered = nuevos }
            , Cmd.none
            )

    HoverOffMany ids ->
        let
            nuevos = List.foldl Set.remove model.hovered ids
        in
            ( { model | hovered = nuevos }
            , Cmd.none
            )


    OpenModal entregable -> 
       ( { model | modalVisibility = Visible, modalTitle = entregable.tituloModal, modalView = entregable.vistaModal}
        , Cmd.none)


    CloseModal ->
       ( { model | modalVisibility = Hidden, modalView = none}, Task.succeed HoverOffAll |> Task.perform identity)

    SortEntregables sortOrder ->
        ( { model | sortOrder = sortOrder }
        , Task.succeed HoverOffAll |> Task.perform identity
        )
        
    _ ->
      (model, Cmd.none)



scrollToTop : Cmd Msg
scrollToTop =
    Browser.Dom.setViewport 0 0 |> Task.perform (\() -> NoOp)
    
    
-- VIEW


view : Model -> Browser.Document Msg
view model =
  let 
    (deviceClass, deviceOrientation) = 
        case model.device of
            { class, orientation} -> (class, orientation)


  in
    case model.route of
        Route.HomepageRoute ->
            viewHome model 

        _ ->
            viewHome model



viewHome : Model -> Browser.Document Msg
viewHome model =
    let 
        (deviceClass, deviceOrientation) = 
            case model.device of
                { class, orientation} -> (class, orientation)

    in
        { title  = "B1 Protfolio"
        , body =    
            [case deviceClass of
                Phone -> phoneView model
                Tablet -> desktopView model
                Desktop -> desktopView model
                BigDesktop -> desktopView model
            ]
        }



-- PHONE VIEW


phoneView : Model -> Html Msg
phoneView model =  
    let  
        sideFiller =  el [width (fillPortion 1), height fill] none

        centerCol = 
            case model.sortOrder of
                Desc -> 
                    column [centerX, centerY, width (fillPortion 10), height fill, spacing 10, paddingEach {top = 80, bottom = 20, left = 0, right = 10}]
                    <| List.indexedMap (\i (k, e) -> botonEntregable e (2000 + i) model.hovered) 
                    <| Dict.toList entregables    

                Categories ->
                    column [centerX, centerY, width (fillPortion 17), height fill, spacing 10, paddingEach {top = 80, bottom = 20, left = 10, right = 10}]
                    <| List.indexedMap (\i s -> 
                        column (borderStyle ++ [width fill, Background.color s.color, spacing 10, paddingEach {top = 20, bottom = 20, left = 10, right = 10}] )
                            <| List.append [paragraph [Font.center, paddingEach {top = 15, bottom = 15, left = 10, right = 10}] [ el montserratBold (text s.titulo)]]
                            <| List.indexedMap (\j e -> (botonEntregable e (i*1000 + j) model.hovered)) s.entregables 
                        ) 
                    <| seccionesEnOrden
    in
        layout 
        [ width fill, height fill, centerX, centerY, inFront <| Header.phoneHeader model]
        <| 
        column [centerX, width fill, height fill]
        [row [centerX, centerY, width fill, height fill, paddingEach {top = 40, left = 0, bottom = 50, right = 0}]
        <|  
            [ sideFiller
            , centerCol
            , sideFiller
            ]
        , Footer.footer]
 



-- DESKTOP VIEW

desktopView : Model -> Html Msg
desktopView model = 
  let 
    (modalAttrs, modal) = 
        case model.modalVisibility of
            Hidden ->
                ([] ,[])
            Visible ->
                ([HtmlAttributes.style "overflow" "hidden"] ,[ Modal.viewOverlay model])

  in
    Html.div (modalAttrs ++ [HtmlAttributes.class "main-container"])
      <| 
      [ Header.headerHtml ]
      ++ modal
      ++ [ layout 
          [ width fill, height fill, centerX, centerY, moveDown 150
          --  ,  behindContent <| infoDebug model -- TODO hide maybeÇ
          --, Background.color white
          ]
          <| column 
              [centerX, centerY, width fill, height fill]
              [ el [ width fill, height fill, paddingEach { top = 20, bottom = 80, left = 20, right = 20}]
                  (contenido model)
              , Footer.footer 
              ]  
      ]


contenido : Model -> Element Msg
contenido model =
    row [ centerX, centerY, spacing 40, width fill]
    [ aside model
    , mainSection model
    , asideEvidencias
    ]


aside : Model -> Element Msg
aside model = 
    let
        seccion = getSeccionByCode "ambitoscompe"
    in
        column 
            ([centerX, centerY, height fill
            , width (fill |> maximum 340)
            , padding 25, spacing 40])
            [paragraph [Font.center]
                [ el montserratBold
                    (text seccion.titulo)
                ]
            , column
                [alignLeft, alignTop, spacing 5]
                [ botonCompetencia (getEntregable "1" model.entregables) "1a entrega" [100, 1, 2, 3] model.hovered
                , botonCompetencia (getEntregable "2" model.entregables) "2a entrega" [101, 8, 10] model.hovered
                , botonCompetencia (getEntregable "3" model.entregables) "4a entrega" [102, 4, 5] model.hovered
                , botonCompetencia (getEntregable "4" model.entregables) "6a entrega" [103, 6, 18, 19] model.hovered
                , botonCompetencia (getEntregable "5" model.entregables) "3a entrega" [104, 9, 11, 12] model.hovered
                , botonCompetencia (getEntregable "6" model.entregables) "5a entrega" [105, 13, 14, 15, 16, 17] model.hovered
                ]
            ]

asideEvidencias : Element Msg
asideEvidencias = 
    let 
        iconos = [ "captura", "doc", "infografia", "audio", "contenido", "video"]

        textos = [ "Captura de pantalla y texto", "Documento", "Infografía", "Audio", "Contenido", "Video"]
    in
        column 
            ([centerX, centerY, height fill
            , width (fill |> maximum 270)
            , padding 25, spacing 40])
            [paragraph [Font.center]
            [ el montserratBold
                (text "Formatos de Evidencia")
            ]
            , column
                [alignRight, alignTop, spacing 20]
                <| List.map2 (\icono texto -> 
                    row [spacing 10, alignRight]
                    [ paragraph [Font.center]
                        [ el montserratSemi
                            (text texto)
                        ]
                    , image [height (px 60)] {src = "assets/" ++ icono ++ ".webp", description = texto}
                    ]) iconos textos
            ]

mainSection : Model -> Element Msg 
mainSection model = 
  row 
    ( borderStyle ++ 
    [centerX, centerY
    , width (fill |> maximum 1150)
    , height (shrink)
    , Background.color blanco
    ])
    [ contextoColaborativo model
    , centro model
    , ensenanzaAprendizaje model
    ]

contextoColaborativo : Model -> Element Msg
contextoColaborativo model = 
    let
        seccion = getSeccionByCode "concolab"
    in
        column
            [alignLeft, alignTop, width (fillPortion 1), height fill, padding 25, Background.color seccion.color, spacing 40]
            [paragraph []
            [ el montserratBold
                (text seccion.titulo)
            ]
            , column
                [alignLeft, alignTop, spacing 20
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
    (innerBorder ++ [centerX, alignTop, width (fillPortion 2), height fill, padding 25, spacing 10])
    [
      evaluacionPrevia model
    , contenidos model
    , contenidoProfundizacion model
    , contextoColaborativoAlumnado model
    , evaluacionYRetroalimentacion model
    ]


evaluacionPrevia : Model -> Element Msg
evaluacionPrevia model =
    let
        seccion = getSeccionByCode "preeval"
    in
        row 
            (borderStyle ++ [Background.color seccion.color, width fill, padding 15, spacing 10])
            [ paragraph [Font.center]
            [ el montserratBold
                (text seccion.titulo)
            ]
            , botonEntregable (getEntregable "4.A" model.entregables) 6 model.hovered
            ]


contenidos : Model -> Element Msg
contenidos model = 
  row 
    [ width fill, centerX, spacing 10]
    [ preguntaFlujo model, contenidoBasico model
    ]


preguntaFlujo : Model -> Element Msg
preguntaFlujo model = 
    column 
        ([spacing 10])
        [ 
          downArrowSvg [moveRight 65] chicleHex 
        , 
            row [spacing 10, paddingXY 20 0]
            [ paragraph [Background.color limon, paddingXY 10 27, Font.center, centerY , Border.rounded 100, Border.solid, Border.width 1, width (px 130), height (px 130)]
                [ el montserratSemi
                    (text "¿Tiene el conocimiento básico?")
                ]
            , rightArrowSvg [padding 5, centerX] chicleHex
            , el (montserratLight)
                (text "No")
            ]
        , downArrowSvg [moveRight 65]  chicleHex
        , el (montserratLight ++ [moveRight 80])
            (text "Sí")
        ]

contenidoBasico : Model -> Element Msg
contenidoBasico model = 
    let
        seccion = getSeccionByCode "conbasico"
    in
        column [spacing 10]
        [ upArrowSvg [moveRight 65] chicleHex
        , column 
            (borderStyle ++ [Background.color seccion.color, padding 15, spacing 10])
            [ paragraph [Font.center]
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
        seccion = getSeccionByCode "conprofund"
    in
        column 
            (borderStyle ++ [Background.color seccion.color, padding 15, spacing 10])
            [ paragraph [Font.center]
            [ el montserratBold
                (text seccion.titulo)
            ]
            , row [spacing 20]
            [ botonEntregable (getEntregable "2.B" model.entregables) 10 model.hovered
            , botonEntregable (getEntregable "5.A" model.entregables) 11 model.hovered
            , botonEntregable (getEntregable "5.B" model.entregables) 12 model.hovered]
            ]


contextoColaborativoAlumnado : Model -> Element Msg
contextoColaborativoAlumnado model = 
    let
        seccion = getSeccionByCode "colabalumn"
    in
        column 
            (borderStyle ++ [Background.color seccion.color, padding 15, spacing 10])
            [ paragraph [Font.center]
            [ el montserratBold
                (text seccion.titulo)
            ]
            , row [spacing 20]
                [ botonEntregable (getEntregable "6.A" model.entregables) 13 model.hovered
                , botonEntregable (getEntregable "6.B" model.entregables) 14 model.hovered
                , botonEntregable (getEntregable "6.C" model.entregables) 15 model.hovered
            ]
            , row [spacing 20]
                [ botonEntregable (getEntregable "6.D" model.entregables) 16 model.hovered
                , botonEntregable (getEntregable "6.E" model.entregables) 17 model.hovered
                ]
            ]

evaluacionYRetroalimentacion : Model -> Element Msg
evaluacionYRetroalimentacion model = 
    let
        seccion = getSeccionByCode "evlaretro"
    in
        column 
            (borderStyle ++ [Background.color seccion.color, padding 15, spacing 10, width fill])
            [ paragraph [Font.center]
            [ el montserratBold
                (text seccion.titulo)
            ]
            , row [spacing 20, centerX]
                [ botonEntregable (getEntregable "4.B" model.entregables) 18 model.hovered
                , botonEntregable (getEntregable "4.C" model.entregables) 19 model.hovered
            ]
            ]

ensenanzaAprendizaje : Model -> Element Msg
ensenanzaAprendizaje model = 
    let
        seccion = getSeccionByCode "ensapre"
    in
        column
            [alignRight, alignTop, width (fillPortion 1), height fill, padding 25, Background.color seccion.color, spacing 40]
            [paragraph [Font.alignRight]
            [ el montserratBold
                (text seccion.titulo)
            ]
            , column
                [alignRight, alignTop, spacing 20]
                [ botonEntregable (getEntregable "3.A" model.entregables) 4 model.hovered
                , botonEntregable (getEntregable "3.B" model.entregables) 5 model.hovered
                ]
            ]


-- infoDebug : Model -> Element msg
-- infoDebug model =
--     column [ width fill, height fill, Font.size 11, padding 10 ]
--         [ text ("key: " ++ Debug.toString model.key)
--         , text ("route: " ++ Debug.toString model.route)
--         , text ("device: " ++ Debug.toString model.device)
--         , text ("dimensions: " ++ Debug.toString model.dimensions)
--         , text ("hovered: " ++ Debug.toString model.hovered)
--         , text ("modalVisibility: " ++ Debug.toString model.modalVisibility)
--         , text ("modalTitle: " ++ model.modalTitle)
--         , text ("entregables: " ++ Debug.toString model.entregables)
--         , text ("sortOrder: " ++ Debug.toString model.sortOrder)
--         ]