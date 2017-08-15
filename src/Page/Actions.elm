module Page.Actions exposing (..)

import Codeschool.Model exposing (..)
import Codeschool.Msg as Msg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (back)
import Polymer.Paper as Paper exposing (..)
import Ui.Generic exposing (..)
import Ui.Sidebar exposing (sidebar)

view : Model -> Html Msg
view model =
  div [][
      div [class "action-list"] [
         listbox [ attribute "slot" "dropdown-content", class "page-header__user-menu-content" ]
        [ h1 [class "mobile-button__fonts-title"] [ text "Actions" ]
        , item [ onClick (ChangeRoute (ClassroomList)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Classrooms"] ]
        , item [ onClick (ChangeRoute (QuestionList)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Questions"] ]
        , item [ onClick (ChangeRoute (Social)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Social"] ]
        , item [ onClick (ChangeRoute (Profile model.user.id)), class "mobile-button__item" ] [ h1 [class "mobile-button__fonts"] [text "Profile"] ]
        , item [ href "/logout/" ] [ h1 [class "mobile-button__fonts"] [text "Logout"] ]
        ]
         , listbox [ attribute "slot" "dropdown-content", class "page-header__user-menu-content__sidebar" ]
         [ h1 [class "mobile-button__fonts-title"] [ text "More" ]
         , sidebar "mobile-sidebar" model
         ]
      ]
    ]
