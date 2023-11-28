DDI between PPIs and clopidogrel (DdiPpiClo)
=============

<img src="https://img.shields.io/badge/Study%20Status-Repo%20Created-lightgray.svg" alt="Study Status: Started">

- Analytics use case(s): **Population-Level Estimation**
- Study type: **Clinical Application**
- Tags: **DrugDrugInteraction, PotonPumInhibitors**
- Study lead: **Seng Chan You, Seung In Seo, Seonji Kim**
- Study lead forums tag: **[SCYou](https://forums.ohdsi.org/u/SCYou)**
- Study start date: **4 July 2022**
- Study end date: 
- Protocol: **https://github.com/ohdsi-studies/DdiPpiClo/tree/master/documents/**
- Publications: 
- Results explorer: 

It is still controversial regarding the interaction between proton pump inhibitors (PPIs) and clopidogrel. Both PPIs and clopidogrel are metabolized by hepatic cytochrome P450 (CYP) enzymes, and in the presence of CYP2C19 inhibition, PPIs could reduce the efficacy of clopidogrel's protective roles in cardiovascular events. Hence, The US Food and Drug Administration (FDA) issued safety announcements between January 2009 and October 2010 warning against concomitant use of clopidogrel and PPIs, especially omeprazole and esomeprazole, due to a potential drug interaction that may attenuate clopidogrel’s antiplatelet activity. After the FDA’s warnings against the use of clopidogrel with strong competitive inhibitor for CYP2C19 (inhibiting PPIs, omeprazole and esomeprazole), treatment with inhibiting PPIs and clopidogrel has continued to decrease since 2010, however, the real-world evidence has not been fully evaluated about whether inhibiting PPIs lead to more severe cardiovascular outcomes compared with weak competitive inhibitor for CYP2C19 (other PPIs, lansoprazole, pantoprazole, rabeprazole, and dexlansoprazole). This study will compare the major adverse cardiovascular events of inhibiting PPIs with other PPIs in patients who receiving clopidogrel. 

Requirements
============

- A database in [Common Data Model version 5](https://ohdsi.github.io/CommonDataModel/) in one of these platforms: SQL Server, Oracle, PostgreSQL, IBM Netezza, Apache Impala, Amazon RedShift, Google BigQuery, Spark, or Microsoft APS.
- R version 4.0.0 or newer
- On Windows: [RTools](http://cran.r-project.org/bin/windows/Rtools/)
- [Java](http://java.com)
- 25 GB of free disk space

How to run
==========
1. Follow [these instructions](https://ohdsi.github.io/Hades/rSetup.html) for seting up your R environment, including RTools and Java. 

2. Open your study package in RStudio. Use the following code to install all the dependencies:

    ```r
    renv::restore()
    ```

3. In RStudio, select 'Build' then 'Install and Restart' to build the package.

   Once installed, you can execute the study by modifying and using the code below. For your convenience, this code is also provided under `extras/CodeToRun.R`:

    ```r
    library(DdiPpiClo)

    # Optional: specify where the temporary files (used by the Andromeda package) will be created:
    options(andromedaTempFolder = "D:/andromedaTemp")
	
    # Maximum number of cores to be used:
    maxCores <- parallel::detectCores()
	
    # Minimum cell count when exporting data:
    minCellCount <- 5
	
    # The folder where the study intermediate and result files will be written:
    outputFolder <- "D:/DdiPpiClo"
	
    # Details for connecting to the server:
    # See ?DatabaseConnector::createConnectionDetails for help
    connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = "sql server",
                                                                server = Sys.getenv("server"),
                                                                user = Sys.getenv("user"),
                                                                password = Sys.getenv("password"),
                                                                pathToDriver = "D:/pathToDriver")
    # The name of the database schema where the CDM data can be found:
    cdmDatabaseSchema <- "cdm_db"

    # The name of the database schema and table where the study-specific cohorts will be instantiated:
    cohortDatabaseSchema <- "scratch.dbo"
    cohortTable <- "ddippicloCohortStudy"

    # Some meta-information that will be used by the export function:
    databaseId <- "DdiPpiClo"
    databaseName <- "DdiPpiClo"
    databaseDescription <- "Drug-drug interaction of PPI and clopidogrel"

    # For some database platforms (e.g. Oracle): define a schema that can be used to emulate temp tables:
    options(sqlRenderTempEmulationSchema = NULL)

    execute(connectionDetails = connectionDetails,
            cdmDatabaseSchema = cdmDatabaseSchema,
            cohortDatabaseSchema = cohortDatabaseSchema,
            cohortTable = cohortTable,
            outputFolder = outputFolder,
            databaseId = databaseId,
            databaseName = databaseName,
            databaseDescription = databaseDescription,
            verifyDependencies = FALSE,
            createCohorts = TRUE,
            synthesizePositiveControls = TRUE,
            runAnalyses = TRUE,
            packageResults = TRUE,
            maxCores = maxCores)
    ```

4. Upload the file ```export/Results_<DatabaseId>.zip``` in the output folder to the study coordinator:

	```r
	uploadResults(outputFolder, privateKeyFileName = "<file>", userName = "<name>")
	```
	
	Where ```<file>``` and ```<name<``` are the credentials provided to you personally by the study coordinator.
		
5. To view the results, use the Shiny app:

	```r
	prepareForEvidenceExplorer("Result_<databaseId>.zip", "/shinyData")
	launchEvidenceExplorer("/shinyData", blind = TRUE)
	```
  
  Note that you can save plots from within the Shiny app. It is possible to view results from more than one database by applying `prepareForEvidenceExplorer` to the Results file from each database, and using the same data folder. Set `blind = FALSE` if you wish to be unblinded to the final results.

License
=======
The DdiPpiClo package is licensed under Apache License 2.0

Development
===========
DdiPpiClo was developed in ATLAS and R Studio.

### Development status

Under development
