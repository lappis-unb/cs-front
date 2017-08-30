module Page.Login exposing (view)

import Codeschool.Model exposing (Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)



view : Model -> Html msg
view m =
    div []
        [ simpleHero "Login" "" "simple-hero"
        , div [ class "main-container" ]
              [ div [ class "item-form", style [("margin-top", "30px")] ]
                [ input [ placeholder "E-mail", type_ "email" ] [] ]
              , div [ class "item-form" ]
                [ input [ placeholder "Password",  type_ "password" ] [] ]
              , button [ class "submit-button" ] [ text "Submit" ]  
              ]

        ]
