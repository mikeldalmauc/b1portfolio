module Types exposing (..)


import Dict exposing (Dict)
import Set exposing (Set)
import Element exposing (Element, Color, Device, none)
import Styles exposing (..)
import Entregables.Entregable1AComunicacion as E1A
import Browser.Navigation as Navigation
import Url exposing (Url)
import Route exposing (Route)
import Browser exposing (UrlRequest)
-- MSG 



type Msg = NoOp
    | UrlClicked UrlRequest
    | UrlChanged Url
    | DeviceClassified Dimensions
    | HoverOn Int
    | HoverOff Int
    | HoverOnMany (List Int)
    | HoverOffMany (List Int)
    | HoverOffAll
    | OpenModal String (Element Msg)
    | CloseModal
    | SortEntregables SortOrder


-- MODEL

type alias Model = 
    { key : Navigation.Key
    , route : Route
    , device : Device
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
    let 
        dict = secciones
    in
        List.map (\s -> getSeccionByCodeDict s dict)
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
    


getSeccionByCodeDict : String -> Dict String Seccion -> Seccion
getSeccionByCodeDict code dict = 
    case Dict.get code dict of
        Just sec -> sec
        Nothing ->    
            { titulo = "esta seccion no es valida"
            , entregables = []
            , color = negro
            }

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

