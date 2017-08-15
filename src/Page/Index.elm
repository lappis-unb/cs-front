module Page.Index exposing (view)

import Codeschool.Model exposing (..)
import Codeschool.Msg as Msg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ui.Generic exposing (container)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)


view : Model -> Html Msg
view m =
    div []
        [ simpleHero "Welcome to Codeschool" "" "simple-hero"
        , container []
            [ promoTable
                ( promoSimple "assignment"
                    "Enroll"
                    []
                    [ text
                        """
                        Codeschool provides many programming-based courses.
                        If you are not registered, please click
                        """
                    , a [ onClick (ChangeRoute (Register)), style [("cursor", "pointer")] ] [ text "here" ]
                    ]
                , promoSimple "search"
                    "Discover"
                    []
                    [ text
                        """
                        You can find tutorials, exercises and other learning
                        materials that are not associated with any course.
                        """
                    ]
                , promoSimple "question_answer"
                    "Interact"
                    []
                    [ text
                        """
                        You can invite your friends to be part of your contacts
                        network and collaborate and challenge them.
                        """
                    ]
                )
            ]
        ]
