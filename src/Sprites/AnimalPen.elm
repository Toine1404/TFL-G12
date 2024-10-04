module Sprites.AnimalPen exposing (..)

{-|


# Animal pen

This allows you to place animals in a pen.

-}

import Color exposing (Color)
import Sprites.Fence as Fence
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Animal msg =
    { height : Float
    , toSvg : { height : Float, width : Float, x : Float, y : Float } -> Svg msg
    , width : Float
    , x : Float
    , y : Float
    }


pen :
    { animals : List (Animal svg)
    , colorFence : Color
    , height : Float
    , polesX : Int
    , polesY : Int
    , width : Float
    , x : Float
    , y : Float
    }
    -> Svg svg
pen data =
    g
        [ transformStandard
            { data
                | height = data.height / (toFloat data.polesY + 1)
                , width = data.width / toFloat data.polesX
            }
        ]
        [ Fence.fenceFace
            { colorBar = data.colorFence
            , colorPole = data.colorFence
            , height = 1
            , poles = data.polesX
            , width = toFloat data.polesX
            , x = 0
            , y = 0
            }
        , Fence.fenceSide
            { color = data.colorFence
            , height = toFloat data.polesY
            , width = 0.05
            , x = 0
            , y = 0.5
            }
        , Fence.fenceSide
            { color = data.colorFence
            , height = toFloat data.polesY
            , width = 0.05
            , x = toFloat data.polesX - 0.05
            , y = 0.5
            }
        , data.animals
            |> List.sortBy .y
            |> List.map
                (\animal ->
                    animal.toSvg
                        { height = animal.height
                        , width = animal.width
                        , x = animal.x * (toFloat data.polesX - animal.width)
                        , y = animal.y * toFloat data.polesY + (1 - animal.height)
                        }
                )
            |> g []
        , Fence.fenceFace
            { colorBar = data.colorFence
            , colorPole = data.colorFence
            , height = 1
            , poles = data.polesX
            , width = toFloat data.polesX
            , x = 0
            , y = toFloat data.polesY
            }
        ]


transformStandard : { a | height : Float, width : Float, x : Float, y : Float } -> Svg.Attribute msg
transformStandard data =
    [ data.width, 0, 0, data.height, data.x, data.y ]
        |> List.map String.fromFloat
        |> String.join " "
        |> (\coords -> "matrix(" ++ coords ++ ")")
        |> transform
