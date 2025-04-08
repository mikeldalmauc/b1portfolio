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
            "2.A Contenido Básico"

        "E2B" ->
            "2.B Contenido de Profundización"

        "E3" ->
            "3 Evidencia del Contexto colaborativo del alumnado"

        "E3A" ->
            "3.A Contexto colaborativo del alumnado"

        "E3B" ->
            "3.B Puesta a disposición de los recursos"

        "E4" ->
            "4 Evaluación y retroalimentación"

        "E4A" ->
            "4.A Evaluación previa"

        "E4B" ->
            "4.B Evaluación formativa"

        "E4C" ->
            "4.C Retroalimentación"

        "E5" ->
            "5 Empoderamiento del alumnado"

        "E5A" ->
            "5.A Accesibilidad de los contenidos digitales"

        "E5B" ->
            "5.B Personalización del aprendizaje"

        "E6" ->
            "6 Trabajo con el alumnado"

        "E6A" ->
            "6.A: Búsquedas eficacez"

        "E6B" ->
            "6.B: Definición de normas de comportamiento"

        "E6C" ->
            "6.C: Desarrollo de contenidos digitales"

        "E6D" ->
            "6.D: Uso responsable"

        "E6E" ->
            "6.E: Resolución de problemas digitales"

        "Esquema" ->
            "Esquema"

        _ ->
            "Titulo no encontrado"
