import Debug exposing (log)
import Html exposing (Html, button, div, text, input, code, textarea)
import Html.Events exposing (onClick, onInput)
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




-- VIEW
view : Model -> Html Msg
view model =
  div []
    [
        div [] [
            textarea [ onInput (\newValue -> SourceUpdated newValue)] [],
            textarea [ onInput (\newValue -> StyleSheetUpdated newValue)] []
        ],
        div [] [
            code [] [
                text (Xslt.transform model.stylesheet model.source)

            ]
        ]
    ]