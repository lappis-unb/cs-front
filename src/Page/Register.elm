module Page.Register exposing (view)

import Codeschool.Model exposing (Model, Route(..))
import Codeschool.Msg as Msg exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, onInput, onSubmit)
import Json.Decode as Json
import Ui.Parts exposing (promoSimple, promoTable, simpleHero)


mapErrorsToLi : List String -> List (Html msg)
mapErrorsToLi errors =
    List.map (\err -> li [] [ text err ]) errors

defineErrorStyle : Bool -> String
defineErrorStyle notHasError =
  if notHasError then
    "item-no-errors"
  else
    "item-errors"


regFormField : Model -> List String -> (String, String, String, String, String) -> Html Msg
regFormField model fieldErrors attributes =
    let
        (placeholderText, fieldType, modelValue, regex, errorMessage) = attributes
        checkErrors = List.isEmpty (mapErrorsToLi fieldErrors)
    in
      div [ class "main-container" ]
        [ div [ class "item-form", class (defineErrorStyle checkErrors)]
            [ input
                [ pattern regex
                , placeholder placeholderText
                , type_ fieldType
                , onInput (Msg.UpdateUserRegister modelValue)
                , title errorMessage
                ] []
            ]
        , ul [] (mapErrorsToLi fieldErrors)
        ]

regProfile : Model -> List String -> (String, String, String, String, String) -> Html Msg
regProfile model fieldErrors attributes =
    let
        (placeholderText, fieldType, modelValue, regex, errorMessage) = attributes
        checkErrors = List.isEmpty (mapErrorsToLi fieldErrors)
    in
      div [ class "main-container" ]
        [ div [ class "item-form", class (defineErrorStyle checkErrors) ]
            [ input
                [ pattern regex
                , placeholder placeholderText
                , type_ fieldType
                , onInput (Msg.UpdateProfileRegister modelValue)
                , title errorMessage
                ] []
            ]
        , ul [] (mapErrorsToLi fieldErrors)
        ]

checkLogin : Model -> Html Msg
checkLogin model =
  case model.isLogged of
    False ->
      div []
          [ simpleHero "Register" "" "simple-hero__page-blue"
          , div [ class "main-container" ]
              [ h1 [ class "form-title" ] [ text "Required Fields" ]
              , regFormField model model.userError.name
                  ( "Full name"
                  , "text"
                  , "name"
                  , "^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]{3,50}$"
                  , "Por favor insira um nome entre 3 e 50 caracteres"
                  )
              , regFormField model model.userError.school_id
                  ( "School id"
                  , "text"
                  , "school_id"
                  , "^[0-9]{1,15}$"
                  , "Somente números são permitidos."
                  )
              , regFormField model model.userError.alias_
                  ( "Username"
                  , "text"
                  , "alias_"
                  , "^[A-Za-z0-9_.]{3,20}$"
                  , "Por favor insira um usuário de 3 a 20 caracteres alfanuméricos. Somente _ e . são permitidos."
                  )
              , div [ class "item-form", class (defineErrorStyle (List.isEmpty (mapErrorsToLi model.userError.email))) ]
                  [ input
                      [ placeholder "E-mail"
                      , type_ "email"
                      , onInput (Msg.UpdateUserRegister "email")
                      ] []
                  ]
              , ul [] (mapErrorsToLi model.userError.email)
              , regFormField model model.userError.password
                  ( "Password"
                  , "password"
                  , "password"
                  , "^[\\S]{6,30}$"
                  , "Sua senha deve conter no mínimo 6 caracteres alfanuméricos. Símbolos permitidos."
                  )
              , regFormField model model.userError.password_confirmation
                  ( "Repeat Password"
                  , "password"
                  , "password_confirmation"
                  , "^[\\S]{6,30}$"
                  , "Confirme sua senha"
                  )
              , h1 [ class "form-title" ] [ text "Optional Fields" ]
              , select [ Html.Attributes.name "Gender", class "item-form", onChange (Msg.UpdateProfileRegister "gender") ]
                  [ option [ value "", disabled True, selected True, class "disabled-item" ] [ text "Gender" ]
                  , option [ value "Male" ] [ text "Male" ]
                  , option [ value "Female" ] [ text "Female" ]
                  , option [ value "Others" ] [ text "Others" ]
                  ]
              , regProfile model model.userError.alias_
                  ( "Phone"
                  , "text"
                  , "phone"
                  , "^[0-9]{8,20}$"
                  , "Por favor insira um telefone válido."
                  )
              , div [ class "date-form" ]
                  [ monthPicker
                  , input [ pattern "([0]?[1-9]|[12][0-9]|3[01])", maxlength 2, placeholder "Day", class "date-item", onInput (Msg.UpdateDate "day") ] []
                  , input [ pattern "^(19|20)[0-9]{2}$", maxlength 4, placeholder "Year", class "date-item", onInput (Msg.UpdateDate "year") ] []
                  ]
              , regProfile model model.userError.alias_
                  ( "website"
                  , "text"
                  , "website"
                  , "^[A-Za-z0-9_.@]{5,100}$"
                  , "Por favor insira um website válido"
                  )
              , div [ class "item-form" ]
                  [ textarea [ maxlength 500, placeholder "About me", onInput (Msg.UpdateProfileRegister "about_me") ] []
                  ]
              , button [ class "submit-button", onClick Msg.DispatchUserRegistration ] [ text "Submit" ]
              ]
          ]
    True ->
      div []
          [ simpleHero "Register" "" "simple-hero__page-blue"
          , div [ class "main-container" ]
            [div [class "loggedin-text"] [ text "You are already logged in!" ]]
            -- style loggedin reused from _login.scss
          ]

view : Model -> Html Msg
view model =
    checkLogin model



radio : String -> Html Msg
radio option =
    Html.label [ class "radio-item" ]
        [ input [ type_ "radio", name "action", onClick (Msg.UpdateUserRegister "gender" option) ] []
        , text option
        ]

-- Custom onChange event for select fields usage
onChange : (String -> msg) -> Attribute msg
onChange handler =
    Html.Events.on "change" <| Json.map handler <| Json.at [ "target", "value" ] Json.string

monthPicker : Html Msg
monthPicker =
    select [ Html.Attributes.name "Month", class "date-month", onChange (Msg.UpdateDate "month") ]
        [ option [ value "", disabled True, selected True, class "disabled-item" ] [ text "Month" ]
        , option [ value "01" ] [ text "January" ]
        , option [ value "02" ] [ text "February" ]
        , option [ value "03" ] [ text "March" ]
        , option [ value "04" ] [ text "April" ]
        , option [ value "05" ] [ text "May" ]
        , option [ value "06" ] [ text "June" ]
        , option [ value "07" ] [ text "July" ]
        , option [ value "08" ] [ text "August" ]
        , option [ value "09" ] [ text "September" ]
        , option [ value "10" ] [ text "October" ]
        , option [ value "11" ] [ text "November" ]
        , option [ value "12" ] [ text "December" ]
        ]
