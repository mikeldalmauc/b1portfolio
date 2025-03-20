module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, div)
import Set exposing (Set)
import Html.Attributes as HtmlAttributes exposing (style)
import Html.Events exposing (onClick, stopPropagationOn)

import Browser.Events exposing (onResize)

import Json.Decode as Decode

import Element exposing (..)
import Element.Font as Font
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events

import Styles exposing (..)

import Dict exposing (Dict)
import Task
import Entregables.Entregable1AComunicacion as E1A

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
  , modalVisibility : ModalVisibilty
  , modalView : Element Msg
  , modalTitle : String
  , entregables : Dict String Entregable
  , sortOrder : SortOrder
  }


type ModalVisibilty
    = Visible
    | Hidden

type SortOrder = Desc | Categories

type alias Dimensions =
    { width : Int
    , height : Int
    }


type alias Flags = Dimensions


type alias Entregable = 
    { codigo : String
    , descripcionEntregable : String
    , tipoEvidencia : Maybe String
    , tituloModal : String
    , vistaModal : Element Msg
    }

type alias Seccion = 
    { titulo : String
    , entregables : List Entregable
    , color : Color
    }

entregables : Dict String Entregable
entregables =
  Dict.fromList
    [ ("1", Entregable "1" "Compromiso profesional" (Just "video") E1A.title E1A.view)
    , ("2", Entregable "2" "Contenidos digitales" (Just "video") E1A.title E1A.view)
    , ("3", Entregable "3" "Enseñanza y aprendizaje" (Just "video") E1A.title E1A.view)
    , ("4", Entregable "4" "Evaluación y retroalimentación" (Just "video") E1A.title E1A.view)
    , ("5", Entregable "5" "Empoderamiento del alumnado" (Just "video") E1A.title E1A.view)
    , ("6", Entregable "6" "Desarrollo de la competencia digital del alumnado" (Just "video") E1A.title E1A.view)
        
    , ("1.A", Entregable "1.A" "Comunicación" (Just "captura") E1A.title E1A.view)
    , ("1.B", Entregable "1.B" "Trabajo en equipo" (Just "captura") E1A.title E1A.view)
    , ("1.C", Entregable "1.C" "Netiqueta" (Just "infografia") E1A.title E1A.view)

    , ("2.A", Entregable "2.A" "Básico" (Just "contenido") E1A.title E1A.view)
    , ("2.B", Entregable "2.B" "Profundización" (Just "contenido") E1A.title E1A.view)

    , ("3.A", Entregable "3.A" "Contexto colaborativo del alumnado" Nothing E1A.title E1A.view)
    , ("3.B", Entregable "3.B" "Recursos" Nothing E1A.title E1A.view)

    , ("4.A", Entregable "4.A" "Evaluación previa" Nothing E1A.title E1A.view)
    , ("4.B", Entregable "4.B" "Formativa" Nothing E1A.title E1A.view)
    , ("4.C", Entregable "4.C" "Retroalimentación" Nothing E1A.title E1A.view)

    , ("5.A", Entregable "5.A" "Accesibilidad" Nothing E1A.title E1A.view)
    , ("5.B", Entregable "5.B" "Personalización" Nothing E1A.title E1A.view)

    , ("6.A", Entregable "6.A" "Búsquedas" (Just "doc") E1A.title E1A.view)
    , ("6.B", Entregable "6.B" "Normas de conducta" (Just "doc") E1A.title E1A.view)
    , ("6.C", Entregable "6.C" "Contenidos digitales" (Just "doc") E1A.title E1A.view)
    , ("6.D", Entregable "6.D" "Uso responsable" (Just "doc") E1A.title E1A.view)
    , ("6.E", Entregable "6.E" "Resolución de problemas" (Just "doc") E1A.title E1A.view)
    ]

seccionesEnOrden : List Seccion
seccionesEnOrden =
    List.map (\s -> getSeccionByCode s)
        ["ambitoscompe"  
        , "concolab"  
        , "ensapre"
        , "preeval" 
        , "conbasico"
        , "conprofund"
        , "colabalumn"
        , "evlaretro"]


secciones : Dict String Seccion
secciones =
    let
        dictEntregables = entregables
    in 
        Dict.fromList
        [  ("ambitoscompe"  
                ,{ titulo = "Ámbitos de competencia"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["1", "2", "3", "4", "5", "6"]
                , color = blanco})
            , ("concolab"  
                ,{ titulo = "Contexto colaborativo del equipo docente"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["1.A", "1.B", "1.C"]
                , color = azul})
            , ("ensapre" 
                , { titulo = "Enseñanza y aprendizaje"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["3.A", "3.B"]
                , color = limon})
            , ("preeval"  
                ,{ titulo = "Evaluación previa sobre un tema"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["4.A"]
                , color = chicle})
            , ("conbasico" 
                ,{ titulo = "Contenido de conocimiento basico"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["2.A", "5.A"]
                , color = naranja})
            , ("conprofund"
                ,{ titulo = "Contenido de profundización"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["2.B", "5.A", "5.B"]
                , color = naranja})
            , ("colabalumn"
                ,{ titulo = "Contexto colaborativo del alumnado"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["6.A", "6.B", "6.C", "6.D", "6.E"]
                , color = turquesa})
            , ("evlaretro" 
                ,{ titulo = "Evaluacion Y Retroalimentacion"
                , entregables = List.map (\e -> getEntregable e dictEntregables) ["4.B", "4.C"]
                , color = chicle})
            ]
    


getSeccionByCode : String -> Seccion
getSeccionByCode code = 
    let 
        secc = secciones
    in 
        case Dict.get code secc of
            Just sec -> sec
            Nothing ->    
                { titulo = "esta seccion no es valida"
                , entregables = []
                , color = negro
                }


colorFromCode : String -> Color
colorFromCode code =
    case (List.head <| String.toList code) of
      Just c -> 
        case c of 
          '1' -> naranja
          '2' -> turquesa
          '3' -> azul
          '4' -> limon
          '5' -> chicle
          '6' -> rojo
          _ -> negro
      Nothing -> negro




getEntregable : String -> Dict String Entregable -> Entregable
getEntregable key dict = 
    case Dict.get key dict of
        Just entregable -> entregable
        Nothing -> Entregable "0" "Esto no es un entregable" Nothing "Esta pagina no debería verse" none


init : Dimensions -> ( Model, Cmd Msg )
init dimensions =
    ({    
        device = classifyDevice dimensions
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


type Msg
  = NoOp
  | DeviceClassified Dimensions
  | HoverOn Int
  | HoverOff Int
  | HoverOnMany (List Int)
  | HoverOffMany (List Int)
  | HoverOffAll
  | OpenModal String (Element Msg)
  | CloseModal
  | SortEntregables SortOrder


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =

  case msg of

    DeviceClassified dimensions ->
        ( { model | device = (classifyDevice dimensions), dimensions = dimensions } , Cmd.none)
                
    HoverOn id ->
        ( { model | hovered = Set.insert id model.hovered }
        , Cmd.none
        )

    HoverOff id ->
        ( { model | hovered = Set.remove id model.hovered }
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


    OpenModal modalTitle modalView -> 
       ( { model | modalVisibility = Visible, modalTitle = modalTitle, modalView = modalView }, Cmd.none)


    CloseModal ->
       ( { model | modalVisibility = Hidden, modalView = none}, Task.succeed HoverOffAll |> Task.perform identity)

    SortEntregables sortOrder ->
        ( { model | sortOrder = sortOrder }
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
    case deviceClass of
        Phone -> phoneView model
        Tablet -> desktopView model
        Desktop -> desktopView model
        BigDesktop -> desktopView model

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
                    <| List.indexedMap (\i (k, s) -> 
                        column (borderStyle ++ [width fill, Background.color s.color, spacing 10, paddingEach {top = 20, bottom = 20, left = 10, right = 10}] )
                            <| List.append [paragraph [Font.center, paddingEach {top = 15, bottom = 15, left = 10, right = 10}] [ el montserratBold (text s.titulo)]]
                            <| List.indexedMap (\j e -> (botonEntregable e (i*1000 + j) model.hovered)) s.entregables 
                        ) 
                    <| Dict.toList secciones
    in
        layout 
        [ width fill, height fill, centerX, centerY, inFront <| phoneHeader model]
        <| 
        column [centerX, width fill, height fill]
        [row [centerX, centerY, width fill, height fill, paddingEach {top = 40, left = 0, bottom = 50, right = 0}]
        <|  
            [ sideFiller
            , centerCol
            , sideFiller
            ]
        , footer]
 


phoneHeader : Model -> Element Msg
phoneHeader model = 
  row [alignTop, width fill, spacing 10, height (fill |> maximum 70), Background.color blanco, paddingXY 20 0, Border.widthEach {top=0, left=0, bottom=1, right=0}, Border.solid]
  [ image [paddingXY 0 0, height (px 40)] {src = "assets/favicon.svg", description = "Logo de Mikel"}
    , el 
      ( montserratBold
      ) 
      (text "   B1 Digitalizazioa")
  , sortOrderButton model
  ]



sortOrderButton : Model -> Element Msg
sortOrderButton model = 
    let 
        imageAttrs = [paddingXY 0 0, height (px 40), alignRight, htmlAttribute (HtmlAttributes.style "filter" "drop-shadow(2px 2px 0px #000000)")]
    in
        case model.sortOrder of
            Categories -> 
                image ((Events.onClick <| SortEntregables Desc) :: imageAttrs)
                    {src = "assets/sort-categories.svg", description = "Logo de Categorias"}
            Desc ->
                image ((Events.onClick <| SortEntregables Categories) :: imageAttrs)
                    {src = "assets/sort-desc.svg", description = "Logo de Ordenar"}


-- DESKTOP VIEW

desktopView : Model -> Html Msg
desktopView model = 
  let 
    modal = 
        case model.modalVisibility of
            Hidden ->
                []   
            Visible ->
                [ viewOverlay model]

  in
    Html.div [HtmlAttributes.class "main-container"]
      <| 
      [ headerHtml ]
      ++ modal
      ++ [ layout 
          [ width fill, height fill, centerX, centerY, moveDown 150
      --,  behindContent <| infoDebug model -- TODO hide maybeÇ
          --, Background.color white
          ]
          <| column 
              [centerX, centerY, width fill, height fill]
              [ el [ width fill, height fill, paddingEach { top = 20, bottom = 80, left = 20, right = 20}]
                  (contenido model)
              , footer 
              ]  
      ]

viewOverlay : Model -> Html Msg
viewOverlay model =
    div
        [ style "position" "fixed"
        , style "top" "0"
        , style "left" "0"
        , style "width" "100%"
        , style "height" "100%"
        , style "background-color" "rgba(0,0,0,0.4)"
        , style "z-index" "9999"
        , onClick CloseModal
        ]
        [ -- 2) El contenedor del modal en sí, centrado mediante position absolute + transform
          div
            [ style "position" "absolute"
            , style "top" "50%"
            , style "left" "50%"
            , style "transform" "translate(-50%, -50%)"
            , style "background-color" "white"
            , style "border-radius" "8px"
            , style "box-shadow" "0 4px 6px rgba(0,0,0,0.3)"
            , style "width" "70%"       -- Ajusta al tamaño deseado
            , style "max-width" "80%" -- O lo que prefieras
            , style "max-height" "80%" -- O lo que prefieras
            , style "padding" "20px"
             -- Evitamos que el clic aquí "suba" y cierre.  
            , stopPropagationOn "click" (Decode.succeed (NoOp, True))
            ]
            [  layout [] <| modalViewFun model
            ]
        ]

alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
  ( msg, True )


modalViewFun : Model -> Element Msg
modalViewFun model =
    let 
        dropShadowValue =
            if (Set.member 99 model.hovered) then
                "drop-shadow(3px 3px 1px darkgray)"
            else
                "none"
    in
    column
        [ scrollbars
        , width fill
        , height fill
        , Border.rounded 8
        , Background.color blanco
        , padding 20
        ]
        [ row [ width fill ]
            [ el (montserratBold) (text model.modalTitle)
            , closeButton 
                [ alignRight, pointer, Events.onClick CloseModal  
                , Events.onMouseEnter (HoverOn 99)
                , Events.onMouseLeave (HoverOff 99)
                , htmlAttribute (HtmlAttributes.style "filter" dropShadowValue)
                ]
            ]
        , model.modalView -- aquí va el contenido real del modal
        ]


headerHtml : Html Msg
headerHtml =
    Html.div
        [ HtmlAttributes.class "fixed-header"]
        [ encabezadoFijado ]

encabezadoFijado : Html Msg
encabezadoFijado =
    layout [Background.color blanco] 
        <| 
        row [centerY, paddingXY 20 0, width fill]
        [el 
            ( montserratTitulo
            ) 
            (text "B1 Competencia digital del profesorado")
        , image [alignRight, paddingXY 20 0, height (px 50)] {src = "assets/favicon.svg", description = "Logo de Mikel"}
        ]


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


botonEntregable : Entregable -> Int -> Set Int -> Element Msg
botonEntregable entregable id hovered= 
  let
    (shadowStyle, dropShadowValue) =
        if (Set.member id hovered) then
            ([Border.shadow
                { offset = (4, 4)
                , size = 2
                , blur = 0
                , color = negro
                }
            ], "drop-shadow(3px 3px 0px black)")
        else
            ([], "none")
    
    iconoEvidencia = case entregable.tipoEvidencia of 
        Just icono  -> image [height (px 40), alignRight, moveRight 20, moveDown 20, htmlAttribute (HtmlAttributes.style "filter" dropShadowValue)] {src = "assets/" ++ icono ++ ".webp", description = "icono de evidencia"}
        Nothing -> none
  in
    row (borderStyle ++ shadowStyle ++
        [ Background.color <| colorFromCode entregable.codigo, width fill, height (px 60), padding 10, spacing 5, pointer
        , Events.onMouseEnter (HoverOn id)
        , Events.onMouseLeave (HoverOff id)
        , inFront iconoEvidencia
        , Events.onClick <| OpenModal entregable.tituloModal entregable.vistaModal
        ])
        <| 
        [el (montserratBold ++ []) (text entregable.codigo), paragraph (montserratLight ++ [paddingEach {top = 0, right = 20, bottom = 0, left = 0}]) [text entregable.descripcionEntregable]]


botonCompetencia : Entregable -> String -> List Int -> Set Int -> Element Msg
botonCompetencia entregable entrega ids hovered= 
  let
    (shadowStyle, factor, dropShadowValue) = 
        case (List.head ids) of
            Nothing -> ([], 0.7, "none")
            Just id -> 
                if (Set.member id hovered) then
                    ([Border.shadow
                        { offset = (2, 2)
                        , size = 2
                        , blur = 0
                        , color = negro
                        }
                    ], 0.0, "drop-shadow(3px 3px 0px black)")
                else
                    ([], 0.7, "none")
    color = colorFromCode entregable.codigo
  in
    row (
        [ width fill, height (px 70), padding 7, spacing 30, pointer
        , Events.onMouseEnter (HoverOnMany ids)
        , Events.onMouseLeave (HoverOffMany ids)
        , Events.onClick <| OpenModal entregable.tituloModal entregable.vistaModal
        ])
        [el (shadowStyle ++ montserratBold ++ [Font.center, centerX, centerY, width <| px 50, height <| px 50, Background.color color, Border.width 1, Border.solid, Border.rounded 50, padding 15]) (text entregable.codigo)
        , column [alignLeft, width (fill), spacing 10] 
            [ paragraph (montserratSemiBold ++ [ Font.color color, Font.shadow { offset = ( 1, 1 ), blur = 0, color = oscurecer color factor}]) [text entregable.descripcionEntregable]
            , paragraph (montserratLight ++ [ Font.shadow { offset = ( 0.5, 0.5 ), blur = 0, color = oscurecer grisclaro factor}]) [text entrega]
            ]
        , image [height (px 50), htmlAttribute (HtmlAttributes.style "filter" dropShadowValue)] {src = "assets/" ++ "video" ++ ".webp", description = "icono de video"}
        ]


-- infoDebug : Model -> Element msg
-- infoDebug model =
--     column 
--         [ width fill, height fill, Font.size 11, padding 10]
--         [ 
--         --  text <| "wheel Delta Y: " ++ fromFloat model.wheelModel.deltaY
--       --  , text <| "wheel Delta X: " ++ fromFloat model.wheelModel.deltaX
--        -- , text <| "tab: " ++ fromInt model.tab
--         --,
--          text <| "device: " ++ Debug.toString model.device
--          , text <| "dimensions: " ++ Debug.toString model.dimensions
--         -- , text <| "galleryTab1: " ++ Debug.toString model.galleryTab1
--         -- , text <| "gesture: " ++ Debug.toString model.gesture
--         ]