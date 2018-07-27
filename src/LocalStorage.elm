module LocalStorage
    exposing
        ( store
        , retrive
        , remove
        )

import Native.LocalStorage
import Task exposing (Task)
import Json.Decode as Decode


store :
    String
    -> String
    -> (Result String () -> msg)
    -> Cmd msg
store key value constructor =
    value
        |> Native.LocalStorage.store key
        |> Task.map (always ())
        |> Task.attempt constructor


retrive :
    String
    -> Decode.Decoder a
    -> (Result String (Maybe a) -> msg)
    -> Cmd msg
retrive key decoder constructor =
    let
        unpack : Result x (Maybe (Result x a)) -> Result x (Maybe a)
        unpack result =
            case result of
                -- Task failed
                Err error ->
                    Err error

                -- Task succeeded but decoder failed
                Ok (Just (Err error)) ->
                    Err error

                -- Everything went fine and the key we set
                Ok (Just (Ok value)) ->
                    Ok (Just value)

                -- Everything went fine but the key was not set
                Ok Nothing ->
                    Ok Nothing
    in
        key
            |> Native.LocalStorage.retrive
            |> Task.map (Maybe.map (Decode.decodeValue decoder))
            |> Task.attempt (unpack >> constructor)


remove :
    String
    -> (Result String () -> msg)
    -> Cmd msg
remove key constructor =
    key
        |> Native.LocalStorage.remove
        |> Task.attempt constructor
