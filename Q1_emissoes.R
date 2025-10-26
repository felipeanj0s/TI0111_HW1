# Q1 — Emissões
suppressPackageStartupMessages({ library(tidyverse) })
dir.create("figs", showWarnings = FALSE)

# Opção A: cole os 80 valores aqui
x <- c(
  # 15.8,22.7,26.8, ...  <-- substitua pelos 80 valores
)

# Opção B: se x estiver vazio, lê de CSV com 80 números em uma única linha
if (length(x) == 0) {
  path_csv <- "Q1_emissoes_valores.csv"
  if (file.exists(path_csv)) {
    x <- scan(path_csv, what = numeric(), sep = ",", quiet = TRUE)
  } else {
    stop("Preencha x OU crie Q1_emissoes_valores.csv com 80 números na primeira linha.")
  }
}

media   <- mean(x); mediana <- median(x)
moda    <- as.numeric(names(sort(table(x), decreasing = TRUE))[1])
ampl    <- diff(range(x)); vari <- var(x); dp <- sd(x); cv <- dp / media
qs <- quantile(x, c(.25,.5,.75)); iqr <- IQR(x)
lim_inf <- qs[1] - 1.5*iqr; lim_sup <- qs[3] + 1.5*iqr
outliers <- x[x < lim_inf | x > lim_sup]
prop_acima_25 <- mean(x > 25)

cat("Q1 resumo\n",
    "n =", length(x), "\n",
    "media =", media, " mediana =", mediana, " moda =", moda, "\n",
    "amplitude =", ampl, " var =", vari, " dp =", dp, " cv =", cv, "\n",
    "Q1/Q2/Q3 =", qs, " IQR =", iqr, "\n",
    "lim_inf =", lim_inf, " lim_sup =", lim_sup, "\n",
    "outliers =", outliers, "\n",
    "prop > 25 =", prop_acima_25, "\n")

p_hist <- ggplot(tibble(x), aes(x)) + geom_histogram(bins = 12) + ggtitle("Q1 - Histograma")
ggsave("figs/q1_hist.png", p_hist, width = 6, height = 4, dpi = 150)

p_box  <- ggplot(tibble(x), aes(y = x)) + geom_boxplot() + ggtitle("Q1 - Boxplot")
ggsave("figs/q1_box.png", p_box, width = 4, height = 4, dpi = 150)
