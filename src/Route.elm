module Route exposing (Route(..), decode, encode)

import Url exposing (Url)
import Url.Builder
import Url.Parser exposing ((</>), (<?>))
import Url.Parser.Query


type Route
    = HomepageRoute
    | Entregable1A


decode : Url -> Route
decode url =
    Url.Parser.oneOf
        [ Url.Parser.top |> Url.Parser.map HomepageRoute
        , Url.Parser.s "entregable1a" |> Url.Parser.map Entregable1A
        ]
        |> (\a -> Url.Parser.parse a url |> Maybe.withDefault HomepageRoute)


encode : Route -> String
encode route =
    Url.Builder.absolute
        (case route of
            HomepageRoute ->
                []

            Entregable1A ->
                [ "entregable1a" ]
        )
        []
    