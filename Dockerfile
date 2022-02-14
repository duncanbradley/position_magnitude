FROM rocker/verse:4.1.2

ADD cache/ /home/rstudio/cache/
ADD data/ /home/rstudio/data/
ADD figures/ /home/rstudio/figures/
ADD position_magnitude.Rmd /home/rstudio/
ADD position_magnitude.Rproj /home/rstudio/

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
RUN R -e "devtools::install_github('crsh/papaja')"




