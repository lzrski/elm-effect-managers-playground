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
    { next : Int
    , multiplier : Int
    }


init : Task Never State
init =
    State 0 2 |> Task.succeed


onEffects :
    Router msg Never
    -> List (MyCmd msg)
    -> State
    -> Task Never State
onEffects router cmds state =
    case cmds of
        [] ->
            Task.succeed state

        (GenerateUID constructor) :: rest ->
            (state.next * state.multiplier)
                |> constructor
                |> Platform.sendToApp router
                |> Task.map (always { state | next = state.next + 1 })
                |> Task.andThen (onEffects router rest)


onSelfMsg :
    Platform.Router msg Never
    -> Never
    -> State
    -> Task Never State
onSelfMsg router never state =
    Task.succeed state
