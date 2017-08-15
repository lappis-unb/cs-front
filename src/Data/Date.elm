module Data.Date exposing (..)

{-| Represents date objects in Elm
-}

import Json.Decode as Dec exposing (..)
import Json.Encode as Enc
import Json.Decode.Pipeline exposing (decode, required)

type alias Date =
  { month: String
  , day: String
  , year: String
  }


testDate : Date
testDate =
    { month = "January"
    , day = "22"
    , year = "1996"
    }

dateDecoder : Dec.Decoder Date
dateDecoder =
    decode Date
      |> required "month" Dec.string
      |> required "day" Dec.string
      |> required "year" Dec.string


toJson : Date -> Dec.Value
toJson date =
    let
        str =
            Enc.string
    in
    Enc.object
        [ ( "month", str date.month)
        , ( "day", str date.day)
        , ( "year", str date.year)
        ]
