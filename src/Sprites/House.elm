module Sprites.House exposing (defaultDoorColor, defaultKnobColor, defaultRoofColor, defaultWallColor, defaultWindowColor, house, main)

import Color exposing (Color)
import Svg exposing (..)
import Svg.Attributes as SvgAttr


defaultDoorColor : Color
defaultDoorColor =
    Color.rgb255 116 91 61


defaultKnobColor : Color
defaultKnobColor =
    Color.rgb255 0 0 0


defaultRoofColor : Color
defaultRoofColor =
    Color.rgb255 154 122 96


defaultWallColor : Color
defaultWallColor =
    Color.rgb255 237 237 237


defaultWindowColor : Color
defaultWindowColor =
    Color.rgb255 101 101 101


{-| Determines the relative height of the house part.
The rest of the image is filled with the house's roof.
-}
houseHeight : Float
houseHeight =
    0.45


{-| Determine the relative height of the door.
-}
doorHeight : Float
doorHeight =
    0.8 * houseHeight


{-| Determine the relative height of the windows.
-}
windowHeight : Float
windowHeight =
    0.5 * houseHeight


{-| Determine the relative width of the windows.
-}
windowWidth : Float
windowWidth =
    min 0.225 houseHeight


{-| Determine the relative bar width on the windows.
-}
windowBarWidth : Float
windowBarWidth =
    0.1 * windowWidth


main : Svg svg
main =
    Svg.svg
        [ SvgAttr.viewBox "0 0 1000 1000"
        , SvgAttr.width "1000"
        , SvgAttr.height "1000"
        ]
        [ house
            { colorDoor = defaultDoorColor
            , colorDoorKnob = defaultKnobColor
            , colorRoof = defaultRoofColor
            , colorWall = defaultWallColor
            , colorWindow = defaultWindowColor
            , height = 750
            , width = 1000
            , x = 0
            , y = 0
            }
        ]


house :
    { colorDoor : Color
    , colorDoorKnob : Color
    , colorRoof : Color
    , colorWall : Color
    , colorWindow : Color
    , height : Float
    , width : Float
    , x : Float
    , y : Float
    }
    -> Svg svg
house data =
    g
        []
        -- Roof
        [ polygon
            [ SvgAttr.fill (Color.toCssString data.colorRoof)
            , [ ( 0.5, 0 ), ( 0, 1 - houseHeight ), ( 1, 1 - houseHeight ) ]
                |> List.map (\( a, b ) -> ( a * data.width, b * data.height ))
                |> List.map (\( a, b ) -> ( a + data.x, b + data.y ))
                |> List.map (Tuple.mapBoth String.fromFloat String.fromFloat)
                |> List.map (\( a, b ) -> a ++ "," ++ b)
                |> String.join " "
                |> SvgAttr.points
            ]
            []

        -- House wall
        , rect
            [ SvgAttr.fill (Color.toCssString data.colorWall)
            , SvgAttr.x (String.fromFloat (0.1 * data.width + data.x))
            , SvgAttr.y (String.fromFloat ((1 - houseHeight) * data.height + data.y))
            , SvgAttr.width (String.fromFloat (0.8 * data.width))
            , SvgAttr.height (String.fromFloat (houseHeight * data.height))
            ]
            []

        -- Door
        , rect
            [ SvgAttr.fill (Color.toCssString data.colorDoor)
            , SvgAttr.x (String.fromFloat (0.2 * data.width + data.x))
            , SvgAttr.y (String.fromFloat ((1 - doorHeight) * data.height + data.y))
            , SvgAttr.width (String.fromFloat (0.25 * data.width))
            , SvgAttr.height (String.fromFloat (doorHeight * data.height))
            ]
            []

        -- Door knob
        , circle
            [ SvgAttr.fill (Color.toCssString data.colorDoorKnob)
            , SvgAttr.cx (String.fromFloat (0.4 * data.width + data.x))
            , SvgAttr.cy (String.fromFloat ((1 - (doorHeight / 2)) * data.height + data.y))
            , min (0.025 * data.width) (0.5 * doorHeight * data.height / 2)
                |> String.fromFloat
                |> SvgAttr.r
            ]
            []

        -- Windows
        , rect
            [ SvgAttr.fill (Color.toCssString data.colorWindow)
            , SvgAttr.x (String.fromFloat ((0.825 - windowWidth) * data.width + data.x))
            , SvgAttr.y (String.fromFloat ((1 - doorHeight) * data.height + data.y))
            , SvgAttr.width (String.fromFloat (windowWidth * data.width))
            , SvgAttr.height (String.fromFloat (windowHeight * data.height))
            ]
            []

        -- Window bars
        , rect
            [ SvgAttr.fill (Color.toCssString data.colorWall)
            , SvgAttr.x (String.fromFloat ((0.825 - windowWidth / 2 - windowBarWidth / 2) * data.width + data.x))
            , SvgAttr.y (String.fromFloat ((1 - doorHeight) * data.height + data.y))
            , SvgAttr.width (String.fromFloat (windowBarWidth * data.width))
            , SvgAttr.height (String.fromFloat (windowHeight * data.height))
            ]
            []
        , rect
            [ SvgAttr.fill (Color.toCssString data.colorWall)
            , SvgAttr.x (String.fromFloat ((0.825 - windowWidth) * data.width + data.x))
            , SvgAttr.y (String.fromFloat ((1 - doorHeight + windowHeight / 2 - windowBarWidth / 2) * data.height + data.y))
            , SvgAttr.width (String.fromFloat (windowWidth * data.width))
            , SvgAttr.height (String.fromFloat (windowBarWidth * data.height))
            ]
            []
        ]
