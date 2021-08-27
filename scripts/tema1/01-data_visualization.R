#########################################################################################################
# Clase 19: Nuestro primer ggplot



#Cargamos la libreria tidyverse
library(tidyverse)


# Registramos las versiones de la libreria utilizada.
# Esto, nos permite ante cualquier cambio de versiÃ³n que No funcione, volver a la primera

# v ggplot2 3.3.3     v purrr   0.3.4
# v tibble  3.1.1     v dplyr   1.0.6
# v tidyr   1.1.3     v stringr 1.4.0
# v readr   1.4.0     v forcats 0.5.1


# Estas son las funciones que, invocadas sin el Nombre del paquete, estarÃ¡n en conflicto 

# x dplyr::filter() masks stats::filter()
# x dplyr::lag()    masks stats::lag()

#Preguntas:
#Los coches con motor mÃ¡s grande consumen mÃ¡s combustible que los coches con motor mÃ¡s pequeÃ±os.
#La relaciÃ³n consumo / tamaÃ±o es lineal? Es no lineal? Es exponencial?
#Es positiva? Es negativa?

View(mpg) # nombre del dataset a utilizar para graficar
?mpg # help(mpg)

# Munufactor: Marca
# Model: Modelo
# displ: cilindrada del motor (litros)
# year: anio
# cyl: cantidad de cilindros.
# trans: Manual o automatico.
# drv: tipo de traccion
# cty
# hwy: numero de millas recorridas en autopista por galÃ³n de combustible (3.785411784 litros)
# fl:
# class: Tipo de vehiculo (auto, compacto, pickup)

ggplot(data = mpg)

mpg %>% ggplot()


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# Plantilla Representacion Grafica con GGPLOT:
# ggplot(data = <dataframe>) +
#   <GEOM_FUNTION>(mapping = aes(x = variable1, y = variable2))  


# geom_point: grafico de nube de puntos
# maapping: describe que variable se mapea en cada eje 
# aes: describe la estetica



#########################################################################################################
# Clase 20: Combinando los mapping esteticos del grafico.

?geom_point

# Color de los puntos: color = f(class): Asignará un color por cada valor de la VARIABLE
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))



# TamaÃ±o de los puntos: size = f(class) (conviene uasr con variable NUMERICA (1, 2, 3, con orden.!!)
# el warninig es xq estamos usando una variable CATEGORICA (blanco, negro, azul, etc)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
 


# Transparencia de los puntos: alpha = f(class)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))



# Forma de los puntos: shape = f(class) (solo permite representar 6 formas de puntos a la vez)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))



# Estetica global (por fuera de la geom_xxx) a nivel de ggplot: 
# La aplicacion global se aplica sobre todos los geom-xxx que componen el ggplot 


# Ej1: A nivel del ggplot
ggplot(data = mpg, mapping = aes(color = "red")) + 
  geom_point(mapping = aes(x = displ, y = hwy))



# Eje2: A nivel del geom_xxx pero por fuera del aes, separado por una coma (,).
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy),
             color = "red")


# color = nombre del color en formato string
# size = tamano del punto en mm
# shape = forma del punto segun numeros desde el 0 al 25 (googlear: ggplot2 Quick Reference Shape)
  
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


# Ejemplo 1: de aplicaciÃ³n de "size"
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), shape = 23, color = "red",fill = "yellow", size = 2)


# Ejemplo 2: En este ejemplo se observa la alineacion de R luego de las comas (,) y parentesis ()
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ,
                           y = hwy),
             shape = 23,
             size = 3, color = "red", 
             fill = 'yellow')


#########################################################################################################
# Clase 21: Problemas comunes cuando empezamos a usar R. 

# Algunas anotaciones menores (de mucho texto..!) en el cuaderno de notas


# PARENTESIS: El itemizado de los parentesis, permite revisar facilmente la falta de alguno de ellos.  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ,
                           y = hwy
                           ),
             shape = 23,
             size = 3, color = "red", 
             fill = "yellow"
             )

# COMILLAS DE TEXTO: Le da lo mismo las comillas como "" o bien las ''

# SIGNO + : El signo mas utilizado para sumar distintas capas debe estar al FINAL DE LINEA..!!

# HELP: Cuando NO funciona alguna función  --> ?NombreDeLaFuncion 

# ERRORES: Es una buena practica, INTERPRETAR los errores de lo contrario, pegarlos en GOOGLE..!!

#########################################################################################################
# Clase 22: FACETS (Subplot)

# Los FACETS permiten hacer un grafico diferente (subplots), representando VARIABLES CATEGORICAS.
# Las variables CATEGORICAS tienen un numero finito de valores (pocos)

# facet_wrap: 
# Permite hacer un subplot (grafiquito independiente) por cada valor de la VARIABLE CATEGORICA..!! 
# facet_wrap(~<VARIABLE_CATEGORICA>). La variable categorica se la simboliza anteponiendole el signo ~.
# La variable CATEGORICA, debe además ser DISCRETA (de pocos valores)

# Observar, existe un subplot (grafiquito) por cada valor de la variable class..!! 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2) # El nrow: determina la cantidad de filas con grafiquitos.!


# Idem arriba pero, en tres filas.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 3)


# facet_grid: 
# Permite hacer subplots por cada "par" de valores de dos VARIABLES CATEGORICAS distintas.!!
# facet_grid(<FORMULA_VARIABLE1>~<FORMULA_VARIABLE2>): Permite cruzar dos variables categoricasentre si.
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~cyl)


ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl) # Facets por "cyl" y graficos orientados en columnas (.~cyl).



ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(cyl~.) # Facets por "cyl" y graficos orientados en filas (cyl~.).



ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv~.) # Facetes por "drv" y graficos orientados en filas (drv~.)

#########################################################################################################
# Clase 23: Diferentes Geometrias


# Diferentes geometricas: se debe cambiar el tipo de GEOM_XXXX

# Geometria: nube de puntos
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))  


# Geometria de linea suavizada
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))


# Geometria de linea suavizada por tipo de traccion (drv)
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))


# Combinacion de Geometrias: Nube de Puntos y Linea Suavizada en funciion de variable tracciion (drv).
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))+ 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv)) 

# Idem anterior con paramentros generales
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(mapping = aes())+ 
  geom_smooth(mapping = aes(linetype = drv))


# ver DISTINTAS GEOMETRIAS EN: "data_visualization.pdf" 


?geom_smooth # Aqui podemos ver la documentacion de las distintas geometrias.


######################################################################################################
# Clase 24: Combinar Graficos y Añadir Dimensiones de Visualizacion


# Grafico Original
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))



# Grafico desagrupado por alguna variable discreta con "group" y "color" e insersion de "show legend" 
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv, color = drv),
              show.legend = T) # Fuerza leyenda por color



# idem anterior sin ecesidad de parametro "group"
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
              show.legend = T)



# Transferencia de parametros Locales a Globales: Se transfieren parametros locales (sobre c/geom_xxx) 
# a parametros globales (sobre el ggplot). Esto permite No repetir parametros en cada geom_xxx


# con repeticion de parametros (a nivel de geom_xxxx)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))


# sin repeticion de parametros (a nivel de gggplot)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # parametroa a nivel global (s/ ggplot) 
  geom_point(mapping = aes(shape = class)) +            # parametros a nivel local (s/geom_xxx)
  geom_smooth(mapping = aes(color = drv))               # parametros a nivel local (s/geom_xxx)
# Ante parametrizaciónes Locales y globales contrapuestas, prevalece la parametrizacion local.


# Asignación de una geometria sobre el valor de una variable en particular (filter):
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "suv"), se = F) # el geom_point se aplica sobre el valor "suv" de class.!
#"se"=F elimina sombreado intervalo de confianza


#########################################################################################################
# Tarea 4: Geometrias con ggplot


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, col = drv)) + 
  geom_point() + 
  geom_smooth( se = F)


#Ejercicio 4: 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))


#Ejercicio 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se=F)


#Ejercicio 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(mapping = aes(group = drv), se = F)


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point() + 
  geom_smooth(mapping = aes(), se = F)


ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point() + 
  geom_smooth(mapping = aes(linetype = drv), se = F)
# En este ejemplo se ve claramente como un parametro local (linetype) predomina sobre el global (group)


#Ejercicio 7: Los parametros x, y y col son parametros gobales (comunes) a todos los puntos y lineas de los geom_xxx
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, col = drv)) + 
  geom_point() + 
  geom_smooth( se = F)


#Ejercicio 8
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(col = drv, shape = drv)) + 
  geom_smooth( se = F)


#Ejercicio 9
ggplot(data = mpg, mapping = aes(x = displ, y = hwy) ) + 
  geom_point(mapping = aes(col = drv, shape = drv)) + 
  geom_smooth(mapping = aes(linetype = drv), se=F)


#Ejercicio 10
ggplot(data = mpg, mapping = aes(x = displ, y = hwy) ) + 
  geom_point(mapping = aes(fill = drv), size = 4, 
             shape = 23, col = "white", stroke = 2) 

##########################################################################################################
# Clase 25: Transformaciones Estadisticas Basicas


# Ejemplo del dataset de diamantes
View(diamonds) # Vista en Editor de Scripts

diamonds # Vista en consola

# Diagrama de BARRAS (Variable Discreta agrupada por categoria)
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut)) # El "stat" por defecto es la funcion "COUNT"

# IMPORTANTE: 
# El estadistico por defecto en este y otros gráficos es el COUNT. Se puede cambiar..!!

?geom_bar


# Diagrama de barras donde se reeemplazo el geom_bar por stat_count (identicos)
ggplot(data = diamonds)+
  stat_count(mapping = aes(x = cut)) # X es variable discreta


##########################################################################################################
# Clase 26: Cambiando las Transformaciones Estadísticas de los los Graficos 


# La funcion TRIBBLE permite generar el DATAFRAME a MANO. 

demo_diamonds <- tribble(
  ~cut,       ~freqs,
  "Fair",       1610,
  "Good",       4906,
  "Very Good", 12082,
  "Premium",   13791,
  "Ideal",     21551
)

view(demo_diamonds)

ggplot(data = demo_diamonds) + 
  geom_bar(mapping = aes(x=cut, y = freqs), 
           stat = "identity")
# A diferencia del ejemplo anterior, en este ejemplo con stat = identity, le estamos diciendo a 
# geom_bar que tome el valor de las variables indicadas en el TRIBBLE.!!



# REPRESENTACION ESTADISTICA: 
# Representacion porcentual de la variable "x", en funcion del total. 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))



# RESUMEN ESTADISTICO: Se aplica un RESUMEN ESTADISTICO sobre la variable filtrada (depth)
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max, 
    fun.y = mean
  )

#########################################################################################################
# Clase 27: Parametro "Position" del grafico


# Repetimos el ggplot original
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut)) # El "stat" por defecto es la funcion "COUNT"


# geom_bar: Colores y formas


# colour: colorea el borde de la barra
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))


# fill: Colorea el interior de la barra s/ la misma variable
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))


# fill: colorea la barra s/ una segunda variable apilada
 ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))


 # idema anterior 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color))


# geom_bar: Positions NO apilados (Identity / dodge / fill)

# Repetimos el ggplot original: Aqui, las barras estan apiladas
ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, fill = clarity))


# position = identity: Aqui las barras No estan apiladas 
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 0.5, position = "identity")


# idem anterior sin relleno (fill=NA)
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")


# position = "fill" : Permite observar las distintas proporciones de la varible de cruce
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(position = "fill")


# position = "dodge" (Una barrita al lado de la otra)
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")


## Volvemos al scatterplot: 

# Grafico de puntos original
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ, y = hwy))
  

# position = "jitter": Evita el over plotting de puntos
# suma ruido aleatorio a los valores de la variable tal que, No se superpongan los puntos
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point( position = "jitter" )


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point( position = "jitter" )



# Idem anterior, utilizando la funcion geom_jitter 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_jitter()



?position_stack # Apila los valores de la variable (suma los valores de y).
?position_identity # No apila los valores de la variable (ej: una barrita detras de otra, tiene poco uso)
?position_fill # Determina el porcentaje que le corresponde a una variable respecto de otra
?position_dodge # Idem identity, No apila valores (ej: Una barrita al lado de otra)
?position_jitter # Permite observar valores que antes, estaben yuxtapuestos en el mismo punto. 


###################################################################################################################
# Clase 28: Cambiando los sistemas de coordenadas
# El sistemas de coordenadas por defecto es el "Cartesiano x - y".   


# coord_flip() -> Permite girar un grafico, cambiando la posicion de los ejes x e y.
ggplot(data = mpg, mapping = aes(x=class, y = hwy)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x=class, y = hwy)) + 
  geom_boxplot() + 
  coord_flip() # gira el grafico



#coord_quickmap() -> configura el aspect ratio para mapas (ver ejemplo abajo)

usa <- map_data("usa") # cargamos el mapa de usa

?map_data # vemos que paises y regiones estan contemplados en map_data

# observar que la representacion de usa esta deforme 
ggplot(usa, aes(long, lat, group = group)) + 
  geom_polygon(fill = "blue", color = "white")

# observar que con "coord_quickmap" corregimos el aspecto visual de la representacion
ggplot(usa, aes(long, lat, group = group)) + 
  geom_polygon(fill = "blue", color = "white") + 
  coord_quickmap() # Ajusta la escala de latitud - longitud para No deformar visuamente la los mapas.


# ideamejemplo anterior con Italia
italy <- map_data("italy")


ggplot(italy, aes(long, lat, group = group)) + 
  geom_polygon(fill = "blue", color = "white")


ggplot(italy, aes(long, lat, group = group)) + 
  geom_polygon(fill = "blue", color = "white") + 
  coord_quickmap()



# Coordenadas Polares: -> coord_polar() 

ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = F, # eliminamos legendas
    width = 1        # ancho de las barras
  ) +
  theme(aspect.ratio = 1) +  # aspecto cuadrado del grafico
  labs(x = NULL, y = NULL ) + # eliminamos los labs de los ejes 
  coord_polar() # coordenadas polares

#########################################################################################################

# Clase 29: Fe de Erratas (dijo Media y se trata de la MEDIANA en ggplot_box)

#########################################################################################################
# Clase 30: La gramatica final de ggplot2


# GRAMATICA DE ggplot2

#ggplot(data = <DATA_FRAME>) +
#  <GEOM_FUNCTION>(
#                  mapping = aes(<MAPPINGS>),
#                  stat = <STAT>,
#                  position = <POSITION>
#                 ) + 
#   <COORDINATE_FUNCTION>() + 
#   <FACET_FUNCTION>()



# TITULOS Y SUBTITULOS en ggplot
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = clarity, fill = clarity, y = ..count..)) +
  coord_polar() +
  facet_wrap(~cut) +
  labs(x=NULL, y = NULL, 
       title = "Ejemplo final de ggplot con JB",
       caption = "Dos variables cruzadas de diamonds",
       subtitle="Aprender ggplot puede ser hasta divertido ;)")


##########################################################################################################


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



