module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onDoubleClick, on, keyCode)
import Html.Attributes exposing (..)
import Svg
import Svg.Attributes
import Json.Decode


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


model : CarStatus
model =
    { locationX = 0
    , locationY = 0
    , facing = Right
    }


type alias CarStatus =
    { locationX : Int
    , locationY : Int
    , facing : Facing
    }


type Facing
    = Left
    | Right
    | Up
    | Down


update : Drive -> CarStatus -> CarStatus
update msg model =
    case msg of
        Slow ->
            { model | locationX = model.locationX + 10 }

        Fast ->
            { model | locationX = model.locationX + 50 }

        Reverse ->
            { model | locationX = model.locationX + 100 }

        Move 68 ->
            { model
                | locationX = model.locationX + 20
                , facing = Right
            }

        Move 65 ->
            { model
                | locationX = model.locationX - 20
                , facing = Left
            }

        Move 87 ->
            { model
                | locationY = model.locationY - 20
                , facing = Up
            }

        Move 83 ->
            { model
                | locationY = model.locationY + 20
                , facing = Down
            }

        Move _ ->
            model


type Drive
    = Slow
    | Fast
    | Reverse
    | Move Int


view : CarStatus -> Html Drive
view model =
    let
        rotation =
            case model.facing of
                Up ->
                    -90

                Down ->
                    90

                Left ->
                    0

                Right ->
                    0

        scale =
            case model.facing of
                Up ->
                    { x = 1, y = -1 }

                Down ->
                    { x = 1, y = 1 }

                Left ->
                    { x = -1, y = 1 }

                Right ->
                    { x = 1, y = 1 }
    in
        Html.div
            [ style
                [ ( "transform", "translateX(" ++ toString model.locationX ++ "px) translateY(" ++ toString model.locationY ++ "px) rotate(" ++ toString rotation ++ "deg) scale(" ++ toString scale.x ++ "," ++ toString scale.y ++ ")" )
                , ( "display", "table" )
                , ( "transition", "transform 0.5s linear" )
                ]
            , onClick Slow
            , onDoubleClick Fast
            , on "keydown" (Json.Decode.map Move keyCode)
            , tabindex 1
            , id "carDiv"
            ]
            [ Svg.svg
                [ Svg.Attributes.height "150"
                , Svg.Attributes.viewBox "0 0 1000 600"
                , Svg.Attributes.width "250"
                ]
                [ Svg.path
                    [ Svg.Attributes.d "M258.298,360.138c-3.532,0-6.396,2.863-6.396,6.396s2.863,6.396,6.396,6.396    c3.533,0,6.396-2.864,6.396-6.396S261.831,360.138,258.298,360.138z M249.185,347.261c0.627-0.297,1.27-0.566,1.929-0.802v-21.958    c-6.421,1.09-12.353,3.615-17.454,7.234L249.185,347.261z M265.481,386.608v21.957c6.421-1.089,12.354-3.615,17.456-7.233    l-15.525-15.526C266.784,386.104,266.141,386.372,265.481,386.608z M258.298,378.287c-1.498,0-2.711,1.214-2.711,2.711    s1.213,2.711,2.711,2.711c1.497,0,2.71-1.214,2.71-2.711S259.795,378.287,258.298,378.287z M277.57,375.646l15.526,15.525    c3.619-5.102,6.145-11.033,7.234-17.455h-21.958C278.137,374.376,277.868,375.019,277.57,375.646z M277.572,357.419    c0.297,0.627,0.563,1.271,0.799,1.931h21.96c-1.09-6.421-3.614-12.354-7.234-17.456L277.572,357.419z M239.026,357.421    L223.5,341.895c-3.619,5.102-6.145,11.034-7.234,17.455h21.958C238.459,358.69,238.729,358.048,239.026,357.421z M270.053,366.532    c0,1.498,1.213,2.711,2.711,2.711c1.497,0,2.71-1.213,2.71-2.711c0-1.497-1.213-2.711-2.71-2.711    C271.266,363.821,270.053,365.035,270.053,366.532z M258.298,354.778c1.497,0,2.71-1.214,2.71-2.711s-1.213-2.711-2.71-2.711    c-1.498,0-2.711,1.214-2.711,2.711S256.801,354.778,258.298,354.778z M282.936,331.736c-5.103-3.619-11.033-6.146-17.455-7.235    v21.958c0.659,0.235,1.301,0.506,1.928,0.803L282.936,331.736z M258.298,296.717c-38.559,0-69.816,31.258-69.816,69.816    s31.258,69.817,69.816,69.817s69.816-31.259,69.816-69.817S296.856,296.717,258.298,296.717z M258.298,416.402    c-27.542,0-49.869-22.327-49.869-49.869s22.327-49.868,49.869-49.868c27.542,0,49.869,22.326,49.869,49.868    S285.84,416.402,258.298,416.402z M233.66,401.331c5.102,3.618,11.033,6.146,17.454,7.234v-21.957    c-0.659-0.236-1.301-0.507-1.928-0.804L233.66,401.331z M246.544,366.532c0-1.497-1.214-2.711-2.711-2.711    s-2.711,1.214-2.711,2.711c0,1.498,1.214,2.711,2.711,2.711S246.544,368.03,246.544,366.532z M238.225,373.717h-21.96    c1.09,6.422,3.614,12.354,7.234,17.456l15.525-15.525C238.727,375.021,238.461,374.376,238.225,373.717z M942.04,354.237    c0-10.764,0-21.53,0-32.295c-0.844-0.422-1.688-0.844-2.533-1.267c-0.211-2.321-0.422-4.644-0.633-6.965    c-1.85-6.894-3.914-15.878-7.599-21.53c-7.04-10.8-19.746-16.062-32.295-21.53c-34.22-14.911-128.362-33.508-156.784-34.175    c0.933,0.086,0.575,0.097-1.525-0.021c0.482,0,0.996,0.009,1.525,0.021c-4.535-0.417-39.679-2.624-54.195-0.723    c-0.132,0.049-0.311,0.07-0.522,0.069c0.17-0.024,0.348-0.047,0.522-0.069c2.252-0.831-9.728-10.068-127.804-70.22    c-2.423-1.234-4.968-1.055-6.965-2.533c-11.97,0.655-20.115,8.844-22.164,14.564c0.72,1.373,32.21,11.714,53.192,26.596    c10.925,7.749,7.229,5.339,15.198,14.564c-3.132,4.728-8.658,19.761,0.633,22.797c-22.161,2.466-7.602-10.908-6.332-23.43    c-6.826-1.675-13.932,23.43-13.932,23.43l-129.813-6.332c0,0-6.135,0.342-7.599-0.634c-3.122-15.811,9.875-22.184,0-46.227    c-1.135-2.762-9.501-7.339-13.932-4.433c-2.211-6.339-6.443,32.725-6.332,50.659c1.079,1.22-126.237-5.699-127.281-6.332    c-0.796-32.773-1.314-27.807-2.533-37.361c2.594,0.677-20.958-7.431-25.963,15.198c-1.295,4.884-2.61,10.718-2.533,17.097    c-15.561-3.881-39.104-1.9-58.258-1.899c-18.324,0.001-35.271-0.843-53.192,3.166c-9.906,2.217-20.008,1.098-29.129,3.166    c-10.905,2.474-22.346,0.825-32.928,3.167c-3.771,0.834-7.951-1.174-10.132,0c-6.623,2.236-7.943,12.816-7.599,22.163    c3.811,3.633-0.434,2.066,5.066,3.166c-0.009,12.716-0.852,29.8-5.066,36.728c-1.003,1.92-12.655,5.614-15.198,6.966    c0.422,9.498,0.844,18.998,1.266,28.496c2.334,7.056,14.616,16.094,2.533,24.063c0.571,4.949,3.71,5.706,5.066,9.499    c2.881,0.635,5.176,1.289,8.865,1.267c0.844,3.165,1.689,6.332,2.533,9.498c7.854,15.831,23.385,9.433,54.458,10.132    c4.221,0.845,12.665,3.8,12.665,3.8h41.185c-0.016-0.632-0.024-1.265-0.024-1.9v-19.63c0-40.568,32.887-73.456,73.456-73.456    c40.568,0,73.455,32.888,73.455,73.456v19.63c0,0.636-0.008,1.269-0.023,1.9h387.222l0.536-24.063    c0-39.169,32.827-70.923,71.996-70.923c39.17,0,70.923,31.754,70.923,70.923v24.063h13.298c0,0,32.508-1.267,48.76-1.9    c13.813-4.133,16.987-8.727,7.899-15.188c-0.152,0.329-0.429,0.183-0.934-0.643c0.324,0.217,0.636,0.431,0.934,0.643    c0.61-1.318-0.81-10.405,2.232-15.207C937.818,354.237,939.93,354.237,942.04,354.237z M799.559,386.608v21.957    c6.422-1.089,12.354-3.615,17.456-7.233l-15.526-15.526C800.861,386.104,800.218,386.372,799.559,386.608z M792.375,360.138    c-3.532,0-6.396,2.863-6.396,6.396s2.863,6.396,6.396,6.396s6.396-2.864,6.396-6.396S795.907,360.138,792.375,360.138z     M783.263,347.261c0.627-0.297,1.27-0.566,1.929-0.802v-21.958c-6.421,1.09-12.353,3.615-17.454,7.234L783.263,347.261z     M792.375,378.287c-1.497,0-2.71,1.214-2.71,2.711s1.213,2.711,2.71,2.711c1.498,0,2.711-1.214,2.711-2.711    S793.873,378.287,792.375,378.287z M792.375,296.717c-38.559,0-69.816,31.258-69.816,69.816s31.258,69.817,69.816,69.817    s69.816-31.259,69.816-69.817S830.934,296.717,792.375,296.717z M792.375,416.402c-27.541,0-49.868-22.327-49.868-49.869    s22.327-49.868,49.868-49.868c27.542,0,49.869,22.326,49.869,49.868S819.917,416.402,792.375,416.402z M811.649,357.419    c0.297,0.627,0.563,1.271,0.799,1.931h21.96c-1.09-6.421-3.614-12.354-7.233-17.456L811.649,357.419z M811.647,375.646    l15.526,15.525c3.619-5.102,6.145-11.033,7.234-17.455H812.45C812.214,374.376,811.945,375.019,811.647,375.646z M804.13,366.532    c0,1.498,1.214,2.711,2.711,2.711s2.711-1.213,2.711-2.711c0-1.497-1.214-2.711-2.711-2.711S804.13,365.035,804.13,366.532z     M792.375,354.778c1.498,0,2.711-1.214,2.711-2.711s-1.213-2.711-2.711-2.711c-1.497,0-2.71,1.214-2.71,2.711    S790.878,354.778,792.375,354.778z M773.104,357.421l-15.526-15.526c-3.619,5.102-6.145,11.034-7.234,17.455h21.958    C772.537,358.69,772.806,358.048,773.104,357.421z M817.013,331.736c-5.102-3.619-11.033-6.146-17.454-7.235v21.958    c0.659,0.235,1.301,0.506,1.929,0.803L817.013,331.736z M772.302,373.717h-21.96c1.091,6.422,3.615,12.354,7.234,17.456    l15.525-15.525C772.805,375.021,772.538,374.376,772.302,373.717z M780.621,366.532c0-1.497-1.214-2.711-2.711-2.711    s-2.711,1.214-2.711,2.711c0,1.498,1.214,2.711,2.711,2.711S780.621,368.03,780.621,366.532z M767.737,401.331    c5.102,3.618,11.033,6.146,17.454,7.234v-21.957c-0.659-0.236-1.301-0.507-1.928-0.804L767.737,401.331z"
                    , Svg.Attributes.fill "#323232"
                    ]
                    []
                ]
            ]
