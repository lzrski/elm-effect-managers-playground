module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
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
    | Stored (Result String ())
    | Retrive
    | Retrived (Result String (Maybe String))
    | Remove
    | Removed (Result String ())


init : ( Model, Cmd Msg )
init =
    let
        decoder =
            Decode.string
    in
        Model "" ! [ LocalStorage.retrive "foo" decoder Retrived ]


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
            model ! [ LocalStorage.store "foo" model.value Stored ]

            { model | value = value } ! []
        Stored (Ok ()) ->

        Stored (Err message) ->
            { model | value = "" } ! []

        Retrive ->
            model ! []

        Retrived (Ok (Just value)) ->
            { model | value = value } ! []

        Retrived (Ok Nothing) ->
            { model | value = "Nothing here" } ! []

        Retrived (Err message) ->
            { model | value = "" } ! []

        Remove ->
            model
                ! [ LocalStorage.remove "foo" Removed ]

        Removed (Ok ()) ->
            model
                ! [ LocalStorage.retrive "foo" Decode.string Retrived ]

        Removed (Err message) ->
            model
                ! []


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
        , button
            [ onClick Remove ]
            [ text "Remove" ]
        ]
