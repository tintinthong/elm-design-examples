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
    alignLeft,
    image,
    mouseOver)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Tuple 



main = 
    Element.layout []
        rowOfCards
        
type alias Model = { content : String}

init : Model 
init = { content = "" }

type alias CardData = { title: String , subtitle: String, imageUrl: String}

newCard : CardData
newCard = {title =  "Some title" , subtitle = "", imageUrl = Tuple.second imageURLs} 

isEven : Int -> Bool
isEven = (\x -> modBy 2 x == 0)

chooseImage : Int -> String 
chooseImage n = if(isEven n) then Tuple.second imageURLs else Tuple.first imageURLs

imageURLs = (  "https://bit.ly/2VS0QBW","https://bit.ly/3eMl8FA")

generateCards : Int -> List CardData 
generateCards n = 
    case n of
    0 -> []
    _ -> [ { title = String.fromInt n , subtitle = "Subtitle", imageUrl = chooseImage n }] ++ generateCards (n-1) 
    
transformListUI : List CardData -> List (Element msg)
transformListUI xs = List.map card xs     

 
rowOfCards =
    row [ 
    width fill, 
    centerY, 
    spacing 10,
    padding 10, 
    Border.width 2 ] 
        <| transformListUI 
        <| generateCards 2 

type Msg = Maybe String  

update msg model = 
    case msg of 
    Nothing ->
        { model | content = "" } 
    Just somestring ->
        { model | content = somestring}
         

    

        
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
            ,imageUI cardData.imageUrl
            ,descriptionUI "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
            ,buttonUI
            
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
descriptionUI content = 
            Element.textColumn [ 
            width fill  
            ,Border.width 2 
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
            ,spacing 10
            , padding 10 
            ]
            [
            Element.paragraph
            [][Element.text <| content]
            ]

imageUI : String -> Element msg 
imageUI url = image [Border.width 2, width fill] 
            { src = url, description = "Some image"}
 

white =
    Element.rgb255 255 255 255 

lightblue =
    Element.rgb255 205 235 249
    
blue =
    Element.rgb255 69 179 231
    
buttonUI : Element msg 
buttonUI = 
    Input.button
        [ 
        mouseOver [
            Background.color lightblue
        ]
        ,Font.size 16
        ,padding 10
        ,Border.width 2
        ,Background.color white
        , Element.focused
            [ Background.color blue ]
        ]
        { 
        onPress = Nothing 
        , label = text "Click Here"
        }
 
 
