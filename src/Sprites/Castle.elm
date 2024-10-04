module Sprites.Castle exposing (castle, defaultDoorColor, defaultGrayStoneColor, main)

import Color exposing (Color)
import Html.Attributes as HtmlAttr
import Svg exposing (..)
import Svg.Attributes exposing (..)


defaultDoorColor : Color
defaultDoorColor =
    Color.rgb255 85 59 9


defaultGrayStoneColor : Color
defaultGrayStoneColor =
    Color.rgb255 101 101 101


xOffset : Float
xOffset =
    244.24665


yOffset : Float
yOffset =
    188.63325


xSize : Float
xSize =
    899.9767


ySize : Float
ySize =
    602.05215


rectAttr :
    { edgeColor : Color
    , fillColor : Color
    , height : Float
    , width : Float
    , x : Float
    , y : Float
    }
    -> Svg svg
rectAttr data =
    rect
        [ HtmlAttr.style "stroke" (Color.toCssString data.edgeColor)
        , HtmlAttr.style "fill" (Color.toCssString data.fillColor)
        , height (String.fromFloat data.height)
        , width (String.fromFloat data.width)
        , HtmlAttr.attribute "x" (String.fromFloat data.x)
        , HtmlAttr.attribute "y" (String.fromFloat data.y)
        ]
        []


main : Svg svg
main =
    Svg.svg
        [ viewBox "0 0 1000 750"
        , width "1000"
        , height "750"
        ]
        [ castle
            { colorDoor = defaultDoorColor
            , colorStone = defaultGrayStoneColor
            , height = 750
            , width = 1000
            , x = 0
            , y = 0
            }
        ]


castle :
    { colorDoor : Color
    , colorStone : Color
    , height : Float
    , width : Float
    , x : Float
    , y : Float
    }
    -> Svg svg
castle data =
    g
        [ fill (Color.toCssString data.colorDoor)
        , transformStandard { data | width = data.width / 53, height = data.height / 20 }
        ]
        [ [ ( 0, 0 )
          , ( 2, 0 )
          , ( 2, 1 )
          , ( 3, 1 )
          , ( 3, 0 )
          , ( 5, 0 )
          , ( 5, 1 )
          , ( 6, 1 )
          , ( 6, 0 )
          , ( 8, 0 )
          , ( 8, 1 )
          , ( 9, 1 )
          , ( 9, 0 )
          , ( 11, 0 )
          , ( 11, 1 )
          , ( 12, 1 )
          , ( 12, 0 )
          , ( 14, 0 )
          , ( 14, 1 )
          , ( 15, 1 )
          , ( 15, 0 )
          , ( 17, 0 )
          , ( 17, 5 )
          , ( 14, 5 )
          , ( 14, 8 )
          , ( 15, 8 )
          , ( 15, 7 )
          , ( 17, 7 )
          , ( 17, 8 )
          , ( 18, 8 )
          , ( 18, 7 )
          , ( 20, 7 )
          , ( 20, 8 )
          , ( 21, 8 )
          , ( 21, 7 )
          , ( 23, 7 )
          , ( 23, 8 )
          , ( 24, 8 )
          , ( 24, 7 )
          , ( 26, 7 )
          , ( 26, 8 )
          , ( 27, 8 )
          , ( 27, 7 )
          , ( 29, 7 )
          , ( 29, 8 )
          , ( 30, 8 )
          , ( 30, 7 )
          , ( 32, 7 )
          , ( 32, 8 )
          , ( 33, 8 )
          , ( 33, 7 )
          , ( 35, 7 )
          , ( 35, 8 )
          , ( 36, 8 )
          , ( 36, 7 )
          , ( 38, 7 )
          , ( 38, 8 )
          , ( 39, 8 )
          , ( 39, 7 )
          , ( 41, 7 )
          , ( 41, 8 )
          , ( 42, 8 )
          , ( 42, 5 )
          , ( 39, 5 )
          , ( 39, 0 )
          , ( 41, 0 )
          , ( 41, 1 )
          , ( 42, 1 )
          , ( 42, 0 )
          , ( 44, 0 )
          , ( 44, 1 )
          , ( 45, 1 )
          , ( 45, 0 )
          , ( 47, 0 )
          , ( 47, 1 )
          , ( 48, 1 )
          , ( 48, 0 )
          , ( 50, 0 )
          , ( 50, 1 )
          , ( 51, 1 )
          , ( 51, 0 )
          , ( 53, 0 )
          , ( 53, 5 )
          , ( 50, 5 )
          , ( 50, 20 )
          , ( 3, 20 )
          , ( 3, 5 )
          , ( 0, 5 )
          ]
            |> List.map (\( a, b ) -> String.fromInt a ++ "," ++ String.fromInt b)
            |> String.join " "
            |> points
            |> List.singleton
            |> List.append [ fill (Color.toCssString data.colorStone) ]
            |> Svg.polygon
            |> (|>) []
        , rect [ height "6", width "7", x "23", y "14" ] []
        , ellipse [ cx "26.5", cy "14", rx "3.5", ry "1.761" ] []
        ]


transformStandard : { a | height : Float, width : Float, x : Float, y : Float } -> Svg.Attribute msg
transformStandard data =
    [ data.width, 0, 0, data.height, data.x, data.y ]
        |> List.map String.fromFloat
        |> String.join " "
        |> (\coords -> "matrix(" ++ coords ++ ")")
        |> transform
