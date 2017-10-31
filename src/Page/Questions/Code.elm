module Page.Questions.Code exposing (viewDetail, question)

-- import Codeschool.Msg exposing (..)
-- import Data.User exposing (User)

import Codeschool.Msg exposing (..)
import Data.Question exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
-- import Ui.Generic exposing (container, icon)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)

-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)


viewDetail : CodeQuestion -> Html msg
viewDetail cls =
    div []
        [ simpleHero question.questionInfo.title "" "simple-hero__page-blue"
        , div [ class "question-description" ]
            [
                Codeschool.Msg.toHtmlString """# Basic
Codifique um software receba o ano de nascimento de uma
pessoa e o ano atual. Calcule e mostre:
- a) A idade dessa pessoa.
- b) Quantos anos essa pessoa terá  em 2018."""
            ]
          , select [ class "select-language"  ]
              [ option [ value "", disabled True, selected True, class "disabled-item" ] [ text "Select language" ]
              , option [ value "C" ] [ text "C" ]
              , option [ value "Python" ] [ text "Python" ]
              , option [ value "Java" ] [ text "Java" ]
              , option [ value "Java" ] [ text "Java" ]
              , option [ value "Java" ] [ text "Java" ]
              ]
          , div [ class "item-question" ]
              [ textarea [ class "item-question", maxlength 1000, placeholder "Insert your code" ] []
              ]
          , button [ class "send-button" ] [ text "Send to evaluation" ]
        ]

question : CodeQuestion
question =
    { questionInfo = questionInfoExample
    , description =
        """Codifique um software receba o ano de nascimento de uma
        pessoa e o ano atual. Calcule e mostre:
        a) A idade dessa pessoa.
        b) Quantos anos essa pessoa terá  em 2018.
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa."""
    , acceptedLanguages = [Java, C, Cpp, Python2, Python]
    , selectedLanguage = ""
    , answer = ""
    }
