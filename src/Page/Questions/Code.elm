module Page.Questions.Code exposing (view)

-- import Codeschool.Msg exposing (..)
-- import Data.User exposing (User)

import Codeschool.Model exposing (Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Generic exposing (container, icon)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)


-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)



view : Model -> Html msg
view m =
    div []
        [ simpleHero "Idade" "" "simple-hero__page-blue"
        , div [ class "main-container" ]
            [ text
              """
              Codifique um software receba o ano de nascimento de uma pessoa e o ano atual. Calcule e mostre:
              a) A idade dessa pessoa.
              b) Quantos anos essa pessoa terá  em 2018.
              """
            ]
          , div [ class "item-question" ]
              [ textarea [ class "item-question", maxlength 1000, placeholder "Insert your code" ] []
              ]
          , button [ class "cancel-button" ] [ text "Cancel" ]
          , button [ class "send-button" ] [ text "Send to evaluation" ]
        ]
