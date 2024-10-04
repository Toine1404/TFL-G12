module Screens.Welcome exposing (..)

{-|


# Welcome screen

The welcome screen is the first screen that the player sees.

-}

import Color exposing (Color)
import Element exposing (Element)
import Element.Background
import Layout
import Theme



-- MODEL


getBoxSize : { a | height : Int, width : Int } -> Int
getBoxSize data =
    maxBoxSize
        |> min data.height
        |> min data.width


maxBoxSize : Int
maxBoxSize =
    1000


boxPadding : Int
boxPadding =
    50



-- UPDATE
-- VIEW


view :
    { backgroundColor : Color
    , boxColor : Color
    , buttonColor : Color
    , height : Int
    , onStart : msg
    , width : Int
    }
    -> Element msg
view data =
    case getBoxSize data of
        size ->
            let
                halfWidth =
                    floor ((toFloat size - 2 * toFloat boxPadding) / 2)

                newHeight =
                    size - 2 * boxPadding
            in
            [ introductionPicture { height = newHeight, width = halfWidth }
            , startButton
                { buttonColor = data.buttonColor
                , height = newHeight
                , onPress = Just data.onStart
                , width = halfWidth
                }
                |> Element.el [ Element.centerX, Element.centerY ]
            ]
                |> List.map
                    (Element.el
                        [ Element.height Element.fill
                        , Element.width (Element.px halfWidth)
                        ]
                    )
                |> Element.row
                    [ Element.Background.color (Theme.toElmUiColor data.boxColor)
                    , Element.centerX
                    , Element.centerY
                    , Element.height (Element.px size)
                    , Element.padding boxPadding
                    , Element.spaceEvenly
                    , Element.width (Element.px size)
                    ]
                |> Element.el
                    [ Element.Background.color (Theme.toElmUiColor data.backgroundColor)
                    , Element.height (Element.px data.height)
                    , Element.width (Element.px data.width)
                    ]


introductionPicture : { height : Int, width : Int } -> Element msg
introductionPicture data =
    Element.image
        [ Element.centerY
        , Element.height (Element.px data.height)
        , Element.width (Element.px data.width)
        ]
        { src = "static/cursed-person.png"
        , description = "Cursed person greeting a player who joins the game"
        }


startButton : { buttonColor : Color, height : Int, onPress : Maybe msg, width : Int } -> Element msg
startButton data =
    Element.column
        [ Element.padding 10 ]
        [ Layout.containedButton
            { buttonColor = data.buttonColor
            , clickColor = data.buttonColor
            , icon = always Element.none
            , onPress = data.onPress
            , text = "START"
            }
        ]
