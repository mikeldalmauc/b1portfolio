module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html)
import Browser.Events exposing (onResize)

import Element exposing (..)
import Element.Font as Font

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
    --, Element.explain Debug.todo
    ,  behindContent <| infoDebug model -- TODO hide maybeÇ
      ]
      mainSection  


mainSection: Element Msg
mainSection = 
  column 
    [width (fill |> maximum 1000), centerX]
    <| List.repeat 20 fontTest


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