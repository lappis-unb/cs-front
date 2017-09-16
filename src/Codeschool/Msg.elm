module Codeschool.Msg exposing (..)

{-| Main page messages and update function
-}

import Codeschool.Model exposing (Model, Route)
import Codeschool.Routing exposing (parseLocation, reverse)
import Data.Date exposing (..)
import Data.User exposing (..)
import Http exposing (..)
import Json.Decode exposing (string)
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
    | UpdateProfile String String
    | RequestReceiver (Result Http.Error ExpectRegister)
    | SendProfileData (Result Http.Error SendProfile)
    | ContinueRequestReceiver
    | GetLoginResponse (Result Http.Error Auth)
    | UpdateDate String String
    | DispatchLogin
    | UpdateLogin String String
    | LogOut

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

        UpdateRegister inputModel inputValue ->
            let
                newUser = formReceiver model.user inputModel inputValue
            in
                ({model | user = newUser}, Cmd.none)

        UpdateProfile inputModel inputValue ->
            let
              newProfile = profileReceiver model.sendProfile inputModel inputValue
            in
              ({model | sendProfile = newProfile}, Cmd.none)

        UpdateLogin inputModel inputValue ->
            let
                newLogin = loginReceiver model.userLogin inputModel inputValue
            in
                ({model | userLogin = newLogin}, Cmd.none)

        DispatchUserRegistration ->
          let
              data = sendRegData model.user

          in
        --    Debug.log (toString data)
            (model, data)

        DispatchLogin ->
          let
            data = sendLoginData model.userLogin
          in
            Debug.log(toString data)
            (model, data)


        UpdateDate field value ->
            let
              newDate = dateReceiver model.date field value
              newProfile = dateUserUpdate model.sendProfile newDate
              newModel = {model | date = newDate, sendProfile = newProfile}
            in
               newModel ! []


        -- Handle successful user registration
        RequestReceiver (Ok register) ->
          let
            login = { email = model.user.email, password = model.user.password }
          in
            Debug.log "OK OK"
            Debug.log(toString register)
            ({model | expectRegister = register, userLogin = login}, Cmd.none)
            |> andThen ContinueRequestReceiver

        ContinueRequestReceiver ->
          let
              test= (sendProfileData model)
          in
            (model, test)


        -- Handle API error validations by parsing
        -- the json response and updating the UserError model
        RequestReceiver (Err (BadStatus response)) ->
         let
             newErrors = userErrorUpdate model.userError response.body
         in
            Debug.log "#DeuRuim validacao"
            ({model | userError = newErrors}, Cmd.none)



        RequestReceiver (Err (BadPayload string (response))) ->
          Debug.log ("Toma aí ó:" ++ toString response)
          Debug.log ("Tem mais:" ++ toString string)
          (model, Cmd.none)

        -- Handle others API errors, Ex: connection timeout
        RequestReceiver (Err _) ->
          Debug.log "#DeuRuim de vez"
          (model, Cmd.none)

        SendProfileData (Ok data) ->
          Debug.log(toString model.expectRegister.profile.user)
          (model, Cmd.none)

        SendProfileData (Err _) ->
          Debug.log("meeeeeeeee")
          (model, Cmd.none)

        GetLoginResponse (Ok data) ->
          let
            newLoggedUser = data.user
            newToken = data.token
          in
          Debug.log("Deu bom")
            { model | loggedUser = newLoggedUser, token = newToken, isLogged = True} ! []
            |> andThen (ChangeRoute Codeschool.Model.Index)

        GetLoginResponse (Result.Err _) ->
          Debug.log("Deu ruim")
          (model, Cmd.none)

        LogOut ->
          let
            noneUser = {alias_ = "", email = ""}
          in
            {model | loggedUser = noneUser, isLogged = False } ! []
            |> andThen (ChangeRoute Codeschool.Model.Index)



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


dateUserUpdate : SendProfile -> Date -> SendProfile
dateUserUpdate profile date =
  {profile | date_of_birth = date.year ++ "-" ++ date.month ++ "-" ++ date.day}


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


loginReceiver : UserLogin -> String -> String -> UserLogin
loginReceiver userLogin inputModel inputValue =
  case inputModel of
    "email" ->
        { userLogin | email = inputValue }

    "password" ->
        { userLogin | password = inputValue}

    _ ->
       userLogin

formReceiver : User -> String -> String -> User
formReceiver user inputModel inputValue =
  case inputModel of
    "name" ->
        {user | name = inputValue}

    "alias_" ->
        {user | alias_ = inputValue}

    "email" ->
        {user | email = inputValue}

    "password" ->
        {user | password = inputValue}

    "password_confirmation" ->
        {user | password_confirmation = inputValue}

    "school_id" ->
        {user | school_id = inputValue}

    _ ->
        user

profileReceiver : SendProfile -> String -> String -> SendProfile
profileReceiver sendProfile inputModel inputValue =
  case inputModel of
    "gender" ->
      {sendProfile | gender = inputValue}
    "phone" ->
      {sendProfile | phone = inputValue}
    "date_of_birth" ->
      {sendProfile | date_of_birth = inputValue}
    "website" ->
      {sendProfile | website = inputValue}
    "about_me" ->
      {sendProfile | about_me = inputValue}
    _ ->
      sendProfile



sendLoginData : UserLogin -> Cmd Msg
sendLoginData user =
    let
        userLoginRequest =
            Http.request
                { body = Data.User.toJsonLogin user |> Http.jsonBody
                , expect = Http.expectJson authDecoder
                , headers = []
                , method = "POST"
                , timeout = Nothing
                , url = "http://localhost:8000/api-token-auth/"
                , withCredentials = False
                }
    in
        userLoginRequest |> Http.send GetLoginResponse


sendRegData : User -> Cmd Msg
sendRegData user =
    let
        userRegRequest =
            Http.request
                { body = Data.User.toJson user |> Http.jsonBody
                , expect = Http.expectJson registerDecoder
                , headers = []
                , method = "POST"
                , timeout = Nothing
                , url = "http://localhost:8000/api/users/"
                , withCredentials = False
                }
    in
        userRegRequest |> Http.send RequestReceiver

sendProfileData : Model -> Cmd Msg
sendProfileData model =
    let
        profileUpdateRequest =
            Http.request
                { body = Data.User.toJsonSendProfile model.sendProfile |> Http.jsonBody
                , expect = Http.expectJson profileDecoder
                , headers = [Http.header "token" model.token]
                , method = "PUT"
                , timeout = Nothing
                , url = "http://localhost:8000/api/profile/" ++ (toString model.expectRegister.profile.user)
                , withCredentials = False
                }
    in
        profileUpdateRequest |> Http.send SendProfileData


andThen : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andThen msg ( model, cmd ) =
    let
        ( newmodel, newcmd ) =
            update msg model
    in
        newmodel ! [ cmd, newcmd ]
