module Entregables.Entregable1B exposing (..)

import Element exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttributes
import Views.Contenidos exposing (videoView)

title : String
title = "1.B Trabajo en equipo"

view : Element msg
view = 
       el [ scrollbars, centerX, centerY ]
        <| videoView  "https://www.youtube.com/embed/o5Gv4_FdcYs?si=pcHtFUzWvv0IjbrM"
