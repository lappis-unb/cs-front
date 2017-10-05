module Data.Registration exposing (..)

import Json.Decode as Dec exposing (..)
import Json.Encode as Enc
import Json.Decode.Pipeline exposing (decode, required, optional)

{-| Represents a simple user form
-}
type alias UserForm =
    { name : String --needed
    , alias_ : String -- needed
    , email : String -- needed
    , password : String -- needed
    , password_confirmation : String -- needed
    , school_id: String -- needed
    , profile : ProfileForm
    }

-- User register initialization
emptyUserRegister : UserForm
emptyUserRegister =
    { name = ""
    , alias_ = ""
    , email = ""
    , password = ""
    , password_confirmation = ""
    , school_id = ""
    , profile = emptyProfile
    }


{-| A decoder for user form objects
-}
userDecoder : Dec.Decoder UserForm
userDecoder =
    decode UserForm
      |> required "name" Dec.string
      |> required "alias" Dec.string
      |> required "email" Dec.string
      |> required "password" Dec.string
      |> required "password_confirmation" Dec.string
      |> required "school_id" Dec.string
      |> required "profile" profileDecoder

{-| Convert user to JSON
-}
toJson : UserForm -> Dec.Value
toJson user =
    let
        str =
            Enc.string
    in
    Enc.object
        [ ( "alias", str user.alias_ )
        , ( "email", str user.email )
        , ( "name", str user.name )
        , ( "password", str user.password)
        , ( "password_confirmation", str user.password_confirmation)
        , ( "school_id", str user.school_id)
        , ( "profile", toJsonSendProfile user.profile)
        ]


{-| Represents a simple profile form
-}
type alias ProfileForm =
      { gender: Maybe Int
      , phone : String
      , date_of_birth: Maybe String
      , website: String
      , about_me: String
      , user: Int
      }

-- Profile register initialization
emptyProfile : ProfileForm
emptyProfile =
  { gender =  Nothing
  , phone = ""
  , date_of_birth = Nothing
  , website = ""
  , about_me = ""
  , user = 0
  }

-- Profile register encoder
toJsonSendProfile : ProfileForm -> Dec.Value
toJsonSendProfile profileRegister =
    let
      str =
        Enc.string
    in
      Enc.object
      [ ( "gender", (maybeExtractor profileRegister.gender Enc.int) )
      , ( "phone", str profileRegister.phone )
      , ( "date_of_birth", (maybeExtractor profileRegister.date_of_birth Enc.string) )
      , ( "website", str profileRegister.website )
      , ( "about_me", str profileRegister.about_me )
      , ( "user", Enc.int profileRegister.user )
      ]
maybeExtractor: Maybe a -> (a ->Enc.Value) -> Enc.Value
maybeExtractor a type_ =
  case a of
    Nothing ->
      Enc.null
    Just val ->
      type_ val

-- profile register decoder
profileDecoder : Dec.Decoder ProfileForm
profileDecoder =
  decode ProfileForm
    |> required "gender" (Dec.maybe Dec.int)
    |> required "phone" Dec.string
    |> required "date_of_birth" (Dec.maybe Dec.string)
    |> required "website" Dec.string
    |> required "about_me" Dec.string
    |> required "user" Dec.int


{-| Represents a expecter response to register
-}
type alias ExpectRegisterResponse =
  { alias_: String
  , role: String
  , profile : ProfileForm
  }

-- expect register initialization
emptyExpectRegisterResponse : ExpectRegisterResponse
emptyExpectRegisterResponse =
  { alias_ = ""
  , role = ""
  , profile = emptyProfile
  }

-- expect register decoder
expectRegisterDecoder : Dec.Decoder ExpectRegisterResponse
expectRegisterDecoder =
  decode ExpectRegisterResponse
    |> required "alias" Dec.string
    |> required "role" Dec.string
    |> required "profile" profileDecoder


{-| Represents users registration errors
-}
type alias UserError =
    { name : List String
    , alias_ : List String -- needed
    , email : List String -- needed
    , password : List String -- needed
    , password_confirmation : List String -- needed
    , school_id: List String -- needed
    , profile: ProfileFormError
    }

type alias ProfileFormError =
      { gender: List String
      , phone : List String
      , date_of_birth: List String
      , website: List String
      , about_me: List String
      }


-- empty users errors initialization
emptyUserError : UserError
emptyUserError =
    { name = []
    , alias_ = []
    , email = []
    , password = []
    , password_confirmation = []
    , school_id = []
    , profile = emptyProfileError
    }

-- Profile register initialization
emptyProfileError : ProfileFormError
emptyProfileError =
  { gender =  []
  , phone = []
  , date_of_birth = []
  , website = []
  , about_me = []
  }


-- user errors decoders
userErrorDecoder : Dec.Decoder UserError
userErrorDecoder =
    decode UserError
      |> optional "name" (Dec.list Dec.string) []
      |> optional "alias" (Dec.list Dec.string) []
      |> optional "email" (Dec.list Dec.string) []
      |> optional "password" (Dec.list Dec.string) []
      |> optional "password_confirmation" (Dec.list Dec.string) []
      |> optional "school_id" (Dec.list Dec.string) []
      |> optional "profile" (profileErrorDecoder) emptyProfileError

profileErrorDecoder : Dec.Decoder ProfileFormError
profileErrorDecoder =
    decode ProfileFormError
      |> optional "gender" (Dec.list Dec.string) []
      |> optional "phone" (Dec.list Dec.string) []
      |> optional "date_of_birth" (Dec.list Dec.string) []
      |> optional "website" (Dec.list Dec.string) []
      |> optional "about_me" (Dec.list Dec.string) []
