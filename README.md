
---

# TI0111 – Homework 1: Estatística Descritiva


Nome: Felipe Anjos Justino Ribeiro | Matrícula: 563543

Prof: Michela Mulas

---

## Q1 — Emissões

Os valores de emissões foram analisados para obter medidas de tendência central e dispersão.
Script executado: `Q1_emissoes.R`

**Resumo gerado:**

* Média ≈ 24,1
* Mediana ≈ 24,4
* Moda ≈ 15,8
* Amplitude ≈ 15,2
* Variância ≈ 17,7
* Desvio-padrão ≈ 4,21
* Coeficiente de Variação ≈ 17 %
* Proporção > 25 ≈ 45 %

**Gráficos:**

* `figs/q1_hist.png` – Histograma das emissões
* `figs/q1_box.png` – Boxplot das emissões

---

## Q2 — Seleção de Candidatos

Análise de idade, renda e experiência por nacionalidade.
Script executado: `Q2_candidatos.R`

**Resumo geral:**

| Métrica | Idade | Renda | Experiência |
| ------- | ----- | ----- | ----------- |
| Média   | 38,6  | 1,92  | 15,6        |
| Mediana | 38,5  | 1,75  | 15          |
| DP      | 9,93  | 0,71  | 8,7         |

**Renda média por nacionalidade:**

| Nacionalidade | Renda Média | Experiência Média |
| ------------- | ----------- | ----------------- |
| Alemana       | 2,30        | 15                |
| Italiana      | 2,22        | 17,6              |
| Inglesa       | 2,15        | 15,5              |
| Francesa      | 1,80        | 16                |
| Belga         | 1,30        | 13                |
| Espanhola     | 1,23        | 1,3               |

**Correlação (experiência × renda):** ≈ 0,50

**Candidatos selecionados (exp ≥ 10, renda < 2):**
Belga (46 anos), Francesa (51 anos), Italiana (39 e 52 anos)

**Gráficos:**

* `figs/q2_scatter.png` – Experiência × Renda
* `figs/q2_box_idade.png` – Idade por Nacionalidade
* `figs/q2_box_renda.png` – Renda por Nacionalidade

---

## Q3 — Bike Sharing

Análise do conjunto de dados de aluguel de bicicletas (`HW1_bike_sharing.csv`).
Script executado: `Q3_bike_sharing.R`

**Resumo do dataset:**

* Observações = 731
* Período = 2011-01-01 → 2012-12-31
* Variáveis principais → `temp`, `casual`, `registered`

**Estatísticas principais:**

| Variável             | Média | Mediana | 1º Quartil | 3º Quartil |
| -------------------- | ----- | ------- | ---------- | ---------- |
| Temperatura (°C)     | 20,3  | 20,4    | 13,8       | 26,9       |
| Usuários casuais     | 848   | 713     | 316        | 1096       |
| Usuários registrados | 3665  | 3667    | 2542       | 4788       |

**Gráficos:**

* `figs/q3_barras_estacao.png` – Distribuição por estação
* `figs/q3_barras_clima.png` – Distribuição por clima
* `figs/q3_ts_temp.png` – Série temporal da temperatura
* `figs/q3_ts_total.png` – Série temporal do total de usuários

