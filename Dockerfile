# Add the rocker/verse Docker image for R 4.1.2

FROM rocker/verse:4.1.2

# Add our files to container

ADD data/ /home/rstudio/data/
ADD figures/ /home/rstudio/figures/
ADD position_magnitude.Rmd /home/rstudio/
ADD position_magnitude.Rproj /home/rstudio/
ADD position_magnitude_cache/ /home/rstudio/position_magnitude_cache/
ADD template.tex /home/rstudio/
ADD makefile /home/rstudio/
ADD vgtc.cls /home/rstudio/
ADD bib_styles/ /home/rstudio/bib_styles/

# Add appropriate versions of required R packages to container

RUN R -e "install.packages('devtools')"

RUN R -e "require(devtools)"

RUN R -e "devtools::install_version('lme4', version = '1.1-27.1', dependencies = T)"
RUN R -e "devtools::install_version('ordinal', version = '2019.12-10', dependencies = T)"
RUN R -e "devtools::install_version('buildmer', version = '2.3', dependencies = T)"
RUN R -e "devtools::install_version('emmeans', version = '1.7.0', dependencies = T)"
RUN R -e "devtools::install_version('patchwork', version = '1.1.1', dependencies = T)"
RUN R -e "devtools::install_version('magick', version = '2.7.3', dependencies = T)"
RUN R -e "devtools::install_version('egg', version = '0.4.5', dependencies = T)"
RUN R -e "devtools::install_version('scales', version = '1.1.1', dependencies = T)"
RUN R -e "devtools::install_version('insight', version = '0.15.0', dependencies = T)"
RUN R -e "devtools::install_version('bookdown', version = '0.24', dependencies = T)"
RUN R -e "devtools::install_version('qwraps2', version = '0.5.2', dependencies = T)"
RUN R -e "devtools::install_github('crsh/papaja')"

