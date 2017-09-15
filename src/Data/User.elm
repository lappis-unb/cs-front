module Data.User exposing (..)

{-| Represents user objects in Elm
-}

import Json.Decode as Dec exposing (..)
import Json.Encode as Enc
import Json.Decode.Pipeline exposing (decode, required, optional)


{-| Represents a simple user
-}
type alias User =
    { name : String --needed
    , alias_ : String -- needed
    , email : String -- needed
    , password : String -- needed
    , password_confirmation : String -- needed
    , school_id: String -- needed
    }

type alias SendProfile =
      { gender: String
      , phone : String
      , date_of_birth: String
      , website: String
      , about_me: String
      , visibility: String
      }

type alias Auth =
  { token : String
  , user : LoggedUser
  }

type alias UserLogin =
  { email: String
  , password : String
  }

type alias LoggedUser =
   { alias_: String
   , email: String
   }

type alias UserError =
    { name : List String
    , alias_ : List String -- needed
    , email : List String -- needed
    , email_confirmation : List String -- needed
    , password : List String -- needed
    , password_confirmation : List String -- needed
    , school_id: List String -- needed
    , gender: List String
    , birthday: List String
    , about_me: List String
    }


emptyAuth : Auth
emptyAuth = { token = "", user = emptyLoggedUser }

emptyLoggedUser : LoggedUser
emptyLoggedUser = {alias_ = "", email = ""}

testUser : User
testUser =
    { name = "Anonymous"
    , alias_ = "unknown"
    , email = "none@gmail.com"
    , password = "123456"
    , password_confirmation = "123456"
    , school_id = "15/0344750"
    }

testProfile : SendProfile
testProfile =
  { gender = ""
  , phone = ""
  , date_of_birth = ""
  , website = ""
  , about_me = ""
  , visibility = ""
  }

testLogin : UserLogin
testLogin =
  { email = ""
  , password = ""
  }

testUserError : UserError
testUserError =
    { name = []
    , alias_ = []
    , email = []
    , email_confirmation = []
    , password = []
    , password_confirmation = []
    , school_id = []
    , gender = []
    , birthday = []
    , about_me = []
    }

userErrorDecoder : Dec.Decoder UserError
userErrorDecoder =
    decode UserError
      |> optional "name" (Dec.list Dec.string) []
      |> optional "alias" (Dec.list Dec.string) []
      |> optional "email" (Dec.list Dec.string) []
      |> optional "email_confirmation" (Dec.list Dec.string) []
      |> optional "password" (Dec.list Dec.string) []
      |> optional "password_confirmation" (Dec.list Dec.string) []
      |> optional "school_id" (Dec.list Dec.string) []
      |> optional "gender" (Dec.list Dec.string) []
      |> optional "birthday" (Dec.list Dec.string) []
      |> optional "about_me" (Dec.list Dec.string) []

authDecoder : Dec.Decoder Auth
authDecoder =
    decode Auth
      |> required "token" Dec.string
      |> required "user" loggedUserDecoder

loggedUserDecoder : Dec.Decoder LoggedUser
loggedUserDecoder =
    decode LoggedUser
      |> required "alias" Dec.string
      |> required "email" Dec.string

{-| A decoder for user objects
-}
userDecoder : Dec.Decoder User
userDecoder =
    decode User
      |> required "name" Dec.string
      |> required "alias" Dec.string
      |> required "email" Dec.string
      |> required "password" Dec.string
      |> required "password_confirmation" Dec.string
      |> required "school_id" Dec.string
    -- Dec.map8 User
    --     (field "name" string)
    --     (field "alias" string)
    --     (field "email" string)
    --     (field "email_confirmation" string)
    --     (field "id" int)
    --     (field "password" string)
    --     (field "password_confirmation" string)
    --     (field "school_id" string)


{-| Convert user to JSON
-}
toJson : User -> Dec.Value
toJson user =
    let
        str =
            Enc.string
    in
    Enc.object
        [ ( "name", str user.name )
        , ( "alias", str user.alias_ )
        , ( "email", str user.email )
        , ( "password", str user.password)
        , ( "password_confirmation", str user.password_confirmation)
        , ( "school_id", str user.school_id)
        ]


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
