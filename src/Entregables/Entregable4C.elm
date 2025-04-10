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
    MarkdownThemed.renderFull
    """
# 4C Estrategia de evaluación formativa centrada en el feedback

- [4C Estrategia de evaluación formativa centrada en el feedback](#4c-estrategia-de-evaluación-formativa-centrada-en-el-feedback)
  - [Vídeo explicativo](#vídeo-explicativo)
  - [Feedback formativo con GitHub Classroom](#feedback-formativo-con-github-classroom)
  - [Feedback formativo con Moodle](#feedback-formativo-con-moodle)
  - [Evidencias de retroalimentación](#evidencias-de-retroalimentación)

<br></br>

## Vídeo explicativo

<br></br>
En un breve vídeo, podemos mostrar al alumnado **cómo y cuándo** va a recibir feedback sobre su proceso de aprendizaje, tanto en GitHub Classroom como en Moodle:

1. **Explicar las etapas de desarrollo del proyecto** y cómo se revisan en GitHub Classroom.  
2. **Mostrar ejemplos de rúbricas** y dónde el alumnado verá sus calificaciones y comentarios en Moodle.  

<br></br>

---

## Feedback formativo con GitHub Classroom

El **objetivo** principal es ofrecer retroalimentación continua y ajustada a la evolución de cada estudiante. Para ello, se aprovechan las funcionalidades de GitHub Classroom:

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

3. **Uso de issues**  
   - Se crean *issues* cuando se detectan fallos o posibles mejoras.  
   - El alumnado aprende a gestionar y cerrar esos *issues*, dejando constancia del proceso de resolución.  
   - Es útil para fomentar la comunicación, ya que no solo el profesor, sino también los compañeros, pueden opinar y ayudar.

4. **Plantillas de feedback automático** (opcional)  
   - Se pueden configurar pequeños tests o *checks* con GitHub Actions, que alerten sobre errores de compilación o fallos en pruebas unitarias.  
   - Ofrecen una retroalimentación rápida y objetiva, complementando la revisión manual.

---

## Feedback formativo con Moodle

**Moodle** ofrece una plataforma centralizada para comentarios y calificaciones cualitativas, donde podemos aplicar diferentes técnicas de retroalimentación:

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

5. **Badges o insignias de progreso**  
   - Una forma de **motivar** al alumnado reconociendo logros específicos (por ejemplo, *“Excelente documentación”*, *“Resolución de bugs”*).  
   - Se pueden automatizar las condiciones para asignar estas insignias según la calificación, la participación en foros, o la entrega puntual de tareas.

---

## Evidencias de retroalimentación

1. **Historial de Pull Requests comentados**  
   - Muestra las sugerencias y consejos aportados al alumnado, así como las respuestas y correcciones de este.

2. **Informe de rúbricas y calificaciones en Moodle**  
   - Permite al alumnado ver sus **fortalezas y debilidades** en aspectos concretos.  
   - El profesorado puede exportar estos informes para supervisar el progreso global y proponer ajustes pedagógicos.

3. **Participación en foros y issues**  
   - El conteo de mensajes y su contenido reflejan el grado de implicación del alumnado y su aprendizaje colaborativo.

4. **Mejoras implementadas**  
   - Se comparan versiones antiguas del código con las nuevas para ver si las sugerencias de *feedback* han sido aplicadas.  
   - Esto evidencia la **evolución real** del estudiante.

En resumen, la retroalimentación continua basada en **comentarios de código**, **rúbricas de Moodle**, **discusiones en foros** y **auto-evaluaciones** constituye un pilar fundamental en la **evaluación formativa** de un curso de Desarrollo de Aplicaciones Multiplataforma. De esta manera, el alumnado no solo sabe cuál es su calificación final, sino también **por qué** la ha obtenido y **cómo** puede mejorar en cada paso del proceso.
    """
