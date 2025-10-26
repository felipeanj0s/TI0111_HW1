# Q3 — Bike sharing
suppressPackageStartupMessages({
  library(tidyverse)
  library(lubridate)
  library(readr)
})
dir.create("figs", showWarnings = FALSE)

CSV_PATH <- "HW1_bike_sharing.csv"
if (!file.exists(CSV_PATH)) {
  candidatos <- list.files(".", pattern = "^HW1_bike_sharing\\.csv$", recursive = TRUE, full.names = TRUE)
  if (length(candidatos) >= 1) CSV_PATH <- candidatos[1] else stop("CSV não encontrado.")
}

df <- readr::read_csv(CSV_PATH, show_col_types = FALSE)

# remove colunas sem nome (ex.: ...1)
drop_unnamed <- names(df)[grepl("^\\.\\.\\.", names(df))]
if (length(drop_unnamed) > 0) df <- df[, setdiff(names(df), drop_unnamed)]

# mantém apenas colunas usadas
keep <- intersect(c("dteday","season","weathersit","temp","casual","registered"), names(df))
df <- df[, keep]
stopifnot(all(c("dteday","season","weathersit","temp","casual","registered") %in% names(df)))

# tipos
df <- df |>
  mutate(
    dteday = ymd(dteday),
    season = as.numeric(season),
    weathersit = as.numeric(weathersit),
    temp = as.numeric(temp),
    casual = as.numeric(casual),
    registered = as.numeric(registered)
  )

# resumo período
n_obs  <- nrow(df)
start_date <- min(df$dteday); end_date <- max(df$dteday)
cat("n_obs =", n_obs, " inicio =", as.character(start_date), " fim =", as.character(end_date), "\n")
print(sapply(df, class))

# estatísticas
num_cols <- c("temp","casual","registered")
stats <- df |>
  summarise(across(all_of(num_cols),
                   list(media=mean, mediana=median,
                        q1=~quantile(.x,.25), q3=~quantile(.x,.75)),
                   .names="{.col}_{.fn}"))
print(stats)

# rótulos e derivados
df <- df |>
  mutate(
    season = factor(season, levels = c(1,2,3,4),
                    labels = c("Primavera","Verao","Outono","Inverno")),
    weathersit = factor(weathersit, levels = c(1,2,3,4),
                        labels = c("Ceu limpo","Nublado","Chuva fraca","Chuva forte")),
    total_users = casual + registered,
    temp_real = temp * 41
  )

g1 <- df |> count(season) |> ggplot(aes(season, n)) + geom_col() + ggtitle("Q3 - Observações por Estação")
ggsave("figs/q3_barras_estacao.png", g1, width = 6, height = 4, dpi = 150)

g2 <- df |> count(weathersit) |> ggplot(aes(weathersit, n)) + geom_col() + ggtitle("Q3 - Observações por Clima")
ggsave("figs/q3_barras_clima.png", g2, width = 6, height = 4, dpi = 150)

g3 <- df |> ggplot(aes(dteday, temp_real)) + geom_line() + ggtitle("Q3 - Temperatura Real (°C)")
ggsave("figs/q3_ts_temp.png", g3, width = 7, height = 3.5, dpi = 150)

g4 <- df |> ggplot(aes(dteday, total_users)) + geom_line() + ggtitle("Q3 - Total de Usuários por Dia")
ggsave("figs/q3_ts_total.png", g4, width = 7, height = 3.5, dpi = 150)
