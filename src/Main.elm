module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (..)
import Json.Encode as Encode
import Model exposing (Model)
import Msg exposing (..)
import Ports
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
    let
        decoder : Ports.UIEvent -> Msg
        decoder event =
            event
                |> Debug.log "Received"
                |> always NoOp
    in
        Ports.subscribe decoder


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.NoOp ->
            model ! []

        UIDRequest ->
            model ! [ UID.generate (Encode.int >> Send "New UID") ]

        Send kind data ->
            model ! [ Ports.send kind data ]


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
