module Page.Actions exposing (..)

import Codeschool.Model exposing (..)
import Codeschool.Msg as Msg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ui.Sidebar exposing (sidebar)

checkLogin : Model -> Html Msg
checkLogin model =
  case model.isLogged of
    False ->
      div [] []
    True ->
      span [ onClick LogOut, class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Logout"] ]

view : Model -> Html Msg
view model =
  div [][
      div [class "action-list"] [
         div [ attribute "slot" "dropdown-content", class "page-header__user-menu-content" ]
        [ h1 [class "mobile-button__fonts-title"] [ text "Actions" ]
        , span [ onClick (ChangeRoute (ClassroomList)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Classrooms"] ]
        , span [ onClick (ChangeRoute (QuestionList)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Questions"] ]
        , span [ onClick (ChangeRoute (Social)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Social"] ]
        , span [ onClick (ChangeRoute (Profile)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Profile"] ]
        , checkLogin model
        ]
         , div [ attribute "slot" "dropdown-content", class "page-header__user-menu-content__sidebar" ]
         [ h1 [class "mobile-button__fonts-title"] [ text "More" ]
         , sidebar "mobile-sidebar" model
         ]
      ]
    ]
