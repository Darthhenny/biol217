#To get this colour profile: Tools --> Global options --> Appearance --> Cobalt
# BASIC COMMANDS -----------------------------------------
$ # Choose on column of a dataframe
c() #add more than one input, data, variables,....
?ggplot
# WORKING DIRECTORY STUFF -------------------------------------------
getwd() # see working directory
set('C:/Path') # change wd
dir.create('data') # create folder
dir.create('data/raw_data') # create folder with a path
## Data Types --------------------------------------------
  #Numeric variable: A Number 
  #Categorical variable: A Categorie
    'Hello World' # Use '' or "" to create a categorical variable (string)
  #Logical operators: When Awnser can be YES, or TRUE

class(x) #Find out the Type of your variable
# Data structure---------------------------------------------
data.frame() #create a data frame (table)

# Data operators ----------------------------
x=2 # '=' stores variable
& # and between two seperate functions
| # or 
# Variables --------------------------------------------
x <- 2+3 # create a variable with '<-'
x <- y <- z <- 5 # can also create multiple at a time
'Hello World' #Use '' or "" to create a categorical variable (string)

# PACKAGES -------------------------------
CRAN #one of the most famous R-package repositories
Bioconductor # A Repo used for more biologica application
install independencies #means install every required other package
install.packages(ggplot2) #install a package
library() #activate software or see if the box in packages is checked
#ggplot2 --------------------------------------
ggplot(data=iris, mapping = aes(Petal.Length, Sepal.Length, shape=Species ,size=Petal.Width, colour=Sepal.Width)) + geom_point()
plot1 <- ggplot() #Save the plot in a variable
plot1 + ggsave()
# Try around with "iris" set------------------
data("iris")
View("iris")
class(iris$Petal.Length)
plot(iris)
boxplot(data=iris, iris$Sepal.Length~iris$Species)
library(ggplot2)
install.packages(ggplot2)
install.packages(c('readxl', 'plotly'))
install.packages("tidyverse")

ggplot(data=iris, mapping = aes(Species, Sepal.Width, colour=Species)) + geom_jitter()
ggplot(data=iris, mapping = aes(Petal.Length, Sepal.Length, shape=Species ,size=Petal.Width, colour=Sepal.Width)) + geom_point()
plot1 <- ggplot(data=iris, mapping = aes(Petal.Length, Sepal.Length, shape=Species ,size=Petal.Width, colour=Sepal.Width)) + geom_point() #Save the plot in a variable
plot1 + ggsave('testplot1.tiff', height=6, width=8, units='in', dpi=300)
plot1 + ggsave('testplot2.tiff', height=6, width=8, units='in', dpi=300, compression='lzw')
spread(iris,  Petal.Width, Species,)
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Length)
hist(iris$Petal.Width)

boxplot(iris$Sepal.Width)

ggplot(data=iris, aes(Species, Petal.Length)) + geom_boxplot()
#------------------------------------------------------
trees<- data.frame(trees)
View(trees)
ggplot(data=trees, mapping=aes(Height, Volume))+geom_boxplot()+ggtitle("Trees Boxplot")+theme(plot.title = element_text(hjust = 0.5), axis.text.y=element_blank())
ggplot(data=trees, mapping=aes(Height, Volume)) + geom_jitter()+ggtitle("Trees Jitterplot")+theme(plot.title = element_text(hjust = 0.5), axis.text.y=element_blank()) 
ggplot(data=trees, mapping=aes(Height, Volume, size=Girth, colour=Girth)) + geom_point()+ggtitle("Trees Pointplot")+theme(plot.title = element_text(hjust = 0.5), axis.text.y=element_blank() )
ggplot(data=trees, mapping=aes(Girth, as.factor(Volume))) + geom_dotplot()+ggtitle("Trees Dotplot")+theme(plot.title = element_text(hjust = 0.5), axis.text.y=element_blank())
ggplot(data=trees, aes(x = Girth, y = Volume, color = Height)) + geom_line() + guides(color = guide_legend(title = "Height")) +ggtitle("Trees Lineplot")+theme(plot.title = element_text(hjust = 0.5), axis.text.y=element_blank())
?facet_wrap

ggplot(data=trees, mapping=aes(Girth, Volume, fill=Height)) + geom_area()+ facet_wrap(~align)
ggplot(data=trees, mapping=aes(Girth, Volume, colour=Height)) + geom_curve(xend=22, yend=80)

plot_ly(data=trees,aes(x=Girth,y=Volume,z=Height, type="scatter3d",  mode="markers", color=Height)) +  geom_point() #braucht plotly

a + facet_wrap(~align)
#-----------------------------------------
setRepositories() #then enter all repo: 1 2 3 4 5 6 7 Enter

install.packages()

# ------------------------------------------------
# Day9
library(readxl)
df <- read_excel("R_heatmap_log2FC.xls", 
                               sheet = "Sheet1")


ggplot(df, aes(seq_type,name, fill=log2fold_change))+geom_tile() +
  scale_fill_gradient(low='#de3163', high='black') +
  theme_linedraw() + 
  labs( x = "Sequence type", y = "Gennames") +
  guides(fill=guide_legend(title="Log to fold change")) +
  ggtitle("Novel gene names") +
  theme(plot.title = element_text(hjust = 0.5))


df_identifier<-read_excel("R_heatmap_identifier.xls", 
           sheet = "Sheet1")
df_identifier2<-tidyr::gather(iris, key='Identifier', value='log2FC')

data("iris")
iris_long<-tidyr::gather(iris, key='Species', value='log2FC')

ggplot(df_identifier, aes(method,Identifier, fill=log2FC))+geom_tile() +
  scale_fill_gradient(low='blue', high='white',) +
  theme_linedraw() + 
  labs( x = "mRNA", y = "Identifier") +
  guides(fill=guide_legend(title="Log2FC")) +
  ggtitle("Novel genes identifier") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.y=element_blank() )



