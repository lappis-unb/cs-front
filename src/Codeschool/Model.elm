module Codeschool.Model
    exposing
        ( Model
        , Route(..)
        , init
        )

{-| Page model components.
-}

import Data.Classroom exposing (Classroom, ClassroomInfo)
import Data.Date exposing (..)
import Data.User exposing (..)
import Data.Registration exposing (..)
import Data.Login exposing (..)
import Time exposing (Time)
import Toast exposing (Toast)

{-| Main page Model
-}
type alias Model =
    { userRegister : UserForm
    , profileRegister : ProfileForm
    , expectRegister : ExpectRegisterResponse
    , userError: UserError
    , userLogin : UserLogin
    , route : Route
    , classroomInfoList : List ClassroomInfo
    , classroom : Maybe Classroom
    , loadedAssets : List String
    , date : Date
    , time : Time
    , toast : Toast String
    , auth : Auth
    , isLogged : Bool
    , markdownToString : String
    }


{-| Starts the main model to default state.
-}
init : Model
init =
    { userRegister = emptyUserRegister
    , profileRegister = emptyProfile
    , expectRegister = emptyExpectRegisterResponse
    , userError = emptyUserError
    , userLogin = emptyLogin
    , route = Index
    , classroomInfoList = []
    , classroom = Nothing
    , loadedAssets = []
    , date = testDate
    , time = 0
    , toast = Toast.initWithTransitionDelay (Time.second * 1.5)
    , auth = emptyAuth
    , isLogged = False
    , markdownToString = """
                # Basic
                Codifique um software receba o ano de nascimento de uma
                pessoa e o ano atual. Calcule e mostre:
                - a) A idade dessa pessoa.
                - b) Quantos anos essa pessoa terá  em 2018.
                """
    }



---- ROUTES ----


type alias Slug =
    String


type alias Id =
    Int


{-| A list of all valid routes in Codeschool
-}
type Route
    = Index
    | NotFound
    | ClassroomList
    | Classroom Slug
    | SubmissionList
    | ScoreBoard
    | Progress
    | Learn
    | Help
    | QuestionRoot
    | QuestionList Slug
    | Question Slug Slug
    | Social
    | Profile
    | Logout
    | Actions
    | Register
    | Login
