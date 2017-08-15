module Codeschool.Msg exposing (..)

{-| Main page messages and update function
-}

import Codeschool.Model exposing (Model, Route)
import Codeschool.Routing exposing (parseLocation, reverse)
import Data.Date exposing (..)
import Data.User exposing (User, UserError, toJson, userDecoder, userErrorDecoder)
import Http exposing (..)
import Json.Decode exposing (string)
import Json.Decode.Pipeline exposing (decode, required)
import Navigation exposing (Location, back, newUrl)

{-| Message type
-}
type Msg
    = ChangeLocation Location
    | ChangeRoute Route
    | RequireAsset String
    | AssetLoaded String
    | GoBack Int
    | DispatchUserRegistration
    | UpdateRegister String String
    | RequestReceiver (Result Http.Error User)
    | UpdateDate String String
    | UpdateUserDate

{-| Update function
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeRoute route ->
            model ! [ newUrl (reverse route) ]

        ChangeLocation loc ->
            { model | route = parseLocation loc } ! []

        RequireAsset asset ->
            if List.any ((==) asset) model.loadedAssets then
                model ! []
                --- TODO: send a message requesting to load an asset
            else
                model ! []

        AssetLoaded asset ->
            { model | loadedAssets = withElement asset model.loadedAssets } ! []

        GoBack int->
         (model, back int)

        DispatchUserRegistration ->

          let
              data = sendRegData model.user

          in
        --    Debug.log (toString data)
            (model, data)

        UpdateRegister inputModel inputValue ->
            let
                newUser = formReceiver model.user inputModel inputValue
            in
                ({model | user = newUser}, Cmd.none)

        UpdateUserDate ->
            let
                newUser = dateUserUpdate model.user model.date
            in
                ({model | user = newUser}, Cmd.none)

        UpdateDate field value ->
            let
              newDate = dateReceiver model.date field value
              newModel = {model | date = newDate}
            in
              update UpdateUserDate newModel


        -- Handle successful user registration
        RequestReceiver (Ok user) ->
          Debug.log "OK OK"
          Debug.log(toString user)
          (model, Cmd.none)


        -- Handle API error validations by parsing
        -- the json response and updating the UserError model
        RequestReceiver (Err (BadStatus response)) ->
         let
             newErrors = userErrorUpdate model.userError response.body
         in
            Debug.log "#DeuRuim validacao"
            ({model | userError = newErrors}, Cmd.none)


        -- Handle others API errors, Ex: connection timeout
        RequestReceiver (Err _) ->
          Debug.log "#DeuRuim de vez"
          (model, Cmd.none)



userErrorUpdate : UserError -> String -> UserError
userErrorUpdate userError response =
    let
        decodedResponse =
            Json.Decode.decodeString userErrorDecoder response
    in
        case decodedResponse of
        Ok message ->
            message

        _ ->
            userError


{-| Return a new list that surely include the given element
-}
withElement : a -> List a -> List a
withElement el lst =
    if List.any ((==) el) lst then
        lst
    else
        el :: lst


dateUserUpdate : User -> Date -> User
dateUserUpdate user date =
  {user | birthday = date.month ++ "-" ++ date.day ++ "-" ++ date.year}


dateReceiver : Date -> String -> String -> Date
dateReceiver date field value =
    case field of
      "month" ->
          {date | month = value}
      "day" ->
          {date | day = value}
      "year" ->
          {date | year = value}
      _ ->
          date


formReceiver : User -> String -> String -> User
formReceiver user inputModel inputValue =
  case inputModel of
    "name" ->
        {user | name = inputValue}

    "alias_" ->
        {user | alias_ = inputValue}

    "email" ->
        {user | email = inputValue}

    "email_confirmation" ->
        {user | email_confirmation = inputValue}

    "password" ->
        {user | password = inputValue}

    "password_confirmation" ->
        {user | password_confirmation = inputValue}

    "school_id" ->
        {user | school_id = inputValue}

    "gender" ->
        {user | gender = inputValue}

    "about_me" ->
        {user | about_me = inputValue}

    _ ->
        user


sendRegData : User -> Cmd Msg
sendRegData user =
    let
        userRegRequest =
            Http.request
                { body = Data.User.toJson user |> Http.jsonBody
                , expect = Http.expectJson userDecoder
                , headers = []
                , method = "POST"
                , timeout = Nothing
                , url = "http://localhost:3000/users"
                , withCredentials = False
                }
    in
        userRegRequest |> Http.send RequestReceiver
