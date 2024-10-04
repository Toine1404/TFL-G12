module Sprites.Farm exposing (..)

import Browser
import Color exposing (Color)
import Sprites.Fence as Fence
import Sprites.House as House
import Sprites.Pig as Pig
import Sprites.PigPen as PigPen
import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
    Browser.element
        { init =
            \() ->
                ( init defaultInitInput, Cmd.none )
        , subscriptions = subscriptions
        , update = update
        , view =
            \model ->
                Svg.svg
                    [ viewBox "0 0 1000 500"
                    , width "1000"
                    , height "500"
                    ]
                    [ view
                        { height = 500
                        , model = model
                        , width = 1000
                        , x = 0
                        , y = 0
                        }
                    ]
        }



-- MODEL


type alias Model =
    { colorFence : Color
    , colorHouse : Color
    , colorDoor : Color
    , colorDoorKnob : Color
    , colorRoof : Color
    , pen : PigPen.Model
    }


type alias Msg =
    PigPen.Msg


type alias InitInput =
    { colorFence : Color
    , colorHouse : Color
    , colorDoor : Color
    , colorDoorKnob : Color
    , colorRoof : Color
    , pigs : List (PigPen.PigInput {})
    , polesX : Int
    , polesY : Int
    }


init : InitInput -> Model
init data =
    { colorDoor = data.colorDoor
    , colorDoorKnob = data.colorDoorKnob
    , colorFence = data.colorFence
    , colorHouse = data.colorHouse
    , colorRoof = data.colorRoof
    , pen =
        PigPen.init
            { pigs = data.pigs
            , polesX = data.polesX
            , polesY = data.polesY
            }
    }


defaultInitInput : InitInput
defaultInitInput =
    { colorDoor = Color.rgb255 93 73 40
    , colorDoorKnob = House.defaultKnobColor
    , colorFence = Fence.defaultFenceColor
    , colorHouse = Color.rgb255 168 114 60
    , colorRoof = Color.rgb255 112 92 72
    , pigs =
        [ { colorEyeballs = Pig.defaultEyeballColor
          , colorEyes = Pig.defaultEyesColor
          , colorNose = Color.rgb255 202 127 143
          , colorNoseHole = Pig.defaultNoseHoleColor
          , colorSkin = Color.rgb255 214 163 174
          , height = 0.75 * 1.4
          , width = 1.4
          }
        , { colorEyeballs = Pig.defaultEyeballColor
          , colorEyes = Pig.defaultEyesColor
          , colorNose = Color.rgb255 155 73 18
          , colorNoseHole = Pig.defaultNoseHoleColor
          , colorSkin = Color.rgb255 118 50 4
          , height = 0.75 * 1.5
          , width = 1.5
          }
        , { colorEyeballs = Pig.defaultEyeballColor
          , colorEyes = Pig.defaultEyesColor
          , colorNose = Color.rgb255 165 131 108
          , colorNoseHole = Pig.defaultNoseHoleColor
          , colorSkin = Color.rgb255 126 104 90
          , height = 0.75 * 1.6
          , width = 1.6
          }
        ]
    , polesX = 6
    , polesY = 4
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case PigPen.update msg model.pen of
        ( newPen, cmd ) ->
            ( { model | pen = newPen }, cmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    PigPen.subscriptions model.pen



-- VIEW


view :
    { height : Float
    , model : Model
    , width : Float
    , x : Float
    , y : Float
    }
    -> Svg svg
view data =
    g
        [ transformStandard data ]
        [ PigPen.view
            { colorFence = data.model.colorFence
            , height = 1
            , model = data.model.pen
            , width = 0.75
            , x = 0.25
            , y = 0
            }
        , House.house
            { colorDoor = data.model.colorDoor
            , colorDoorKnob = data.model.colorDoorKnob
            , colorRoof = data.model.colorRoof
            , colorWall = data.model.colorHouse
            , colorWindow = data.model.colorHouse
            , height = 1
            , width = 0.4
            , x = 0
            , y = 0
            }
        ]


transformStandard : { a | height : Float, width : Float, x : Float, y : Float } -> Svg.Attribute msg
transformStandard data =
    [ data.width, 0, 0, data.height, data.x, data.y ]
        |> List.map String.fromFloat
        |> String.join " "
        |> (\coords -> "matrix(" ++ coords ++ ")")
        |> transform
