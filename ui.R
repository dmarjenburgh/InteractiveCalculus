library(shiny)

fun_descr <- HTML("sin(2&pi;x)")
cols <- colours()

shinyUI(pageWithSidebar(
    headerPanel("Learning calculus through interactive examples"),
    sidebarPanel(
        h3("Function parameters"),
        sliderInput('xic', "Tangent x-coordinate",
                    min = -1, max = 1, value = 0, step = 0.1),
        sliderInput('vertx', "Vertical line x-coordinate",
                    min = -1, max = 1, value = 0.5, step = 0.1),
        h3("Colours"),
        selectInput("fcol", "Sinusoid colour", choices = cols, selected = "blue"),
        selectInput("tcol", "Tangent line colour", choices = cols, selected = "purple"),
        selectInput("lcol", "Vertical line colour", choices = cols, selected = "red")
        ),

    mainPanel(
        p("This app displays the graph of the function", fun_descr,
          ", the tangent line to the curve at a certain point on the graph and a vertical line.",
          "You can alter the point of the tangent line and the x-coordinate of the vertical line by using the sliders.",
          "The area between the curve, the tangent line and the vertical line will be shaded and its area is calculated.",
          "In addition, you can play with the colors as you like"),
        p("Optional assignment: Can you reproduce the calculated area using pen and paper for a given set of parameters?"),
        h3("Tangent to the graph of ", fun_descr),
        plotOutput("myPlot"),
        p("The area of the shaded region is", textOutput("area"))
    )
))
