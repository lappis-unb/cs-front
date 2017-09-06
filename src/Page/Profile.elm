module Page.Profile exposing (view)

import Codeschool.Model exposing (Model)
import Html exposing (..)
import Ui.Generic exposing (container)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)



view : Model -> Html msg
view m =
    div []
        [ simpleHero m.loggedUser.alias_ "Profile" "simple-hero"
        , container []
            [ h1 [] [ text "Personal info" ]
            , p [] [ text ("Name: " ++ m.loggedUser.alias_) ]
            , p [] [ text ("E-mail: " ++ m.loggedUser.email) ]
            ]
        ]
