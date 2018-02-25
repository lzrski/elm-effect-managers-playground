module Msg exposing (Msg(..))

import Json.Decode as Decode


type Msg
    = UIDRequest
    | Send String Decode.Value
    | NoOp
