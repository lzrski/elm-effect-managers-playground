port module Ports exposing (send, subscribe, UIEvent)

import Json.Decode as Decode


port states : UIState -> Cmd msg


port events : (UIEvent -> msg) -> Sub msg


type alias UIState =
    { kind : String
    , data : Decode.Value
    }


type alias UIEvent =
    { kind : String
    , data : Decode.Value
    }


send : String -> Decode.Value -> Cmd msg
send kind data =
    UIState kind data |> states


subscribe : (UIEvent -> msg) -> Sub msg
subscribe constructor =
    events constructor
