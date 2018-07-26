module Msg exposing (Msg(..))

import Json.Decode as Decode


type Msg
    = UIDRequest
    | Send String Decode.Value
    | Store Int
    | Stored (Result String Int)
    | NoOp
