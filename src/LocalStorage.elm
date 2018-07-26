module LocalStorage
    exposing
        ( store
        , retrive
        )

import Native.LocalStorage
import Task exposing (Task)


store : String -> (Result String String -> msg) -> Cmd msg
store value constructor =
    value
        |> Native.LocalStorage.store
        |> Task.attempt constructor


retrive : (Result String String -> msg) -> Cmd msg
retrive constructor =
    Native.LocalStorage.retrive
        |> Task.attempt constructor
