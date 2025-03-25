module Route exposing (Route(..), decode, encode)

import Url exposing (Url)
import Url.Parser exposing (oneOf, s, top, map, parse)
import Url.Builder


-- Definición del tipo Route con todas las rutas necesarias

type Route
    = HomepageRoute
    | Entregable1
    | Entregable2
    | Entregable3
    | Entregable4
    | Entregable5
    | Entregable6
    | Entregable1A
    | Entregable1B
    | Entregable1C
    | Entregable2A
    | Entregable2B
    | Entregable3A
    | Entregable3B
    | Entregable4A
    | Entregable4B
    | Entregable4C
    | Entregable5A
    | Entregable5B
    | Entregable6A
    | Entregable6B
    | Entregable6C
    | Entregable6D
    | Entregable6E


-- Función decode: recibe una Url y devuelve la Route correspondiente.
-- Si la Url no coincide con ningún patrón, se retorna HomepageRoute.

decode : Url -> Route
decode url =
    oneOf
        [ top |> map HomepageRoute
        , s "entregable1"  |> map Entregable1
        , s "entregable2"  |> map Entregable2
        , s "entregable3"  |> map Entregable3
        , s "entregable4"  |> map Entregable4
        , s "entregable5"  |> map Entregable5
        , s "entregable6"  |> map Entregable6
        , s "entregable1a" |> map Entregable1A
        , s "entregable1b" |> map Entregable1B
        , s "entregable1c" |> map Entregable1C
        , s "entregable2a" |> map Entregable2A
        , s "entregable2b" |> map Entregable2B
        , s "entregable3a" |> map Entregable3A
        , s "entregable3b" |> map Entregable3B
        , s "entregable4a" |> map Entregable4A
        , s "entregable4b" |> map Entregable4B
        , s "entregable4c" |> map Entregable4C
        , s "entregable5a" |> map Entregable5A
        , s "entregable5b" |> map Entregable5B
        , s "entregable6a" |> map Entregable6A
        , s "entregable6b" |> map Entregable6B
        , s "entregable6c" |> map Entregable6C
        , s "entregable6d" |> map Entregable6D
        , s "entregable6e" |> map Entregable6E
        ]
        |> (\parser -> parse parser url |> Maybe.withDefault HomepageRoute)


-- Función encode: convierte una Route en su representación String para la URL.

encode : Route -> String
encode route =
    Url.Builder.absolute
        (case route of
            HomepageRoute ->
                []

            Entregable1 ->
                [ "entregable1" ]

            Entregable2 ->
                [ "entregable2" ]

            Entregable3 ->
                [ "entregable3" ]

            Entregable4 ->
                [ "entregable4" ]

            Entregable5 ->
                [ "entregable5" ]

            Entregable6 ->
                [ "entregable6" ]

            Entregable1A ->
                [ "entregable1a" ]

            Entregable1B ->
                [ "entregable1b" ]

            Entregable1C ->
                [ "entregable1c" ]

            Entregable2A ->
                [ "entregable2a" ]

            Entregable2B ->
                [ "entregable2b" ]

            Entregable3A ->
                [ "entregable3a" ]

            Entregable3B ->
                [ "entregable3b" ]

            Entregable4A ->
                [ "entregable4a" ]

            Entregable4B ->
                [ "entregable4b" ]

            Entregable4C ->
                [ "entregable4c" ]

            Entregable5A ->
                [ "entregable5a" ]

            Entregable5B ->
                [ "entregable5b" ]

            Entregable6A ->
                [ "entregable6a" ]

            Entregable6B ->
                [ "entregable6b" ]

            Entregable6C ->
                [ "entregable6c" ]

            Entregable6D ->
                [ "entregable6d" ]

            Entregable6E ->
                [ "entregable6e" ]
        )
        []
