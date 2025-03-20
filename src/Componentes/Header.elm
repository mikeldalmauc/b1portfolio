module Componentes.Header exposing (..)

import Html exposing (Html)

import Element.Background as Background
import Element.Border as Border
import Element.Events as Events

import Element exposing (..)
import Styles exposing (..)
import Html.Attributes as HtmlAttributes exposing (style)
import Types exposing (..)


headerHtml : Html Msg
headerHtml =
    Html.div
        [ HtmlAttributes.class "fixed-header"]
        [ encabezadoFijado ]

encabezadoFijado : Html Msg
encabezadoFijado =
    layout [Background.color blanco] 
        <| 
        row [centerY, paddingXY 20 0, width fill]
        [el 
            ( montserratTitulo
            ) 
            (text "B1 Competencia digital del profesorado")
        , image [alignRight, paddingXY 20 0, height (px 50)] {src = "assets/favicon.svg", description = "Logo de Mikel"}
        ]




phoneHeader : Model -> Element Msg
phoneHeader model = 
  row [alignTop, width fill, spacing 10, height (fill |> maximum 70), Background.color blanco, paddingXY 20 0, Border.widthEach {top=0, left=0, bottom=1, right=0}, Border.solid]
  [ image [paddingXY 0 0, height (px 40)] {src = "assets/favicon.svg", description = "Logo de Mikel"}
    , el 
      ( montserratBold
      ) 
      (text "   B1 Digitalizazioa")
  , sortOrderButton model
  ]



sortOrderButton : Model -> Element Msg
sortOrderButton model = 
    let 
        imageAttrs = [paddingXY 0 0, height (px 40), alignRight, htmlAttribute (HtmlAttributes.style "filter" "drop-shadow(2px 2px 0px #000000)")]
    in
        case model.sortOrder of
            Categories -> 
                image ((Events.onClick <| SortEntregables Desc) :: imageAttrs)
                    {src = "assets/sort-categories.svg", description = "Logo de Categorias"}
            Desc ->
                image ((Events.onClick <| SortEntregables Categories) :: imageAttrs)
                    {src = "assets/sort-desc.svg", description = "Logo de Ordenar"}
