module Codeschool.Routing exposing (parseLocation, reverse)

import Codeschool.Model exposing (Route(..))
import Navigation exposing (Location)
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Index top
        , map Classroom (s "classrooms" </> string)
        , map ClassroomList (s "classrooms/")
        , map SubmissionList (s "submissions")
        , map ScoreBoard (s "score")
        , map Progress (s "progress")
        , map Learn (s "learn")
        , map Help (s "help")
        , map QuestionRoot (s "questions")
        , map QuestionList (s "questions" </> string)
        , map Question (s "questions" </> string </> string)
        , map Social (s "social")
        , map Profile (s "profile")
        , map Logout (s "logout")
        , map Actions (s "actions")
        , map Register (s "register")
        , map Login (s "login")
        ]


{-| Convert location to route
-}
parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            NotFound


{-| Reverse URL without using the # prefix.
-}
baseReverse : Route -> String
baseReverse route =
    case route of
        Index ->
            ""

        Classroom st ->
            "classrooms/" ++ st

        ClassroomList ->
            "classrooms/"

        SubmissionList ->
            "submissions/"

        ScoreBoard ->
            "score/"

        Progress ->
            "progress/"

        Learn ->
            "learn/"

        Help ->
            "help/"

        QuestionRoot ->
            "questions/"

        QuestionList st ->
            "questions/" ++ st

        Question a b ->
            "code/" ++ a ++ "/" ++ b

        Social ->
            "social"

        Profile ->
            "profile/"

        Logout ->
            "logout/"

        NotFound ->
            "404.html"

        Actions ->
            "actions/"

        Register ->
            "register/"

        Login ->
            "login/"


{-| Reverse URL prepending the "#" symbol
-}
reverse : Route -> String
reverse route =
    "#" ++ baseReverse route
