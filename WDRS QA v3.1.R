##----------------------------------------------------------------
##                            libraries 
##----------------------------------------------------------------

if(!require("pacman")) install.packages("pacman")
p_load(tidyverse, lubridate, data.table, readxl, openxlsx, writexl, dplyr)

##----------------------------------------------------------------
##                            setup 
##----------------------------------------------------------------


## Set directory
setwd("//dohfltum13/Confidential/DCHS/CDE/01_Linelists_Cross Coverage/Novel CoV/01 - Epi/01 - Case inv/REDCap QA Specialists/WDRS/QA")

today <- Sys.Date()
mmddyyyy <- toupper(as.character(today, format = '%m-%d-%Y'))

##Query from WDRS
wdrs_conn_wc <- DBI::dbConnect(odbc::odbc(),
                               Driver = "SQL Server Native Client 11.0",
                               Server = "WDRSDBPR, 9799",
                               Database = "WDRS",
                               Trusted_connection = "yes",
                               ApplicationIntent= "ReadOnly")



wdrs <-
  DBI::dbGetQuery(
    wdrs_conn_wc,
    "SELECT CASE_ID, CREATE_DATE,
INVESTIGATION_START_DATE, INVESTIGATION_COMPLETE_DATE, CASE_COMPLETE_DATE, DOH_CICT_INVESTIGATION, 
INVESTIGATOR, INVESTIGATION_STATUS, INVESTIGATION_STATUS_UNABLE_TO_COMPLETE_REASON, DATE_INTERVIEW_ATTEMPT_OUTCOME, DATE_INTERVIEW_ATTEMPT_OUTCOME_UNABLE_TO_REACH_CASECONTACT_SPECIFY,
CICT_DTC_NEEDED, CICT_QA_NOTES, CICT_QA_REVIEWED,
REPORTING_ADDRESS, REPORTING_CITY, REPORTING_STATE, REPORTING_ZIPCODE, ACCOUNTABLE_COUNTY,
LHJ_NOTIFICATION_DATE, 
DOH_CASE_CLASSIFICATION_GENERAL, 
POSITIVE_DEFINING_LAB_DATE_SARS,  
POSITIVE_PCR_LAB_DATE_COVID19, 
POSITIVE_AG_LAB_DATE_COVID19,
OUTBREAK_RELATED,
PHONE_NUMBER, RACE_AGGREGATED, RACE_OTHER_RACE_SPECIFY, RACE_AI_OR_AN, RACE_NH_OR_PI, ETHNICITY, LANGUAGE, LANGUAGE_OTHER_SPECIFY, 
AGE_INTERVIEW, ALTERNATE_CONTACT_AVAILABLE, ALTERNATE_CONTACT_AVAILABLE_TYPE, ALTERNATE_CONTACT_AVAILABLE_TYPE_SPECIFY_RELATIONSHIP,
SEX_ASSIGNED_AT_BIRTH, SEX_ASSIGNED_AT_BIRTH_SPECIFY, SEXUAL_ORIENTATION, SEXUAL_ORIENTATION_SPECIFY,
GENDER_IDENTITY, GENDER_IDENTITY_SPECIFY,
AGE_YEARS,
DATE_INTERVIEW_ATTEMPT, DATE_INTERVIEW_ATTEMPT_OUTCOME, DATE_INTERVIEW_ATTEMPT_OUTCOME_UNABLE_TO_REACH_CASECONTACT_SPECIFY,
ALTERNATE_CONTACT_AVAILABLE,
ALTERNATE_CONTACT_AVAILABLE_TYPE,
ALTERNATE_CONTACT_AVAILABLE_TYPE_PHONE_NUMBER,
ALTERNATE_CONTACT_AVAILABLE_TYPE_SPECIFY_RELATIONSHIP,
ALTERNATIVE_CONTACT_AVIALABLE_TYPE_NAME,
CLINCIAL_QP_NOTES,
COMPLAINANT_ILL, SYMPTOM_ONSET_DATE,
ANY_FEVER_SUBJECTIVE_MEASURED, CHILLS, HEADACHE, MYALGIA, PHARYNGITIS, CDC_N_COV_2019_CONGESTION, COUGH,DIFFICULTY_BREATHING,
DYSPNEA, PNEUMONIA, NAUSEA, VOMITING, DIARRHEA, ABDOMINAL_PAIN, CDC_N_COV_2019_ANOSMIA, CDC_N_COV_2019_DYSGEUSIA_AGEUSIA,
FATIGUE, OTHER_SYMPTOMS, OTHER_SYMPTOMS_SPECIFY,
VACCINE_INFORMATION_AVAILABLE, 
VACCINE_INFORMATION_AVAILABLE_DATE,
VACCINE_INFORMATION_AVAILABLE_ADMINISTERED,
VACCINE_INFORMATION_AVAILABLE_ADMINISTRATION_INFORMATION_SOURCE,
VACCINE_INFORMATION_AVAILABLE_SOURCES_REVIEWED_SPECIFY,
CDC_N_COV_2019_HOSPITALIZED, CDC_N_COV_2019_HOSPITALIZED_FACILITY_NAME, CDC_N_COV_2019_HOSPITALIZED_ADMISSION_DATE,
CDC_N_COV_2019_HOSPITALIZED_DISCHARGE_DATE, CDC_N_COV_2019_HOSPITALIZED_ICU, CDC_N_COV_2019_HOSPITALIZED_MECHANICAL_VENTILATION_INTUBATION_REQUIRED,
CDC_N_COV_2019_HOSPITALIZED_STILL_HOSPITALIZED, DIED_ILLNESS,
 TEN_DAYS_PATIENT_HEALTHCARE_SETTING, TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_NAME_FACILITY,
CDC_N_COV_2019_TEN_DAYS_PATIENT_HEALTHCARE_SETTING_LTCF, CDC_N_COV_2019_TEN_DAYS_PATIENT_HEALTHCARE_SETTING_LTCF_NAME,
CDC_N_COV_2019_TEN_DAYS_PATIENT_HEALTHCARE_SETTING_LTCF_NAME_VISIT, TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE,
TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_END, TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_TYPE_FACILITY,
TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_TYPE_EXPOSURE, TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_REASON_VISIT,
TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_STREET, TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_CITY,
TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_STATE, TEN_DAYS_PATIENT_HEALTHCARE_SETTING_START_DATE_ZIP,
COVID_19_PERMANENT_HOME, COVID_19_SLEEP_BEFORE_ONSET_TEST, 
COVID_19_SLEEP_BEFORE_ONSET_TEST_OTHER_SPECIFY, COVID_19_EMPLOYEER_HOUSING,
PREGNANCY_STATUS, PREGNANCY_STATUS_DIAGNOSIS,
CURRENT_SMOKER, CDC_N_COV_2019_SMOKE_VAPE, DIABETES,
CANCER_DIAGNOSIS_TREATMENT_12_MONTHS_PRIOR_ONSET, CANCER_DIAGNOSIS_TREATMENT_12_MONTHS_PRIOR_ONSET_SPECIFY, 
IMMUNOSUPPRESSIVE_THERAPY_DISEASE, IMMUNOSUPPRESSIVE_THERAPY_DISEASE_SPECIFY, CHRONIC_HEART_DISEASE,
ASTHMA, CHRONIC_LUNG_DISEASE_EG, CHRONIC_LIVER_DISEASE, CHRONIC_KIDNEY_DISEASE,
CURRENT_PRESCRIPTIONS_TREATMENT, HEMODIALYSIS_TIME_ONSET, ANY_UNDERLYING_MEDICAL_CONDITION, ANY_UNDERLYING_MEDICAL_CONDITION_SPECIFY,
 PATIENT_EMPLOYED_STUDENT, 
OCCUPATION,
OCCUPATION_BUSINESS_TYPE,
OCCUPATION_CITY,
OCCUPATION_EMPLOYER,
OCCUPATION_PHONE,
OCCUPATION_STATE,
OCCUPATION_STREET,
OCCUPATION_SUITE,
OCCUPATION_TYPE,
OCCUPATION_ZIP,
PATIENT_STUDENT,
SCHOOL_CITY,
SCHOOL_GRADE_LEVEL,
SCHOOL_NAME,
SCHOOL_PHONE,
SCHOOL_STATE,
SCHOOL_STREET,
SCHOOL_SUITE,
SCHOOL_ZIP,
TEACHERS_NAME,
PUBLIC_SETTING_VISIT_EMPLOYED_VOLUNTEER, 
PUBLIC_SETTING_VISIT_EMPLOYED_VOLUNTEER_DATE,
PUBLIC_SETTING_VISIT_EMPLOYED_VOLUNTEER_END_DATE,
PUBLIC_SETTING_VISIT_EMPLOYED_VOLUNTEER_FACILITY_NAME,
PUBLIC_SETTING_VISIT_EMPLOYED_VOLUNTEER_SETTINGS,
FOURTEEN_DAYS_CONFIRMED_PROBABLE_CORONAVIRUS, FOURTEEN_DAYS_CONFIRMED_PROBABLE_CORONAVIRUS_NAME,
 CARE_COORD_ESSENTIAL_ITEMS,
CARE_COORD_ESSENTIAL_ITEMS_SPECIFY,
CARE_COORD_CONTACT
FROM DD_GCD_COVID_19_FLATTENED
WHERE (INVESTIGATION_COMPLETE_DATE BETWEEN '2023-08-16' AND Dateadd(dd, -1, getdate())
  OR CASE_COMPLETE_DATE BETWEEN '2023-08-16' AND Dateadd(dd, -1, getdate()) )
AND (DOH_CICT_INVESTIGATION IS NOT NULL)
AND (INVESTIGATOR IS NOT NULL)
AND (INVESTIGATION_STATUS = 'Complete')
AND (CICT_DTC_NEEDED IS NULL)
AND (CICT_QA_REVIEWED IS NULL
       OR CICT_QA_REVIEWED = 'Complete')
       AND (DATE_INTERVIEW_ATTEMPT_OUTCOME NOT LIKE '%Partial interview%')
ORDER BY INVESTIGATION_COMPLETE_DATE desc
"
  )

#save a tempory file into your folder, then read it in. (A detour to avoid the merge.date.table error) 
data.table::fwrite(wdrs, file=paste0("Y:/Confidential/DCHS/PHOCIS/Surveillance/DIQA/Development Projects/Faustine/WDRS_TEST.csv"))


min_data_report <- read.csv("Y:/Confidential/DCHS/PHOCIS/Surveillance/DIQA/Development Projects/Faustine/WDRS_TEST.csv")


## Make min_data_report a data table
wdrs <- data.table(min_data_report)

## Change all NULL to NA
wdrs[wdrs == "NULL"] <-NA
wdrs[wdrs == ""] <-NA


## Pull in reference spreadsheets
fips_codes <- read_excel("geographic_codes.xlsx", sheet="County")


## Replace fips codes with county names
fips_working <- fips_codes %>%
  mutate(COUNTYFP = as.numeric(COUNTYFP))%>%
  dplyr::select(COUNTYFP, COUNTY_NAME)

wdrs[, ACCOUNTABLE_COUNTY := gsub("WA-", "", ACCOUNTABLE_COUNTY, ignore.case = TRUE)]
wdrs[, ACCOUNTABLE_COUNTY := as.numeric(ACCOUNTABLE_COUNTY)]
wdrs <- merge(x = wdrs, y = fips_working, 
              by.x = "ACCOUNTABLE_COUNTY", by.y = "COUNTYFP", all.x=TRUE)

wdrs[, ACCOUNTABLE_COUNTY := NULL]
names(wdrs)[names(wdrs) == "COUNTY_NAME"] <- "ACCOUNTABLE_COUNTY"

qa_report<- copy(wdrs)


## NEW COLUMN WITH TEAM NAMES

## Pull in reference spreadsheets
team_name <- read_excel("OSS Roster.xlsx", sheet="OSS Roster")

#table1$val2 <- table2$val2[match(table1$pid, table2$pid)]
#matching team name to Investigator
qa_report$Team <- team_name$Team[match(qa_report$INVESTIGATOR, team_name$Name)]

#move Team column next to Investigator
qa_report <- qa_report %>% relocate(Team, .after = INVESTIGATOR)



##----------------------------------------------------------------
##                         Code variables
##----------------------------------------------------------------


#########ADMIN
#########INV STATUS



coded_vars <- "inv"
qa_report$inv[is.na(qa_report$INVESTIGATOR)] <- "missing investigator |"

coded_vars <- c(coded_vars, "lhj_notif_date")
qa_report$lhj_notif_date[is.na(qa_report$LHJ_NOTIFICATION_DATE)] <- "missing LHJ notification date |"


coded_vars <- c(coded_vars, "inv_start_date")
qa_report$inv_start_date[is.na(qa_report$INVESTIGATION_START_DATE)] <- "missing inv start date |"

coded_vars <- c(coded_vars, "inv_comp_date")
qa_report$inv_comp_date[is.na(qa_report$INVESTIGATION_COMPLETE_DATE)] <- "missing inv complete date |"

coded_vars <- c(coded_vars, "case_comp_date")
qa_report$case_comp_date[is.na(qa_report$CASE_COMPLETE_DATE)] <- "missing case complete date |"

coded_vars <- c(coded_vars, "inv_stat")
#qa_report$inv_stat[is.na(qa_report$INVESTIGATION_STATUS)] <- "missing investigation status |"
qa_report<- qa_report %>% mutate(inv_stat= case_when(INVESTIGATION_STATUS == 'Complete'& 
                                                       !grepl('Complete interview',DATE_INTERVIEW_ATTEMPT_OUTCOME)
                                                     ~ "Inv Stat & Interview Outcome does not match |"))

coded_vars <- c(coded_vars, "inv_stat_UTC_reason")
qa_report <- mutate(qa_report, inv_stat_UTC_reason = as.character(""))
#qa_report$inv_stat_UTC_reason[is.na(qa_report$INVESTIGATION_STATUS_UNABLE_TO_COMPLETE_REASON)] <- "missing unable to complete reason |"

coded_vars <- c(coded_vars, "case_class")
#qa_report$POSITIVE_PCR_LAB_DATE_COVID19 <- parse_date_time(qa_report$POSITIVE_PCR_LAB_DATE_COVID19, "ymd")
#parse_date_time(qa_report$POSITIVE_AG_LAB_DATE_COVID19, "ymd")
qa_report$POSITIVE_PCR_LAB_DATE_COVID19 <- as.Date(qa_report$POSITIVE_PCR_LAB_DATE_COVID19)
qa_report$POSITIVE_AG_LAB_DATE_COVID19 <- as.Date(qa_report$POSITIVE_AG_LAB_DATE_COVID19)

qa_report$diff_days <- difftime(qa_report$POSITIVE_PCR_LAB_DATE_COVID19, qa_report$POSITIVE_AG_LAB_DATE_COVID19, units="days")

qa_report<- qa_report %>% mutate(case_class= case_when((POSITIVE_PCR_LAB_DATE_COVID19 != '2030-01-01' &
                                                          diff_days <= 10 & diff_days >= -10 &
                                                          DOH_CASE_CLASSIFICATION_GENERAL == 'Probable')
                                                       | (POSITIVE_AG_LAB_DATE_COVID19 == '2030-01-01' & 
                                                            DOH_CASE_CLASSIFICATION_GENERAL == 'Probable')
                                                       | (POSITIVE_PCR_LAB_DATE_COVID19 == '2030-01-01' &
                                                            DOH_CASE_CLASSIFICATION_GENERAL == 'Confirmed')
                                                       ~ "Incorrect case classification |",
                                                       is.na(DOH_CASE_CLASSIFICATION_GENERAL) ~ "missing case classification |",
                                                       DOH_CASE_CLASSIFICATION_GENERAL == 'Classification pending'
                                                       | DOH_CASE_CLASSIFICATION_GENERAL == 'Not reportable' ~ "Update case classification |"
))


#case_when(is.na(Price) ~ "NIL", Price >= 500000 & Price <= 900000   ~ "Average", Price > 900000 ~ "High", TRUE ~ "Low"))



coded_vars <- c(coded_vars, "doh_cict_inv")
qa_report$doh_cict_inv[is.na(qa_report$DOH_CICT_INVESTIGATION)] <- "missing DOH CICT investigation required |"




#########ADMIN II 
coded_vars <- c(coded_vars, "addy")
qa_report$addy[is.na(qa_report$REPORTING_ADDRESS) | is.na(qa_report$REPORTING_CITY)|
                 is.na(qa_report$REPORTING_STATE)| is.na(qa_report$REPORTING_ZIPCODE)] <- "missing address |"

coded_vars <- c(coded_vars, "county")
qa_report$county[is.na(qa_report$ACCOUNTABLE_COUNTY)] <- "missing county |"




#########DEMO
coded_vars <- c(coded_vars, "race")
qa_report$race[is.na(qa_report$RACE_AGGREGATED)] <- "missing race |"

coded_vars <- c(coded_vars, "ethnic")
qa_report$ethnic[is.na(qa_report$ETHNICITY)] <- "missing ethnicity |"

coded_vars <- c(coded_vars, "lang")
qa_report$lang[is.na(qa_report$LANGUAGE)] <- "missing language |"

coded_vars <- c(coded_vars, "sogi")
qa_report<- qa_report %>% mutate(sogi= case_when(AGE_YEARS >= 18
                                                 &(ALTERNATE_CONTACT_AVAILABLE == 'No'
                                                    |is.na(qa_report$ALTERNATE_CONTACT_AVAILABLE))
                                                 & (is.na(qa_report$SEXUAL_ORIENTATION)
                                                    | is.na(qa_report$GENDER_IDENTITY)
                                                    | is.na(qa_report$SEX_ASSIGNED_AT_BIRTH))
                                                 ~ "missing SOGI/Sex assigned at birth |"))





#########COMMUNICATIONS
coded_vars <- c(coded_vars, "int_attempt")
qa_report$int_attempt[is.na(qa_report$DATE_INTERVIEW_ATTEMPT)] <- "missing interview attempt date |"

coded_vars <- c(coded_vars, "int_attempt_outcome")
qa_report$int_attempt_outcome[is.na(qa_report$DATE_INTERVIEW_ATTEMPT_OUTCOME)] <- "missing interview attempt outcome |"

coded_vars <- c(coded_vars, "int_attempt_outcome_specify")
qa_report <- mutate(qa_report, int_attempt_outcome_specify = as.character(""))




#########NOTES
coded_vars <- c(coded_vars, "generalnotes")
qa_report$generalnotes[is.na(qa_report$CLINCIAL_QP_NOTES)] <- "missing call notes |"




#########CLINICAL INFO
coded_vars <- c(coded_vars, "clin_info")
qa_report$clin_info[is.na(qa_report$COMPLAINANT_ILL)] <- "missing complainant ever symptomatic |"
# logic needed 
#qa_report <- qa_report[is.na(SYMPTOM_ONSET_DATE), clin_info := "missing complainant ever symptomatic and/or symptom onset date|"]




#########SYMPTOMS
coded_vars <- c(coded_vars, "any_symp")
qa_report$any_symp[is.na(qa_report$ANY_FEVER_SUBJECTIVE_MEASURED)|
                     is.na(qa_report$CHILLS)|
                     is.na(qa_report$HEADACHE)|
                     is.na(qa_report$MYALGIA)|
                     is.na(qa_report$PHARYNGITIS)|
                     is.na(qa_report$CDC_N_COV_2019_CONGESTION)|
                     is.na(qa_report$COUGH)|
                     is.na(qa_report$DIFFICULTY_BREATHING)|
                     is.na(qa_report$DYSPNEA)|
                     is.na(qa_report$PNEUMONIA)|
                     is.na(qa_report$NAUSEA)|
                     is.na(qa_report$VOMITING)|
                     is.na(qa_report$DIARRHEA)|
                     is.na(qa_report$ABDOMINAL_PAIN)|
                     is.na(qa_report$CDC_N_COV_2019_ANOSMIA)|
                     is.na(qa_report$CDC_N_COV_2019_DYSGEUSIA_AGEUSIA)|
                     is.na(qa_report$FATIGUE)|
                     is.na(qa_report$OTHER_SYMPTOMS)] <- "missing symptom(s) |"
# other symptoms specify qa_report <- qa_report[is.na(any_symp), any_symp := "missing symptom(s) |"]




######### VACCINATION
coded_vars <- c(coded_vars, "vacc")
qa_report<- qa_report %>% mutate(vacc= case_when(
  is.na(VACCINE_INFORMATION_AVAILABLE) ~ "missing vaccination info available |",
  VACCINE_INFORMATION_AVAILABLE == 'Yes'
  & (is.na(qa_report$VACCINE_INFORMATION_AVAILABLE_DATE)
     | is.na(qa_report$VACCINE_INFORMATION_AVAILABLE_ADMINISTERED)
     | is.na(qa_report$VACCINE_INFORMATION_AVAILABLE_ADMINISTRATION_INFORMATION_SOURCE)
     | VACCINE_INFORMATION_AVAILABLE_ADMINISTRATION_INFORMATION_SOURCE == ', '
     | grepl(', , ',VACCINE_INFORMATION_AVAILABLE_ADMINISTRATION_INFORMATION_SOURCE))
  ~ "missing vaccine details |",
  VACCINE_INFORMATION_AVAILABLE_ADMINISTERED == 'Other'
  & (is.na(qa_report$VACCINE_INFORMATION_AVAILABLE_SOURCES_REVIEWED_SPECIFY))
  ~ "missing vaccine type, specify |"
))



######### HOSPITALIZATION
coded_vars <- c(coded_vars, "hosp")
qa_report$hosp[is.na(qa_report$CDC_N_COV_2019_HOSPITALIZED)] <- "missing hospitalized for illness |"

coded_vars <- c(coded_vars, "hosp_info")
qa_report <- mutate(qa_report, hosp_info = as.character(""))
# qa_report$hosp_info[is.na(qa_report$CDC_N_COV_2019_HOSPITALIZED_FACILITY_NAME)|
#                      is.na(qa_report$CDC_N_COV_2019_HOSPITALIZED_ADMISSION_DATE)|
#                      is.na(qa_report$CDC_N_COV_2019_HOSPITALIZED_DISCHARGE_DATE)|
#                      is.na(qa_report$CDC_N_COV_2019_HOSPITALIZED_ICU)|
#                      is.na(qa_report$CDC_N_COV_2019_HOSPITALIZED_MECHANICAL_VENTILATION_INTUBATION_REQUIRED)|
#                      is.na(qa_report$CDC_N_COV_2019_HOSPITALIZED_STILL_HOSPITALIZED)] <- "missing hospitalized info |"

coded_vars <- c(coded_vars, "hosp_died")
qa_report$hosp_died[is.na(qa_report$DIED_ILLNESS)] <- "missing died of illness |"




######### RISK & RESPONSE PT 1
coded_vars <- c(coded_vars, "rr_hcs")
qa_report <- mutate(qa_report, rr_hcs = as.character(""))
#qa_report$rr_hcs[is.na(qa_report$TEN_DAYS_PATIENT_HEALTHCARE_SETTING)] <- "missing visit/stayed in HC setting |"

#  qa_report_items$rr_hcs_info,
qa_report <- mutate(qa_report, rr_hcs_info = as.character(""))

######### RISK & RESPONSE PT 1
coded_vars <- c(coded_vars, "rr_home")
qa_report$rr_home[is.na(qa_report$COVID_19_PERMANENT_HOME)] <- "missing permanent home |"


coded_vars <- c(coded_vars, "rr_home_info")
qa_report <- mutate(qa_report, rr_home_info = as.character(""))
#qa_report <- qa_report[is.na(COVID_19_SLEEP_BEFORE_ONSET_TEST), rr_home_info := "missing location slept the night before |"]
#qa_report <- qa_report[is.na(COVID_19_SLEEP_BEFORE_ONSET_TEST_OTHER_SPECIFY), rr_home_info := "missing location slept the night before specify |"]

coded_vars <- c(coded_vars, "rr_home_employer")
qa_report <- mutate(qa_report, rr_home_employer = as.character(""))
#qa_report$rr_home_employer[is.na(qa_report$COVID_19_EMPLOYEER_HOUSING)] <- "missing employer housing? |"




######### PREGNANCY
coded_vars <- c(coded_vars, "pregnancy")
qa_report<- qa_report %>% mutate(pregnancy= case_when(SEX_ASSIGNED_AT_BIRTH == 'Female' 
                                                      & AGE_YEARS >= 12 & AGE_YEARS <= 55
                                                      & (is.na(qa_report$PREGNANCY_STATUS)
                                                         | is.na(qa_report$PREGNANCY_STATUS_DIAGNOSIS))
                                                      ~ "Missing pregnancy status and/or pregnancy at the time of COVID-19 diagnosis |"))





######### PREDISPOSING CONDITIONS
coded_vars <- c(coded_vars, "any_prediscond")
qa_report$any_prediscond[is.na(qa_report$CURRENT_SMOKER)|
                           is.na(qa_report$CDC_N_COV_2019_SMOKE_VAPE)|
                           is.na(qa_report$DIABETES)|
                           is.na(qa_report$CANCER_DIAGNOSIS_TREATMENT_12_MONTHS_PRIOR_ONSET)|
                           is.na(qa_report$IMMUNOSUPPRESSIVE_THERAPY_DISEASE)|
                           is.na(qa_report$CHRONIC_HEART_DISEASE)|
                           is.na(qa_report$ASTHMA)|
                           is.na(qa_report$CHRONIC_LUNG_DISEASE_EG)|
                           is.na(qa_report$CHRONIC_LIVER_DISEASE)|
                           is.na(qa_report$CHRONIC_KIDNEY_DISEASE)|
                           is.na(qa_report$CURRENT_PRESCRIPTIONS_TREATMENT)|
                           is.na(qa_report$ANY_UNDERLYING_MEDICAL_CONDITION)] <- "missing predisposing condition(s) |"
#qa_report <- qa_report[is.na(HEMODIALYSIS_TIME_ONSET), any_prediscond := "missing predisposing condition(s) |"]




######### EMPLOYER/SCHOOL
coded_vars <- c(coded_vars, "employed")
qa_report<- qa_report %>% mutate(employed= case_when(AGE_YEARS >= 16
                                                     & (is.na(qa_report$PATIENT_EMPLOYED_STUDENT))
                                                     ~ "missing employed |"))

coded_vars <- c(coded_vars, "student")
qa_report$student[is.na(qa_report$PATIENT_STUDENT)] <- "missing student |"




######### TRAVEL
#coded_vars <- c(coded_vars, "futuretravel")
#qa_report$futuretravel[is.na(qa_report$TRAVEL_FUTURE)] <- "missing future travel |"




######### CONTACTS
coded_vars <- c(coded_vars, "contact_pubsetting")
qa_report$contact_pubsetting[is.na(qa_report$PUBLIC_SETTING_VISIT_EMPLOYED_VOLUNTEER)] <- "missing public setting while contagious |"

coded_vars <- c(coded_vars, "contact_close")
qa_report$contact_close[is.na(qa_report$FOURTEEN_DAYS_CONFIRMED_PROBABLE_CORONAVIRUS)] <- "missing close contact with confirmed or prob case |"




######### CARE COORD
coded_vars <- c(coded_vars, "cc_essential")
qa_report$cc_essential[is.na(qa_report$CARE_COORD_ESSENTIAL_ITEMS)] <- "missing care coord essential resources |"





####### CASE WHEN  ---

#qa_report<- qa_report %>% mutate(int_attempt_outcome_specify= case_when(DATE_INTERVIEW_ATTEMPT_OUTCOME == 'Unable to reach case/contact' &
#                                                            is.na(qa_report$DATE_INTERVIEW_ATTEMPT_OUTCOME_UNABLE_TO_REACH_CASECONTACT_SPECIFY)
#                                                      ~ "missing specify interview attempt outcome |"))


#case_when(is.na(Price) ~ "NIL", Price >= 500000 & Price <= 900000   ~ "Average", Price > 900000 ~ "High", TRUE ~ "Low"))






##----------------------------------------------------------------
##                      COMBINE COLUMNS 
##----------------------------------------------------------------
qa_report <- data.frame(qa_report)

qa_report$CICT_QA_NOTES<-do.call(paste,c(qa_report[coded_vars],sep = ""))

qa_report$CICT_QA_NOTES<-gsub("[NA]", "", qa_report$CICT_QA_NOTES)

qa_report$date <- mmddyyyy

#Divide the dataset into 2, 1 with the empty CICT_QA_NOTES, the other is the rest (CICT_QA_NOTES not empty). 
#Only combine the column with not empty CICT_QA_NOTES with the date, then combine the 2 dataset. 
NAQA<-qa_report%>%
  filter(CICT_QA_NOTES=="")

NonNAQA<-anti_join(qa_report,NAQA,by="CASE_ID")%>%
  arrange(desc(CREATE_DATE))

NonNAQA$CICT_QA_NOTES<-paste0(NonNAQA$date," ",NonNAQA$CICT_QA_NOTES)

qa_report<-rbind(NAQA,NonNAQA)%>%
  arrange(desc(CREATE_DATE))

#divide dataset by team
team11<-NonNAQA%>%
  filter(Team=='TEAM 11')
team13<-NonNAQA%>%
  filter(Team=='TEAM 13')
team14<-NonNAQA%>%
  filter(Team=='TEAM 14')

## if CICT_QA_NOTES is not blank, then CICT_QA_REVIEWED = Incomplete -- this might be hard to inc. if the past notes are still here

## Tally # of QAs in QA_total



## Write QA Report Excel file#

## no longer need but save for future write_csv(qa_report, "//dohfltum13/Confidential/DCHS/CDE/01_Linelists_Cross Coverage/Novel CoV/01 - Epi/01 - Case inv/REDCap QA Specialists/WDRS/QA/QA_Report.csv")

# write the combined daily as an excel file in the "_daily_download" folder
fwrite(qa_report,paste0("//dohfltum13/Confidential/DCHS/CDE/01_Linelists_Cross Coverage/Novel CoV/01 - Epi/01 - Case inv/REDCap QA Specialists/WDRS/QA/testQA_Report ", today(), ".csv"))
fwrite(b,paste0("//dohfltum13/Confidential/DCHS/CDE/01_Linelists_Cross Coverage/Novel CoV/01 - Epi/01 - Case inv/REDCap QA Specialists/WDRS/QA/testQA_Report_WithQA ", today(), ".csv"))
fwrite(team11,paste0("//dohfltum13/Confidential/DCHS/CDE/01_Linelists_Cross Coverage/Novel CoV/01 - Epi/01 - Case inv/REDCap QA Specialists/WDRS/QA/testQA_Report_TEAM11 ", today(), ".csv"))
fwrite(team13,paste0("//dohfltum13/Confidential/DCHS/CDE/01_Linelists_Cross Coverage/Novel CoV/01 - Epi/01 - Case inv/REDCap QA Specialists/WDRS/QA/testQA_Report_TEAM13 ", today(), ".csv"))
fwrite(team14,paste0("//dohfltum13/Confidential/DCHS/CDE/01_Linelists_Cross Coverage/Novel CoV/01 - Epi/01 - Case inv/REDCap QA Specialists/WDRS/QA/testQA_Report_TEAM14 ", today(), ".csv"))
