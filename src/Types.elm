module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Element exposing (Color, Device, Element)
import Lottie
import Route exposing (Route(..))
import Set exposing (Set)
import Url exposing (Url)



-- MSG


type Msg
    = NoOp
    | UrlClicked UrlRequest
    | UrlChanged Url
    | DeviceClassified Dimensions
    | HoverOn Int
    | HoverOff Int
    | HoverOnMany (List Int)
    | HoverOffMany (List Int)
    | HoverOffAll
    | OpenModal Entregable
    | CloseModal
    | SortEntregables SortOrder
    | GoTo Route
    | OpenMenu
    | LottieMsg



-- MODEL


type alias Model =
    { key : Navigation.Key
    , route : Route
    , device : Device
    , dimensions : Dimensions
    , hovered : Set Int
    , modalVisibility : ModalVisibilty
    , modalView : Dimensions -> Element Msg
    , modalTitle : String
    , entregables : Dict String Entregable
    , sortOrder : SortOrder
    , menuVisible : ModalVisibilty
    }


type ModalVisibilty
    = Visible
    | Hidden


type SortOrder
    = Desc
    | Categories


type alias Dimensions =
    { width : Int
    , height : Int
    }


type alias Flags =
    Dimensions


type alias Entregable =
    { codigo : String
    , route : Route
    , descripcionEntregable : String
    , tipoEvidencia : Maybe String
    , tituloModal : String
    , vistaModal : Dimensions -> Element Msg
    }


type alias Seccion =
    { titulo : String
    , entregables : List Entregable
    , color : Color
    }
