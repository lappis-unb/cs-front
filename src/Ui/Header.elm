module Ui.Header exposing (..)

{-| The Header component
-}

import Codeschool.Model exposing (..)
import Codeschool.Msg as Msg exposing (..)
import Color exposing (black, blue)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Material.Icons.Action
import Material.Icons.Navigation exposing (more_horiz)
import Ui.Generic exposing (icon, zindex)


{-| View header component.
-}
checkLogin : Model -> Html Msg
checkLogin model =
  case model.isLogged of
    False ->
      div [] []
    True ->
      span [ (onClick LogOut) ] [ text "Logout" ]

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

        userMenu =
                div [class "dropdown"]
                    [ Material.Icons.Navigation.menu black 32
                    , div [class "dropdown-content"]
                          [ div [class "page-header__user-menu-icon"] [ Material.Icons.Action.perm_identity black 32 ]
                          , div [ class "page-header__user-menu-title" ] [ h1 [] [ text "Actions" ] ]
                          , span [ onClick (ChangeRoute (Register)) ] [ text "Register" ]
                          , span [ onClick (ChangeRoute (Profile)) ] [ text "Profile" ]
                          , checkLogin model
                          ]
                    ]


        fabOnClick =
          if model.route == Actions then
            onClick (GoBack 1)
          else
            onClick (ChangeRoute Actions)


        mobileMenu =
                div [ fabOnClick, class "mobile-button"]
                    [ Material.Icons.Navigation.menu black 32
                    , div [  ]
                          []
                    ]


            -- div
            --     [ class "page-header__user-menu"
            --     , attribute "horizontal-align" "right"
            --     , attribute "horizontal-offset" "-0"
            --     , attribute "vertical-offset" "80"
            --     ]
            --     [ span
            --         [ slot "dropdown-trigger"
            --         , class "mobile-button"
            --         , attribute "mini" "mini"
            --         , attribute "label" " ツ "
            --         , fabOnClick
            --         ]
            --         []
            --     ]

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
                , link QuestionRoot "Questions"
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
