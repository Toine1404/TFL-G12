module Sprites.PigPen exposing (..)

import Browser
import Browser.Events
import Color exposing (Color)
import Random
import Sprites.AnimalPen as AnimalPen
import Sprites.Fence as Fence
import Sprites.Pig as Pig
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time


main =
    Browser.element
        { init =
            \() ->
                ( init
                    { pigs =
                        [ 1.25, 1.0, 0.75 ]
                            |> List.map
                                (\size ->
                                    { colorEyeballs = Pig.defaultEyeballColor
                                    , colorEyes = Pig.defaultEyesColor
                                    , colorNose = Pig.defaultNoseColor
                                    , colorNoseHole = Pig.defaultNoseHoleColor
                                    , colorSkin = Pig.defaultSkinColor
                                    , height = 0.75 * size
                                    , width = size
                                    }
                                )
                    , polesX = 5
                    , polesY = 5
                    }
                , Cmd.none
                )
        , subscriptions = subscriptions
        , update = update
        , view =
            \model ->
                Svg.svg
                    [ viewBox "0 0 1000 1000"
                    , width "1000"
                    , height "1000"
                    ]
                    [ view
                        { colorFence = Fence.defaultFenceColor
                        , height = 1000
                        , model = model
                        , width = 1000
                        , x = 0
                        , y = 0
                        }
                    ]
        }



-- MODEL


type alias Model =
    { now : Time.Posix, pigs : List Pig, polesX : Int, polesY : Int }


type Msg
    = OnAnimationFrame Time.Posix
    | OnTriggerPigs
    | ReplacePig Int (Maybe Pig)


type alias Pig =
    PigInput Walk


type alias PigInput a =
    { a
        | colorEyeballs : Color
        , colorEyes : Color
        , colorNose : Color
        , colorNoseHole : Color
        , colorSkin : Color
        , height : Float
        , width : Float
    }


type alias Walk =
    { startX : Float
    , startY : Float
    , stopX : Float
    , stopY : Float
    , t0 : Time.Posix
    , walkingSpeed : Float
    }


init : { pigs : List (PigInput {}), polesX : Int, polesY : Int } -> Model
init data =
    { now = Time.millisToPosix 0
    , pigs =
        List.indexedMap
            (\i newPig ->
                { colorEyeballs = newPig.colorEyeballs
                , colorEyes = newPig.colorEyes
                , colorNose = newPig.colorNose
                , colorNoseHole = newPig.colorNoseHole
                , colorSkin = newPig.colorSkin
                , height = newPig.height
                , startX =
                    i
                        |> modBy data.polesX
                        |> toFloat
                        |> (\n -> n / toFloat data.polesX)
                        |> Basics.min 1
                , startY =
                    i
                        |> modBy data.polesY
                        |> toFloat
                        |> (\n -> n / toFloat data.polesY)
                , stopX =
                    i
                        |> modBy data.polesX
                        |> toFloat
                        |> (\n -> n / toFloat data.polesX)
                        |> Basics.min 1
                , stopY =
                    i
                        |> modBy data.polesY
                        |> toFloat
                        |> (\n -> n / toFloat data.polesY)
                , t0 = Time.millisToPosix 0
                , walkingSpeed = toFloat (Basics.max data.polesX data.polesY) / 50
                , width = newPig.width
                }
            )
            data.pigs
    , polesX = data.polesX
    , polesY = data.polesY
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnAnimationFrame posix ->
            ( { model | now = posix }, Cmd.none )

        OnTriggerPigs ->
            ( model
            , model.pigs
                |> List.indexedMap Tuple.pair
                |> List.filterMap
                    (\( i, pig ) ->
                        if pigFinishedWalking model.now pig then
                            Just (Random.generate (ReplacePig i) (maybeNewDirection 5 pig))

                        else
                            Nothing
                    )
                |> Cmd.batch
            )

        ReplacePig i (Just newPig) ->
            ( { model
                | pigs =
                    model.pigs
                        |> List.indexedMap
                            (\j pig ->
                                if i == j then
                                    { newPig | t0 = model.now }

                                else
                                    pig
                            )
              }
            , Cmd.none
            )

        ReplacePig _ Nothing ->
            ( model, Cmd.none )


pigFinishedWalking : Time.Posix -> Pig -> Bool
pigFinishedWalking now pig =
    let
        currentPos =
            pigPos now pig
    in
    currentPos.x == pig.stopX && currentPos.y == pig.stopY


pigPos : Time.Posix -> Pig -> { x : Float, y : Float }
pigPos now pig =
    let
        distance =
            Basics.max (abs (pig.stopX - pig.startX)) (abs (pig.stopY - pig.startY))

        timeElapsed =
            toFloat (Time.posixToMillis now - Time.posixToMillis pig.t0) / 1000

        progress =
            timeElapsed
                * pig.walkingSpeed
                / distance
                |> Basics.min 1
                |> Basics.max 0
    in
    { x = pig.stopX * progress + pig.startX * (1 - progress)
    , y = pig.stopY * progress + pig.startY * (1 - progress)
    }


maybeNewDirection : Int -> Pig -> Random.Generator (Maybe Pig)
maybeNewDirection n pig =
    Random.uniform True (List.repeat n False)
        |> Random.andThen
            (\startWalking ->
                if startWalking then
                    Random.map Just (newDirection pig)

                else
                    Random.constant Nothing
            )


newDirection : Pig -> Random.Generator Pig
newDirection pig =
    Random.map2
        (\newX newY ->
            { pig
                | startX = pig.stopX
                , startY = pig.stopY
                , stopX = newX
                , stopY = newY
            }
        )
        (Random.float 0 1)
        (Random.float 0 1)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrame OnAnimationFrame
        , Time.every 1000 (always OnTriggerPigs)
        ]



-- VIEW


view :
    { colorFence : Color
    , height : Float
    , model : Model
    , width : Float
    , x : Float
    , y : Float
    }
    -> Svg svg
view data =
    AnimalPen.pen
        { animals =
            data.model.pigs
                |> List.map
                    (\pig ->
                        case pigPos data.model.now pig of
                            pos ->
                                { height = pig.height
                                , toSvg =
                                    \coords ->
                                        Pig.pig
                                            { colorEyeball = pig.colorEyeballs
                                            , colorEyes = pig.colorEyes
                                            , colorNose = pig.colorNose
                                            , colorNoseHole = pig.colorNoseHole
                                            , colorSkin = pig.colorSkin
                                            , height = coords.height
                                            , leftEyeOffsetX =
                                                eyeOffset
                                                    { start = pig.startX
                                                    , current = pos.x
                                                    , end = pig.stopX
                                                    }
                                            , leftEyeOffsetY =
                                                eyeOffset
                                                    { start = pig.startY
                                                    , current = pos.y
                                                    , end = pig.stopY
                                                    }
                                            , rightEyeOffsetX =
                                                eyeOffset
                                                    { start = pig.startX
                                                    , current = pos.x
                                                    , end = pig.stopX
                                                    }
                                            , rightEyeOffsetY =
                                                eyeOffset
                                                    { start = pig.startY
                                                    , current = pos.y
                                                    , end = pig.stopY
                                                    }
                                            , width = coords.width
                                            , x = coords.x
                                            , y = coords.y
                                            }
                                , width = pig.width
                                , x = pos.x
                                , y = pos.y
                                }
                    )
        , colorFence = data.colorFence
        , height = data.height
        , polesX = data.model.polesX
        , polesY = data.model.polesY
        , width = data.width
        , x = data.x
        , y = data.y
        }


eyeOffset : { start : Float, current : Float, end : Float } -> Float
eyeOffset { start, current, end } =
    if current == end then
        0

    else
        end - start
