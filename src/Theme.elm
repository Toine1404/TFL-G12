module Theme exposing (..)

{-|


# Theme

The Theme helps pick colors from different color schemes.

-}

import Catppuccin.Frappe as CF
import Catppuccin.Latte as CL
import Catppuccin.Macchiato as CA
import Catppuccin.Mocha as CO
import Color
import Element
import Element.Background


{-| Catppuccin flavor used for display.
-}
type Flavor
    = Frappe
    | Latte
    | Macchiato
    | Mocha


background : (Flavor -> Color.Color) -> Flavor -> Element.Attribute msg
background toColor =
    toColor >> toElmUiColor >> Element.Background.color


toElmUiColor : Color.Color -> Element.Color
toElmUiColor =
    Color.toRgba >> Element.fromRgb


rosewater : Flavor -> Color.Color
rosewater flavor =
    case flavor of
        Frappe ->
            CF.rosewater

        Latte ->
            CL.rosewater

        Macchiato ->
            CA.rosewater

        Mocha ->
            CO.rosewater


rosewaterUI : Flavor -> Element.Color
rosewaterUI =
    rosewater >> toElmUiColor


flamingo : Flavor -> Color.Color
flamingo flavor =
    case flavor of
        Frappe ->
            CF.flamingo

        Latte ->
            CL.flamingo

        Macchiato ->
            CA.flamingo

        Mocha ->
            CO.flamingo


flamingoUI : Flavor -> Element.Color
flamingoUI =
    flamingo >> toElmUiColor


pink : Flavor -> Color.Color
pink flavor =
    case flavor of
        Frappe ->
            CF.pink

        Latte ->
            CL.pink

        Macchiato ->
            CA.pink

        Mocha ->
            CO.pink


pinkUI : Flavor -> Element.Color
pinkUI =
    pink >> toElmUiColor


mauve : Flavor -> Color.Color
mauve flavor =
    case flavor of
        Frappe ->
            CF.mauve

        Latte ->
            CL.mauve

        Macchiato ->
            CA.mauve

        Mocha ->
            CO.mauve


mauveUI : Flavor -> Element.Color
mauveUI =
    mauve >> toElmUiColor


red : Flavor -> Color.Color
red flavor =
    case flavor of
        Frappe ->
            CF.red

        Latte ->
            CL.red

        Macchiato ->
            CA.red

        Mocha ->
            CO.red


redUI : Flavor -> Element.Color
redUI =
    red >> toElmUiColor


maroon : Flavor -> Color.Color
maroon flavor =
    case flavor of
        Frappe ->
            CF.maroon

        Latte ->
            CL.maroon

        Macchiato ->
            CA.maroon

        Mocha ->
            CO.maroon


maroonUI : Flavor -> Element.Color
maroonUI =
    maroon >> toElmUiColor


peach : Flavor -> Color.Color
peach flavor =
    case flavor of
        Frappe ->
            CF.peach

        Latte ->
            CL.peach

        Macchiato ->
            CA.peach

        Mocha ->
            CO.peach


peachUI : Flavor -> Element.Color
peachUI =
    peach >> toElmUiColor


yellow : Flavor -> Color.Color
yellow flavor =
    case flavor of
        Frappe ->
            CF.yellow

        Latte ->
            CL.yellow

        Macchiato ->
            CA.yellow

        Mocha ->
            CO.yellow


yellowUI : Flavor -> Element.Color
yellowUI =
    yellow >> toElmUiColor


green : Flavor -> Color.Color
green flavor =
    case flavor of
        Frappe ->
            CF.green

        Latte ->
            CL.green

        Macchiato ->
            CA.green

        Mocha ->
            CO.green


greenUI : Flavor -> Element.Color
greenUI =
    green >> toElmUiColor


teal : Flavor -> Color.Color
teal flavor =
    case flavor of
        Frappe ->
            CF.teal

        Latte ->
            CL.teal

        Macchiato ->
            CA.teal

        Mocha ->
            CO.teal


tealUI : Flavor -> Element.Color
tealUI =
    teal >> toElmUiColor


sky : Flavor -> Color.Color
sky flavor =
    case flavor of
        Frappe ->
            CF.sky

        Latte ->
            CL.sky

        Macchiato ->
            CA.sky

        Mocha ->
            CO.sky


skyUI : Flavor -> Element.Color
skyUI =
    sky >> toElmUiColor


sapphire : Flavor -> Color.Color
sapphire flavor =
    case flavor of
        Frappe ->
            CF.sapphire

        Latte ->
            CL.sapphire

        Macchiato ->
            CA.sapphire

        Mocha ->
            CO.sapphire


sapphireUI : Flavor -> Element.Color
sapphireUI =
    sapphire >> toElmUiColor


blue : Flavor -> Color.Color
blue flavor =
    case flavor of
        Frappe ->
            CF.blue

        Latte ->
            CL.blue

        Macchiato ->
            CA.blue

        Mocha ->
            CO.blue


blueUI : Flavor -> Element.Color
blueUI =
    blue >> toElmUiColor


lavender : Flavor -> Color.Color
lavender flavor =
    case flavor of
        Frappe ->
            CF.lavender

        Latte ->
            CL.lavender

        Macchiato ->
            CA.lavender

        Mocha ->
            CO.lavender


lavenderUI : Flavor -> Element.Color
lavenderUI =
    lavender >> toElmUiColor


text : Flavor -> Color.Color
text flavor =
    case flavor of
        Frappe ->
            CF.text

        Latte ->
            CL.text

        Macchiato ->
            CA.text

        Mocha ->
            CO.text


textUI : Flavor -> Element.Color
textUI =
    text >> toElmUiColor


subtext1 : Flavor -> Color.Color
subtext1 flavor =
    case flavor of
        Frappe ->
            CF.subtext1

        Latte ->
            CL.subtext1

        Macchiato ->
            CA.subtext1

        Mocha ->
            CO.subtext1


subtext1UI : Flavor -> Element.Color
subtext1UI =
    subtext1 >> toElmUiColor


subtext0 : Flavor -> Color.Color
subtext0 flavor =
    case flavor of
        Frappe ->
            CF.subtext0

        Latte ->
            CL.subtext0

        Macchiato ->
            CA.subtext0

        Mocha ->
            CO.subtext0


subtext0UI : Flavor -> Element.Color
subtext0UI =
    subtext0 >> toElmUiColor


overlay2 : Flavor -> Color.Color
overlay2 flavor =
    case flavor of
        Frappe ->
            CF.overlay2

        Latte ->
            CL.overlay2

        Macchiato ->
            CA.overlay2

        Mocha ->
            CO.overlay2


overlay2UI : Flavor -> Element.Color
overlay2UI =
    overlay2 >> toElmUiColor


overlay1 : Flavor -> Color.Color
overlay1 flavor =
    case flavor of
        Frappe ->
            CF.overlay1

        Latte ->
            CL.overlay1

        Macchiato ->
            CA.overlay1

        Mocha ->
            CO.overlay1


overlay1UI : Flavor -> Element.Color
overlay1UI =
    overlay1 >> toElmUiColor


overlay0 : Flavor -> Color.Color
overlay0 flavor =
    case flavor of
        Frappe ->
            CF.overlay0

        Latte ->
            CL.overlay0

        Macchiato ->
            CA.overlay0

        Mocha ->
            CO.overlay0


overlay0UI : Flavor -> Element.Color
overlay0UI =
    overlay0 >> toElmUiColor


surface2 : Flavor -> Color.Color
surface2 flavor =
    case flavor of
        Frappe ->
            CF.surface2

        Latte ->
            CL.surface2

        Macchiato ->
            CA.surface2

        Mocha ->
            CO.surface2


surface2UI : Flavor -> Element.Color
surface2UI =
    surface2 >> toElmUiColor


surface1 : Flavor -> Color.Color
surface1 flavor =
    case flavor of
        Frappe ->
            CF.surface1

        Latte ->
            CL.surface1

        Macchiato ->
            CA.surface1

        Mocha ->
            CO.surface1


surface1UI : Flavor -> Element.Color
surface1UI =
    surface1 >> toElmUiColor


surface0 : Flavor -> Color.Color
surface0 flavor =
    case flavor of
        Frappe ->
            CF.surface0

        Latte ->
            CL.surface0

        Macchiato ->
            CA.surface0

        Mocha ->
            CO.surface0


surface0UI : Flavor -> Element.Color
surface0UI =
    surface0 >> toElmUiColor


base : Flavor -> Color.Color
base flavor =
    case flavor of
        Frappe ->
            CF.base

        Latte ->
            CL.base

        Macchiato ->
            CA.base

        Mocha ->
            CO.base


baseUI : Flavor -> Element.Color
baseUI =
    base >> toElmUiColor


mantle : Flavor -> Color.Color
mantle flavor =
    case flavor of
        Frappe ->
            CF.mantle

        Latte ->
            CL.mantle

        Macchiato ->
            CA.mantle

        Mocha ->
            CO.mantle


mantleUI : Flavor -> Element.Color
mantleUI =
    mantle >> toElmUiColor


crust : Flavor -> Color.Color
crust flavor =
    case flavor of
        Frappe ->
            CF.crust

        Latte ->
            CL.crust

        Macchiato ->
            CA.crust

        Mocha ->
            CO.crust


crustUI : Flavor -> Element.Color
crustUI =
    crust >> toElmUiColor


brown : Flavor -> Color.Color
brown flavor =
    case flavor of
        Frappe -> Color.rgb 165 42 42  -- Example RGB for a brown color
        Latte  -> Color.rgb 139 69 19  -- Example RGB for another shade of brown
        Macchiato -> Color.rgb 160 82 45
        Mocha -> Color.rgb 101 67 33

brownUI : Flavor -> Element.Color
brownUI =
    brown >> toElmUiColor
