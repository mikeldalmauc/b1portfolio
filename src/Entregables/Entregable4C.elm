module Entregables.Entregable4C exposing (..)

import Element exposing (..)
import Entregables.Titulos exposing (..)
import Html exposing (Html, col)
import Html.Attributes as HtmlAttributes
import MarkdownThemed
import Route exposing (Route(..))
import Styles exposing (montserrat)
import Svg.Attributes exposing (fontSize)
import Types exposing (..)
import Views.Componentes exposing (..)


view : Dimensions -> Element msg
view d =
    column [ width (fill |> maximum (round (toFloat d.width * 0.9))) ]
        [ breadcrumbs d
            [ Just ( Entregable4, titulo "E4" )
            , Just ( Entregable4C, titulo "E4C" )
            ]
        , content d
        , footerNavigation d
            (Just ( Entregable4B, titulo "E4B" ))
            (Just ( Entregable5, titulo "E5" ))
        ]


content : Dimensions -> Element msg
content d =
    column [ width fill, height fill, spacing 10 ]
        [ MarkdownThemed.renderFull <| """
# 4C Feedback utilizando herramientas digitales

<img width='600' src='assets/4CFeedback.webp' alt='Una persona dando feedback a otra.'/>

- [Vídeo explicativo](#vídeo-explicativo)
- [Feedback formativo con GitHub Classroom](#feedback-formativo-con-github-classroom)
- [Feedback formativo con Moodle](#feedback-formativo-con-moodle)

<br></br>
<br></br>
<br></br>
<br></br>


En este documento propongo un conjunto de estrategias de feedback, basadas en las herramientas de evaluación elegidas en el apartado [4.B Evaluación Formativa](/entregable4b) que son **Moodle** y **Github**. Por lo tanto trataré de aprovechar en la medida de lo posible los distintos recursos que ofrecen estas plataformas. Sin olvidar que el objetivo principal es ofrecer retroalimentación continua y ajustada a la evolución de cada estudiante.


## Vídeo explicativo
"""
        , el [ paddingEach { bottom = 70, top = 5, left = 0, right = 0 } ] <| videoView d "https://www.youtube.com/embed/oqLeZB3yyVU?si=SkivQCNfnuCVTB6p"
        , MarkdownThemed.renderFull <| """
<br></br>


## Feedback formativo con GitHub Classroom

1. **Revisiones de Pull Requests**  
   - Cada vez que el alumnado sube su código mediante un pull request (PR), se comentan aspectos como:
     - Legibilidad y orden del código  
     - Corrección de errores de sintaxis o de lógica  
     - Buenas prácticas de programación (convenciones de nombres, test, etc.)  
   - Se señalan aciertos y se proponen posibles mejoras que el alumnado puede implementar en futuras entregas.

2. **Comentarios en el historial de commits**  
   - Permite ver la evolución del proyecto en el tiempo.  
   - Se aconsejan prácticas de *commit* frecuentes y descriptivos (por ejemplo, *“fix: corrige bug en el formulario de login”*).  
   - Un historial ordenado es un indicador de disciplina y organización.

3. **Plantillas de feedback automático** (opcional)  
   - Se pueden configurar pequeños tests con GitHub Actions, que alerten sobre errores de compilación o fallos en pruebas unitarias.  
   - Ofrecen una retroalimentación rápida y objetiva, complementando la revisión manual, ideal para ciertos ejercicios de programación.
   

## Feedback formativo con Moodle

1. **Rúbricas detalladas**  
   - Cada práctica o proyecto se acompaña de una rúbrica con **criterios claros** (organización del código, usabilidad de la app, documentación…).  
   - Con solo puntuar cada criterio, Moodle puede **generar la nota** y mostrar **comentarios personalizados** en cada sección.

2. **Retroalimentación escrita o multimedia**  
   - El docente puede añadir anotaciones específicas acerca de la forma de resolver la práctica o sugerir recursos adicionales.
   - Los **comentarios en audio o vídeo** suelen resultar cercanos y motivadores para el alumnado.

3. **Cuestionarios de autoevaluación**  
   - Diseñados para que el alumnado pueda diagnosticar su nivel, ver los aciertos y errores, y recibir *feedback* inmediato.  
   - Permite al docente ver estadísticas generales y así orientar mejor la retroalimentación colectiva.

4. **Foros de seguimiento**  
   - Un espacio en el que se plantean dudas, se discuten problemas concretos y se ofrece *feedback* público para toda la clase.  
   - En ocasiones, las respuestas de los compañeros pueden complementar la visión del docente.

5. **Insignias de progreso**  
   - Una forma de **motivar** al alumnado reconociendo logros específicos (por ejemplo, *“Excelente documentación”*, *“Resolución de bugs”*).  
   - Se pueden automatizar las condiciones para asignar estas insignias según la calificación, la participación en foros, o la entrega puntual de tareas.

"""
        ]
