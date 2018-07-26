module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import LocalStorage


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { value : String }


type Msg
    = NoOp
    | Update String
    | Store
    | Stored (Result String String)
    | Retrive
    | Retrived (Result String String)


init : ( Model, Cmd Msg )
init =
    Model "" ! [ LocalStorage.retrive Retrived ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Update value ->
            { model | value = value } ! []

        Store ->
            model ! [ LocalStorage.store model.value Stored ]

        Stored (Ok value) ->
            { model | value = value } ! []

        Stored (Err message) ->
            { model | value = "" } ! []

        Retrive ->
            model ! []

        Retrived (Ok value) ->
            { model | value = value } ! []

        Retrived (Err message) ->
            { model | value = "" } ! []


view : Model -> Html.Html Msg
view model =
    div
        []
        [ div
            []
            [ pre
                []
                [ text "Model: "
                , model |> toString |> text
                ]
            ]
        , div
            []
            [ input
                [ onInput Update
                , value model.value
                ]
                []
            ]
        , button
            [ onClick Store ]
            [ text "Store" ]
        ]
