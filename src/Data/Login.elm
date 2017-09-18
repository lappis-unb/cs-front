module Data.Login exposing (..)

import Json.Decode as Dec exposing (..)
import Json.Encode as Enc

{-| Represents the login form
-}
type alias UserLogin =
  { email: String
  , password : String
  }

-- login form initialization
emptyLogin : UserLogin
emptyLogin =
  { email = ""
  , password = ""
  }

-- login form encoder
toJsonLogin : UserLogin -> Dec.Value
toJsonLogin user =
    let
        str =
            Enc.string
    in
    Enc.object
        [ ( "email", str user.email )
        , ( "password", str user.password)
        ]
