function(input, output, session){
  
 #Structure
  output$structure <- renderPrint(
    #structure of the data
    my_data %>%
      str()
  )
  
#Summary
  output$summary <- renderPrint(
    #summary
    my_data%>%
      summary()
  )
  
#DataTable
  output$dataT <- renderDataTable(
    my_data
  )
  
  
  output$dataNew <- renderDataTable({
    my_data 
    my_dataFilter <- subset(my_data, my_data$Negeri == input$statesMY)
  })
  
  
  #Structure
  output$structure1 <- renderPrint(
    #structure of the data
    my_PWDdata %>%
      str()
  )
  
  #Summary
  output$summary2 <- renderPrint(
    #summary
    my_PWDdata%>%
      summary()
  )
  
  #DataTable
  output$dataPWD <- renderDataTable(
    my_PWDdata
  )
  
  #creating scatter plot
  output$scatter <- renderPlotly({
  
    Newscatter_data%>%
    ggplot(aes(x=`Average num of pwds in 5 years according to state`, y = `Number of ngos according to state` )) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(title = "Relation between number of NGOs and average number of PWDs from 2017-2021",
         x = "Average number of PWDs from 2017-2021",
         y= "Number of NGOs according to state") + 
    theme(plot.title = element_textbox_simple(size=10, halign = 0.5))
  #ggplot()
  })
  
  ### Bar Charts - PWD State wise trend
  output$bar <- renderPlotly({
    bar_data %>% 
      plot_ly() %>% 
      add_bars(x=~State, y=~Total) %>% 
      layout(title = "Total number of PWDs from 2017-2021 according to State",
             xaxis = list(title = "State"),
             yaxis = list(title = "Number of PWDs" ))
  })
  
  ### Bar Charts - NGO State wise trend
  output$NGObar <- renderPlotly({
    barNGO_data %>% 
      plot_ly() %>% 
      add_bars(x=~State, y=~`Number of NGOs`) %>% 
      layout(title = "Total number of NGOs according to State",
             xaxis = list(title = "State"),
             yaxis = list(title = "Number of NGOs" ))
  })
  
  ### Bar Charts - Year wise trend
  output$barYear <- renderPlotly({
    bar_data %>% 
      plot_ly() %>% 
      add_bars(x=~State, y=~get(input$var1)) %>% 
      layout(title = paste("Number of newly registerd PWD in", input$var1),
             xaxis = list(title = "State"),
             yaxis = list(title = paste("Total in", input$var1) ))
  })
  
  # new column for the popup label
 
  NGOlatlong_data <- NGOlatlong_data%>%mutate(
  cntnt = paste("Name:", `Nama Pertubuhan`, "<br/>", "Address:", Alamat, 
                 "<br/>", "State:", Negeri, "<br/>", "Email:", Email, 
                 "<br/>", "Contact:", `No Tel`))
  
  # create the leaflet map  
  
  filteredData <- reactive({
   if(input$statesMY == "All States")
     NGOlatlong_data
    else{
      filter(NGOlatlong_data, c2 == input$statesMY)
    }
  })
  
  pres.dat.sel <- reactive({
    data.subset <- if(input$statesMY == "All States")
      NGOlatlong_data
    else
      NGOlatlong_data[NGOlatlong_data$Negeri == input$statesMY,]
    return(data.subset)
  })
  
  output$newmap <- renderLeaflet({
    leaflet() %>% 
      leaflet(options = leafletOptions(zoomControl = FALSE)) %>%
      htmlwidgets::onRender("function(el, x) {
        L.control.zoom({ position: 'bottomleft' }).addTo(this)
    }") %>% addTiles() %>% addMarkers(data = pres.dat.sel(),popup = ~cntnt) %>%
      addScaleBar() 
  })
  
output$chloromap <- renderLeaflet({
  leaflet() %>%
    leaflet(options = leafletOptions(zoomControl = FALSE)) %>%
    htmlwidgets::onRender("function(el, x) {
        L.control.zoom({ position: 'bottomleft' }).addTo(this)
    }") %>%
    addTiles() %>%
    addPolygons(data = MYstates, color = "white", weight = 1, smoothFactor = 0.5, 
                fillOpacity = 0.8, fillColor = pal(chloro_data$Total), 
                highlight = highlightOptions(
                  weight = 5,
                  color = "#666666",
                 # dashArray = ""
                  fillOpacity = 0.7,
                  bringToFront = TRUE
                ),
                label = lapply(labels, HTML)) %>%
    addLegend(pal =pal,
              values = chloro_data$Total,
              opacity = 0.7,
              position = "topright")
})

MYstates <- readOGR(dsn = "C:/Users/Turjo/Documents/Hamim/stanford-qg469kj1734-shapefile", layer = "qg469kj1734")
bins <- c(0,200,400,600,800,1000,1200,1400,1600,1800)
pal <- colorBin("RdYlBu", domain = chloro_data$Total, bins= bins)
labels <- paste("<p>", chloro_data$State, "</p>",
                "<p>", "Number of PWDs:", chloro_data$Total)


#Structure
output$structure <- renderPrint(
  #structure of the data
  myNew_data %>%
    str()
)

#Summary
output$summary <- renderPrint(
  #summary
  myNew_data%>%
    summary()
)

#DataTable
output$dataNew <- renderDataTable(
  myNew_data
)


output$dataNew <- renderDataTable({
  dat.sel <- subset({
    data.filt <- if(input$statesMY == "All States")
      myNew_data
    else
      myNew_data[myNew_data$Negeri == input$statesMY,]
    return(data.filt)
    
  }) 
 # dat.selFilter <- subset(myNew_data, dat.sel()$Negeri == input$statesMY) 
    
})

#Rendering top 5 ngos in each state

output$head1 <- renderText(
  paste("5 states with the highest number of PWD NGOs in Malaysia")
)

output$top5 <- renderTable({
  barNGO_data %>%
    select(State, `Number of NGOs`) %>%
    arrange(desc(`Number of NGOs`)) %>%
    head(5)
})

output$head2 <- renderText(
  paste("5 states with the lowest number of PWD NGOs in Malaysia")
)

output$low5 <- renderTable({
  barNGO_data %>%
    select(State, `Number of NGOs`) %>%
    arrange(`Number of NGOs`) %>%
    head(5)
})

output$head3 <- renderText(
  paste("5 states with the highest number of PWDs in", input$var1)
)
 
output$head4 <- renderText(
  paste("5 states with the lowest number of PWDs in", input$var1)
)

output$top5PWD <- renderTable({
  
  bar_data %>% 
    select(State, input$var1) %>% 
    arrange(desc(get(input$var1))) %>% 
    head(5)
  
})

# Rendering table with 5 states with low PWD
output$low5PWD <- renderTable({
  
  bar_data %>% 
    select(State, input$var1) %>% 
    arrange(get(input$var1)) %>% 
    head(5)
  
  
})
 
}