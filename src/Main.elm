module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html)
import Html.Attributes as HtmlAttributes

import Browser.Events exposing (onResize)

import Element exposing (..)
import Element.Font as Font
import Element.Background as Background
import Element.Border as Border

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
  }
  

init : Dimensions -> ( Model, Cmd Msg )
init dimensions =
    ({    
        device = Element.classifyDevice dimensions
        , dimensions = dimensions
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    DeviceClassified dimensions ->
                ( { model | device = (Element.classifyDevice dimensions), dimensions = dimensions } , Cmd.none)

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
    layout 
      [ width fill, height fill
    -- , Element.explain Debug.todo
    ,  behindContent <| infoDebug model -- TODO hide maybeÇ
    --, Background.color white
      ]   
      <| mainSection model


mainSection : Model -> Element Msg 
mainSection model = 
  row 
    ( borderStyle ++ 
    [centerX, centerY
    , width (fill |> maximum 1300)
    , height (fill |> maximum 800)
    -- , Element.explain Debug.todo
    ])
    [
      contextoColaborativo model,
      centro model,
      ensenanzaAprendizaje model
    ]

contextoColaborativo : Model -> Element Msg
contextoColaborativo model = 
  column
    [alignLeft, alignTop, width (fillPortion 1), height fill, padding 25, Background.color limon, spacing 40]
    [Element.paragraph []
      [ Element.el montserratBold
        (text "Contexto colaborativo del equipo docente")
      ]
    , botones model
    ]

botones : Model -> Element Msg
botones model = 
   column
    [alignLeft, alignTop, spacing 10]
    [ botonEntregable "1.A" "Comunicación" chicle
    , botonEntregable "1.A" "Trabajo en equipo" chicle
    , botonEntregable "1.A" "Netiqueta" chicle
    ]

type alias DescripcionEntregable = String
type alias NumeroEntregable = String

botonEntregable : NumeroEntregable -> DescripcionEntregable -> Color -> Element Msg
botonEntregable num desc color = 
  row (borderStyleBoton ++ [centerX, centerY, Background.color color, padding 10])
    [Element.el montserratBold (text num)
    ,Element.el montserratLight (text desc)]


centro : Model -> Element Msg
centro model = 
 column
    (innerBorder ++ [centerX, alignTop, width (fillPortion 2), height fill, padding 25])
    [fontTest]


ensenanzaAprendizaje : Model -> Element Msg
ensenanzaAprendizaje model = 
 column
    [alignRight, alignTop, width (fillPortion 1), height fill, padding 25, Background.color azul]
    [Element.paragraph [Font.alignRight]
      [ Element.el montserratBold
        (text "Enseñanza y aprendizaje")
      ]
    ]


fontTest: Element Msg
fontTest =
  column [centerX, centerY]
    [ Element.el
        montserratBold
        (text "Some bold text")
    , 
    Element.el
        montserratLight
        (text "some ligth paragraph long")
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