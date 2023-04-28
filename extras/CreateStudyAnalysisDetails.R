# Copyright 2023 Observational Health Data Sciences and Informatics
#
# This file is part of DdiPpiClo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Create the analyses details
#'
#' @details
#' This function creates files specifying the analyses that will be performed.
#'
#' @param workFolder        Name of local folder to place results; make sure to use forward slashes
#'                            (/)
#'
#' @export
createAnalysesDetails <- function(workFolder) {
  defaultPrior <- Cyclops::createPrior(priorType = "laplace",
                                       exclude = c(0),
                                       useCrossValidation = TRUE)
  
  defaultControl <- Cyclops::createControl(cvType = "auto",
                                           startingVariance = 0.01,
                                           noiseLevel = "quiet",
                                           tolerance  = 2e-07,
                                           maxIterations = 2500,
                                           cvRepetitions = 10,
                                           seed = 1234)
  
  ####TO DO!!!!####
  excludedCovariateConceptIds <- c(904453,911735,923645,929887,948078,1322184,19039926)
  
  
  defaultCovariateSettings <- FeatureExtraction::createDefaultCovariateSettings(excludedCovariateConceptIds = excludedCovariateConceptIds,
                                                                                addDescendantsToExclude = TRUE)
  defaultCovariateSettings$DemographicsAge <- TRUE #Adding age
  
  # customCovariateSettings <-  FeatureExtraction::createCovariateSettings(useDemographicsGender = TRUE,
  #                                                                        useDemographicsAge = TRUE,
  #                                                                        useDemographicsAgeGroup = TRUE,
  #                                                                        useDemographicsRace = TRUE,
  #                                                                        #useDemographicsEthnicity = FALSE,
  #                                                                        useDemographicsIndexYear = TRUE,
  #                                                                        useDemographicsIndexMonth = FALSE,
  #                                                                        #useDemographicsPriorObservationTime = FALSE,
  #                                                                        #useDemographicsPostObservationTime = FALSE,
  #                                                                        #useDemographicsTimeInCohort = FALSE,
  #                                                                        #useDemographicsIndexYearMonth = FALSE,
  #                                                                        #useConditionOccurrenceAnyTimePrior = FALSE,
  #                                                                        useConditionOccurrenceLongTerm = TRUE,
  #                                                                        #useConditionOccurrenceMediumTerm = TRUE,
  #                                                                        useConditionOccurrenceShortTerm = TRUE,
  #                                                                        #useConditionOccurrencePrimaryInpatientAnyTimePrior = FALSE,
  #                                                                        #useConditionOccurrencePrimaryInpatientLongTerm = FALSE,
  #                                                                        #useConditionOccurrencePrimaryInpatientMediumTerm = TRUE,
  #                                                                        #useConditionOccurrencePrimaryInpatientShortTerm = FALSE,
  #                                                                        #useConditionEraAnyTimePrior = FALSE,
  #                                                                        #useConditionEraLongTerm = FALSE,
  #                                                                        #useConditionEraMediumTerm = FALSE,
  #                                                                        #useConditionEraShortTerm = FALSE,
  #                                                                        #useConditionEraOverlapping = FALSE,
  #                                                                        #useConditionEraStartLongTerm = FALSE,
  #                                                                        #useConditionEraStartMediumTerm = FALSE,
  #                                                                        #useConditionEraStartShortTerm = FALSE,
  #                                                                        useConditionGroupEraAnyTimePrior = TRUE,
  #                                                                        #useConditionGroupEraLongTerm = TRUE,
  #                                                                        #useConditionGroupEraMediumTerm = FALSE,
  #                                                                        #useConditionGroupEraShortTerm = TRUE,
  #                                                                        #useConditionGroupEraOverlapping = FALSE,
  #                                                                        #useConditionGroupEraStartLongTerm = FALSE,
  #                                                                        #useConditionGroupEraStartMediumTerm = FALSE,
  #                                                                        #useConditionGroupEraStartShortTerm = FALSE,
  #                                                                        #useDrugExposureAnyTimePrior = FALSE,
  #                                                                        #useDrugExposureLongTerm = FALSE,
  #                                                                        #useDrugExposureMediumTerm = TRUE,
  #                                                                        useDrugExposureShortTerm = TRUE,
  #                                                                        #useDrugEraAnyTimePrior = FALSE,
  #                                                                        #useDrugEraLongTerm = FALSE,
  #                                                                        #useDrugEraMediumTerm = FALSE,
  #                                                                        #useDrugEraShortTerm = FALSE,
  #                                                                        #useDrugEraOverlapping = FALSE,
  #                                                                        #useDrugEraStartLongTerm = FALSE,
  #                                                                        #useDrugEraStartMediumTerm = FALSE,
  #                                                                        #useDrugEraStartShortTerm = FALSE,
  #                                                                        useDrugGroupEraAnyTimePrior = TRUE,
  #                                                                        useDrugGroupEraLongTerm = TRUE,
  #                                                                        #useDrugGroupEraMediumTerm = FALSE,
  #                                                                        useDrugGroupEraShortTerm = TRUE,
  #                                                                        useDrugGroupEraOverlapping = TRUE,
  #                                                                        #useDrugGroupEraStartLongTerm = FALSE,
  #                                                                        #useDrugGroupEraStartMediumTerm = FALSE,
  #                                                                        #useDrugGroupEraStartShortTerm = FALSE,
  #                                                                        #useProcedureOccurrenceAnyTimePrior = FALSE,
  #                                                                        useProcedureOccurrenceLongTerm = TRUE,
  #                                                                        #useProcedureOccurrenceMediumTerm = FALSE,
  #                                                                        useProcedureOccurrenceShortTerm = TRUE,
  #                                                                        #useDeviceExposureAnyTimePrior = FALSE,
  #                                                                        #useDeviceExposureLongTerm = TRUE,
  #                                                                        #useDeviceExposureMediumTerm = FALSE,
  #                                                                        useDeviceExposureShortTerm = TRUE,
  #                                                                        #useMeasurementAnyTimePrior = FALSE,
  #                                                                        #useMeasurementLongTerm = FALSE,
  #                                                                        #useMeasurementMediumTerm = TRUE,
  #                                                                        useMeasurementShortTerm = TRUE,
  #                                                                        #useMeasurementValueAnyTimePrior = FALSE,
  #                                                                        #useMeasurementValueLongTerm = FALSE,
  #                                                                        #useMeasurementValueMediumTerm = TRUE,
  #                                                                        useMeasurementValueShortTerm = TRUE,
  #                                                                        #useMeasurementRangeGroupAnyTimePrior = FALSE,
  #                                                                        #useMeasurementRangeGroupLongTerm = FALSE,
  #                                                                        #useMeasurementRangeGroupMediumTerm = FALSE,
  #                                                                        #useMeasurementRangeGroupShortTerm = FALSE,
  #                                                                        #useObservationAnyTimePrior = FALSE,
  #                                                                        #useObservationLongTerm = FALSE,
  #                                                                        #useObservationMediumTerm = FALSE,
  #                                                                        #useObservationShortTerm = FALSE,
  #                                                                        #useCharlsonIndex = FALSE,
  #                                                                        #useDcsi = FALSE,
  #                                                                        #useChads2 = FALSE,
  #                                                                        #useChads2Vasc = FALSE,
  #                                                                        #useDistinctConditionCountLongTerm = FALSE,
  #                                                                        #useDistinctConditionCountMediumTerm = FALSE,
  #                                                                        #useDistinctConditionCountShortTerm = FALSE,
  #                                                                        #useDistinctIngredientCountLongTerm = FALSE,
  #                                                                        #useDistinctIngredientCountMediumTerm = FALSE,
  #                                                                        #useDistinctIngredientCountShortTerm = FALSE,
  #                                                                        #useDistinctProcedureCountLongTerm = FALSE,
  #                                                                        #useDistinctProcedureCountMediumTerm = FALSE,
  #                                                                        #useDistinctProcedureCountShortTerm = FALSE,
  #                                                                        #useDistinctMeasurementCountLongTerm = FALSE,
  #                                                                        #useDistinctMeasurementCountMediumTerm = FALSE,
  #                                                                        #useDistinctMeasurementCountShortTerm = FALSE,
  #                                                                        #useDistinctObservationCountLongTerm = FALSE,
  #                                                                        #useDistinctObservationCountMediumTerm = FALSE,
  #                                                                        #useDistinctObservationCountShortTerm = FALSE,
  #                                                                        useVisitCountLongTerm = TRUE,
  #                                                                        #useVisitCountMediumTerm = FALSE,
  #                                                                        #useVisitCountShortTerm = FALSE,
  #                                                                        #useVisitConceptCountLongTerm = FALSE,
  #                                                                        #useVisitConceptCountMediumTerm = FALSE,
  #                                                                        #useVisitConceptCountShortTerm = FALSE,
  #                                                                        longTermStartDays = -365,
  #                                                                        # mediumTermStartDays = -90,
  #                                                                        shortTermStartDays = -30,
  #                                                                        endDays = 0,
  #                                                                        includedCovariateConceptIds = c(),
  #                                                                        addDescendantsToInclude = FALSE,
  #                                                                        excludedCovariateConceptIds = excludedCovariateConceptIds,
  #                                                                        addDescendantsToExclude = TRUE,
  #                                                                        includedCovariateIds = c())
  covariateSettings <- list(defaultCovariateSettings
                            # ,customCovariateSettings
  )
  
  getDbCmDataArgs <- CohortMethod::createGetDbCohortMethodDataArgs(washoutPeriod = 0,
                                                                   firstExposureOnly = FALSE,
                                                                   removeDuplicateSubjects = 'keep first',
                                                                   restrictToCommonPeriod = TRUE,
                                                                   maxCohortSize = 0,
                                                                   covariateSettings = covariateSettings)
  
  ####TAR####
  otPop <- CohortMethod::createCreateStudyPopulationArgs(firstExposureOnly = FALSE,
                                                         removeSubjectsWithPriorOutcome = TRUE,
                                                         washoutPeriod = 0,
                                                         removeDuplicateSubjects = 'keep first',
                                                         minDaysAtRisk = 1,
                                                         riskWindowStart = 1,
                                                         startAnchor = "cohort start",
                                                         riskWindowEnd = 0,
                                                         endAnchor = "cohort end",
                                                         censorAtNewRiskWindow = FALSE)
  
  ittPop <- CohortMethod::createCreateStudyPopulationArgs(removeSubjectsWithPriorOutcome = TRUE,
                                                          firstExposureOnly = FALSE,
                                                          washoutPeriod = 0,
                                                          removeDuplicateSubjects = 'keep first',
                                                          minDaysAtRisk = 1,
                                                          riskWindowStart = 1,
                                                          startAnchor = "cohort start",
                                                          riskWindowEnd = 9999,
                                                          endAnchor = "cohort end",
                                                          censorAtNewRiskWindow = FALSE)
  
  ####Create PS####
  createPsArgsAtt <- CohortMethod::createCreatePsArgs(control = defaultControl,
                                                      errorOnHighCorrelation = FALSE,
                                                      excludeCovariateIds = excludedCovariateConceptIds,
                                                      stopOnError = FALSE,
                                                      estimator = "att" #for the average treatment effect in the treated
  )
  createPsArgsAte <- CohortMethod::createCreatePsArgs(control = defaultControl,
                                                      errorOnHighCorrelation = FALSE,
                                                      excludeCovariateIds = excludedCovariateConceptIds,
                                                      stopOnError = FALSE,
                                                      estimator = "ate" #for the average treatment effect
  )
  
  createPsArgsAto <- CohortMethod::createCreatePsArgs(control = defaultControl,
                                                      errorOnHighCorrelation = FALSE,
                                                      excludeCovariateIds = excludedCovariateConceptIds,
                                                      stopOnError = FALSE,
                                                      estimator = "ato" #ATO for average treatment effect in the overlap population
  )
  
  ####PS model####
  oneToOneMatchOnPsArgs <- CohortMethod::createMatchOnPsArgs(maxRatio = 1,
                                                             caliper = 0.2,
                                                             caliperScale = "standardized logit")
  
  variableRatioMatchOnPsArgs <- CohortMethod::createMatchOnPsArgs(maxRatio = 100,
                                                                  caliper = 0.2,
                                                                  caliperScale = "standardized logit")
  
  stratifyByPsArgs <- CohortMethod::createStratifyByPsArgs(numberOfStrata = 10)
  
  
  
  ####Outcome model####
  #without matching arg
  fitOutcomeModelArgsNoMat <- CohortMethod::createFitOutcomeModelArgs(useCovariates = FALSE,
                                                                      modelType = "cox",
                                                                      stratified = FALSE,
                                                                      prior = defaultPrior,
                                                                      control = defaultControl)
  #conditioning
  fitOutcomeModelArgsCon <- CohortMethod::createFitOutcomeModelArgs(useCovariates = FALSE,
                                                                    modelType = "cox",
                                                                    stratified = TRUE,
                                                                    prior = defaultPrior,
                                                                    control = defaultControl)
  #Without conditioning
  fitOutcomeModelArgsWoCon <- CohortMethod::createFitOutcomeModelArgs(useCovariates = FALSE,
                                                                      modelType = "cox",
                                                                      stratified = FALSE,
                                                                      prior = defaultPrior,
                                                                      control = defaultControl)
  
  #IPTW
  fitOutcomeModelArgsIptw <- CohortMethod::createFitOutcomeModelArgs(useCovariates = FALSE,
                                                                     modelType = "cox",
                                                                     stratified = FALSE,
                                                                     prior = defaultPrior,
                                                                     control = defaultControl,
                                                                     inversePtWeighting = TRUE
  )
  
  #PS overlap weighting
  fitOutcomeModelArgsOW <- CohortMethod::createFitOutcomeModelArgs(useCovariates = FALSE,
                                                                   modelType = "cox",
                                                                   stratified = FALSE,
                                                                   prior = defaultPrior,
                                                                   control = defaultControl,
                                                                   inversePtWeighting = TRUE
  )
  
  #Create trimming args
  trimByPsToEquipoiseArgs <- CohortMethod::createTrimByPsToEquipoiseArgs(bounds = c(0.3,0.7))
  # trimByPsToIptwArgs <- CohortMethod::createTrimByIptwArgs()
  #Stumer et al., 10.1093/aje/kwab041
  
  # Compute Covariate Balance
  computeSharedCovBalArgs <- CohortMethod::createComputeCovariateBalanceArgs()
  computeCovBalArgs <- CohortMethod::createComputeCovariateBalanceArgs(covariateFilter = CohortMethod::getDefaultCmTable1Specifications())
  
  ####CohortMethod Analysis####
  #On-treatment, PS overlap weighting
  # a11 <- CohortMethod::createCmAnalysis(analysisId = 11,
                                        # description = "On-treatment, PS overlap weighting",
                                        # getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        # createStudyPopArgs = otPop,
                                        # createPsArgs = createPsArgsAto,
                                        # computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        # computeCovariateBalanceArgs = computeCovBalArgs,
                                        # fitOutcomeModelArgs = fitOutcomeModelArgsOW)
  
  #On-treatment, 1:1 PS matching
  a12 <- CohortMethod::createCmAnalysis(analysisId = 12,
                                        description = "On-treatment, one-to-one matching",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = otPop,
                                        createPsArgs = createPsArgsAtt,
                                        matchOnPsArgs = oneToOneMatchOnPsArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsWoCon)
  
  
  #On-treatment, variable-ratio PS matching
  a13 <- CohortMethod::createCmAnalysis(analysisId = 13,
                                        description = "On-treatment, variable-ratio matching",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = otPop,
                                        createPsArgs = createPsArgsAtt,
                                        matchOnPsArgs = variableRatioMatchOnPsArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsCon)
  
  #On-treatment, PS stratification
  a14 <- CohortMethod::createCmAnalysis(analysisId = 14,
                                        description = "On-treatment, stratification",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = otPop,
                                        createPsArgs = createPsArgsAtt,
                                        stratifyByPsArgs = stratifyByPsArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsCon)
  
  #On-treatment, IPTW
  a15 <- CohortMethod::createCmAnalysis(analysisId = 15,
                                        description = "On-treatment, IPTW",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = otPop,
                                        createPsArgs = createPsArgsAte,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsIptw)
  
  #On-treatment, Without matching
  a16 <- CohortMethod::createCmAnalysis(analysisId = 16,
                                        description = "On-treatment, Without matching",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = otPop,
                                        createPsArgs = NULL,
                                        stratifyByPsArgs = NULL,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsNoMat)
  #On-treatment trimming by equipoise
  a17 <- CohortMethod::createCmAnalysis(analysisId = 17,
                                        description = "On-treatment, PS overlap weighting within equipoise",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = otPop,
                                        createPsArgs = createPsArgsAto,
                                        trimByPsToEquipoiseArgs = trimByPsToEquipoiseArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsOW)
  
  a18 <- CohortMethod::createCmAnalysis(analysisId = 18,
                                        description = "On-treatment, IPTW within equipoise",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = otPop,
                                        createPsArgs = createPsArgsAte,
                                        trimByPsToEquipoiseArgs = trimByPsToEquipoiseArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsIptw)
  ################
  
  #ITT, PS overlap weighting
  # a31 <- CohortMethod::createCmAnalysis(analysisId = 31,
                                        # description = "ITT, PS overlap weighting",
                                        # getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        # createStudyPopArgs = ittPop,
                                        # createPsArgs = createPsArgsAto,
                                        # computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        # computeCovariateBalanceArgs = computeCovBalArgs,
                                        # fitOutcomeModelArgs = fitOutcomeModelArgsOW)
  
  #ITT, 1:1 PS matching
  a32 <- CohortMethod::createCmAnalysis(analysisId = 32,
                                        description = "ITT, one-to-one matching",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = ittPop,
                                        createPsArgs = createPsArgsAtt,
                                        matchOnPsArgs = oneToOneMatchOnPsArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsWoCon)
  
  
  #ITT, variable-ratio PS matching
  a33 <- CohortMethod::createCmAnalysis(analysisId = 33,
                                        description = "ITT, variable-ratio matching",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = ittPop,
                                        createPsArgs = createPsArgsAtt,
                                        matchOnPsArgs = variableRatioMatchOnPsArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsCon)
  
  #ITT, PS stratification
  a34 <- CohortMethod::createCmAnalysis(analysisId = 34,
                                        description = "ITT, stratification",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = ittPop,
                                        createPsArgs = createPsArgsAtt,
                                        stratifyByPsArgs = stratifyByPsArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsCon)
  
  #ITT, IPTW
  a35 <- CohortMethod::createCmAnalysis(analysisId = 35,
                                        description = "ITT, IPTW",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = ittPop,
                                        createPsArgs = createPsArgsAte,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsIptw)
  
  #ITT, Without matching
  a36 <- CohortMethod::createCmAnalysis(analysisId = 36,
                                        description = "ITT, Without matching",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = ittPop,
                                        createPsArgs = NULL,
                                        stratifyByPsArgs = NULL,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsNoMat)
  #Trimming
  a37 <- CohortMethod::createCmAnalysis(analysisId = 37,
                                        description = "ITT, PS overlap weighting within equipoise",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = ittPop,
                                        createPsArgs = createPsArgsAto,
                                        trimByPsToEquipoiseArgs = trimByPsToEquipoiseArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsOW)
  
  a38 <- CohortMethod::createCmAnalysis(analysisId = 38,
                                        description = "ITT, IPTW within equipoise",
                                        getDbCohortMethodDataArgs = getDbCmDataArgs,
                                        createStudyPopArgs = ittPop,
                                        createPsArgs = createPsArgsAte,
                                        trimByPsToEquipoiseArgs = trimByPsToEquipoiseArgs,
                                        computeSharedCovariateBalanceArgs = computeSharedCovBalArgs,
                                        computeCovariateBalanceArgs = computeCovBalArgs,
                                        fitOutcomeModelArgs = fitOutcomeModelArgsIptw)
  
  
  ####Wrap up####
  cmAnalysisList <- list(a11, 
    a12, a13, a14, a15, a16, a17, 
    a18, 
    a31, 
    a32, a33, a34, a35, a36, a37, 
    a38)
  
  CohortMethod::saveCmAnalysisList(cmAnalysisList, file.path(workFolder, "inst/settings/cmAnalysisList.json"))
}

