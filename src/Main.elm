module Main exposing (main)

{-|


# Main module

This module is the main module that gets compiled to the single HTML file.

It contains a complete web application.

@docs main

-}

import Browser
import Browser.Dom
import Browser.Events
import Element
import Element.Background
import Screens.Farm as Farm
import Screens.Welcome as Welcome
import Task
import Theme


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { flavor : Theme.Flavor
    , height : Int
    , screen : Screen
    , width : Int
    }


type Msg
    = OnPigScreen Farm.Msg
    | ScreenSize { height : Int, width : Int }
    | StartGame


type Screen
    = EmptyScreen
    | PigScreen Farm.Model
    | WelcomeScreen


init : () -> ( Model, Cmd Msg )
init () =
    ( { flavor = Theme.Latte
      , height = 480
      , screen = WelcomeScreen
      , width = 720
      }
    , Browser.Dom.getViewport
        |> Task.perform
            (\viewport ->
                ScreenSize
                    { height = floor viewport.viewport.height
                    , width = floor viewport.viewport.width
                    }
            )
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPigScreen m ->
            case model.screen of
                PigScreen mdl ->
                    case Farm.update m mdl of
                        ( newMdl, cmd ) ->
                            ( { model | screen = PigScreen newMdl }
                            , Cmd.map OnPigScreen cmd
                            )

                _ ->
                    ( model, Cmd.none )

        ScreenSize { height, width } ->
            ( { model | height = height, width = width }
            , Cmd.none
            )

        StartGame ->
            ( { model | screen = PigScreen Farm.init }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onResize (\w h -> ScreenSize { width = w, height = h })
        , case model.screen of
            PigScreen mdl ->
                Farm.subscriptions mdl |> Sub.map OnPigScreen

            _ ->
                Sub.none
        ]



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "TFL - G12"
    , body =
        (case model.screen of
            EmptyScreen ->
                Element.none

            WelcomeScreen ->
                Welcome.view
                    { backgroundColor = Theme.base model.flavor
                    , boxColor = Theme.mantle model.flavor
                    , buttonColor = Theme.mauve model.flavor
                    , height = model.height
                    , onStart = StartGame
                    , width = model.width
                    }

            PigScreen mdl ->
                Farm.view
                    { height = model.height
                    , model = mdl
                    , toMsg = OnPigScreen
                    , width = model.width
                    }
        )
            |> Element.layout
                [ Element.Background.color (Theme.baseUI model.flavor)
                ]
            |> List.singleton
    }
