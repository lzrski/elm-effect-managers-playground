port module Ports exposing (send)


port states : Int -> Cmd msg


send : Int -> Cmd msg
send value =
    value |> states
