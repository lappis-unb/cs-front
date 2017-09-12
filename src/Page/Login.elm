module Page.Login exposing (view)

import Codeschool.Model exposing (Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)
import Codeschool.Msg as Msg exposing (Msg)



checkLogin : Model -> Html Msg
checkLogin model =
    case model.isLogged of
      False ->
        div [ class "main-container" ]
              [ div [ class "item-form", style [("margin-top", "30px")] ]
                [ input [ placeholder "E-mail", type_ "email", onInput (Msg.UpdateLogin "email") ] [] ]
              , div [ class "item-form" ]
                [ input [ placeholder "Password",  type_ "password", onInput (Msg.UpdateLogin "password") ] [] ]
              , button [ class "submit-button", onClick Msg.DispatchLogin ] [ text "Submit" ]
              ]
      True ->
        div [ class "main-container" ]
            [div [class "loggedin-text"] [ text "You are already logged in!" ]]


view : Model -> Html Msg
view m =
    div []
        [ simpleHero "Login" "" "simple-hero"
        , checkLogin m
        ]
