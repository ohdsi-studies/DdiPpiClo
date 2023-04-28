# use R 4.1.2 as a base image
FROM rocker/rstudio:4.1.2

# install OS dependencies including java and python 3
RUN apt-get update && apt-get install -y openjdk-11-jdk liblzma-dev libbz2-dev libncurses5-dev curl python3-dev python3.venv \
&& R CMD javareconf \
&& rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('rJava', dependencies = TRUE)"

# GitHub Token
ARG GIT_ACCESS_TOKEN
RUN echo "GITHUB_PAT=$GIT_ACCESS_TOKEN" >> /usr/local/lib/R/etc/Renviron 

# install devtools
RUN apt-get update
RUN apt-get install -y \
    build-essential \ 
    libcurl4-gnutls-dev \
    libxml2-dev \
    libssl-dev \
    libgit2-dev \
# install other
    libfontconfig1-dev \
    libcairo2-dev \
    libsodium-dev

RUN R -e "install.packages('devtools')"
RUN R -e "devtools::install_version('dplyr', version = '1.1.0', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('data.table')"
RUN R -e "install.packages('R.utils')"
RUN R -e "install.packages('rvg')"
RUN R -e "install.packages('credentials')"

# install PLP Packages 
RUN R -e 'devtools::install_github("OHDSI/OhdsiRTools",ref="v1.9.1")'
RUN R -e 'devtools::install_github("OHDSI/OhdsiSharing",ref="v0.2.2")'
RUN R -e 'devtools::install_github("OHDSI/DatabaseConnector",ref="v6.1.0")'
RUN R -e 'devtools::install_github("OHDSI/FeatureExtraction",ref="v3.2.0")'
RUN R -e 'devtools::install_github("OHDSI/PatientLevelPrediction",ref="v5.0.4")'
RUN R -e 'devtools::install_github("OHDSI/BigKnn",ref="v1.0.0")'
RUN R -e 'devtools::install_github("OHDSI/Andromeda",ref="v0.6.3")'
RUN R -e 'devtools::install_github("OHDSI/CohortGenerator",ref="v0.4.0")'

# install PLE Packages
RUN R -e 'devtools::install_github("OHDSI/CohortMethod",ref="v5.0.0")'
RUN R -e 'devtools::install_github("OHDSI/MethodEvaluation",ref="v2.2.0")'
RUN R -e 'devtools::install_github("OHDSI/EmpiricalCalibration",ref="v3.0.0")'
RUN R -e 'devtools::install_github("OHDSI/EvidenceSynthesis",ref="v0.2.1")'
# install additional packages
RUN R -e "install.packages('renv')"
RUN R -e "install.packages('lubridate')"

# install shiny and other R packages used by the OHDSI PatientLevelPrediction R package viewPLP() function
# and additional model related R packages
RUN install2.r \
        DT \
        markdown \
        plotly \
        shiny \
        shinycssloaders \
        shinydashboard \
        shinyWidgets \
        xgboost \
&& rm -rf /tmp/download_packages/ /tmp/*.rds

# install JDBC driver
RUN mkdir -p /home/rstudio/temp
RUN mkdir -p /home/rstudio/jdbc
RUN mkdir -p /home/rstudio/analysis
RUN mkdir -p /home/rstudio/result
RUN R -e "DatabaseConnector::downloadJdbcDrivers(dbms = 'postgresql',pathToDriver = '/home/rstudio/jdbc')"
RUN R -e "DatabaseConnector::downloadJdbcDrivers(dbms = 'redshift',pathToDriver = '/home/rstudio/jdbc')"
RUN R -e "DatabaseConnector::downloadJdbcDrivers(dbms = 'sql server',pathToDriver = '/home/rstudio/jdbc')"
RUN R -e "DatabaseConnector::downloadJdbcDrivers(dbms = 'oracle',pathToDriver = '/home/rstudio/jdbc')"
RUN R -e "DatabaseConnector::downloadJdbcDrivers(dbms = 'spark',pathToDriver = '/home/rstudio/jdbc')"