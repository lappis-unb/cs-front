module Page.Profile exposing (view)

import Codeschool.Model exposing (Model)
import Html exposing (..)
import Ui.Generic exposing (container)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)
import Data.User exposing (User, UserError, toJson, userDecoder, userErrorDecoder, LoggedUser)


-- type alias Profile =
--     { name : String, email : String }
--
--
-- profile =
--     { name = "John Smith", email = "foo@google.com" }


view : Model -> Html msg
view m =
    div []
        [ simpleHero m.loggedUser.alias_ "Profile" "simple-hero"
        , container []
            [ h1 [] [ text "Personal info" ]
            , p [] [ text ("Name: " ++ m.loggedUser.alias_) ]
            , p [] [ text ("url (test): " ++ m.loggedUser.url) ]
            , p [] [ text ("role (test): " ++ m.loggedUser.role) ]
            ]
        ]
