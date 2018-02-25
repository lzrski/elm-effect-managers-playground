effect module UID where { command = MyCmd } exposing (generate)

import Platform exposing (Router)
import Task exposing (Task)


type MyCmd msg
    = GenerateUID (Int -> msg)


generate : (Int -> msg) -> Cmd msg
generate constructor =
    command (GenerateUID constructor)


cmdMap : (a -> b) -> MyCmd a -> MyCmd b
cmdMap f (GenerateUID constructor) =
    GenerateUID (constructor >> f)


type alias State =
    Int


init : Task Never State
init =
    Task.succeed 0


onEffects :
    Router msg Never
    -> List (MyCmd msg)
    -> State
    -> Task Never Int
onEffects router cmds state =
    case cmds of
        [] ->
            Task.succeed state

        (GenerateUID constructor) :: rest ->
            constructor state
                |> Platform.sendToApp router
                |> Task.andThen (\_ -> onEffects router rest (state + 1))


onSelfMsg :
    Platform.Router msg Never
    -> Never
    -> State
    -> Task Never State
onSelfMsg router never state =
    Task.succeed state
