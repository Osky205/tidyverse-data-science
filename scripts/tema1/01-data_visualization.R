#########################################################################################################
# Clase 19: Nuestro primer ggplot



#Cargamos la libreria tidyverse
library(tidyverse)


# Registramos las versiones de la libreria utilizada.
# Esto, nos permite ante cualquier cambio de versión que No funcione, volver a la primera

# v ggplot2 3.3.3     v purrr   0.3.4
# v tibble  3.1.1     v dplyr   1.0.6
# v tidyr   1.1.3     v stringr 1.4.0
# v readr   1.4.0     v forcats 0.5.1


# Estas son las funciones que, invocadas sin el Nombre del paquete, estarán en conflicto 

# x dplyr::filter() masks stats::filter()
# x dplyr::lag()    masks stats::lag()

#Preguntas:
#Los coches con motor más grande consumen más combustible que los coches con motor más pequeños.
#La relación consumo / tamaño es lineal? Es no lineal? Es exponencial?
#Es positiva? Es negativa?

View(mpg)
?mpg #help(mpg)

# displ: tamaño del motor del coche en litros
# hwy: número de millas recorridas en autopista por galón de combustible (3.785411784 litros)

ggplot(data = mpg)

mpg %>% ggplot()


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))


# ggplot(data = dataframe) +
#   geom_point(mapping = aes(x = variable1, y = variable2))  


# geom_point: grafico de nube de puntos
# maapping: describe que variable se mapea en cada eje 
# aes: describe la estetica



#########################################################################################################
# Clase 20: Combinando los mapping esteticos del grafico.



# Color de los puntos: color = f(class)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))



# Tamaño de los puntos: size = f(class) (conviene que sea numérico)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))



# Transparencia de los puntos: alpha = f(class)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))




# Forma de los puntos: shape f(class) (solo permite representar 6 formas de puntos a la vez)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))



# Elección manual de estéticas global (por fuera del mapping)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "red")

# color = nombre del color en formato string
# size = tamaño del punto en mm
# shape = forma del punto según números desde el 0 al 25 (googlear: ggplot2 Quick Reference Shape)
  
  # 0 - 14: son formas huecas y por tanto solo se le puede cambiar el color
  # 15- 20: son formas rellenas de color, por tanto se le puede cambiar el color
  # 21 - 25: son formas con borde y relleno, y se les puede cambiar el color (borde) y el fill (relleno)


# Google -> ggplot2 Quick Reference Shape: codigo con los numeros de los distintos shape.
d=data.frame(p=c(0:25,32:127))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)

# Ejemplo 1: de aplicación de "size"
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), shape=23, color="red",fill="yellow", size=3)

# Ejemplo 2: En este ejemplo se observa la alineación de R luego de las comas (,) y parentesis ()
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ,
                           y = hwy
                           ),
             shape = 23,
             size = 10, color = "red", 
             fill = 'yellow'
             )

#########################################################################################################
# Clase 21: Problemas comunes cuando empezamos a usar R. 
# Algunas anotaciones menores (de mucho texto..!) en el cuaderno de notas

#########################################################################################################
# Clase 22: Los facets de ggplot 

# Los facets permiten hacer diferentes subplots (graficos).
# Se utiizan con variables categoricas (numero finito de valores)


# facet_wrap(~ <FORMULA_VARIABLE>): Permite hacer un subplot (grafico) por cada valor de la variable
#                                   La variable debe ser discreta
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2) # nrow: cantidad de filas con gráfiquitos.!



ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~displ, nrow = 3)



# facet_grid(<FORMULA_VARIABLE1>~<FORMULA_VARIABLE2>): Permite cruzar dos variables entre si.
#                                                      Un grafico por cada combinacion de las variables 
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~cyl)



ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl) # Facets por "cyl" y graficos orientados en columnas (.~cyl).



ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(cyl~.) # Facets por "cyl" y graficos orientados en filas (cyl~.).



ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.) # Facetes por "drv" y graficos orientados en filas (drv~.)

#########################################################################################################
# Clase 23: EMPEZAR DESDE AQUI..!!!!!!!!!!!!!!



#Diferentes geometrías
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y =hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x=displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype = drv))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, color = drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype = drv, color = drv))

?geom_smooth


ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x=displ, y=hwy, group = drv, color = drv),
              show.legend = T)

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(shape = class)) + 
  geom_smooth(mapping = aes(color = drv))


ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "suv"), se = F)

ggplot(data = mpg, mapping = aes(x=displ, y = hwy,color = drv)) + 
  geom_point() + 
  geom_smooth( se = F)


#Ejercicio 4
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y = hwy)) + 
  geom_smooth(mapping = aes(x=displ, y = hwy))

#Ejercicio 5
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se=F)

#Ejercicio 6
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(mapping = aes(group=drv), se=F)

#Ejercicio 7
ggplot(data = mpg, mapping = aes(x=displ, y = hwy, col=drv)) + 
  geom_point() + 
  geom_smooth( se=F)

#Ejercicio 8
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(col=drv, shape = drv)) + 
  geom_smooth( se=F)

#Ejercicio 9
ggplot(data = mpg, mapping = aes(x=displ, y = hwy) ) + 
  geom_point(mapping = aes(col=drv, shape = drv)) + 
  geom_smooth(mapping = aes(linetype = drv), se=F)

#Ejercicio 10
ggplot(data = mpg, mapping = aes(x=displ, y = hwy) ) + 
  geom_point(mapping = aes(fill = drv), size = 4, 
             shape = 23, col = "white", stroke = 2) 


## Ejemplo del dataset de diamantes
View(diamonds)

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

?geom_bar

ggplot(data = diamonds)+
  stat_count(mapping = aes(x=cut))


demo_diamonds <- tribble(
  ~cut,       ~freqs,
  "Fair",       1610,
  "Good",       4906,
  "Very Good", 12082,
  "Premium",   13791,
  "Ideal",     21551
)

ggplot(data = demo_diamonds) + 
  geom_bar(mapping = aes(x=cut, y = freqs), 
           stat = "identity")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max, 
    fun.y = median
  )

#Colores y formas de los gráficos


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color))

## position = "identity"
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 0.2, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")


## position = "fill"
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(position = "fill")

## position = "dodge"
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")


## Volvemos al scatterplot
## position = "jitter"
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point( position = "jitter" )

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_jitter()

?position_stack
?position_identity
?position_fill
?position_dodge
?position_jitter


# Sistemas de Coordenadas

#coord_flip() -> cambia los papeles de x e y
ggplot(data = mpg, mapping = aes(x=class, y = hwy)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x=class, y = hwy)) + 
  geom_boxplot() + 
  coord_flip()

#coord_quickmap() -> configura el aspect ratio para mapas

usa <- map_data("usa")

ggplot(usa, aes(long, lat, group = group)) + 
  geom_polygon(fill = "blue", color = "white") + 
  coord_quickmap()

italy <- map_data("italy")

ggplot(italy, aes(long, lat, group = group)) + 
  geom_polygon(fill = "blue", color = "white") + 
  coord_quickmap()

#coord_polar()

ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = F,
    width = 1
  ) +
  theme(aspect.ratio = 1) + 
  labs(x = NULL, y = NULL) + 
  coord_polar()


ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point() + 
  geom_abline() + 
  coord_fixed()

?geom_jitter
?geom_boxplot
?labs
?geom_abline

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color))+ 
  theme(aspect.ratio = 1) + 
  labs(x = NULL, y = NULL) + 
  coord_polar()


# Gramática por capas de ggplot2

#ggplot(data = <DATA_FRAME>) +
#  <GEOM_FUNCTION>(
#                  mapping = aes(<MAPPINGS>),
#                  stat = <STAT>,
#                  position = <POSITION>
#                 ) + 
#   <COORDINATE_FUNCTION>() + 
#   <FACET_FUNCTION>()

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = clarity, fill = clarity, y = ..count..)) +
  coord_polar() +
  facet_wrap(~cut) +
  labs(x=NULL, y = NULL, title = "Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds",
       subtitle="Aprender ggplot puede ser hasta divertido ;)")

