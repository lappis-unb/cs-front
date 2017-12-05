module Codeschool.Msg exposing (..)

{-| Main page messages and update function
-}

import Markdown exposing (..)
import Html exposing (..)
import Codeschool.Model exposing (Model, Route)
import Codeschool.Routing exposing (parseLocation, reverse)
import Data.Date exposing (..)
import Data.User exposing (..)
import Data.Registration exposing (..)
import Data.Login exposing (..)
import Data.ProgrammingLanguage exposing (..)
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
    -- Dispatchs
    | DispatchUserRegistration
    | DispatchLogin
    | GetLanguagesSuported
    -- Responses
    | GetRegistrationResponse (Result Http.Error ExpectRegisterResponse)
    | GetProfileResponse (Result Http.Error ProfileForm)
    | GetLoginResponse (Result Http.Error Auth)
    | GetLanguagesSuportedResponse (Result Http.Error ProgrammingLanguage)
    | LoginAfterRegistration
    | ContinueRegistration
    -- Form handling
    -- | FormMsg FormMsg2
    | UpdateUserRegister String String
    | UpdateProfileRegister String String
    | UpdateDate String String
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

-- Dispatchs
        DispatchUserRegistration ->
          let
            data = sendRegistrationData model.userRegister
          in
            (model, data)

        DispatchLogin ->
          let
            data = sendLoginData model.userLogin
          in
            (model, data)
        GetLanguagesSuported ->
          let
            data = getLanguagesData model
          in
            (model, data)

-- OK Responses
        GetLanguagesSuportedResponse (Ok data) ->
          Debug.log("Pegou languages")
          Debug.log(toString model)
          (model, Cmd.none)

        GetLoginResponse (Ok data) ->
          Debug.log("Logado com sucesso")
            { model | auth = {user = data.user, token = data.token}, isLogged = True} ! []
            |> andThen (ChangeRoute Codeschool.Model.Index)

        -- Handle successful userRegister registration
        GetRegistrationResponse (Ok register) ->
          let
            login = { email = model.userRegister.email, password = model.userRegister.password }
          in
            Debug.log "OK OK Registration"
            Debug.log(toString register)
            ({model | expectRegister = register, userLogin = login}, Cmd.none)
            |> andThen LoginAfterRegistration

        GetProfileResponse (Ok data) ->
          Debug.log "OK OK Profile"
          Debug.log(toString model.expectRegister.profile.user)
          (model, Cmd.none)

        LoginAfterRegistration ->
          let
            data = sendLoginData model.userLogin
          in
            Debug.log("Logando após cadastro")
            Debug.log(toString data)
            (model, data)
            |> andThen ContinueRegistration

        ContinueRegistration ->
          let
              test= (sendProfileData model)
          in
            Debug.log("Continuando Registro")
            (model, test)

-- Errors Responses
        GetLanguagesSuportedResponse (Result.Err _) ->
          Debug.log("Erro Ao pegar languages")
          (model, Cmd.none)

        GetLoginResponse (Result.Err _) ->
          Debug.log("Erro Geral GetLogin")
          (model, Cmd.none)

        -- Handle API error validations by parsing
        -- the json response and updating the UserError model
        GetRegistrationResponse (Err (BadStatus response)) ->
         let
             newErrors = userErrorUpdate model.userError response.body
         in
            Debug.log "Bad Status!"
            ({model | userError = newErrors}, Cmd.none)

        GetRegistrationResponse (Err (BadPayload string (response))) ->
          Debug.log ("Response:" ++ toString response)
          Debug.log ("Tem mais:" ++ toString string)
          (model, Cmd.none)

        -- Handle others API errors, Ex: connection timeout
        GetRegistrationResponse (Err _) ->
          Debug.log "Erro Geral GetRegistration"
          (model, Cmd.none)

        GetProfileResponse (Err _) ->
          Debug.log("Erro Geral GetProfile")
          (model, Cmd.none)


-- Form handling
        UpdateUserRegister inputModel inputValue ->
            let
                newUser = formReceiver model.userRegister inputModel inputValue
            in
                ({model | userRegister = newUser}, Cmd.none)

        UpdateProfileRegister inputModel inputValue ->
            let
              newProfile = profileReceiver model.profileRegister inputModel inputValue
            in
              ({model | profileRegister = newProfile}, Cmd.none)

        UpdateLogin inputModel inputValue ->
            let
                newLogin = loginReceiver model.userLogin inputModel inputValue
            in
                ({model | userLogin = newLogin}, Cmd.none)

        UpdateDate field value ->
            let
              newDate = dateReceiver model.date field value
              newProfile = dateUserUpdate model.profileRegister newDate
              newModel = {model | date = newDate, profileRegister = newProfile}
            in
               newModel ! []

        LogOut ->
            {model | auth = emptyAuth, isLogged = False } ! []
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

toHtmlString markdownTxt =
    Markdown.toHtml [] markdownTxt


dateUserUpdate : ProfileForm -> Date -> ProfileForm
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

formReceiver : UserForm -> String -> String -> UserForm
formReceiver userRegister inputModel inputValue =
  case inputModel of
    "name" ->
        {userRegister | name = inputValue}

    "alias_" ->
        {userRegister | alias_ = inputValue}

    "email" ->
        {userRegister | email = inputValue}

    "password" ->
        {userRegister | password = inputValue}

    "password_confirmation" ->
        {userRegister | password_confirmation = inputValue}

    "school_id" ->
        {userRegister | school_id = inputValue}

    _ ->
        userRegister

profileReceiver : ProfileForm -> String -> String -> ProfileForm
profileReceiver profileRegister inputModel inputValue =
  case inputModel of
    "gender" ->
      {profileRegister | gender = inputValue}
    "phone" ->
      {profileRegister | phone = inputValue}
    "date_of_birth" ->
      {profileRegister | date_of_birth = inputValue}
    "website" ->
      {profileRegister | website = inputValue}
    "about_me" ->
      {profileRegister | about_me = inputValue}
    _ ->
      profileRegister



sendLoginData : UserLogin -> Cmd Msg
sendLoginData userRegister =
    let
        userLoginRequest =
            Http.request
                { body = Data.Login.toJsonLogin userRegister |> Http.jsonBody
                , expect = Http.expectJson authDecoder
                , headers = []
                , method = "POST"
                , timeout = Nothing
                , url = "http://localhost:8000/api-token-auth/"
                , withCredentials = False
                }
    in
        userLoginRequest |> Http.send GetLoginResponse


sendRegistrationData : UserForm -> Cmd Msg
sendRegistrationData userRegister =
    let
        userRegRequest =
            Http.request
                { body = Data.Registration.toJson userRegister |> Http.jsonBody
                , expect = Http.expectJson expectRegisterDecoder
                , headers = []
                , method = "POST"
                , timeout = Nothing
                , url = "http://localhost:8000/api/users/"
                , withCredentials = False
                }
    in
        userRegRequest |> Http.send GetRegistrationResponse

sendProfileData : Model -> Cmd Msg
sendProfileData model =
    let
        profileUpdateRequest =
            Http.request
                { body = Data.Registration.toJsonSendProfile model.profileRegister |> Http.jsonBody
                , expect = Http.expectJson profileDecoder
                , headers = [Http.header "Token" ("JWT " ++ model.auth.token)]
                , method = "PUT"
                , timeout = Nothing
                , url = "http://localhost:8000/api/profile/" ++ (toString model.expectRegister.profile.user)
                , withCredentials = False
                }
    in
        Debug.log("aqui????????" ++ "Token:" ++ model.auth.token )
        profileUpdateRequest |> Http.send GetProfileResponse

getLanguagesData : Model -> Cmd Msg
getLanguagesData model =
    let
        getLanguagesRequest =
            Http.request
                { body = Http.emptyBody
                , expect = Http.expectJson programmingLanguageDecoder
                , headers = [Http.header "Token" ("JWT " ++ model.auth.token)]
                , method = "GET"
                , timeout = Nothing
                , url = "http://localhost:8000/api/programming-languages/"
                , withCredentials = False
                }
    in
        Debug.log("aqui????????" ++ model.suportedLanguanges.name )
        getLanguagesRequest |> Http.send GetLanguagesSuportedResponse

andThen : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andThen msg ( model, cmd ) =
    let
        ( newmodel, newcmd ) =
            update msg model
    in
        newmodel ! [ cmd, newcmd ]
