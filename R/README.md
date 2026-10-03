# 🧬 Clinical Trial Survival Analysis of Adjuvant Chemotherapy Using R

> **A practical survival-analysis project using R and the `survival` package**

![R](https://img.shields.io/badge/R-Statistics-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Survival Analysis](https://img.shields.io/badge/Method-Survival%20Analysis-0F766E?style=for-the-badge)
![Clinical Trial](https://img.shields.io/badge/Domain-Clinical%20Trial-7C3AED?style=for-the-badge)

---

## 📌 Project Overview

This project demonstrates a survival-analysis workflow using the **`colon` dataset** available in R's `survival` package.

The analysis focuses on **time to recurrence** after treatment and compares recurrence-free survival across treatment groups while considering selected patient characteristics.

### 🎯 Main Objective

> **To study time to cancer recurrence and its association with treatment and selected patient characteristics using survival-analysis methods in R.**

---

## 🖼️ Project Poster

```text
╔══════════════════════════════════════════════════════════════════════╗
║       🧬 CLINICAL TRIAL SURVIVAL ANALYSIS USING R                  ║
║                                                                      ║
║              TIME TO RECURRENCE • CENSORING • HAZARD                ║
║                                                                      ║
║   Clinical Trial Data                                                ║
║          │                                                           ║
║          ▼                                                           ║
║   ┌──────────────────────┐                                           ║
║   │  DATA PREPARATION    │                                           ║
║   │  etype = 1           │                                           ║
║   │  recurrence outcome   │                                           ║
║   └──────────┬───────────┘                                           ║
║              ▼                                                       ║
║   ┌──────────────────────┐                                           ║
║   │ KAPLAN–MEIER         │                                           ║
║   │ Survival Curves      │                                           ║
║   └──────────┬───────────┘                                           ║
║              ▼                                                       ║
║   ┌──────────────────────┐                                           ║
║   │ LOG-RANK TEST        │                                           ║
║   │ Curve Comparison     │                                           ║
║   └──────────┬───────────┘                                           ║
║              ▼                                                       ║
║   ┌──────────────────────┐                                           ║
║   │ COX PROPORTIONAL     │                                           ║
║   │ HAZARDS MODEL        │                                           ║
║   └──────────┬───────────┘                                           ║
║              ▼                                                       ║
║   ┌──────────────────────┐                                           ║
║   │ HAZARD RATIOS + CI   │                                           ║
║   │ Treatment / Covariates║                                          ║
║   └──────────┬───────────┘                                           ║
║              ▼                                                       ║
║   ┌──────────────────────┐                                           ║
║   │ PH ASSUMPTION CHECK  │                                           ║
║   │ cox.zph()            │                                           ║
║   └──────────────────────┘                                           ║
║                                                                      ║
║  R • survival • Surv() • survfit() • survdiff() • coxph()           ║
╚══════════════════════════════════════════════════════════════════════╝
```

---

## 🔬 Analysis Flow

```mermaid
flowchart TD
    A[Colon Clinical Trial Dataset] --> B[Understand Variables]
    B --> C[Filter etype = 1<br/>Recurrence]
    C --> D[Select Relevant Variables]
    D --> E[Create Survival Object<br/>Surv time + status]
    E --> F[Kaplan-Meier Analysis]
    F --> G[Compare Treatment Curves]
    G --> H[Log-Rank Test]
    H --> I[Cox Proportional Hazards Model]
    I --> J[Hazard Ratios + 95% CI]
    J --> K[Check PH Assumption<br/>cox.zph()]
    K --> L[Interpret Results]
```

---

## 📊 Dataset & Variables

The project uses the **`colon`** dataset from the R `survival` package.

For the recurrence analysis, the dataset is first restricted to `etype == 1`.

| Variable | Meaning |
|---|---|
| `rx` | Treatment group |
| `time` | Follow-up time for recurrence/censoring |
| `status` | 1 = recurrence observed; 0 = censored |
| `age` | Age at baseline |
| `sex` | Patient sex |
| `nodes` | Number of positive lymph nodes |
| `etype` | Event type; `1` is used for recurrence analysis |

---

## 🧪 Statistical Methods

### 1. Kaplan–Meier Estimation

Estimates recurrence-free survival over time and allows visual comparison of treatment groups.

```r
surv_obj <- Surv(time = recurrence$time,
                 event = recurrence$status)

km_model <- survfit(surv_obj ~ rx, data = recurrence)
plot(km_model)
```

### 2. Log-Rank Test

Tests whether the survival curves differ between treatment groups.

```r
survdiff(Surv(time, status) ~ rx, data = recurrence)
```

### 3. Cox Proportional Hazards Model

Models the association between recurrence hazard and treatment/patient characteristics.

```r
cox_model <- coxph(
  Surv(time, status) ~ rx + age + sex + nodes,
  data = recurrence
)

summary(cox_model)
exp(coef(cox_model))
exp(confint(cox_model))
```

### 4. Proportional Hazards Assumption

```r
ph_test <- cox.zph(cox_model)
ph_test
plot(ph_test)
```

---

## 🧹 Data Preparation

```r
library(survival)
data(colon)

recurrence <- subset(colon, etype == 1)

recurrence <- recurrence[, c(
  "rx", "time", "status", "age", "sex", "nodes"
)]

head(recurrence)
str(recurrence)
summary(recurrence)
```

### Why `etype == 1`?

The original dataset contains records for different event types. For this project, the analysis is specifically focused on **recurrence**, so the recurrence records are selected before modelling.

---

## 🧠 Key Statistical Concepts

### Survival Time

The amount of time a patient is followed until the event occurs or the observation is censored.

### Censoring

If a patient leaves follow-up or reaches the end of observation without a recurrence being observed, the exact recurrence time is unknown. This is represented using `status = 0`.

### Hazard

Hazard describes the instantaneous event rate among patients who are still at risk at a particular time.

### Hazard Ratio

In the Cox model:

```text
HR = exp(β)
```

- `HR = 1` → no estimated difference in hazard
- `HR < 1` → lower estimated hazard relative to the reference
- `HR > 1` → higher estimated hazard relative to the reference

These are **associations**, not automatically causal treatment effects.

---

## 🛠️ R Packages

```r
library(survival)
```

Main functions used:

- `Surv()` — creates a survival object
- `survfit()` — Kaplan–Meier estimation
- `survdiff()` — log-rank test
- `coxph()` — Cox proportional hazards model
- `cox.zph()` — proportional hazards assumption check

---

## 📁 Suggested Repository Structure

```text
clinical-trial-survival-analysis/
│
├── README.md
├── data/
├── R/
│   └── survival_analysis.R
├── figures/
│   ├── kaplan_meier_curve.png
│   └── cox_ph_diagnostics.png
└── report/
    └── survival_analysis_report.pdf
```

---

## 📈 Expected Outputs

The analysis can produce:

1. Kaplan–Meier recurrence-free survival curves
2. Treatment-group survival comparison
3. Log-rank test result
4. Cox regression coefficients
5. Hazard ratios and confidence intervals
6. Proportional-hazards diagnostic results

---

## ⚠️ Interpretation Note

This project demonstrates statistical analysis of clinical-trial survival data. Results should be interpreted in the context of the study design, censoring, model assumptions, confidence intervals, and the variables included in the model.

**Statistical association should not automatically be interpreted as causation.**

---

## 👨‍💻 Author

**Kapil Gunde**  
M.Sc. Statistics | Banaras Hindu University

---

### ⭐ Project Focus

**R • Biostatistics • Clinical Trials • Survival Analysis • Kaplan–Meier • Log-Rank Test • Cox Regression • Hazard Ratios**
