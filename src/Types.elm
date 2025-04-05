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
    | OpenEntregable Entregable
    | CloseEntregable
    | SortEntregables SortOrder
    | GoTo Route
    | OpenMenu
    | LottieMsg
    | MountH5P
    | CleanH5PContent
    | Highlight
    | OpenModal String
    | CloseModal



-- MODEL


type alias Model =
    { key : Navigation.Key
    , route : Route
    , device : Device
    , dimensions : Dimensions
    , hovered : Set Int
    , entregableVisibility : Visibility
    , entregableView : Dimensions -> Element Msg
    , entregableTitle : String
    , entregables : Dict String Entregable
    , modalVisibility : Visibility
    , modalView : String
    , sortOrder : SortOrder
    , menuVisible : Visibility
    }


type Visibility
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
    , tituloEntregable : String
    , vistaEntregable : Dimensions -> Element Msg
    }


type alias Seccion =
    { titulo : String
    , entregables : List Entregable
    , color : Color
    }
