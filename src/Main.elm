module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--

import Browser exposing (UrlRequest(..))
import Browser.Dom
import Browser.Events exposing (onResize)
import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import Route
import Set exposing (Set)
import Styles exposing (..)
import Task
import Types exposing (..)
import Url exposing (Url)
import Views.Botones as Botones exposing (..)
import Views.DesktopMain as DesktopMain
import Views.Footer as Footer
import Views.Header as Header
import Views.Modal as Modal
import Views.PhoneMain as PhoneMain



-- MAIN


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onResize
            (\width height ->
                DeviceClassified { width = width, height = height }
            )
        ]


init : Dimensions -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init dimensions url key =
    let
        route =
            Route.decode url

        baseModel =
            { key = key
            , route = route
            , device = classifyDevice dimensions
            , dimensions = dimensions
            , hovered = Set.empty
            , modalVisibility = Hidden
            , modalView = none
            , modalTitle = ""
            , entregables = entregables
            , sortOrder = Categories
            }
    in
    case getEntregableFromRoute route of
        Just entregable ->
            -- Si la ruta decodificada es un entregable, abrimos el modal directamente
            ( { baseModel
                | modalVisibility = Visible
                , modalTitle = entregable.tituloModal
                , modalView = entregable.vistaModal
              }
            , Cmd.none
            )

        Nothing ->
            ( baseModel, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    -- case  getEntregableFromRoute (Route.decode url) of
                    --     Just entregable ->
                    --         ( model, Cmd.batch [
                    --               Navigation.pushUrl model.key (Url.toString url)
                    --                 , Task.perform (\_ -> OpenModal entregable) (Task.succeed ())])
                    --     Nothing ->
                    ( model
                    , Navigation.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model, Navigation.load url )

        UrlChanged url ->
            case getEntregableFromRoute (Route.decode url) of
                Just entregable ->
                    ( { model | route = Route.decode url }, Cmd.batch [ Task.perform (\_ -> OpenModal entregable) (Task.succeed ()) ] )

                Nothing ->
                    ( { model | route = Route.decode url }, Cmd.batch [ Task.perform (\_ -> CloseModal) (Task.succeed ()) ] )

        DeviceClassified dimensions ->
            ( { model | device = classifyDevice dimensions, dimensions = dimensions }, Cmd.none )

        HoverOn id ->
            ( { model | hovered = Set.insert id model.hovered }
            , Cmd.none
            )

        HoverOff id ->
            ( { model | hovered = Set.remove id model.hovered }
            , Cmd.none
            )

        HoverOffAll ->
            ( { model | hovered = Set.empty }
            , Cmd.none
            )

        HoverOnMany ids ->
            let
                nuevos =
                    List.foldl Set.insert model.hovered ids
            in
            ( { model | hovered = nuevos }
            , Cmd.none
            )

        HoverOffMany ids ->
            let
                nuevos =
                    List.foldl Set.remove model.hovered ids
            in
            ( { model | hovered = nuevos }
            , Cmd.none
            )

        OpenModal entregable ->
            ( { model | modalVisibility = Visible, modalTitle = entregable.tituloModal, modalView = entregable.vistaModal }
            , Cmd.none
            )

        CloseModal ->
            ( { model | modalVisibility = Hidden, modalView = none }
            , Cmd.batch
                [ Task.perform identity (Task.succeed HoverOffAll)
                ]
            )

        SortEntregables sortOrder ->
            ( { model | sortOrder = sortOrder }
            , Task.succeed HoverOffAll |> Task.perform identity
            )

        GoTo route ->
            ( model
            , Navigation.pushUrl model.key (Route.encode route)
            )

        _ ->
            ( model, Cmd.none )


scrollToTop : Cmd Msg
scrollToTop =
    Browser.Dom.setViewport 0 0 |> Task.perform (\() -> NoOp)



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        ( deviceClass, deviceOrientation ) =
            case model.device of
                { class, orientation } ->
                    ( class, orientation )
    in
    case model.route of
        Route.HomepageRoute ->
            viewHome model

        _ ->
            viewHome model


viewHome : Model -> Browser.Document Msg
viewHome model =
    let
        ( deviceClass, deviceOrientation ) =
            case model.device of
                { class, orientation } ->
                    ( class, orientation )
    in
    { title = "B1 Protfolio"
    , body =
        [ case deviceClass of
            Phone ->
                PhoneMain.view model

            Tablet ->
                DesktopMain.view model

            Desktop ->
                DesktopMain.view model

            BigDesktop ->
                DesktopMain.view model
        ]
    }



-- DESKTOP VIEW


infoDebug : Model -> Element Msg
infoDebug model =
    column [ width fill, height fill, Font.size 11, padding 10 ]
        [ text ("key: " ++ Debug.toString model.key)
        , text ("route: " ++ Debug.toString model.route)
        , text ("device: " ++ Debug.toString model.device)
        , text ("dimensions: " ++ Debug.toString model.dimensions)
        , text ("hovered: " ++ Debug.toString model.hovered)
        , text ("modalVisibility: " ++ Debug.toString model.modalVisibility)
        , text ("modalTitle: " ++ model.modalTitle)
        , text ("entregables: " ++ Debug.toString model.entregables)
        , text ("sortOrder: " ++ Debug.toString model.sortOrder)
        ]
