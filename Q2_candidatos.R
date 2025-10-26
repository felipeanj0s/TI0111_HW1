# Q2 — Seleção de candidatos
suppressPackageStartupMessages({ library(tidyverse) })
dir.create("figs", showWarnings = FALSE)

df <- tribble(
 ~idade, ~nacionalidade, ~renda, ~experiencia,
 28, "Italiana", 2.3,  2,
 34, "Inglesa",  1.6,  8,
 46, "Belga",    1.2, 21,
 26, "Espanhola",0.9,  1,
 37, "Italiana", 2.1, 15,
 29, "Espanhola",1.6,  3,
 51, "Francesa", 1.8, 28,
 31, "Belga",    1.4,  5,
 39, "Italiana", 1.2, 13,
 43, "Italiana", 2.8, 20,
 58, "Italiana", 3.4, 32,
 44, "Inglesa",  2.7, 23,
 25, "Francesa", 1.6,  1,
 23, "Espanhola",1.2,  0,
 52, "Italiana", 1.1, 29,
 42, "Alemana",  2.5, 18,
 48, "Francesa", 2.0, 19,
 33, "Italiana", 1.7,  7,
 38, "Alemana",  2.1, 12,
 46, "Italiana", 3.2, 23
)

res_geral <- df |> summarise(
  idade_media = mean(idade), idade_mediana = median(idade), idade_dp = sd(idade),
  renda_media = mean(renda), renda_mediana = median(renda), renda_dp = sd(renda),
  exp_media   = mean(experiencia), exp_mediana = median(experiencia), exp_dp = sd(experiencia)
)
print(res_geral)

res_nat <- df |> group_by(nacionalidade) |>
  summarise(renda_media = mean(renda), exp_media = mean(experiencia), .groups = "drop") |>
  arrange(desc(renda_media))
print(res_nat)

cor_exp_renda <- cor(df$experiencia, df$renda, method = "pearson")
cat("cor(exp, renda) =", cor_exp_renda, "\n")

g1 <- ggplot(df, aes(experiencia, renda)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Q2 - Experiência vs Renda")
ggsave("figs/q2_scatter.png", g1, width = 6, height = 4, dpi = 150)

g2 <- ggplot(df, aes(nacionalidade, idade)) + geom_boxplot() + ggtitle("Q2 - Idade por Nacionalidade")
ggsave("figs/q2_box_idade.png", g2, width = 6, height = 4, dpi = 150)

g3 <- ggplot(df, aes(nacionalidade, renda)) + geom_boxplot() + ggtitle("Q2 - Renda por Nacionalidade")
ggsave("figs/q2_box_renda.png", g3, width = 6, height = 4, dpi = 150)

selecionados <- df |> filter(experiencia >= 10, renda < 2.0) |> select(nacionalidade, idade)
print(selecionados)
