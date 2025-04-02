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
import Element.Font as Fon
import Entregables.Entregables exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import Route
import Set exposing (Set)
import Styles exposing (..)
import Task
import Types exposing (..)
import Url exposing (Url)
import Views.Botones as Botones exposing (..)
import Views.DesktopView as DesktopView
import Views.Footer as Footer
import Views.Header as Header
import Views.PhoneView as PhoneView



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
            , modalView = \d -> none
            , modalTitle = ""
            , entregables = entregables
            , sortOrder = Categories
            , menuVisible = Hidden
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
        NoOp ->
            ( model, Cmd.none )

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
            let
                newRoute =
                    Route.decode url

                -- Prepara un comando de scroll si hay un fragmento presente
                scrollCmd =
                    case url.fragment of
                        Just fragmentId ->
                            Task.attempt (always NoOp)
                                (Browser.Dom.getElement fragmentId
                                    |> Task.andThen
                                        (\elem ->
                                            -- Desplazar la ventana al punto Y del elemento
                                            Browser.Dom.setViewport 0 elem.element.y
                                        )
                                )

                        Nothing ->
                            Cmd.none
            in
            case getEntregableFromRoute newRoute of
                Just entregable ->
                    ( { model | route = newRoute }
                    , Cmd.batch
                        [ Task.perform (\_ -> OpenModal entregable) (Task.succeed ())
                        , scrollCmd
                        ]
                    )

                Nothing ->
                    ( { model | route = newRoute }
                    , Cmd.batch
                        [ Task.perform (\_ -> CloseModal) (Task.succeed ())
                        , scrollCmd
                        ]
                    )

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
            ( { model | modalVisibility = Hidden, modalView = \d -> none }
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

        OpenMenu ->
            ( { model
                | menuVisible =
                    if model.menuVisible == Visible then
                        Hidden

                    else
                        Visible
              }
            , Cmd.none
            )


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
                PhoneView.view model

            Tablet ->
                DesktopView.view model

            Desktop ->
                DesktopView.view model

            BigDesktop ->
                DesktopView.view model
        ]
    }



-- DESKTOP VIEW
-- infoDebug : Model -> Element Msg
-- infoDebug model =
--     column [ width fill, height fill, Font.size 11, padding 10 ]
--         [ text ("key: " ++ Debug.toString model.key)
--         , text ("route: " ++ Debug.toString model.route)
--         , text ("device: " ++ Debug.toString model.device)
--         , text ("dimensions: " ++ Debug.toString model.dimensions)
--         , text ("hovered: " ++ Debug.toString model.hovered)
--         , text ("modalVisibility: " ++ Debug.toString model.modalVisibility)
--         , text ("modalTitle: " ++ model.modalTitle)
--         , text ("entregables: " ++ Debug.toString model.entregables)
--         , text ("sortOrder: " ++ Debug.toString model.sortOrder)
--         ]
