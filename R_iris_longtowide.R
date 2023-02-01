data(iris)
setRepositories()
.libPaths()

irisl1<-stack(iris[1:4])

spread(iris,key=Species,value=Sepal.Length)

iris_w1 <- pivot_wider(iris,names_from=Species, values_from=Petal.Length)

iris_w2 <- pivot_wider(iris,names_from=Species, values_from=c(Sepal.Length:Petal.Width))
iris_w3 <- pivot_wider(iris,names_from=Species, names_sep='.', values_from=c(Sepal.Length:Petal.Width))
                       
iris_w4 <- pivot_wider(iris,names_from=Petal.Length, values_from=Species)

iris_w1<- 
  gather(key = "flower_att", value = "measurement",
         iris$Species) %>%
  separate(flower_att, into = c("Part","Method")) %>%
  group_by(Species, Part, Method) %>%
  mutate(rn = row_number()) %>% 
  ungroup %>%
  spread(Method,measurement)


reshape(iris, 
        direction = "long",
        varying = list(names(iris)[3:7]),
        v.names = "Value",
        idvar = c("Code", "Country"),
        timevar = "Year",
        times = 1950:1954)


