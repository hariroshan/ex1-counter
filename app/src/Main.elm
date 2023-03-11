module Main exposing (main)

import Browser
import Native exposing (Native, button, label)
import Native.Attributes as NA
import Native.Event as Ev
import Native.Layout as Layout


type alias Model =
    { count : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { count = 0 }
    , Cmd.none
    )


type Msg
    = Inc
    | Dec


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Inc ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Dec ->
            ( { model | count = model.count - 1 }, Cmd.none )


makeButton : String -> msg -> Native msg
makeButton btnText msg =
    button
        [ NA.class "primary"
        , NA.text btnText
        , Ev.onTap msg
        ]
        []


view : Model -> Native Msg
view model =
    Layout.flexboxLayout
        [ NA.alignItems "center"
        , NA.justifyContent "space-between"
        , NA.height "100%"
        ]
        [ makeButton "-" Dec
        , label
            [ NA.class "main"
            , model.count
                |> String.fromInt
                |> NA.text
            ]
            []
        , makeButton "+" Inc
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
