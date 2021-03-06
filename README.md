# Absence Makes The Chart Grow Stronger: Blank Space and Axis Range Influence Interpretations of Magnitude in Risk Communication

A set of experiments investigating how manipulating axis limits affects viewers' interpretations of magnitude.

## Data

Data for each experiment (.csv format) can be found in the `data` folder. 

The R script `anonymisation.R` was used for all essential pre-processing: generating anonymised files by removing Prolific ID numbers, and also excluding particpants who failed to meet inclusion criteria (e.g., attention checks). 

### Analysis Within a Fully-Reproducible Computational Environment

We provide resources for re-creating the computational environment (R version, package versions) used for all data wrangling, data visualization, statistical modelling, and reporting. 

First, clone this GitHub repository to your local machine. With Docker running in the background, use a terminal to navigate to the new repository on your local machine and type the following Docker command:

`docker build -t position_magnitude .`

Then, type:

`docker run --rm -p 8787:8787 -e PASSWORD=password position_magnitude`

Once the container is running, open your browser and type `localhost:8787` in the address bar. Enter the username `rstudio` and `password` as the password. This will generate a fully interactive RStudio session, which will be running from the container.

#### Re-Creating the Manuscript

Using RStudio within the Docker container, you may re-create the .pdf version of the manuscript by opening `position_magnitude.Rmd` and pressing the 'Knit' button, which will execute the code used to generate the .pdf. 

**IMPORTANT:** Computationally intensive models have been cached to ameliorate performance. The cache will not be recognised *automatically* when using RStudio within the Docker container. `eval_models` must be set to `FALSE` in line 60 in order to use the cached models. This will prevent `knitr` from executing the code for each model, but will 'lazyload' all cached models so they can be used in manuscript generation. Setting `eval_models` to `TRUE` in line 60 will result in all models being re-generated.

Files used in manuscript generation:

- `position_magnitude.Rmd`: R Markdown script including text and code
- `position_magnitude_cache`: folder containing cached models
- `data`: folder containing collected data
- `images` and `position_magnitude_files` folders for manuscript figures 
- `bibliography.bib` for referencing
- `template.tex`: LaTeX template used for formatting. This requires the following:
  + `bib_styles` folder for bibliography formatting styles
  + `makefile` and `vgtc.cls` for output rendering

Knitting `position_magnitude.Rmd` will output `position_magntude.pdf`. This will take some time as additional LaTeX files will be downloaded within the session.

## Experiment Code and Materials

The experimental code and materials, plus links to run the experiments, are available here:

- Experiment 1: https://gitlab.pavlovia.org/ExPrag_UoM/riskE1
- Experiment 2: https://gitlab.pavlovia.org/ExPrag_UoM/riskE2
- Experiment 3: https://gitlab.pavlovia.org/ExPrag_UoM/riskE3

## Pre-Registrations

Pre-registrations can be found here: https://osf.io/qn46s/
