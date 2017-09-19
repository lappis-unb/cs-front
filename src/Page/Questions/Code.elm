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
    div [ class "question-info-card" ]
      [ Ui.Generic.icon [ class "question-info-card__icon" ] "code"
      , h1 [ class "question-info-card__title" ]
          [ text "Questão mega hard"
          ]
      , p [ class "question-info-card__description" ]
          [ text "Essa questão foi desenvolvida para ferrar a vida de vocês"
          ]
      ]
