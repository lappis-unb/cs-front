module Page.Questions.BasicQuestion exposing (clsList, viewList)

import Codeschool.Model exposing (Model)
import Data.Question exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Generic exposing (container, date, emoticon)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)

questions_type = "Basic questions"
questions_type_description = "Easy Easy Maaann, mostly basic questions"

viewList : List QuestionInfo -> Html msg
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
        [ simpleHero questions_type questions_type_description "simple-hero__page-blue"
        , div [] children
        ]


questionInfo : QuestionInfo -> Html msg
questionInfo cls =
    div [ class "question-card" ]
        [ Ui.Generic.icon [ class "question-info-card__icon" ] cls.icon
        , h1 [ class "question-card__title" ]
            [ text cls.questionName
            ]
        , p [ class "question-card__description" ]
            [ text cls.shortDescription
            ]
        ]


questionOne : QuestionInfo
questionOne =
    { questionName = "Questão mais facil"
    , shortDescription = "Questão mais facil, se n conseguir fazer vaza."
    , icon = "sentiment_very_satisfied"
    }


questionTwo : QuestionInfo
questionTwo =
    { questionName = "Segunda mais facil"
    , shortDescription = "Questão facil também."
    , icon = "code"
    }

questionThree : QuestionInfo
questionThree =
    { questionName = "Questão dificil"
    , shortDescription = "Essa é hard"
    , icon = "loop"
    }


clsList : List QuestionInfo
clsList =
    [ questionOne, questionTwo, questionThree ]
