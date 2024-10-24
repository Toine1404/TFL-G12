module Sprites.LankyHuman exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)



-- The new medieval character SVG


medievalKnight : { height : Float, width : Float, x : Float, y : Float } -> Svg svg
medievalKnight data =
    g [ transformStandard data ]
        [ -- Body
          path
            [ d "M 0.5 0 L 0.3 0.5 L 0.7 0.5 Z" -- A triangle for the body
            , fill "blue"
            ]
            []
        , -- Shield
          path
            [ d "M 0.4 0.4 A 0.1 0.2 0 1 0 0.6 0.4 L 0.5 0.7 Z" -- Semi-circle shield
            , fill "red"
            ]
            []
        , -- Sword
          rect
            [ x "0.55", y "0.1", width "0.05", height "0.3", fill "silver" ]
            []

        -- A simple sword
        , -- Head
          circle [ cx "0.5", cy "0", r "0.1", fill "peachpuff" ] [] -- Head color
        ]


transformStandard : { height : Float, width : Float, x : Float, y : Float } -> Svg.Attribute msg
transformStandard data =
    [ data.width, 0, 0, data.height, data.x, data.y ]
        |> List.map String.fromFloat
        |> String.join " "
        |> (\coords -> "matrix(" ++ coords ++ ")")
        |> transform
