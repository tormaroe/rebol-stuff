REBOL [ Title: "PSWinCom Intouch client" ]

sender: "REBOL"

sendmessage: func[sender receiver message] [
  
]

view layout [
  backcolor white
  style label text 50 bold
  h1 "PSWinCom Intouch"
  across
    label "From:"
    from: field :sender
  below across
    label "To:"
    to: field ""
  below
    message: area 258x70
  below across
    button "Send" 125 [ 
      sendmessage from/text to/text message/text
      message/text: copy "" 
      show message      
    ]
    button "Close" 125 red [ quit ]
]

