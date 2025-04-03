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

        "E2A" ->
            "2.A"

        "E2B" ->
            "2.B"

        "E3" ->
            "3"

        "E3A" ->
            "3.A"

        "E3B" ->
            "3.B"

        "E4" ->
            "4"

        "E4A" ->
            "4.A"

        "E4B" ->
            "4.B"

        "E4C" ->
            "4.C"

        "E5" ->
            "5"

        "E5A" ->
            "5.A"

        "E5B" ->
            "5.B"

        "E6" ->
            "6"

        "E6A" ->
            "6.A"

        "E6B" ->
            "6.B"

        "E6C" ->
            "6.C"

        "E6D" ->
            "6.D"

        "E6E" ->
            "6.E"

        "Esquema" ->
            "Esquema"

        _ ->
            "Titulo no encontrado"
