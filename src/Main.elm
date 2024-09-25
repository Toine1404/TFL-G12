module Main exposing (main)
{-| # Main module

This module is the main module that gets compiled to the single HTML file.

It contains a complete web application.

@docs main
-}

import Browser

main : Program () Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

type alias Model = ()

type alias Msg = ()

init : () -> ( Model, Cmd Msg )
init () =
    ( (), Cmd.none )

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

-- VIEW

view : Model -> Browser.Document Msg
view _ =
    { title = "TFL - G12"
    , body = []
    }
