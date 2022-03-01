FROM rocker/verse:4.1.2

# Add files to container

ADD cache/ /home/rstudio/cache/
ADD data/ /home/rstudio/data/
ADD figures/ /home/rstudio/figures/
ADD position_magnitude.Rmd /home/rstudio/
ADD position_magnitude.Rproj /home/rstudio/

# Add required R packages to container

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

# Add TeX Live to container to allow easy building of PDF

RUN tlmgr update --self 
RUN tlmgr install latexmk
RUN tlmgr install latex-bin
RUN tlmgr install collection-latex
RUN tlmgr install collection-latexrecommended

RUN tlmgr install tcolorbox
RUN tlmgr install environ
RUN tlmgr install trimspaces
RUN tlmgr install xstring
RUN tlmgr install fontaxes
RUN tlmgr install multirow
RUN tlmgr install glossaries
RUN tlmgr install glossaries-extra
RUN tlmgr install mfirstuc
RUN tlmgr install xfor
RUN tlmgr install datatool
RUN tlmgr install substr
RUN tlmgr install adjustbox
RUN tlmgr install collectbox
RUN tlmgr install xwatermark
RUN tlmgr install catoptions
RUN tlmgr install ltxkeys
RUN tlmgr install framed

RUN tlmgr install carlito
RUN tlmgr install charter
RUN tlmgr install gitinfo2

RUN tlmgr install pdfcomment
RUN tlmgr install datetime2
RUN tlmgr install tracklang
RUN tlmgr install marginnote
RUN tlmgr install soulpos
RUN tlmgr install soul
RUN tlmgr install ec
RUN tlmgr install pdftexcmds
RUN tlmgr install footmisc
RUN tlmgr install attachfile
RUN tlmgr install subfiles
RUN tlmgr install import
RUN tlmgr install picture

RUN tlmgr install pdflscape
RUN tlmgr install xcolor
RUN tlmgr install tools
RUN tlmgr install babel

RUN R -e "devtools::install_version('insight', version = '0.15.0', dependencies = T)"
