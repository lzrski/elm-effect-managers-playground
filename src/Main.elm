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
    case Debug.log "Msg" msg of
        NoOp ->
            ( model
            , Cmd.none
            )

        Update value ->
            ( { model | value = value }
            , Cmd.none
            )

        Store ->
            ( model
            , LocalStorage.store "foo" model.value Stored
            )

        Stored (Ok ()) ->
            ( model
            , Cmd.none
            )

        Stored (Err message) ->
            ( { model | value = "" }
            , Cmd.none
            )

        Retrive ->
            ( model
            , Cmd.none
            )

        Retrived (Ok (Just value)) ->
            ( { model | value = value }
            , Cmd.none
            )

        Retrived (Ok Nothing) ->
            ( { model | value = "Nothing here" }
            , Cmd.none
            )

        Retrived (Err message) ->
            ( { model | value = "" }
            , Cmd.none
            )

        Remove ->
            ( model
            , LocalStorage.remove "foo" Removed
            )

        Removed (Ok ()) ->
            ( model
            , LocalStorage.retrive "foo" Decode.string Retrived
            )

        Removed (Err message) ->
            ( model
            , Cmd.none
            )


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
