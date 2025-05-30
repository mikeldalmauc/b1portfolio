module Entregables.Entregables exposing (..)

import Dict exposing (Dict)
import Element exposing (Color, Device, Element, none)
import Entregables.Entregable1 as E1
import Entregables.Entregable1A as E1A
import Entregables.Entregable1B as E1B
import Entregables.Entregable1C as E1C
import Entregables.Entregable2 as E2
import Entregables.Entregable2A as E2A
import Entregables.Entregable2B as E2B
import Entregables.Entregable3 as E3
import Entregables.Entregable3A as E3A
import Entregables.Entregable3B as E3B
import Entregables.Entregable4 as E4
import Entregables.Entregable4A as E4A
import Entregables.Entregable4B as E4B
import Entregables.Entregable4C as E4C
import Entregables.Entregable5 as E5
import Entregables.Entregable5A as E5A
import Entregables.Entregable5B as E5B
import Entregables.Entregable6 as E6
import Entregables.Entregable6A as E6A
import Entregables.Entregable6B as E6B
import Entregables.Entregable6C as E6C
import Entregables.Entregable6D as E6D
import Entregables.Entregable6E as E6E
import Entregables.Titulos exposing (..)
import Route exposing (Route(..))
import Styles exposing (..)
import Types exposing (..)


entregables : Dict String Entregable
entregables =
    Dict.fromList
        [ ( "1", Entregable "1" Entregable1 "Compromiso profesional" (Just "video") (titulo "E1") E1.view )
        , ( "2", Entregable "2" Entregable2 "Contenidos digitales" (Just "video") (titulo "E2") E2.view )
        , ( "3", Entregable "3" Entregable3 "Enseñanza y aprendizaje" (Just "video") (titulo "E3") E3.view )
        , ( "4", Entregable "4" Entregable4 "Evaluación y retroalimentación" (Just "video") (titulo "E4") E4.view )
        , ( "5", Entregable "5" Entregable5 "Empoderamiento del alumnado" (Just "video") (titulo "E5") E5.view )
        , ( "6", Entregable "6" Entregable6 "Desarrollo de la competencia digital del alumnado" (Just "video") (titulo "E6") E6.view )
        , ( "1.A", Entregable "1.A" Entregable1A "Comunicación" (Just "captura") (titulo "E1A") E1A.view )
        , ( "1.B", Entregable "1.B" Entregable1B "Trabajo en equipo" (Just "captura") (titulo "E1B") E1B.view )
        , ( "1.C", Entregable "1.C" Entregable1C "Netiqueta" (Just "infografia") (titulo "E1C") E1C.view )
        , ( "2.A", Entregable "2.A" Entregable2A "Básico" (Just "contenido") (titulo "E2A") E2A.view )
        , ( "2.B", Entregable "2.B" Entregable2B "Profundización" (Just "contenido") (titulo "E2B") E2B.view )
        , ( "3.A", Entregable "3.A" Entregable3A "Contexto colaborativo del alumnado" Nothing (titulo "E3A") E3A.view )
        , ( "3.B", Entregable "3.B" Entregable3B "Recursos" Nothing (titulo "E3B") E3B.view )
        , ( "4.A", Entregable "4.A" Entregable4A "Evaluación previa" Nothing (titulo "E4A") E4A.view )
        , ( "4.B", Entregable "4.B" Entregable4B "Formativa" Nothing (titulo "E4B") E4B.view )
        , ( "4.C", Entregable "4.C" Entregable4C "Retroalimentación" Nothing (titulo "E4C") E4C.view )
        , ( "5.A", Entregable "5.A" Entregable5A "Accesibilidad" Nothing (titulo "E5A") E5A.view )
        , ( "5.B", Entregable "5.B" Entregable5B "Personalización" Nothing (titulo "E5B") E5B.view )
        , ( "6.A", Entregable "6.A" Entregable6A "Búsquedas" (Just "doc") (titulo "E6A") E6A.view )
        , ( "6.B", Entregable "6.B" Entregable6B "Normas de conducta" (Just "doc") (titulo "E6B") E6B.view )
        , ( "6.C", Entregable "6.C" Entregable6C "Contenidos digitales" (Just "doc") (titulo "E6C") E6C.view )
        , ( "6.D", Entregable "6.D" Entregable6D "Uso responsable" (Just "doc") (titulo "E6D") E6D.view )
        , ( "6.E", Entregable "6.E" Entregable6E "Resolución de problemas" (Just "doc") (titulo "E6E") E6E.view )
        ]


getEntregableFromRoute : Route -> Maybe Entregable
getEntregableFromRoute route =
    List.head <|
        Dict.values <|
            Dict.filter
                (\key v ->
                    case v.route of
                        r ->
                            r == route
                )
                entregables


seccionesEnOrden : List Seccion
seccionesEnOrden =
    let
        dict =
            secciones
    in
    List.map (\s -> getSeccionByCodeDict s dict)
        [ "ambitoscompe"
        , "concolab"
        , "ensapre"
        , "preeval"
        , "conbasico"
        , "conprofund"
        , "colabalumn"
        , "evlaretro"
        ]


secciones : Dict String Seccion
secciones =
    let
        dictEntregables =
            entregables
    in
    Dict.fromList
        [ ( "ambitoscompe"
          , { titulo = "Ámbitos de competencia"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "1", "2", "3", "4", "5", "6" ]
            , color = blanco
            }
          )
        , ( "concolab"
          , { titulo = "Contexto colaborativo del equipo docente"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "1.A", "1.B", "1.C" ]
            , color = azul
            }
          )
        , ( "ensapre"
          , { titulo = "Enseñanza y aprendizaje"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "3.A", "3.B" ]
            , color = limon
            }
          )
        , ( "preeval"
          , { titulo = "Evaluación previa sobre un tema"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "4.A" ]
            , color = chicle
            }
          )
        , ( "conbasico"
          , { titulo = "Contenido de conocimiento basico"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "2.A", "5.A" ]
            , color = naranja
            }
          )
        , ( "conprofund"
          , { titulo = "Contenido de profundización"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "2.B", "5.A", "5.B" ]
            , color = naranja
            }
          )
        , ( "colabalumn"
          , { titulo = "Trabajando con el alumnado"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "6.A", "6.B", "6.C", "6.D", "6.E" ]
            , color = turquesa
            }
          )
        , ( "evlaretro"
          , { titulo = "Evaluacion Y Retroalimentacion"
            , entregables = List.map (\e -> getEntregable e dictEntregables) [ "4.B", "4.C" ]
            , color = chicle
            }
          )
        ]


getSeccionByCodeDict : String -> Dict String Seccion -> Seccion
getSeccionByCodeDict code dict =
    case Dict.get code dict of
        Just sec ->
            sec

        Nothing ->
            { titulo = "esta seccion no es valida"
            , entregables = []
            , color = negro
            }


getSeccionByCode : String -> Seccion
getSeccionByCode code =
    let
        secc =
            secciones
    in
    case Dict.get code secc of
        Just sec ->
            sec

        Nothing ->
            { titulo = "esta seccion no es valida"
            , entregables = []
            , color = negro
            }


colorFromCode : String -> Color
colorFromCode code =
    case List.head <| String.toList code of
        Just c ->
            case c of
                '1' ->
                    naranja

                '2' ->
                    turquesa

                '3' ->
                    azul

                '4' ->
                    limon

                '5' ->
                    chicle

                '6' ->
                    rojo

                _ ->
                    negro

        Nothing ->
            negro


getEntregable : String -> Dict String Entregable -> Entregable
getEntregable key dict =
    case Dict.get key dict of
        Just entregable ->
            entregable

        Nothing ->
            Entregable "0" HomepageRoute "Esto no es un entregable" Nothing "Esta pagina no debería verse" (\d -> none)
