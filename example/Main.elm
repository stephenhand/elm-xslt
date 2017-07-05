module ExampleTransform exposing (..)

import Debug exposing (log)
import Html exposing (Html, button, div, text, input, code, textarea)
import Html.Attributes exposing (style, placeholder)
import Html.Events exposing (onClick, onInput)
import Style exposing (..)
import Xslt


main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions}


-- MODEL

type alias Model = {
    source : String,
    stylesheet : String}



init : (Model, Cmd msg)
init =
  ({
      source="",
      stylesheet=""
  }, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg

subscriptions model =  Sub.none
-- UPDATE

type Msg = SourceUpdated String| StyleSheetUpdated String

update : Msg -> Model -> (Model, Cmd msg)
update msg model  = log "Model State" (
    case msg of
        SourceUpdated newValue ->
            ({model | source = newValue}, Cmd.none)
        StyleSheetUpdated newValue ->
            ({model | stylesheet = newValue}, Cmd.none)
    )

-- STYLES
container : List Style
container = [ position absolute
    , display flex_
    , width (pc 100)
    , height (pc 100)
    ]
pane : List Style
pane = [ width (pc 50)
   , height (pc 100)
   ]
rightPane : List Style
rightPane = List.concat [pane, [paddingLeft (px 15)]]

codeInput : List Style
codeInput = [ width (pc 100)
   , height (pc 50)
   ]

codeOutput : List Style
codeOutput = []
errorOutput = [color "red",
    fontStyle italic
    ]
-- VIEW
view : Model -> Html Msg
view model =
  let
    transformed : Result Xslt.TransformError String
    transformed = Xslt.transform model.stylesheet model.source
  in
  div [style container]
    [
        div [style pane] [
            textarea [ onInput (\newValue -> SourceUpdated newValue), style codeInput, placeholder "Source XML"] [],
            textarea [ onInput (\newValue -> StyleSheetUpdated newValue), style codeInput, placeholder "XSLT Stylesheet"] []
        ],

        div [style rightPane] [
            code [style
                (case transformed of
                    Ok output ->
                        codeInput
                    Err error ->
                        if error.code == 2 || error.code == 4 then
                            codeOutput
                        else
                            errorOutput)
            ] [
                text (case transformed of
                  Ok output ->
                      output
                  Err error ->
                    if error.code == 2 || error.code == 4 then
                        ""
                    else
                      error.message)
            ]
        ]
    ]