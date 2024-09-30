module Sprites.Castle exposing (castle, defaultDoorColor, defaultGrayStoneColor, main)

import Color exposing (Color)
import Html.Attributes as HtmlAttr
import Svg exposing (..)
import Svg.Attributes as SvgAttr


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
        , SvgAttr.height (String.fromFloat data.height)
        , SvgAttr.width (String.fromFloat data.width)
        , HtmlAttr.attribute "x" (String.fromFloat data.x)
        , HtmlAttr.attribute "y" (String.fromFloat data.y)
        ]
        []


main : Svg svg
main =
    Svg.svg
        [ SvgAttr.viewBox "0 0 1000 1000"
        , SvgAttr.width "750"
        , SvgAttr.height "750"
        ]
        [ castle
            { colorDoor = defaultDoorColor
            , colorStone = defaultGrayStoneColor
            , height = 500
            , width = 500
            , x = 250
            , y = 250
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
        [ HtmlAttr.style "stroke-width" "0"
        , HtmlAttr.style "stroke-dasharray" "none"
        , HtmlAttr.style "stroke-linecap" "butt"
        , HtmlAttr.style "stroke-dashoffset" "0"
        , HtmlAttr.style "stroke-linejoin" "miter"
        , HtmlAttr.style "stroke-miterlimit" "4"
        , HtmlAttr.style "fill-rule" "nonzero"
        , HtmlAttr.style "opacity" "1"
        , HtmlAttr.attribute "vector-effect" "non-scaling-stroke"
        ]
        [ rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 7.77 / ySize * data.height
            , width = 66.17 * 2.48 / xSize * data.width
            , x = (2.48 * -33.085 + 1022.43 - xOffset) / xSize * data.width + data.x
            , y = (7.77 * -33.085 + 532.66 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 1.93 / ySize * data.height
            , width = 66.17 * 3.72 / xSize * data.width
            , x = (3.72 * -33.085 + 1020.91 - xOffset) / xSize * data.width + data.x
            , y = (1.93 * -33.085 + 281.78 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 915.23 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 206.83 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 967.4 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 207.64 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 1023.96 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 209.34 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 1078.74 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 209.25 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 1127.35 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 208.25 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 7.77 / ySize * data.height
            , width = 66.17 * 2.48 / xSize * data.width
            , x = (2.48 * -33.085 + 369.26 - xOffset) / xSize * data.width + data.x
            , y = (7.77 * -33.085 + 532.66 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 1.93 / ySize * data.height
            , width = 66.17 * 3.72 / xSize * data.width
            , x = (3.72 * -33.085 + 367.7 - xOffset) / xSize * data.width + data.x
            , y = (1.93 * -33.085 + 281.78 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 261.12 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 207.73 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 314.19 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 207.64 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 370.76 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 209.34 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 425.53 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 209.25 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 474.19 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 208.25 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 5.24 / ySize * data.height
            , width = 66.17 * 10.02 / xSize * data.width
            , x = (10.02 * -33.085 + 699.87 - xOffset) / xSize * data.width + data.x
            , y = (5.24 * -33.085 + 617.32 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 1.93 / ySize * data.height
            , width = 66.17 * 3.72 / xSize * data.width
            , x = (3.72 * -33.085 + 581.29 - xOffset) / xSize * data.width + data.x
            , y = (1.93 * -33.085 + 503.68 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 474.71 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 429.64 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 527.78 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 429.54 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 584.34 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 431.24 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 639.11 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 431.15 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 1.89 / ySize * data.height
            , width = 66.17 * 0.53 / xSize * data.width
            , x = (0.53 * -33.085 + 693.45 - xOffset) / xSize * data.width + data.x
            , y = (1.89 * -33.085 + 475.34 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 1.93 / ySize * data.height
            , width = 66.17 * 3.72 / xSize * data.width
            , x = (3.72 * -33.085 + 855.13 - xOffset) / xSize * data.width + data.x
            , y = (1.93 * -33.085 + 503.68 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 748.55 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 429.64 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 801.62 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 429.54 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 858.18 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 431.24 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 912.95 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 431.15 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = data.colorStone
            , fillColor = data.colorStone
            , height = 66.17 * 0.55 / ySize * data.height
            , width = 66.17 * 0.51 / xSize * data.width
            , x = (0.51 * -33.085 + 961.61 - xOffset) / xSize * data.width + data.x
            , y = (0.55 * -33.085 + 430.19 - yOffset) / ySize * data.height + data.y
            }
        , rectAttr
            { edgeColor = Color.rgb255 0 0 0
            , fillColor = data.colorDoor
            , height = 66.17 * 1.85 / ySize * data.height
            , width = 66.17 * 1.95 / xSize * data.width
            , x = (1.95 * -33.085 + 693 - xOffset) / xSize * data.width + data.x
            , y = (1.85 * -33.085 + 727.98 - yOffset) / ySize * data.height + data.y
            }
        , circle
            [ SvgAttr.cx (String.fromFloat ((692.92 - xOffset) / xSize * data.width + data.x))
            , SvgAttr.cy (String.fromFloat ((662.82 - yOffset) / ySize * data.height + data.y))
            , SvgAttr.r (String.fromFloat (35 * 1.85 / xSize * data.width))
            , HtmlAttr.style "fill" (Color.toCssString data.colorDoor)
            , HtmlAttr.style "stroke" (Color.toCssString (Color.rgb255 0 0 0))
            ]
            []
        ]
