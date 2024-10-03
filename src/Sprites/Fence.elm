module Sprites.Fence exposing (..)

import Color exposing (Color)
import Svg exposing (..)
import Svg.Attributes exposing (..)


defaultFenceColor : Color
defaultFenceColor =
    Color.rgb255 120 93 39


main : Svg svg
main =
    Svg.svg
        [ viewBox "0 0 1000 1000"
        , width "1000"
        , height "1000"
        ]
        [ fenceFace
            { colorBar = defaultFenceColor
            , colorPole = defaultFenceColor
            , height = 250
            , poles = 4
            , width = 1000
            , x = 0
            , y = 0
            }
        , fenceSide
            { color = defaultFenceColor
            , height = 970
            , width = 25
            , x = 0
            , y = 30
            }
        , fenceSide
            { color = defaultFenceColor
            , height = 970
            , width = 25
            , x = 975
            , y = 30
            }
        , fenceFace
            { colorBar = defaultFenceColor
            , colorPole = defaultFenceColor
            , height = 250
            , poles = 4
            , width = 1000
            , x = 0
            , y = 750
            }
        ]


fenceFace : { colorBar : Color, colorPole : Color, height : Float, poles : Int, width : Float, x : Float, y : Float } -> Svg svg
fenceFace data =
    let
        size =
            Basics.max 1 data.poles
    in
    List.range 1 size
        |> List.map
            (\i ->
                fenceFaceTile
                    { colorBar = data.colorBar
                    , colorPole = data.colorPole
                    , height = 1
                    , width = 1
                    , x = toFloat i - 1
                    , y = 0
                    }
            )
        |> g
            [ transformStandard { data | width = data.width / toFloat size }
            , fill (Color.toCssString data.colorPole)
            ]


fenceFaceTile : { colorBar : Color, colorPole : Color, height : Float, width : Float, x : Float, y : Float } -> Svg svg
fenceFaceTile data =
    g
        [ transformStandard data
        , fill (Color.toCssString data.colorBar)
        , stroke (Color.toCssString data.colorBar)
        , strokeWidth "0.005"
        ]
        [ polygon [ points "0,0 0,1 0.1,1 0.1,0.1", fill (Color.toCssString data.colorPole) ] []
        , polygon [ points "1,0 1,1 0.9,1 0.9,0.1", fill (Color.toCssString data.colorPole) ] []
        , rect [ x "0.1", y "0.3", width "0.8", height "0.15" ] []
        , rect [ x "0.1", y "0.65", width "0.8", height "0.15" ] []
        ]


fenceSide : { color : Color, height : Float, width : Float, x : Float, y : Float } -> Svg svg
fenceSide data =
    rect
        [ fill (Color.toCssString data.color)
        , height (String.fromFloat data.height)
        , width (String.fromFloat data.width)
        , x (String.fromFloat data.x)
        , y (String.fromFloat data.y)
        ]
        []


transformStandard : { a | height : Float, width : Float, x : Float, y : Float } -> Svg.Attribute msg
transformStandard data =
    [ data.width, 0, 0, data.height, data.x, data.y ]
        |> List.map String.fromFloat
        |> String.join " "
        |> (\coords -> "matrix(" ++ coords ++ ")")
        |> transform
