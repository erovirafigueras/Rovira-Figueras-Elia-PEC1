# Llibreries utilitzades
library(SummarizedExperiment)
library(readr)
library(dplyr) 

# Fitxers CSV
data_info <- read_csv("DataInfo_S013.csv") # 695 observacions (files) i 4 variables (columnes)
data_values <- read_csv("DataValues_S013.csv") # 39 observacions (files) i 696 variables (columnes)

# Comparativa dels noms de les variables (files de data_info) amb les columnes de data_values
variables_data_info <- data_info$VarName  # Les variables en data_info
variables_data_values <- colnames(data_values)  # Les columnes en data_values

# Identificació de les variables de data_info que no estan en data_values
variables_no_presentes <- setdiff(variables_data_info, variables_data_values)

# Identificació de les variables de data_values que no estan en data_info
variables_extra <- setdiff(variables_data_values, variables_data_info)

# Resultats
variables_no_presentes
variables_extra

data_values <- data_values[, !(colnames(data_values) %in% variables_extra)]

# data_values transposada per al SummarizedExperiment
data_values_t <- t(data_values)

# Assegurar que les files i columnes coincideixen amb les metadades ajustades
rownames(data_values_t) <- data_info$VarName

# Creació de l'objecte SummarizedExperiment
data_values_matrix <- as.matrix(data_values_t)
se <- SummarizedExperiment(
  assays = list(counts = data_values_matrix),
  rowData = data_info
)

print(se)

dim(se)
rownames(se)  # Mostra les variables (files)
colnames(se)  # Mostra les mostres (columnes)
assay(se, "counts")
rowData(se)
summary(assay(se, "counts"))
str(assay(se, "counts")[, 1])
assay(se, "counts") <- apply(assay(se, "counts"), 2, function(x) as.numeric(as.character(x)))
identical(rownames(assay(se)), rownames(assay(se, "counts")))
identical(colnames(assay(se)), colnames(assay(se, "counts")))
assay(se, withDimnames=FALSE) <- apply(assay(se, "counts"), 2, function(x) as.numeric(as.character(x)))
warnings()
# Comprovació de quines columnes tenen valors no numèrics
non_numeric_columns <- sapply(assay(se, "counts"), function(x) any(is.na(as.numeric(as.character(x)))))
non_numeric_columns <- which(non_numeric_columns)
non_numeric_columns
# Mostra els valors no numèrics d'una columna específica (per exemple, la primera columna problemàtica)
assay(se, "counts")[, non_numeric_columns[1]]
# Conversió a numèric, substituint valors no convertibles per NA
assay(se, "counts") <- apply(assay(se, "counts"), 2, function(x) as.numeric(as.character(x)))

# Descripcions gràfiques
hist(assay(se, "counts")[, 1], main="Distribució de la Variable 1", xlab="Valor", ylab="Freqüència")
boxplot(assay(se, "counts"), main="Distribució de les Variables", xlab="Variables", ylab="Valor")
cor_matrix <- cor(assay(se, "counts"), use = "complete.obs")
heatmap(cor_matrix, main="Mapa de calor de la correlació", xlab="Variables", ylab="Variables")

# Creació del directori 
dir.create("Rovira-Figueras-Elia-PEC1")

# Desar l'objecte SummarizedExperiment
save(se, file = "Rovira-Figueras-Elia-PEC1/SummarizedExperiment.Rda")

