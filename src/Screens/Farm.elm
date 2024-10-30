module Screens.Farm exposing (..)

import Element exposing (Element)
import Layout
import Sprites.Farm as Farm



-- MODEL


type alias Model =
    Farm.Model


type alias Msg =
    Farm.Msg


init : Model
init =
    Farm.init Farm.defaultInitInput



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Farm.update



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Farm.subscriptions model



-- VIEW


paddingSize : Int
paddingSize =
    30


view :
    { height : Int
    , model : Model
    , toMsg : Msg -> msg
    , width : Int
    }
    -> Element msg
view data =
    Layout.svg
        { aspectRatio = 1 / 2
        , height = data.height - 2 * paddingSize
        , svg =
            Farm.view
                { height = 1
                , model = data.model
                , width = 2
                , x = 0
                , y = 0
                }
        , viewMinX = 0
        , viewMaxX = 2
        , viewMinY = 0
        , viewMaxY = 1
        , width = data.width - 2 * paddingSize
        }
        |> Element.el [ Element.padding paddingSize ]
