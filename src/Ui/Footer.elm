module Ui.Footer exposing (footer)

{-| The Footer component
-}

import Codeschool.Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Generic exposing (..)


{-| Renders footer element
-}
footer : Model -> Html msg
footer model =
  let
      fab_ =
        if model.route == Actions then
          div [] []
        else
          div [ class "page-footer__copyright" ]
              [ p []
                  [ text "Copyright 2016 -"
                  , a
                      [ href "http://github.com/fabiommendes/codeschool" ]
                      [ text "Codeschool" ]
                  ]
              , p []
                  [ text "Site gerenciado por Fábio M. Mendes na UnB/Gama." ]
              ]


  in
    div
        [ class "page-footer", zindex 10 ] [fab_]
