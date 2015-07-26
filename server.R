library(shiny)

f <- function (x) { sin(2*pi*x) }
tangentf <- function(x, x0, y0) { 2*pi*cos(2*pi*x0)*(x - x0) + y0 }
integrand <- function(x0, y0, xvert) {
    function(x) {
        abs(f(x) - tangentf(x, x0, y0))
    }
}

shinyServer(
    function(input, output) {

        output$myPlot <- renderPlot({
            xic <- input$xic
            yic <- f(xic)
            x_vert <- input$vertx
            x_lower <- min(xic, x_vert)
            x_upper <- max(xic, x_vert)
            plot(f, xlim = c(-1, 1), ylim = c(-4, 4), main = expression("sin(2"*pi*"x)"), col = input$fcol)
            abline(h = 0)
            abline(v = 0)
            abline(v = input$vertx, col = input$lcol, lwd = 2)

            x_shade <- seq(x_lower, x_upper, length.out = 50)
            polygon(c(x_shade, rev(x_shade)), c(f(x_shade), rev(tangentf(x_shade, xic, yic))),
                    border = NA, col = rgb(0.9, .7, 0, 0.5))
            abline(-xic*2*pi*cos(2*pi*xic)+yic, 2*pi*cos(2*pi*xic), col = input$tcol)
            points(x = xic, y = yic, pch = 16)
        })

        output$area <- renderText({
            xic <- input$xic
            yic <- f(xic)
            x_vert <- input$vertx
            x_lower <- min(xic, x_vert)
            x_upper <- max(xic, x_vert)
            integrate(integrand(xic, yic), x_lower, x_upper)$value
        })
    }
)
