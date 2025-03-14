module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html)

import Element exposing (..)
import Styles exposing (..)

-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = Int


init : Model
init =
  0



-- UPDATE


type Msg
  = None


update : Msg -> Model -> Model
update msg model =
  case msg of
    _ ->
      model


-- VIEW


view : Model -> Html Msg
view model =
   layout 
    [ width fill, height fill
    -- , Element.explain Debug.todo
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