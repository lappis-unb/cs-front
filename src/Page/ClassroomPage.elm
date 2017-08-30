module Page.ClassroomPage exposing (view)

import Codeschool.Model exposing (Model)
import Html exposing (..)
import Ui.Generic exposing (container)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)




view : Model -> Html msg
view m =
    div []
      [ simpleHero "profile.name" "Profile" "simple-hero"
        , container []
            [ h1 [] [ text "Personal info" ]
            , p [] [ text ("Name: " ++ "profile.name") ]
            , p [] [ text ("E-mail: " ++ "profile.email") ]
            ]
        ]
