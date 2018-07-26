module LocalStorage
    exposing
        ( store
        , retrive
        )

import Native.LocalStorage
import Task exposing (Task)


store :
    String
    -> String
    -> (Result String String -> msg)
    -> Cmd msg
store key value constructor =
    value
        |> Native.LocalStorage.store key
        |> Task.attempt constructor


retrive :
    String
    -> (Result String String -> msg)
    -> Cmd msg
retrive key constructor =
    key
        |> Native.LocalStorage.retrive
        |> Task.attempt constructor
