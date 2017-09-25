module Data.User exposing (..)

{-| Represents user objects in Elm
-}
import Json.Decode as Dec exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)

-- Logged User type
type alias LoggedUser =
   { alias_: String
   , email: String
   }

-- Logged User initialization
emptyLoggedUser : LoggedUser
emptyLoggedUser = {alias_ = "", email = ""}

-- Logged User Decoder
loggedUserDecoder : Dec.Decoder LoggedUser
loggedUserDecoder =
    decode LoggedUser
      |> required "alias" Dec.string
      |> required "email" Dec.string


{-| Represents a logged user with his token
-}
type alias Auth =
  { token : String
  , user : LoggedUser
  }

emptyAuth : Auth
emptyAuth = { token = "", user = emptyLoggedUser }

authDecoder : Dec.Decoder Auth
authDecoder =
    decode Auth
      |> required "token" Dec.string
      |> required "user" loggedUserDecoder
