module Codeschool.View exposing (..)

--import Html.Attributes exposing (..)

import Codeschool.Model exposing (..)
import Codeschool.Msg exposing (Msg)
import Html exposing (..)
import Page.Classroom exposing (webDetail)
import Page.Help
import Page.Index
import Page.Learn
import Page.NotFound
import Page.Profile
import Page.Progress
import Page.Questions.Base
import Page.ScoreBoard
import Page.Social
import Page.Submission
import Page.Actions
import Page.Register
import Ui.Layout


getRouteView : Model -> Html Msg
getRouteView model =
    case model.route of
        ClassroomList ->
            Page.Classroom.classroomList Page.Classroom.clsList

        Classroom id ->
            Page.Classroom.classroomList Page.Classroom.clsList

        Help ->
            Page.Help.view model

        Index ->
            Page.Index.view model

        Learn ->
            Page.Learn.view model

        Logout ->
            Page.Index.view model

        Profile id ->
            Page.Profile.view model

        Progress ->
            Page.Progress.view model

        QuestionList ->
            Page.Questions.Base.viewList Page.Questions.Base.clsList

        Question id ->
            Page.Questions.Base.viewDetail model

        ScoreBoard ->
            Page.ScoreBoard.view model

        Social ->
            Page.Social.view model

        SubmissionList ->
            Page.Submission.view model

        NotFound ->
            Page.NotFound.view model

        Actions ->
            Page.Actions.view model

        Register ->
            Page.Register.view model


view : Html Msg -> Model -> Html Msg
view msg model =
    Ui.Layout.page (getRouteView model) model
