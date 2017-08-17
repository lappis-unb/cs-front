module Ui.Header exposing (..)

{-| The Header component
-}

import Codeschool.Model exposing (..)
import Codeschool.Msg as Msg exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ui.Generic exposing (icon, zindex)


{-| View header component.
-}
header : Model -> Html Msg
header model =
    let
        link route txt =
            button
                [ onClick (ChangeRoute route)
                , slot "top"
                , class "page-header__link"
                ]
                [ text txt ]

        slot =
            attribute "slot"

        --button =
        --    span [ class "page-header__user-menu" ] [ icon [] "person" ]

        userMenu =
            div
                [ class "page-header__user-menu"
                , attribute "horizontal-align" "right"
                , attribute "horizontal-offset" "-0"
                , attribute "vertical-offset" "80"
                ]
                [ span
                    [ slot "dropdown-trigger"
                    , class "page-header__user-menu-button"
                    , attribute "mini" "mini"
                    , attribute "label" " ツ "
                    ]
                    []
                , div [ slot "dropdown-content", class "page-header__user-menu-content" ]
                    [ div [ class "page-header__user-menu-icon" ] [ icon [] "person" ]
                    , div [ class "page-header__user-menu-title" ] [ h1 [] [ text "Actions" ] ]
                    , span [ onClick (ChangeRoute (Register)) ] [ text "Register" ]
                    , span [ onClick (ChangeRoute (Profile model.user.id)) ] [ text "Profile" ]
                    , span [ href "/logout/" ] [ text "Logout" ]
                    ]
                ]

        fabOnClick =
          if model.route == Actions then
            onClick (GoBack 1)
          else
            onClick (ChangeRoute Actions)


        mobileMenu =
            div
                [ class "page-header__user-menu"
                , attribute "horizontal-align" "right"
                , attribute "horizontal-offset" "-0"
                , attribute "vertical-offset" "80"
                ]
                [ span
                    [ slot "dropdown-trigger"
                    , class "mobile-button"
                    , attribute "mini" "mini"
                    , attribute "label" " ツ "
                    , fabOnClick
                    ]
                    []
                ]

        header =
            div
                [ class "page-header"
                , zindex 10
                ]
                [ span [ class "page-logo", slot "top" ]
                    [ img
                        [ src "https://codeschool.lappis.rocks/static/img/logo.svg"
                        , onClick (ChangeRoute Index)
                        ]
                        []
                    ]
                , link ClassroomList "Classrooms"
                , link QuestionList "Questions"
                , link Social "Social"
                , div [class "page-header__special-buttons"]
                  [
                  icon [ class "page-header__notification" ] "notifications"
                  , userMenu
                  , mobileMenu
                  ]
                ]
    in
    div [] [ header ]
