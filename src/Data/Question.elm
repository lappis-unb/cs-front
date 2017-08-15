module Data.Question exposing (..)

{-| Question representations
-}

{-| Represents the reduced information about a question that is shown on listings
-}
type alias QuestionInfo =
    { questionName : String
    , shortDescription : String
    , icon : String
    }
