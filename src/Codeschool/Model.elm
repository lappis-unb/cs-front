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

{-| Main page Model
-}
type alias Model =
    { userRegister : UserForm
    , expectRegister : ExpectRegisterResponse
    , userError: UserError
    , userLogin : UserLogin
    , route : Route
    , classroomInfoList : List ClassroomInfo
    , classroom : Maybe Classroom
    , loadedAssets : List String
    , date : Date
    , time : Time
    , auth : Auth
    , isLogged : Bool
    }


{-| Starts the main model to default state.
-}
init : Model
init =
    { userRegister = emptyUserRegister
    , expectRegister = emptyExpectRegisterResponse
    , userError = emptyUserError
    , userLogin = emptyLogin
    , route = Index
    , classroomInfoList = []
    , classroom = Nothing
    , loadedAssets = []
    , date = testDate
    , time = 0
    , auth = emptyAuth
    , isLogged = False
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
    | QuestionList
    | Question Id
    | Social
    | Profile
    | Logout
    | Actions
    | Register
    | Login
