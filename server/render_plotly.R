observeEvent(input$add_my_page, {
  alert("You can download this chart ;) Just point mouse at the top of the chart and pick camera icon. ")
})



output$countries <- renderUI({
  
  
  goal <- My_SDG %>%
    dplyr::filter(Goal == as.numeric(input$goal))
  
  selectInput("countries", 
              label = i18n$t("Choose region"),
              choices = unique(goal$GeoAreaName),
              selected = unique(goal$GeoAreaName)[2], multiple = TRUE)
  
  
})


output$description <- renderUI({
  
  goal <- My_SDG %>%
    dplyr::filter(Goal == as.numeric(input$goal))
  
  selectInput("description", 
              label = i18n$t("Choose topic/indicator"),
              choices = unique(goal$SeriesDescription),
              selected = unique(goal$SeriesDescription)[1])
})

# output$group <- renderUI({
#   
#   goal <- My_SDG %>%
#     dplyr::filter(Goal == as.numeric(input$goal))
#  
#   selectInput("group",
#               label = "Group by:")
#   
# })
# 
# output$group2 <- renderUI({
#   
#   goal <- My_SDG %>% 
#     dplyr::filter(Goal == as.numeric(input$goal))
#   
#   selectInput("group2",
#               label = "Group by:")
# })


output$plot_inter <- renderPlotly({
  
  seria <- My_SDG %>%
    dplyr::filter(Goal == as.numeric(input$goal),
                  GeoAreaName %in% input$countries,
                  SeriesDescription == input$description)
                  #X.Age. == input$group,
                  #X.Sex. == input$group2) %>% group_by(X.Age.)
  
  plotly::plot_ly(data = seria,
                  y = ~Value,
                  x = ~TimePeriod,
                  color = ~GeoAreaName,
                  type = "scatter",
                  mode = "lines") %>%
    layout(title = input$description,
           xaxis=list(range=c(2000,2018),
                      title = "Time"),
           ysxis = list(title = "Value"))
})

output$plot_bar_inter <- renderPlotly({

  seria_2 <- My_SDG %>% 
    dplyr::filter(Goal == as.numeric(input$goal),
                  GeoAreaName %in% input$countries,
                  SeriesDescription == input$description)#
                  #X.Age. == input$group,
                  #X.Sex. == input$group2) %>% group_by(X.Age.)
 
  
  plotly::plot_ly(data = seria_2,
                  x = ~TimePeriod,
                  y = ~Value,
                  color = ~GeoAreaName,
                  type = "bar",
                  mode = "markers") %>% 
    layout(title = input$description,
           xaxis=list(range=c(2000,2018),
                      title = "Time"),
           ysxis = list(title = "Value")
    )
  
})

output$plot_scatter_inter <- renderPlotly({
  
  seria_3 <- My_SDG %>% 
    dplyr::filter(Goal == as.numeric(input$goal), GeoAreaName %in% input$countries, SeriesDescription == input$description)

  plotly::plot_ly(data = seria_3,
                  x = ~TimePeriod,
                  y = ~Value,
                  color = ~GeoAreaName,
                  size = ~Value,
                  type = "scatter",
                  mode = "markers") %>% 
    layout(title = input$description,
           xaxis=list(range=c(2000,2018),
                      title = "Time"),
           ysxis = list(title = "Value")
    )
})

