module Page.Questions.QuestionList exposing (clsList, viewList)

import Data.Question exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Generic exposing (container, date, emoticon)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)
import Html.Events exposing (..)
import Codeschool.Model exposing (..)
import Codeschool.Msg exposing (..)

questions_type = "Basic questions"
questions_type_description = "Easy Easy Maaann, mostly basic questions"

viewList : List QuestionInfo -> Html Msg
viewList m =
    let
        -- testing if there are no questions
        --  m = []
        empty =
            [ emoticon ":-("
            , p [ class "center-text" ]
                [ text "Sorry, there are no questions for you."
                , br [] []
                , text "Please wait for more questions or send a message to you teacher to check if everything is ok."
                ]
            ]

        listing =
            [ div [ class "question-info-list" ] (List.map questionInfo m)
            ]

        fab_ =
            div [] []

        children =
            case m of
                [] ->
                    fab_ :: empty

                _ ->
                    fab_ :: listing
    in
    div []
        [ simpleHero questions_type questions_type_description "simple-hero__page-emerald"
        , div [] children
        ]


questionInfo : QuestionInfo -> Html Msg
questionInfo cls =
    div [ class "question-card", onClick (ChangeRoute ( Question "base" "code" )) ]
        [ Ui.Generic.icon [ class "question-info-card__icon" ] cls.icon
        , h1 [ class "question-card__title" ]
            [ text cls.title
            ]
        , p [ class "question-card__description" ]
            [ text cls.shortDescription
            ]
        ]


questionOne : QuestionInfo
questionOne =
    { title = "Questão mais facil"
    , shortDescription = "Questão mais facil, se n conseguir fazer vaza."
    , icon = "sentiment_very_satisfied"
    , slug = "veryeasy"
    }


questionTwo : QuestionInfo
questionTwo =
    { title = "Segunda mais facil"
    , shortDescription = "Questão facil também."
    , icon = "code"
    , slug = "easy"
    }

questionThree : QuestionInfo
questionThree =
    { title = "Questão dificil"
    , shortDescription = "Essa é hard"
    , icon = "loop"
    , slug = "hard"
    }

questionFour : QuestionInfo
questionFour =
    { title = "Questão dificil"
    , shortDescription = "Essa é hard"
    , icon = "loop"
    , slug = "hard2"
    }


clsList : List QuestionInfo
clsList =
    [ questionOne, questionTwo, questionThree, questionFour ]
