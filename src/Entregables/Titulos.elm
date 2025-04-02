module Entregables.Titulos exposing (..)


titulo : String -> String
titulo code =
    case code of
        "E1" ->
            "1 Compromiso profesional"

        "E1A" ->
            "1.A Contexto para la comunicación"

        "E1B" ->
            "1.B Contexto de colaboración"

        "E1C" ->
            "1.C Netiqueta"

        "E2" ->
            "2 Contenidos digitales"

        _ ->
            "Titulo no encontrado"
