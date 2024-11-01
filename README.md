# Rovira-Figueras-Elia-PEC1
Informe elaborat que descriu el procés realitzat, incloent-hi la descàrrega de les dades, la creació del contenidor, l'exploració de les dades i la reposició de les dades en github.

## Descripció del Projecte

Aquest projecte té com a objectiu analitzar un conjunt de dades amb informació mèdica/biològica. Hem creat un objecte `SummarizedExperiment` que integra les dades principals i les metadades per facilitar l'anàlisi estadística i visual de les variables.

Les principals etapes del projecte han estat:
1. Carregar i netejar les dades.
2. Crear el contenidor `SummarizedExperiment`.
3. Realitzar una exploració inicial de les dades amb visualitzacions descriptives.

## Fitxers

- `DataInfo_S013.csv`: Fitxer CSV que conté les metadades de les variables amb els camps:
  - `VarName`: Nom de la variable.
  - `varTpe`: Tipus de variable (ex. integer, character).
  - `Description`: Descripció de la variable.

- `DataValues_S013.csv`: Fitxer CSV que conté les dades principals per a les 39 mostres i 695 variables.

- `SummarizedExperiment.Rda`: Objecte R que conté el conjunt de dades amb les dades principals i metadades integrades en un `SummarizedExperiment`.
