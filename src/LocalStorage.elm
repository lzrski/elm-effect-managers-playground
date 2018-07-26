module LocalStorage
    exposing
        ( store
        )

import Json.Decode as Decode
import Native.LocalStorage
import Task exposing (Task)


store : Int -> (Result String Int -> msg) -> Cmd msg
store value constructor =
    value
        |> Native.LocalStorage.store
        |> Task.attempt constructor
