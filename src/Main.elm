module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (..)
import Model exposing (Model)
import Msg exposing (..)
import UID


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    Model Nothing ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UIDRequest ->
            model ! [ UID.generate UIDGenerated ]

        UIDGenerated value ->
            { model | value = Just value } ! []


view : Model -> Html.Html Msg
view model =
    div
        []
        [ div
            []
            [ pre
                []
                [ text "UID: "
                , text <| toString model.value
                ]
            ]
        , button
            [ onClick UIDRequest ]
            [ text "Request UID" ]
        ]
