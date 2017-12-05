module Data.ProgrammingLanguage exposing (..)

{-| Languages representations
-}
import Json.Decode as Dec exposing (..)
import Json.Decode.Pipeline exposing (decode, required)

{-| Represents the reduced information about a Language that is shown on listings
-}
type alias ProgrammingLanguage =
    { url : String
    , ref : String
    , name : String
    , comments : String
    , is_supported : Bool
    }

emptyProgrammingLanguages : ProgrammingLanguage
emptyProgrammingLanguages =
  { url = ""
  , ref = ""
  , name = ""
  , comments = ""
  , is_supported = True
  }

programmingLanguageDecoder : Dec.Decoder ProgrammingLanguage
programmingLanguageDecoder =
    decode ProgrammingLanguage
      |> required "url" Dec.string
      |> required "ref" Dec.string
      |> required "name" Dec.string
      |> required "comments" Dec.string
      |> required "is_supported" Dec.bool
