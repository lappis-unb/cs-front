module Page.Questions.QuestionRoot exposing (clsList, viewDetail, viewList)

-- import Codeschool.Msg exposing (..)
-- import Data.User exposing (User)

import Codeschool.Model exposing (Model)
import Data.Question exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Generic exposing (container, date, emoticon)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)


-- import Html.Events exposing (..)


viewDetail : Model -> Html msg
viewDetail m =
    div [] [ text "#teste" ]


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
        [ simpleHero "Type of Questions" "See all questions available for you" "simple-hero__page-blue"
        , div [] children
        ]


questionInfo : QuestionInfo -> Html msg
questionInfo cls =
    div [ class "question-info-card" ]
        [ Ui.Generic.icon [ class "question-info-card__icon" ] cls.icon
        , h1 [ class "question-info-card__title" ]
            [ text cls.questionName
            ]
        , p [ class "question-info-card__description" ]
            [ text cls.shortDescription
            ]
        ]


questionOne : QuestionInfo
questionOne =
    { questionName = "Basic"
    , shortDescription = "Elementary programming problems."
    , icon = "sentiment_very_satisfied"
    }


questionTwo : QuestionInfo
questionTwo =
    { questionName = "Conditionals"
    , shortDescription = "Conditional flow control (if/else)."
    , icon = "code"
    }

questionThree : QuestionInfo
questionThree =
    { questionName = "Loops"
    , shortDescription = "Iterations with for/while commands"
    , icon = "loop"
    }

questionFour : QuestionInfo
questionFour =
    { questionName = "Functions"
    , shortDescription = "Organize code using functions."
    , icon = "functions"
    }

questionFive : QuestionInfo
questionFive =
    { questionName = "Files"
    , shortDescription = "Open, process and write files."
    , icon = "insert_drive_file"
    }

questionSix : QuestionInfo
questionSix =
    { questionName = "Lists"
    , shortDescription = "Linear data structures."
    , icon = "list"
    }

clsList : List QuestionInfo
clsList =
    [ questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix ]
