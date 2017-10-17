module Data.Question exposing (..)

{-| Question representations
-}

{-| Represents the reduced information about a question that is shown on listings
-}
type alias QuestionInfo =
    { title : String
    , shortDescription : String
    , icon : String
    , slug : String
    }

type alias CodeQuestion =
    { questionInfo : QuestionInfo
    , description : String
    , acceptedLanguages : List ProgrammingLanguage
    , selectedLanguage : String
    , answer : String
    }

type ProgrammingLanguage
    = Java | C | Cpp | Python2 | Python

programmingLanguageName : ProgrammingLanguage -> String
programmingLanguageName lang =
    case lang of
        Cpp -> "C++"
        Python2 -> "Python 2.7"
        Java -> "Java 8"
        _ -> toString lang

--FIXME : apagar quando API estiver pronta
questionInfoExample : QuestionInfo
questionInfoExample =
    { title = "Functions"
    , shortDescription = "Organize code using functions."
    , icon = "functions"
    , slug = "functions"
    }

codeQuestionExample : CodeQuestion
codeQuestionExample =
    { questionInfo = questionInfoExample
    , description = " Codifique um software receba o ano de nascimento de uma"++
        "pessoa e o ano atual. Calcule e mostre:"++
        "a) A idade dessa pessoa."++
        "b) Quantos anos essa pessoa terá  em 2018."++
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"++
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"++
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"++
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa."
    , acceptedLanguages = [Java, C, Cpp, Python2, Python]
    , selectedLanguage = ""
    , answer = ""
    }
