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
import Time exposing (Time)
import Toast exposing (Toast)

{-| Main page Model
-}
type alias Model =
    { user : User
    , userError: UserError
    , route : Route
    , classroomInfoList : List ClassroomInfo
    , classroom : Maybe Classroom
    , loadedAssets : List String
    , date : Date
    , time : Time
    , toast : Toast String
    }


{-| Starts the main model to default state.
-}
init : Model
init =
    { user = testUser
    , userError = testUserError
    , route = Index
    , classroomInfoList = []
    , classroom = Nothing
    , loadedAssets = []
    , date = testDate
    , time = 0
    , toast = Toast.initWithTransitionDelay (Time.second * 1.5)
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
    | Profile Id
    | Logout
    | Actions
    | Register
