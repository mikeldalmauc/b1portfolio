module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html)
import Set exposing (Set)
import Html.Attributes as HtmlAttributes

import Browser.Events exposing (onResize)

import Element exposing (..)
import Element.Font as Font
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events

import Styles exposing (..)

-- MAIN

main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onResize 
            (\width height ->
                DeviceClassified { width = width, height = height })
        ]


-- MODEL


type alias Model = 
  { device : Device
  , dimensions : Dimensions
  , hovered : Set Int
  }
  

init : Dimensions -> ( Model, Cmd Msg )
init dimensions =
    ({    
        device = Element.classifyDevice dimensions
      , dimensions = dimensions
      , hovered = Set.empty
    }
    , Cmd.none
    )


type alias Dimensions =
    { width : Int
    , height : Int
    }


type alias Flags = Dimensions


-- UPDATE


type Msg
  = None
  | DeviceClassified Dimensions
  | HoverOn Int
  | HoverOff Int
  | HoverOnMany (List Int)
  | HoverOffMany (List Int)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    DeviceClassified dimensions ->
        ( { model | device = (Element.classifyDevice dimensions), dimensions = dimensions } , Cmd.none)
                
    HoverOn id ->
        ( { model | hovered = Set.insert id model.hovered }
        , Cmd.none
        )

    HoverOff id ->
        ( { model | hovered = Set.remove id model.hovered }
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

    _ ->
      (model, Cmd.none)


-- VIEW


view : Model -> Html Msg
view model =
  let 
    (deviceClass, deviceOrientation) = 
        case model.device of
            { class, orientation} -> (class, orientation)
  in
    Html.div [HtmlAttributes.class "main-container"]
    [ headerHtml
    , layout 
        [ width fill, height fill, centerX, centerY, moveDown 150
    --,  behindContent <| infoDebug model -- TODO hide maybeÇ
        --, Background.color white
        ]   
        <| column 
            [centerX, centerY, width fill, height fill]
            [ Element.el [ width fill, height fill, paddingEach { top = 20, bottom = 80, left = 20, right = 20}]
                (contenido model)
            , footer 
            ]
            
    ]

headerHtml : Html Msg
headerHtml =
    Html.div
        [ HtmlAttributes.class "fixed-header"]
        [ encabezadoFijado ]

encabezadoFijado : Html Msg
encabezadoFijado =
    layout []
        <| 
        row [centerY, paddingXY 20 0, width fill]
        [Element.el 
            ( montserratTitulo
            ) 
            (text "B1 Competencia digital del profesorado")
        , Element.image [alignRight, paddingXY 20 0, height (px 50)] {src = "/assets/favicon.svg", description = "Logo de Mikel"}
        ]


footer : Element Msg
footer = 
    column [paddingXY 20 40, width fill, height (px 200), Background.color negro, spaceEvenly]
    [ Element.el 
        ( montserratLight ++ [Font.color blanco, centerX]
        ) 
        (text "B1 Competencia digital del profesorado")
    , Element.el 
        ( montserratLight ++ [Font.color blanco, centerX]
        ) 
        (text "Mikel Dalmau")
    , Element.image [centerX, paddingXY 20 0, height (px 50)] {src = "/assets/CC.webp", description = "Creative Commons, Non comercial, Share Alike"}
    ]

contenido : Model -> Element Msg
contenido model =
    row [ centerX, centerY, spacing 30, width fill]
    [ aside model
    , mainSection model
    , asideEvidencias
    ]

aside : Model -> Element Msg
aside model = 
  column 
    ([centerX, centerY, height fill, width (fill |> maximum 500), padding 25, spacing 40])
    [Element.paragraph [Font.center]
      [ Element.el montserratBold
        (text "Ámbitos de competencia")
      ]
    , column
        [alignLeft, alignTop, spacing 5]
        [ botonCompetencia "1" "Compromiso profesional" "1a entrega" naranja [100, 1, 2, 3] model.hovered
        , botonCompetencia "2" "Contenidos digitales" "2a entrega" turquesa [101, 8, 10] model.hovered
        , botonCompetencia "3" "Enseñanza y aprendizaje" "3a entrega" azul [102, 4, 5] model.hovered
        , botonCompetencia "4" "Evaluación y retroalimentación" "4a entrega" limon [103, 6, 18, 19] model.hovered
        , botonCompetencia "5" "Empoderamiento del alumnado" "5a entrega" chicle [104, 9, 11, 12] model.hovered
        , botonCompetencia "6" "Desarrollo de la competencia digital del alumnado" "6a entrega" rojo [105, 13, 14, 15, 16, 17] model.hovered
        ]
    ]

asideEvidencias : Element Msg
asideEvidencias = 
    let 
        iconos = [ "captura", "doc", "infografia", "audio", "contenido", "video"]

        textos = [ "Captura de pantalla y texto", "Documento", "Infografía", "Audio", "Contenido", "Video"]
    in
        column 
            ([centerX, centerY, height fill, width (fill |> maximum 300), padding 25, spacing 40])
            [Element.paragraph [Font.center]
            [ Element.el montserratBold
                (text "Formatos de Evidencia")
            ]
            , column
                [alignRight, alignTop, spacing 20]
                <| List.map2 (\icono texto -> 
                    row [spacing 10, alignRight]
                    [ Element.paragraph [Font.center]
                        [ Element.el montserratSemi
                            (text texto)
                        ]
                    , Element.image [height (px 60)] {src = "/assets/" ++ icono ++ ".webp", description = texto}
                    ]) iconos textos
            ]

mainSection : Model -> Element Msg 
mainSection model = 
  row 
    ( borderStyle ++ 
    [centerX, centerY
    , width (fill |> maximum 1200)
    , height (shrink)
    -- , Element.explain Debug.todo
    ])
    [ contextoColaborativo model
    , centro model
    , ensenanzaAprendizaje model
    ]

contextoColaborativo : Model -> Element Msg
contextoColaborativo model = 
  column
    [alignLeft, alignTop, width (fillPortion 1), height fill, padding 25, Background.color azul, spacing 40]
    [Element.paragraph []
      [ Element.el montserratBold
        (text "Contexto colaborativo del equipo docente")
      ]
    , column
        [alignLeft, alignTop, spacing 20
        -- , Element.explain Debug.todo 
        ]
        [ botonEntregable "1.A" "Comunicación" (Just "captura")naranja 1 model.hovered
        , botonEntregable "1.B" "Trabajo en equipo" (Just "captura") naranja 2 model.hovered
        , botonEntregable "1.C" "Netiqueta" (Just "infografia") naranja 3 model.hovered
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
  row 
    (borderStyle ++ [Background.color chicle, width fill, padding 15, spacing 10])
    [ Element.paragraph [Font.center]
      [ Element.el montserratBold
        (text "Evaluación previa sobre un tema")
      ]
    , botonEntregable "4.A" "Evaluación previa" Nothing limon 6 model.hovered
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
            [ Element.paragraph [Background.color limon, paddingXY 10 27, Font.center, centerY , Border.rounded 100, Border.solid, Border.width 1, width (px 130), height (px 130)]
                [ Element.el montserratSemi
                    (text "¿Tiene el conocimiento básico?")
                ]
            , rightArrowSvg [Element.padding 5, centerX] chicleHex
            , Element.el (montserratLight)
                (text "No")
            ]
        , downArrowSvg [moveRight 65]  chicleHex
        , Element.el (montserratLight ++ [moveRight 80])
            (text "Sí")
        ]

contenidoBasico : Model -> Element Msg
contenidoBasico model = 
    column [spacing 10]
    [ upArrowSvg [moveRight 65] chicleHex
    , column 
        (borderStyle ++ [Background.color naranja, padding 15, spacing 10])
        [ Element.paragraph [Font.center]
        [ Element.el montserratBold
            (text "Contenido de conocimiento basico")
        ]
        , botonEntregable "2.A" "Básico" (Just "contenido") turquesa 8 model.hovered
        , botonEntregable "5.A" "Accesibilidad" Nothing chicle 9 model.hovered
        ]
    ]

contenidoProfundizacion : Model -> Element Msg
contenidoProfundizacion model = 
  column 
    (borderStyle ++ [Background.color naranja, padding 15, spacing 10])
    [ Element.paragraph [Font.center]
      [ Element.el montserratBold
        (text "Contenido de profundización")
      ]
    , row [spacing 20]
    [ botonEntregable "2.B" "Básico" (Just "contenido") turquesa 10 model.hovered
    , botonEntregable "5.A" "Accesibilidad" Nothing chicle 11 model.hovered
    , botonEntregable "5.B" "Personalización" Nothing chicle 12 model.hovered]
    ]


contextoColaborativoAlumnado : Model -> Element Msg
contextoColaborativoAlumnado model = 
  column 
    (borderStyle ++ [Background.color turquesa, padding 15, spacing 10])
    [ Element.paragraph [Font.center]
      [ Element.el montserratBold
        (text "Contexto colaborativo del alumnado")
      ]
    , row [spacing 20]
        [ botonEntregable "6.A" "Búsquedas" (Just "doc") rojo 13 model.hovered
        , botonEntregable "6.B" "Normas de conducta" (Just "doc") rojo 14 model.hovered
        , botonEntregable "6.C" "Contenidos digitales" (Just "doc") rojo 15 model.hovered
      ]
    , row [spacing 20]
        [ botonEntregable "6.D" "Uso responsable" (Just "doc") rojo 16 model.hovered
        , botonEntregable "6.E" "Resolución de problemas" (Just "doc") rojo 17 model.hovered
        ]
    ]

evaluacionYRetroalimentacion : Model -> Element Msg
evaluacionYRetroalimentacion model = 
  column 
    (borderStyle ++ [Background.color chicle, padding 15, spacing 10, width fill])
    [ Element.paragraph [Font.center]
      [ Element.el montserratBold
        (text "Evaluacion Y Retroalimentacion")
      ]
    , row [spacing 20, centerX]
        [ botonEntregable "4.B" "Formativa" Nothing limon 18 model.hovered
        , botonEntregable "4.C" "Retroalimentación" Nothing limon 19 model.hovered
      ]
    ]

ensenanzaAprendizaje : Model -> Element Msg
ensenanzaAprendizaje model = 
 column
    [alignRight, alignTop, width (fillPortion 1), height fill, padding 25, Background.color limon, spacing 40]
    [Element.paragraph [Font.alignRight]
      [ Element.el montserratBold
        (text "Enseñanza y aprendizaje")
      ]
    , column
        [alignRight, alignTop, spacing 20]
        [ botonEntregable "3.A" "Contexto colaborativo del alumnado" Nothing azul 4 model.hovered
        , botonEntregable "3.B" "Recursos" Nothing azul 5 model.hovered
        ]
    ]


type alias DescripcionEntregable = String
type alias NumeroEntregable = String
type alias Align = Attribute Msg
type alias Evidencia = String

botonEntregable : NumeroEntregable -> DescripcionEntregable -> Maybe Evidencia -> Color -> Int -> Set Int -> Element Msg
botonEntregable num desc evidencia color id hovered= 
  let
    shadowStyle =
        if (Set.member id hovered) then
            [Border.shadow
                { offset = (4, 4)
                , size = 2
                , blur = 0
                , color = negro
                }
            ]
        else
            []
    
    iconoEvidencia = case evidencia of 
        Just icono  -> Element.image [height (px 40), alignRight, moveRight 20, moveDown 20] {src = "/assets/" ++ icono ++ ".webp", description = "icono de evidencia"}
        Nothing -> Element.none
  in
    row (borderStyle ++ shadowStyle ++
        [ Background.color color, width fill, height (px 60), padding 10, spacing 5, pointer
        , Events.onMouseEnter (HoverOn id)
        , Events.onMouseLeave (HoverOff id)
        , inFront iconoEvidencia
        ])
        <| 
        [Element.el (montserratBold ++ []) (text num), Element.paragraph (montserratLight ++ [paddingEach {top = 0, right = 20, bottom = 0, left = 0}]) [text desc]]


botonCompetencia : NumeroEntregable -> DescripcionEntregable -> String -> Color -> List Int -> Set Int -> Element Msg
botonCompetencia num desc entrega color ids hovered= 
  let
    (shadowStyle, factor) = 
        case (List.head ids) of
            Nothing -> ([], 0.7)
            Just id -> 
                if (Set.member id hovered) then
                    ([Border.shadow
                        { offset = (2, 2)
                        , size = 2
                        , blur = 0
                        , color = negro
                        }
                    ], 0.0)
                else
                    ([], 0.7)
  in
    row (
        [ width fill, height (px 70), padding 7, spacing 30, pointer
        , Events.onMouseEnter (HoverOnMany ids)
        , Events.onMouseLeave (HoverOffMany ids)
        ])
        [Element.el (shadowStyle ++ montserratBold ++ [Font.center, centerX, centerY, width <| px 50, height <| px 50, Background.color color, Border.width 1, Border.solid, Border.rounded 50, padding 15]) (text num)
        , column [alignLeft, width (fill), spacing 10] 
            [ Element.paragraph (montserratSemiBold ++ [ Font.color color, Font.shadow { offset = ( 1, 1 ), blur = 0, color = oscurecer color factor}]) [text desc]
            , Element.paragraph (montserratLight ++ [ Font.shadow { offset = ( 1, 1 ), blur = 0, color = oscurecer grisclaro factor}]) [text entrega]
            ]
        , Element.image [height (px 50)] {src = "/assets/" ++ "video" ++ ".webp", description = "icono de video"}
        ]


infoDebug : Model -> Element msg
infoDebug model =
    column 
        [ width fill, height fill, Font.size 11, padding 10]
        [ 
        --  text <| "wheel Delta Y: " ++ fromFloat model.wheelModel.deltaY
      --  , text <| "wheel Delta X: " ++ fromFloat model.wheelModel.deltaX
       -- , text <| "tab: " ++ fromInt model.tab
        --,
         text <| "device: " ++ Debug.toString model.device
         , text <| "dimensions: " ++ Debug.toString model.dimensions
        -- , text <| "galleryTab1: " ++ Debug.toString model.galleryTab1
        -- , text <| "gesture: " ++ Debug.toString model.gesture
        ]