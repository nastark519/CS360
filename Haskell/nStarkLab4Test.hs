{-
    CS 360 lab 4 winter 2018
    Emmet syntax HTML generator.
    Starting code
    Nathan Stark

    This the the testing that is done step by step.
-}

{-
4.2 output once completed:
    *Main> process "strong"
    "<strong></strong>"
    *Main> process "strong."
    "Didn't work try only alpha numeric characters."
    *Main> process "myAw3someE1ementNamE"
    "<myAw3someE1ementNamE></myAw3someE1ementNamE>"
    *Main> process "p"
    "<p></p>"
4.3 output once completed: Note \ are included as they
 will be use as delimiters for the " marks once it is
 executable the \ will be ignored.
    *Main> process ".name"
    "< class=\"name\"></>"
    *Main> process "the.name"
    "<the class=\"name\"></the>"
    *Main> process "span.big"
    "<span class=\"big\"></span>"
    *Main> process "div.col-md-12"
    "<div class=\"col-md-12\"></div>"
4.4 output once completed: Note the \ delimiters will be
 in the next few function returns.
    *Main> process "button#select"
    "<button id=\"select\"></button>"
    *Main> process "form#newuser"
    "<form id=\"newuser\"></form>"
    *Main> process "div#col-md-12"
    "<div id=\"col-md-12\"></div>"
4.5 output once completed: Note that the delimiters \ is not
 found seeing that there are not " needed in the return.
    *Main> process "p>d"
    "<p><d></d></p>"
    *Main> process "div>p"
    "<div><p></p></div>"
    *Main> process "p>span"
    "<p><span></span></p>"
4.6 output once completed: Note that from the ghci the \n will be ignored in the
 function and the output will be all on one line. But run as an exe file it will correct and give a line to each.
    *Main> process "li*3"
    "<li></li>\n<li></li>\n<li></li>\n"
-}