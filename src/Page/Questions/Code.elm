module Page.Questions.Code exposing (viewDetail, question)
import Codeschool.Msg exposing (..)
import Data.Question exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)
import Json.Decode as Json
import Html.Events.Extra exposing (targetValueMaybeIntParse)
import Dict

-- import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ace


langItems = Dict.fromList [(Java, "Java"), (Python, "Python 3")]
langItems = [(Java, "java"), (Python, "python3")]
langItemsInv = List.map (\(a, b) -> (b, a)) langItems


humanLang lang =
    case Dict.get langItems of
        Just obj -> obj
        Nothing -> Python


type alias CodeQuestion =
    { selected : Maybe String }


model : CodeQuestion
model =
    { selected = Nothing }


type Msg
    = NoOp
    | Select (Maybe Int)


update : Msg -> CodeQuestion -> CodeQuestion
update msg cls =
    case msg of
        NoOp ->
            cls

        Select s ->
            { cls | selected = s }
viewDetail : CodeQuestion -> Html msg
viewDetail cls =
    let
    selectEvent =
        on "change"
        (Json.map Select targetSelectedIndex)

    div []
        [ simpleHero question.questionInfo.title "" "simple-hero__page-blue"
        , div [ class "question-description" ]
            [
                Codeschool.Msg.toHtmlString """# Basic
        Codifique um software receba o ano de nascimento de uma
        pessoa e o ano atual. Calcule e mostre:
        - a) A idade dessa pessoa.
        - b) Quantos anos essa pessoa terá  em 2018."""
            ]

        in
          , select [ class "select-language", selectEvents]
              [ option [ value "", disabled True, selected True, class "disabled-item" ] [ text "Select language" ]
              , option [ value "C" ] [ text "C" ]
              , option [ value "Python" ] [ text "Python" ]
              , option [ value "Java" ] [ text "Java" ]
              , option [ value "elm" ] [ text "elm" ]
              , option [ value "Javascript" ] [ text "JavaS" ]
              ]
          , div [ class "item-question", ]
              [ aceEditor "javascript"]
          , button [ class "send-button" ] [ text "Send to evaluation" ]
        ]

question : CodeQuestion
question =
    { questionInfo = questionInfoExample
    , description =
        """Codifique um software receba o ano de nascimento de uma
        pessoa e o ano atual. Calcule e mostre:
        a) A idade dessa pessoa.
        b) Quantos anos essa pessoa terá  em 2018."""
    , acceptedLanguages = [Java, C, Cpp, Python2, Python]
    , selectedLanguage = ""
    , answer = ""
    }


aceEditor : String -> Html msg
aceEditor language =
   Ace.toHtml
      [ Ace.theme "textmate"
      , Ace.enableBasicAutocompletion True
      , Ace.enableLiveAutocompletion True
      , Ace.tabSize 4
      , Ace.mode language
      , Ace.value ""
      ] []
