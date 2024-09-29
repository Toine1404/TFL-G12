module Layout exposing
    ( tab
    , containedButton, outlinedButton, textButton, sideList
    , textInput, passwordInput
    , loadingIndicator, itemWithSubtext
    )

{-|


# Layout

The layout module exposes some boilerplate functions that have produce a
beautiful Material design Elm webpage.


## Elements

@docs tab


## Buttons

@docs containedButton, outlinedButton, textButton


## Text fields

@docs textInput, passwordInput

## Items in a list

@docs itemWithSubtext

## Lists

@docs sideList

## Other elements

@docs loadingIndicator

-}

import Color exposing (Color)
import Element exposing (Element)
import Element.Input
import Widget
import Widget.Customize as Customize
import Widget.Icon exposing (Icon)
import Widget.Material as Material


{-| A contained button representing the most important action of a group.
-}
containedButton :
    { buttonColor : Color
    , clickColor : Color
    , icon : Icon msg
    , onPress : Maybe msg
    , text : String
    }
    -> Element msg
containedButton data =
    Widget.button
        ({ primary = data.buttonColor, onPrimary = data.clickColor }
            |> singlePalette
            |> Material.containedButton
            |> Customize.elementButton [ Element.width Element.fill ]
        )
        { text = data.text, icon = data.icon, onPress = data.onPress }

{-| Multiline item
-}
itemWithSubtext :
    { color : Color
    , leftIcon : Widget.Icon.Icon msg
    , onPress : Maybe msg
    , rightIcon : Widget.Icon.Icon msg
    , text : String
    , title : String
    }
        -> Widget.Item msg
itemWithSubtext data =
    Widget.multiLineItem
        ( { primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.multiLineItem
        )
        { content = data.rightIcon
        , icon = data.leftIcon
        , onPress = data.onPress
        , title = data.title
        , text = data.text
        }

{-| Circular loading bar indicator
-}
loadingIndicator :
    { color : Color
    }
        -> Element msg
loadingIndicator data =
    Widget.circularProgressIndicator
        ( { primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.progressIndicator
        )
        Nothing

{-| An outlined button representing an important action within a group.
-}
outlinedButton :
    { color : Color
    , icon : Icon msg
    , onPress : Maybe msg
    , text : String
    }
    -> Element msg
outlinedButton data =
    Widget.button
        ({ primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.outlinedButton
        )
        { text = data.text, icon = data.icon, onPress = data.onPress }

{-| Show a password field
-}
passwordInput :
    { color : Color
    , label : String
    , onChange : String -> msg
    , placeholder : Maybe String
    , show : Bool
    , text : String
    }
    -> Element msg
passwordInput data =
    Widget.currentPasswordInputV2
        ({ primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.passwordInput
        )
        { label = data.label
        , onChange = data.onChange
        , placeholder =
            data.placeholder
                |> Maybe.map Element.text
                |> Maybe.map (Element.Input.placeholder [])
        , show = data.show
        , text = data.text
        }


{-| Create a simple palette.
-}
singlePalette : { primary : Color, onPrimary : Color } -> Material.Palette
singlePalette { primary, onPrimary } =
    { primary = primary
    , secondary = primary
    , background = primary
    , surface = primary
    , error = primary
    , on =
        { primary = onPrimary
        , secondary = onPrimary
        , background = onPrimary
        , surface = onPrimary
        , error = onPrimary
        }
    }

sideList : { color : Color, items : List (Widget.Item msg) }-> Element msg
sideList data =
    Widget.itemList
        ( { primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.sideSheet
        )
        data.items

{-| A tab selector that always has an item selected.
-}
tab :
    { color : Color
    , content : Int -> Element msg
    , items : List { text : String, icon : Icon msg }
    , onSelect : Int -> msg
    , selected : Int
    }
    -> Element msg
tab data =
    Widget.tab
        ({ primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.tab
        )
        { tabs =
            { onSelect = data.onSelect >> Just
            , options = data.items
            , selected = Just data.selected
            }
        , content = \_ -> data.content data.selected
        }


{-| A text button representing an important action within a group.
-}
textButton :
    { icon : Icon msg
    , onPress : Maybe msg
    , text : String
    , color : Color
    }
    -> Element msg
textButton data =
    Widget.button
        ({ primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.textButton
        )
        { text = data.text, icon = data.icon, onPress = data.onPress }


{-| Text input element.
-}
textInput :
    { color : Color
    , label : String
    , onChange : String -> msg
    , placeholder : Maybe String
    , text : String
    }
    -> Element msg
textInput data =
    Widget.textInput
        ({ primary = data.color, onPrimary = data.color }
            |> singlePalette
            |> Material.textInput
            |> Customize.elementRow [ Element.width Element.fill ]
        )
        { chips = []
        , text = data.text
        , placeholder =
            data.placeholder
                |> Maybe.map Element.text
                |> Maybe.map (Element.Input.placeholder [])
        , label = data.label
        , onChange = data.onChange
        }
