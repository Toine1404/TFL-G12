module Sprites.LankyHuman exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)



lankyHuman : { height : Float, width : Float, x : Float, y : Float } -> Svg svg
lankyHuman data =
    g [ transformStandard data ]
        [ Svg.path
            [ d "M 0.6356 0 A 0.1425 0.0515 0 0 0 0.5529 0.0886 S 0.5899 0.1205 0.5387 0.1185 S 0.1796 0.1082 0.1169 0.1669 S -0.0142 0.2771 0 0.3369 S 0.1083 0.4636 0.0941 0.4924 S 0.0171 0.5141 0.0256 0.546 S 0.171 0.5749 0.1682 0.5409 S 0.1482 0.5275 0.1682 0.4924 S 0.1254 0.3904 0.134 0.3338 S 0.1824 0.2009 0.2251 0.2029 C 0.2422 0.2568 0.2879 0.3266 0.3221 0.3616 S 0.3449 0.4317 0.3563 0.4677 S 0.305 0.6356 0.3164 0.6944 S 0.4047 0.9035 0.3904 0.921 S 0.2166 0.9735 0.2622 0.9859 S 0.3534 1.0034 0.3904 0.9911 S 0.5101 0.9488 0.5044 0.9231 S 0.4189 0.7356 0.4446 0.6882 S 0.4959 0.5089 0.5529 0.5079 S 0.6583 0.6717 0.6583 0.7005 S 0.5928 0.9025 0.5928 0.9272 S 0.6897 0.9859 0.7296 0.9921 S 0.8293 0.989 0.8293 0.9715 S 0.7211 0.9303 0.7211 0.9189 S 0.798 0.7479 0.8037 0.7067 S 0.7153 0.513 0.7153 0.4729 S 0.7068 0.4018 0.7467 0.3647 S 0.7724 0.2009 0.8009 0.1968 S 0.8807 0.3018 0.8807 0.3379 S 0.8921 0.4595 0.8692 0.479 S 0.8094 0.4883 0.8094 0.511 S 0.8863 0.5532 0.9291 0.5233 S 0.9462 0.4966 0.9576 0.477 S 1.0118 0.3812 0.9947 0.3379 S 0.9776 0.2205 0.9092 0.1607 S 0.7325 0.1339 0.704 0.1257 S 0.6641 0.1082 0.7011 0.0979 A 0.1425 0.0515 0 0 0 0.6356 0 Z"
            ]
            []
        ]

transformStandard : { a | height : Float, width : Float, x : Float, y : Float } -> Svg.Attribute msg
transformStandard data =
    [ data.width, 0, 0, data.height, data.x, data.y ]
        |> List.map String.fromFloat
        |> String.join " "
        |> (\coords -> "matrix(" ++ coords ++ ")")
        |> transform
