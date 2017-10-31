module Page.Questions.QuestionRoot exposing (clsList, viewDetail, viewList)

-- import Codeschool.Msg exposing (..)
-- import Data.User exposing (User)

import Codeschool.Model exposing (..)
import Data.Question exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Generic exposing (container, date, emoticon)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)
import Html.Events exposing (..)
import Codeschool.Model exposing (..)
import Codeschool.Msg exposing (..)

-- import Html.Events exposing (..)


viewDetail : Model -> Html Msg
viewDetail m =
    div [] [ text "#teste" ]

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
        [ simpleHero "Category of Questions" "See all questions available for you" "simple-hero__page-emerald"
        , div [] children
        ]


questionInfo : QuestionInfo -> Html Msg
questionInfo cls =
    div [ class "question-info-card", onClick (ChangeRoute (QuestionList "base")) ]
        [ Ui.Generic.icon [ class "question-info-card__icon" ] cls.icon
        , h1 [ class "question-info-card__title" ]
            [ text cls.title
            ]
        , p [ class "question-info-card__description" ]
            [ text cls.shortDescription
            ]
        ]


questionOne : QuestionInfo
questionOne =
    { title = "Basic"
    , shortDescription = "Elementary programming problems."
    , icon = "sentiment_very_satisfied"
    , slug = "basic"
    }


questionTwo : QuestionInfo
questionTwo =
    { title = "Conditionals"
    , shortDescription = "Conditional flow control (if/else)."
    , icon = "code"
    , slug = "conditionals"
    }

questionThree : QuestionInfo
questionThree =
    { title = "Loops"
    , shortDescription = "Iterations with for/while commands"
    , icon = "loop"
    , slug = "loops"
    }

questionFour : QuestionInfo
questionFour =
    { title = "Functions"
    , shortDescription = "Organize code using functions."
    , icon = "functions"
    , slug = "functions"
    }

questionFive : QuestionInfo
questionFive =
    { title = "Files"
    , shortDescription = "Open, process and write files."
    , icon = "insert_drive_file"
    , slug = "files"
    }

questionSix : QuestionInfo
questionSix =
    { title = "Lists"
    , shortDescription = "Linear data structures."
    , icon = "list"
    , slug = "list"
    }

clsList : List QuestionInfo
clsList =
    [ questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix ]
