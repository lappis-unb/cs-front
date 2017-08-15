module Ui.Generic exposing (..)

{-| Generic Ui features and view function helpers. All functions in this module
return generic Html msg objects.
-}

import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Attr msg =
    Html.Attribute msg


type alias Attrs msg =
    List (Attr msg)



---- ELEMENTS ----


{-| Wraps object into a container class
-}
containerWrap : Html msg -> Html msg
containerWrap child =
    div [ class "container" ] [ child ]


{-| A container element
-}
container : List (Attribute msg) -> List (Html msg) -> Html msg
container attrs children =
    div (class "container" :: attrs) children


{-| A material icon element
-}
icon : Attrs msg -> String -> Html msg
icon attrs st =
    i (class "material-icons" :: attrs) [ text st ]


{-| A large emoticon icon
-}
emoticon : String -> Html msg
emoticon str =
    div [ class "large-emoticon" ] [ text str ]


{-| Formats a date
-}
date : Date -> String
date date =
    toString date



---- ATTRIBUTES ----


{-| Z-index of element
-}
zindex : Int -> Attr msg
zindex n =
    style [ ( "z-index", toString n ) ]

