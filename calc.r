REBOL []

calc: make object! [
  init: does [
    comma-activated: false
    current-number: sum: 0 op: 'add
  ]

  init

  display: does [ 
    calc-form/display :current-number :sum 
  ]
  clear: does [
    init
    display
  ]
  operator: func [o] [ 
    equal 
    op: o 
  ]
  carefully: func [block] [
    if error? try [ do block ] [ 
      sum: "ERROR" 
    ]
  ]
  comma: does [
    unless decimal? current-number [
      comma-activated: true
    ]
  ]
  num: func [x] [
    carefully [ 
      temp: to-string current-number
      if comma-activated [ 
        temp: append temp "."
        comma-activated: false
      ]
      temp: append temp to-string x 
      either find temp "." [
        current-number: to-decimal temp
      ] [
        current-number: to-integer temp
      ] 
    ]
    display
  ]
  equal: does [
    carefully [ 
      switch op [
        add      [ sum: sum + current-number ]
        subtract [ sum: sum - current-number ]
        multiply [ sum: sum * current-number ]
        devide   [ sum: sum / current-number ]
      ]
    ]
    op: none current-number: 0 display
  ]
]

calc-form: layout [
  style btn button 35x30
  current-field: field 166 "0" right bold
  sum-field:     field 166 "0" right bold
  btn "C" red     [ calc/clear ]
  across
    btn "/" brown [ calc/operator 'devide ]
    btn "7"       [ calc/num 7 ]
    btn "8"       [ calc/num 8 ]
    btn "9"       [ calc/num 9 ]
  below across
    btn "*" brown [ calc/operator 'multiply ]
    btn "4"       [ calc/num 4 ]
    btn "5"       [ calc/num 5 ]
    btn "6"       [ calc/num 6 ]
  below across
    btn "-" brown [ calc/operator 'subtract ]
    btn "1"       [ calc/num 1 ]
    btn "2"       [ calc/num 2 ]
    btn "3"       [ calc/num 3 ]
  below across
    btn "+" brown [ calc/operator 'add ]
    btn "0"       [ calc/num 0 ]
    btn ","       [ calc/comma ]
    btn "=" red   [ calc/equal ]
]

calc-form: make calc-form [
  display: func [ current result ] [
    current-field/text: to-string current
    sum-field/text: to-string result
    show current-field
    show sum-field
  ]
]

view calc-form
