module Screens.Dialog exposing (..)

import Color exposing (Color)
import Element exposing (Element)
import Layout
import Scripts.ParseScripts as S
import Sprites.LankyHuman exposing (lankyHuman)
import Html
import Html.Attributes
import Element.Border
import Element.Background
import Theme
import Element.Events
import Html.Events
import Parser as P
import Element.Font

-- MODEL

type alias Model =
    { dialog : Maybe S.DialogState, text : String }

type Msg
    = ChooseOption String
    | ClickDialog
    | SetText String

init : Model
init = { dialog = Nothing, text = "" }

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( case msg of
        ChooseOption f ->
            case model.dialog of
                Just d ->
                    if List.any (\(flag, _) -> flag == f) (S.view d).options then
                        { model | dialog = S.goto f d }
                    else
                        model

                Nothing ->
                    model

        ClickDialog ->
            case model.dialog of
                Just d ->
                    case (S.view d).options of
                        _ :: _ ->
                            model

                        [] ->
                            { model | dialog = S.nextPiece d }
                Nothing ->
                    model

        SetText text ->
            { model
            | dialog =
                S.fromString text
                    |> Result.toMaybe
                    |> Maybe.map S.fromDialog
            , text = text
            }
    , Cmd.none
    )

-- VIEW

view :
    { buttonColor : Color
    , errorBoxColor : Color
    , height : Int
    , model : Model
    , textBoxColor : Color
    , toMsg : Msg -> msg
    , width : Int
    } -> Element msg
view data =
    let
        halfHeight = data.height // 2
        halfWidth = data.width // 2
    in
        Element.column []
            [ Element.row []
                [ viewNPC { height = halfHeight, width = halfWidth }
                , case data.model.dialog of
                    Just dialog ->
                        viewDialog
                            { buttonColor = data.buttonColor
                            , height = halfHeight
                            , model = dialog
                            , textBoxColor = data.textBoxColor
                            , toMsg = data.toMsg
                            , width = data.width - halfWidth
                            }
                    
                    Nothing ->
                        Element.none
                ]
            , Element.row []
                [ Html.textarea
                    [ Html.Events.onInput (data.toMsg << SetText)
                    , Html.Attributes.style "height" ((String.fromInt (data.height - halfHeight)) ++ "px")
                    , Html.Attributes.style "width" ((String.fromInt halfWidth) ++ "px")
                    ]
                    []
                    |> Element.html
                    |> Element.el
                        [ Element.height (Element.px (data.height - halfHeight))
                        , Element.width (Element.px halfWidth)
                        ]
                , viewDebugScreen
                    { height = data.height - halfHeight
                    , model = data.model.text
                    , textBoxColor = data.errorBoxColor
                    , width = data.width - halfWidth
                    }
                ]
            ]

viewDebugScreen : { height : Int, model : String, textBoxColor : Color, width : Int } -> Element msg
viewDebugScreen data =
    case S.fromString data.model of
        Ok _ ->
            Element.none
        
        Err e ->
            e
                |> List.map
                    (\deadEnd ->
                        [ Element.text "Line "
                        , Element.el [ Element.Font.bold ] (Element.text (String.fromInt deadEnd.row))
                        , Element.text ", column "
                        , Element.el [ Element.Font.bold ] (Element.text (String.fromInt deadEnd.col))
                        , Element.text ": "
                        , case deadEnd.problem of
                            P.Expecting name ->
                                Element.text ("Expected value \"" ++ name ++ "\"")
                            
                            P.ExpectingInt ->
                                Element.text "Expected a number"
                            
                            P.ExpectingHex ->
                                Element.text "Expected a hex value"
                            
                            P.ExpectingOctal ->
                                Element.text "Expected an octal value"
                            
                            P.ExpectingBinary ->
                                Element.text "Expected a binary value"
                            
                            P.ExpectingFloat ->
                                Element.text "Expected a floating point number"
                            
                            P.ExpectingNumber ->
                                Element.text "Expected a number"
                            
                            P.ExpectingVariable ->
                                Element.text "Expected a variable"
                            
                            P.ExpectingSymbol symbol ->
                                Element.text ("Expected the symbol \"" ++ symbol ++ "\" here")
                            
                            P.ExpectingKeyword keyword ->
                                Element.text ("Expected the keyword \"" ++ keyword ++ "\" here")
                            
                            P.ExpectingEnd ->
                                Element.text "Expected the end of the string there"
                            
                            P.UnexpectedChar ->
                                Element.text "Encountered an unexpected character"
                            
                            P.Problem name ->
                                Element.text ("Encountered a custom problem: " ++ name)
                            
                            P.BadRepeat ->
                                Element.text "Encountered a BadRepeat"
                        ]
                        |> Element.paragraph [ Element.centerX, Element.centerY ]
                    )
                |> Element.column
                    [ Element.Background.color (Theme.toElmUiColor data.textBoxColor)
                    , Element.height (Element.px data.height)
                    , Element.width (Element.px data.width)
                    ]

viewDialog : { buttonColor : Color, height : Int, model : S.DialogState, textBoxColor : Color, toMsg : Msg -> msg, width : Int } -> Element msg
viewDialog data =
    let
        textPadding = Basics.min 50 (data.height // 10)
        textHeight = data.height // 2
    in
        case S.view data.model of
            { text, options } ->
                Element.column
                    [ Element.width (Element.px data.width)
                    ]
                    [ String.trim text
                        |> String.split "\n\n"
                        |> List.map Element.text
                        |> Element.paragraph
                            [ Element.Background.color (Theme.toElmUiColor data.textBoxColor)
                            , Element.Border.rounded 25
                            , Element.Events.onClick (data.toMsg ClickDialog)
                            , Element.height (Element.px textHeight)
                            , Element.padding textPadding
                            , Element.width Element.fill
                            ]
                    , options
                        |> List.map
                            (\(flag, name) ->
                                Element.text name
                                    |> List.singleton
                                    |> Element.paragraph [ Element.centerX, Element.centerY ]
                                    |> Element.el
                                        [ Element.Background.color (Theme.toElmUiColor data.buttonColor)
                                        , Element.Events.onClick (data.toMsg (ChooseOption flag))
                                        , Element.height (Element.px (data.height - textHeight))
                                        , Element.width (Element.px ((data.width // (List.length options) - 10)))
                                        ]
                            )
                        |> Element.row
                            [ Element.centerX
                            , Element.height (Element.px (data.height - textHeight))
                            , Element.spacing 10
                            ]
                    ]

viewNPC : { height : Int, width : Int } -> Element msg
viewNPC data =
    Layout.svg
        { aspectRatio = 3 / 1
        , height = data.height
        , svg =
            lankyHuman
                { height = 3
                , width = 1
                , x = 0
                , y = 0
                }
        , width = data.width
        , viewMinX = 0
        , viewMaxX = 1
        , viewMinY = 0
        , viewMaxY = 3
        }
