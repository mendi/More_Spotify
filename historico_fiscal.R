fiscales <- readxl::read_xlsx("~/downloads/fiscal_historicos.xlsx")

library(ggplot2)
library(dplyr)
library(lubridate)
library("extrafont")

no_interinos <- fiscales %>%
  filter(!is.na(`Días demora`)) 

loadfonts()

ggplot(no_interinos) +
  geom_segment(aes(y=Año, yend=Año, 
                   x=x, xend=xend, col=`Días demora`),
               size=5) +
  geom_point(aes(x=x, y=Año, col=`Días demora`), size=4) +
  geom_point(aes(x=xend, y=Año, col=`Días demora`), size=4) +
  geom_text(aes(x=(x+xend)/2, y=Año, label=paste0(Fiscal, ", ", `Días demora`, " días")), size=3) +
  theme_minimal() +
  xlab("") +
  scale_color_gradient(high="#fc7953", low="#6eb5a1") +
  labs(title="¿Cuánto tiempo ha tardado la CSJ en elegir cada fiscal general?",
       caption = "Fuente: Rodigo Uprimny (@RodrigoUprimny)",
       subtitle = "El tiempo de demora actual es 4.8 veces el promedio histórico desde 1992") +
  scale_y_discrete(limits=no_interinos$Año) +
  xlim(c(-2,max(no_interinos$xend))) +
  annotate("text", x=350, y=2019,
           label="Se toma en cuenta hasta \n el 22 de febrero, cuando la CSJ \n se vuelva a reunir.",
           fontface="italic", size=3, family="Verdana") +
  annotate("curve",x=400, y=2020, xend=380, yend=2024,
           arrow=arrow(length = unit(0.5,"cm")),
           curvature=0.5) +
  annotate("text", x=322, y=1992,
           label="Elaborado por: Hanwen Zhang (@hanwenzhang1982) e Iván Mendivelso", size=3,
           family="Verdana") +
  theme(axis.text.x = element_blank(), 
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        legend.position = "none",
        text = element_text(family = "Verdana"))

ggsave("~/downloads/historico_fiscal.png")  

