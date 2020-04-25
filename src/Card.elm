module Main exposing (..)

import Element exposing (
    Element, 
    el, 
    text, 
    row, 
    alignRight, 
    fill, 
    width, 
    rgb255, 
    spacing, 
    centerY, 
    centerX, 
    padding, 
    fillPortion, 
    height, 
    paddingXY, 
    alignLeft)

import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input


main = 
    Element.layout []
        rowOfCards
        
type alias Model = { content : String}

init : Model 
init = { content = "" }

type alias CardData = { title: String , subtitle: String}

newCard : CardData
newCard = {title =  "Some title" , subtitle = ""} 


generateCards : Int -> List CardData 
generateCards n = 
    case n of
    0 -> []
    _ -> List.append [ { title = String.fromInt n , subtitle = "Subtitle" }] <| generateCards (n-1) 
    --_ -> let x = generateCards (n-1) in 
    --    List.append [ { title = String.fromInt n , subtitle = "hehe" }] x
    
transformListUI : List CardData -> List (Element msg)
transformListUI xs = List.map card xs  
 
rowOfCards =
    row [ width fill, centerY, spacing 10,padding 10, Border.width 2 ] 
        <| transformListUI 
        <| generateCards 2 

type Msg = Maybe String  

update msg model = 
    case msg of 
    Nothing ->
        { model | content = "" } 
    Just somestring ->
        { model | content = somestring}
         

blue =
    Element.rgb255 238 238 238

purple =
    Element.rgb255 128 0 128
    
myButton =
    Input.button
        [ Background.color blue
        , Element.focused
            [ Background.color purple ]
        ]
        { onPress = Just "clickthedamnbutton"
        , label = text "My Button"
        }

myCard : CardData -> Element msg
myCard cardData =
    el
        [ Background.color (rgb255 255 255 255)
        , Font.color (rgb255 0 0 0)
        , Border.color (rgb255 0 0 0)
        , Border.width 5 
        , padding 30
        , Font.family
            [ Font.external
                { name = "Montserrat"
                , url = "https://fonts.googleapis.com/css?family=Montserrat"
                }
            , Font.sansSerif
           ]
        ]
        (Element.text <| cardData.title ++ cardData.subtitle )
        
        
card : CardData -> Element msg
card cardData = Element.el
    [ Background.color (rgb255 255 255 255)
    , Font.color (rgb255 0 0 0)
    , Border.color (rgb255 0 0 0)
    , Border.width 2 
    , padding 10 
    , width fill
    ]
    (
        Element.column [spacing 10]
        [ 
            headerUI {title = cardData.title, subtitle= cardData.subtitle}
            ,descriptionUI "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
        ]
    )
    

headerUI : { title: String, subtitle: String } -> Element msg 
headerUI titleObj = Element.column
            [
            width fill
            ,Font.alignRight
            ,Border.width 2 
            , padding 10
            , spacing 5
            ]
            [ 
            Element.el 
                [            
                    Font.size 25
                    ,Border.width 2 
                    ,Font.extraBold
                    ,Font.family
                    [ Font.external
                        { name = "Roboto"
                        , url = "https://fonts.googleapis.com/css?family=Roboto"
                        }
                        ,Font.sansSerif
                ]
            ] 
            (Element.text <| titleObj.title ++ " - Title" )
            ,Element.el 
                [
                Font.size 15 
                ,Font.extraLight
                ,Border.width 2
                , width fill
                ] 
                ( Element.text <| titleObj.subtitle )
            ]

descriptionUI : String -> Element msg 
descriptionUI content = Element.paragraph
            [
            Border.width 2 
            ,paddingXY 10 10
            ,Font.size 12 
            ,Font.extraLight 
            ,Font.family
                [ Font.external
                    { name = "Roboto"
                    , url = "https://fonts.googleapis.com/css?family=Roboto"
                    }
                , Font.sansSerif
               ]
            ,Font.alignLeft
            ]
            [
            Element.text <| content 
            ]


 
 
 
 
