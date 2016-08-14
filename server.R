#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw the polar trig graph
server <- shinyServer(function(input, output) {
  
  gcd <- function(p, q) {
    while(q) {
      temp = q
      q = p %% q
      p = temp
    }
    return(p)
  }
  
  is.odd <- function(x) x %% 2 != 0
  
  
  output$polarPlot <- renderPlot({
    
    A <- input$a/gcd(input$a, input$b)
    B <- input$b/gcd(input$a, input$b)
    C <- input$step/gcd(input$step, 180)
    D <- 180/gcd(input$step, 180)
    
    #T is number of steps needed for complete graph
    T <- 2*B*D/gcd(2*B,C)
    if(is.odd(input$a) & is.odd(input$b)) T <- B*D/gcd(B,C)
    
    if (input$gtype=="points") type <- "p"
    if (input$gtype=="lines") type <- "l"
    if (input$gtype=="points & lines") type <- "b"
    if (input$gtype=="histogram-like") type <- "h"
    if (input$gtype=="stair steps") type <- "s" 
    
    xylim <- 1/input$zoom
    
    #equation <- paste0("r=sin((",input$a,"/",input$b,")theta)")
    equation <- bquote(italic(r)==sin( frac(.(input$a),.(input$b))  * theta))
    
    from <- 0;
    to <- T*input$step #in degrees
    theta <- seq(from=from, to=to, by=input$step)
    theta <- theta*pi/180
    r <- sin((A/B)*theta)
    x <- r*cos(theta)
    y <- r*sin(theta)
    par(bg = input$bgcol)
    plot(y~x, type=type, axes=FALSE, lwd=input$lwd, col=input$color, xlab="", ylab="",
         asp=1, lty=input$lty, xlim=c(-xylim, xylim), ylim=c(-xylim, xylim))
    mtext(equation, cex=2, col=input$color, side=3, adj=1)
    mtext("copyright 2016 Ken Meehan", col=input$color, side=1, adj=1)
    
  })
})