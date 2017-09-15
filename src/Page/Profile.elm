module Page.Profile exposing (view)

import Codeschool.Model exposing (Model)
import Html exposing (..)
import Ui.Generic exposing (container)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)
import Html.Attributes exposing (..)



checkLogin : Model -> Html msg
checkLogin model =
  case model.isLogged of
    True ->
      div []
          [ simpleHero model.loggedUser.alias_ "Profile" "simple-hero"
          , container []
              [ h1 [] [ text "Personal info" ]
              , p [] [ text ("Name: " ++ model.loggedUser.alias_) ]
              , p [] [ text ("E-mail: " ++ model.loggedUser.email) ]
              ]
          ]
    False ->
      div [ class "main-container" ]
          [div [class "loggedin-text"] [ text "Please login to see your profile!" ]]

view : Model -> Html msg
view m =
    checkLogin m
