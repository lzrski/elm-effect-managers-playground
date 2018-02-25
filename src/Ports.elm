port module Ports exposing (send)

import Json.Decode as Decode


port states : UIState -> Cmd msg


type alias UIState =
    { kind : String
    , data : Decode.Value
    }


send : String -> Decode.Value -> Cmd msg
send kind data =
    UIState kind data |> states
