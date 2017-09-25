module Page.Index exposing (view)

import Codeschool.Model exposing (..)
import Codeschool.Msg as Msg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ui.Generic exposing (container)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)

checkLogin : Model -> String -> Html Msg
checkLogin model place =
    case model.isLogged of
      False ->
        case place of
          "hero" ->
              simpleHero "Welcome to Codeschool" "" "simple-hero"
          "promo" ->
              div []
                  [ text
                    """
                    Codeschool provides many programming-based courses.
                    If you are not registered, please click
                    """
                  , a [ onClick (ChangeRoute (Register)), style [("cursor", "pointer")] ] [ text "here" ]
                  , text
                    """
                    . Otherwise, Log in
                    """
                  , a [ onClick (ChangeRoute (Login)), style [("cursor", "pointer")] ] [ text "here" ]
                  ]

          _ ->
            div [] []

      True ->
        case place of
          "hero" ->
              simpleHero ("Welcome to Codeschool, " ++ model.auth.user.alias_) "" "simple-hero"
          "promo" ->
              div []
                  [ text
                    """
                    Codeschool provides many programming-based courses.
                    Start right now!
                    """
                  ]
          _ ->
            div [] []



view : Model -> Html Msg
view m =
    div []
        [ checkLogin m "hero"
        , container []
            [ promoTable
                ( promoSimple "assignment"
                    "Enroll"
                    []
                    [ checkLogin m "promo"
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
