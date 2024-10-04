module Sprites.Pig exposing (defaultEyeballColor, defaultEyesColor, defaultNoseColor, defaultNoseHoleColor, defaultSkinColor, main, pig)

import Color exposing (Color)
import Svg exposing (..)
import Svg.Attributes exposing (..)


defaultEyeballColor : Color
defaultEyeballColor =
    Color.rgb255 255 255 255


defaultEyesColor : Color
defaultEyesColor =
    Color.rgb255 0 0 0


defaultNoseColor : Color
defaultNoseColor =
    Color.rgb255 202 127 143


defaultNoseHoleColor : Color
defaultNoseHoleColor =
    Color.rgb255 0 0 0


defaultSkinColor : Color
defaultSkinColor =
    Color.rgb255 214 163 174


main : Svg svg
main =
    Svg.svg
        [ viewBox "0 0 1000 750"
        , width "1000"
        , height "750"
        ]
        [ pig
            { colorEyeball = defaultEyeballColor
            , colorEyes = defaultEyesColor
            , colorNose = defaultNoseColor
            , colorNoseHole = defaultNoseHoleColor
            , colorSkin = defaultSkinColor
            , height = 750
            , leftEyeOffsetX = 0.5
            , leftEyeOffsetY = 0.5
            , rightEyeOffsetX = -0.5
            , rightEyeOffsetY = -0.5
            , width = 1000
            , x = 0
            , y = 0
            }
        ]


pig :
    { colorEyeball : Color
    , colorEyes : Color
    , colorNose : Color
    , colorNoseHole : Color
    , colorSkin : Color
    , height : Float
    , leftEyeOffsetX : Float
    , leftEyeOffsetY : Float
    , rightEyeOffsetX : Float
    , rightEyeOffsetY : Float
    , width : Float
    , x : Float
    , y : Float
    }
    -> Svg svg
pig data =
    g
        [ fill (Color.toCssString data.colorSkin)
        , transformStandard data
        ]
        -- Legs
        [ [ 0.15, 0.3, 0.6, 0.75 ]
            |> List.map
                (\v ->
                    rect
                        [ x (String.fromFloat v)
                        , y "0.5"
                        , width "0.1"
                        , height "0.5"
                        ]
                        []
                )
            |> g []

        -- Main body
        , ellipse
            [ cx "0.475"
            , cy "0.5"
            , rx "0.45"
            , ry "0.25"
            ]
            []

        -- Tail
        , tail { height = 0.3, width = 0.2, x = 0, y = 0.2 }

        -- Head
        , face { data | width = 0.3, height = 0.3 * 4 / 3, x = 0.7, y = 0 }
        ]


eye : { a | colorBall : Color, colorIris : Color, eyeOffsetX : Float, eyeOffsetY : Float, height : Float, width : Float, x : Float, y : Float } -> Svg svg
eye data =
    g
        [ transformStandard data ]
        [ circle
            [ cx "0.5"
            , cy "0.5"
            , r "0.5"
            , fill (Color.toCssString data.colorBall)
            ]
            []
        , circle
            [ cx (String.fromFloat (0.5 + data.eyeOffsetX / 4))
            , cy (String.fromFloat (0.5 + data.eyeOffsetY / 4))
            , r "0.25"
            , fill (Color.toCssString data.colorIris)
            ]
            []
        ]


face :
    { a
        | colorEyeball : Color
        , colorEyes : Color
        , colorSkin : Color
        , colorNose : Color
        , colorNoseHole : Color
        , height : Float
        , leftEyeOffsetX : Float
        , leftEyeOffsetY : Float
        , rightEyeOffsetX : Float
        , rightEyeOffsetY : Float
        , width : Float
        , x : Float
        , y : Float
    }
    -> Svg svg
face data =
    g
        [ transformStandard data
        , fill (Color.toCssString data.colorSkin)
        ]
        [ ellipse
            [ cx "0.5"
            , cy "0.55"
            , rx "0.5"
            , ry "0.45"
            ]
            []
        , ellipse
            [ cx "0.1"
            , cy "0.2"
            , rx "0.1"
            , ry "0.2"
            ]
            []
        , ellipse
            [ cx "0.9"
            , cy "0.2"
            , rx "0.1"
            , ry "0.2"
            ]
            []
        , nose
            { colorNose = data.colorNose
            , colorNoseHole = data.colorNoseHole
            , height = 0.25
            , width = 0.5
            , x = 0.25
            , y = 0.6
            }
        , eye
            { colorBall = data.colorEyeball
            , colorIris = data.colorEyes
            , eyeOffsetX = data.leftEyeOffsetX
            , eyeOffsetY = data.leftEyeOffsetY
            , height = 0.25
            , width = 0.25
            , x = 0.2
            , y = 0.25
            }
        , eye
            { colorBall = data.colorEyeball
            , colorIris = data.colorEyes
            , eyeOffsetX = data.rightEyeOffsetX
            , eyeOffsetY = data.rightEyeOffsetY
            , height = 0.25
            , width = 0.25
            , x = 0.55
            , y = 0.25
            }
        ]


hollowCircle : { height : Float, width : Float, x : Float, y : Float } -> Svg svg
hollowCircle data =
    Svg.path
        [ d "M 0.5 0 A 0.5 0.5 0 1 0 0.5 1 A 0.5 0.5 0 1 0 0.5 0 Z M 0.5 0.25 A 0.25 0.25 0 1 1 0.5 0.75 A 0.25 0.25 0 1 1 0.5 0.25 Z"
        , transformStandard data
        ]
        []


nose : { a | colorNose : Color, colorNoseHole : Color, height : Float, width : Float, x : Float, y : Float } -> Svg svg
nose data =
    g
        [ transformStandard data
        , fill (Color.toCssString data.colorNose)
        ]
        [ circle [ cx "0.5", cy "0.5", r "0.5" ] []
        , ellipse
            [ cx "0.275"
            , cy "0.5"
            , rx "0.125"
            , ry "0.25"
            , fill (Color.toCssString data.colorNoseHole)
            ]
            []
        , ellipse
            [ cx "0.725"
            , cy "0.5"
            , rx "0.125"
            , ry "0.25"
            , fill (Color.toCssString data.colorNoseHole)
            ]
            []
        ]


tail : { a | height : Float, width : Float, x : Float, y : Float } -> Svg svg
tail data =
    g
        [ transformStandard { data | height = data.height / 2.5 } ]
        [ hollowCircle { x = 0, y = 0, width = 1, height = 1 }
        , hollowCircle { x = 0, y = 0.75, width = 1, height = 1 }
        , hollowCircle { x = 0, y = 1.5, width = 1, height = 1 }
        ]


transformStandard : { a | height : Float, width : Float, x : Float, y : Float } -> Svg.Attribute msg
transformStandard data =
    [ data.width, 0, 0, data.height, data.x, data.y ]
        |> List.map String.fromFloat
        |> String.join " "
        |> (\coords -> "matrix(" ++ coords ++ ")")
        |> transform
