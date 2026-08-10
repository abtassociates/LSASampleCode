---
layout: default
title: LSA Temporary and Reference Tables
nav_order: 15
parent: LSA Programming Specifications
has_toc: true
last_modified_date: 2026-08-09
last_edit_timestamp: true
---

- Contents
{:toc}

# LSA Temporary and Reference Tables
These tables are created by [01 Temp Reporting and Reference Tables.sql](https://github.com/abtassociates/LSASampleCode/blob/master/01%20Temp%20Reporting%20and%20Reference%20Tables.sql).  

## tlsa_CohortDates
Based on <u>ReportStart</u> and <u>ReportEnd</u>, includes all cohorts used in the LSA with their associated start, end, and lookback dates.

Logic is defined in [3.2 LSA Reporting Cohorts and Dates](03 - Core Concepts and Data Universe.md#32-lsa-reporting-cohorts-and-dates-tlsa_cohortdates).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| Cohort | int | Cohort identifier |
| CohortStart | date | Cohort start date |
| CohortEnd | date | Cohort end date |
| LookbackDate | date | <u>ReportStart</u> - 7 years |
| ReportID | int | LSAReport.ReportID |

## tlsa_HHID
A master table of potentially reportable HMIS HouseholdIDs active in continuum ES/SH/TH/RRH/PSH projects between LookbackDate (<u>ReportStart</u> - 7 years) and <u>ReportEnd</u>.  Used to store effective entry, move-in, and exit dates, household types, and other frequently-referenced data.

Business logic associated with populating tlsa_HHID is in section [3.3 HMIS Household Enrollments](03 - Core Concepts and Data Universe.md#33-hmis-household-enrollments-tlsa_hhid)

| Column Name | Data Type | Notes |
| --- | --- | --- |
| HouseholdID | nvarchar(32) | From HMIS |
| HoHID | nvarchar(32) | The PersonalID for the head of household |
| EnrollmentID | nvarchar(32) | From HMIS |
| ProjectID | nvarchar(32) | From HMIS |
| LSAProjectType | int | If *ProjectType* = 13 and *RRHSubType* = 2, **LSAProjectType** = 13 If *ProjectType* = 13 and *RRHSubType* = 1, **LSAProjectType** = 15 Otherwise, **LSAProjectType** = hmis_Project.*ProjectType*. |
| EntryDate | date | [Section 3.3 - EntryDate](03 - Core Concepts and Data Universe.md#entrydate-tlsa_hhid) |
| MoveInDate | date | [Section 3.3 - MoveInDate](03 - Core Concepts and Data Universe.md#moveindate-tlsa_hhid) |
| ExitDate | date | [Section 3.3 - ExitDate](03 - Core Concepts and Data Universe.md#exitdate-tlsa_hhid) |
| LastBednight | date | [Section 3.3 - LastBedNight](03 - Core Concepts and Data Universe.md#lastbednight-tlsa_hhid) |
| EntryHHType | int |  [Section 3.6 - Household Types](03 - Core Concepts and Data Universe.md#36-household-types-tlsa_hhid) |
| ActiveHHType | int | [Section 3.6 - Household Types](03 - Core Concepts and Data Universe.md#36-household-types-tlsa_hhid) |
| Exit1HHType | int | [Section 3.6 - Household Types](03 - Core Concepts and Data Universe.md#36-household-types-tlsa_hhid) |
| Exit2HHType | int | [Section 3.6 - Household Types](03 - Core Concepts and Data Universe.md#36-household-types-tlsa_hhid) |
| ExitDest | int | [Section 3.3 - ExitDest](03 - Core Concepts and Data Universe.md#exitdest) |
| Active | bit | [Section 5.1 - Active and AIR HouseholdIDs](05 - LSAPerson.md#activehouseholds) |
| AIR | bit | [Section 5.1 - Active and AIR HouseholdIDs](05 - LSAPerson.md#airhouseholds) |
| ExitCohort | int | [Section 7.1 - Qualifying Exits in Exit Cohort Periods](07 - LSAExit.md#71-identify-qualifying-exits-in-exit-cohort-periods) |
| HHChronic | int | [Section 5.12 - HHChronic](05 - LSAPerson.md#hhchronic) |
| HHVet | int | [Section 5.12 - HHVet](05 - LSAPerson.md#hhvet) |
| HHDisability | int | [Section 5.12 - HHDisability](05 - LSAPerson.md#hhdisability) |
| HHFleeingDV | int | [Section 5.12 - HHFleeingDV](05 - LSAPerson.md#hhfleeingdv) |
| HHAdultAge | int | [Section 5.12 - HHAdultAge](05 - LSAPerson.md#hhadultage) |
| HHParent | int | [Section 5.12 - HHParent](05 - LSAPerson.md#hhparent) |
| AC3Plus | int | [Section 5.12 - AC3Plus](05 - LSAPerson.md#ac3plus) |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## tlsa_Enrollment
A master table of potentially reportable enrollments associated with the HouseholdIDs in tlsa_HHID; used to store entry, exit, and move-in dates, enrollment ages, and other frequently-referenced data.

Business logic associated with populating tlsa_Enrollment is in section [3.4 HMIS Client Enrollments (tlsa_Enrollment)](03 - Core Concepts and Data Universe.md#34-hmis-client-enrollments-tlsa_enrollment).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| EnrollmentID | nvarchar(32) | From HMIS  |
| PersonalID | nvarchar(32) | From HMIS |
| HouseholdID | nvarchar(32) | From HMIS |
| RelationshipToHoH | int | From HMIS |
| ProjectID | nvarchar(32) | From HMIS |
| LSAProjectType | int | If *ProjectType* = 13 and *RRHSubType* = 2, **LSAProjectType** = 13 If *ProjectType* = 13 and *RRHSubType* = 1, **LSAProjectType** = 15 Otherwise, **LSAProjectType** = hmis_Project.*ProjectType*.  |
| EntryDate | date | [Section 3.4 - EntryDate](03 - Core Concepts and Data Universe.md#entrydate-tlsa_enrollment) |
| MoveInDate | date | [Section 3.4 - MoveInDate](03 - Core Concepts and Data Universe.md#moveindate-tlsa_enrollment) |
| ExitDate | date | [Section 3.4 - ExitDate](03 - Core Concepts and Data Universe.md#exitdate-tlsa_enrollment) |
| LastBednight | date | [Section 3.4 - LastBedNight](03 - Core Concepts and Data Universe.md#lastbednight-tlsa_enrollment) |
| EntryAge | int | [Section 3.5 - Enrollment Ages](03 - Core Concepts and Data Universe.md#35-enrollment-ages-tlsa_enrollment) |
| ActiveAge | int | [Section 3.5 - Enrollment Ages](03 - Core Concepts and Data Universe.md#35-enrollment-ages-tlsa_enrollment) |
| Exit1Age | int | [Section 3.5 - Enrollment Ages](03 - Core Concepts and Data Universe.md#35-enrollment-ages-tlsa_enrollment) |
| Exit2Age | int | [Section 3.5 - Enrollment Ages](03 - Core Concepts and Data Universe.md#35-enrollment-ages-tlsa_enrollment) |
| DisabilityStatus | int | [Section 3.4 - DisabilityStatus](03 - Core Concepts and Data Universe.md#disabilitystatus) |
| DVStatus | int | [Section 3.4 - DVStatus](03 - Core Concepts and Data Universe.md#dvstatus) |
| Active | bit | [Section 5.2 - Active Enrollments](05 - LSAPerson.md#active-entrollments) |
| AIR | bit | [Section 5.2 - AIR Enrollments](05 - LSAPerson.md#air-enrollments) |
| PITOctober | bit | [Section 9.2 - Active and Point in Time Cohorts](09 - LSACalculated Counts.md#92-identify-active-and-point-in-time-cohorts-for-lsacalculated-counts) |
| PITJanuary | bit | [Section 9.2 - Active and Point in Time Cohorts](09 - LSACalculated Counts.md#92-identify-active-and-point-in-time-cohorts-for-lsacalculated-counts) |
| PITApril | bit | [Section 9.2 - Active and Point in Time Cohorts](09 - LSACalculated Counts.md#92-identify-active-and-point-in-time-cohorts-for-lsacalculated-counts) |
| PITJuly | bit | [Section 9.2 - Active and Point in Time Cohorts](09 - LSACalculated Counts.md#92-identify-active-and-point-in-time-cohorts-for-lsacalculated-counts) |
| CH | bit | [Section 5.6 - Enrollments Relevant to Counting ESSHStreet Dates](05 - LSAPerson.md#56-enrollments-relevant-to-counting-esshstreet-dates) |
| HIV | bit | [Section 5.4 - HIV](05 - LSAPerson.md#hiv) |
| SMI | bit | [Section 5.4 - SMI](05 - LSAPerson.md#smi) |
| SUD | bit | [Section 5.4 - SUD](05 - LSAPerson.md#sud) |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## tlsa_Person
 A client-level pre-cursor to LSAPerson with records for each PersonalID active in report period.

 Business logic associated with tlsa_Person is in section [5 - HMIS Business Logic - LSAPerson](05 - LSAPerson.md)

| Column Name      | Data Type    | Notes                                                                                                                                        |
| ---------------- | ------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| PersonalID       | nvarchar(32) |                                                                                                                                              |
| HoHAdult         | int          | [Section 5.4 - HoHAdult](05 - LSAPerson.md#hohadult)                                                                                         |
| CHStart          | date         | [Section 5.5](05 - LSAPerson.md#55-time-spent-in-essh-or-on-the-street--lsaperson)                                                           |
| LastActive       | date         | [Section 5.5](05 - LSAPerson.md#55-time-spent-in-essh-or-on-the-street--lsaperson)                                                           |
| RaceEthnicity    | int          | [Section 5.4 - RaceEthnicity](05 - LSAPerson.md#raceethnicity)                                                                               |
| VetStatus        | int          | [Section 5.4 - VetStatus](05 - LSAPerson.md#vetstatus)                                                                                       |
| DisabilityStatus | int          | [Section 5.4 - DisabilityStatus](05 - LSAPerson.md#disabilitystatus)                                                                         |
| CHTime           | int          | [Section 5.10 CHTime and CHTimeStatus](05 - LSAPerson.md#510-chtime-and-chtimestatus--lsaperson)                                             |
| CHTimeStatus     | int          | [Section 5.10 CHTime and CHTimeStatus](05 - LSAPerson.md#510-chtime-and-chtimestatus--lsaperson)                                             |
| DVStatus         | int          | [Section 5.4 - DVStatus](05 - LSAPerson.md#dvstatus)                                                                                         |
| ESTAgeMin        | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| ESTAgeMax        | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| HHTypeEST        | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HoHEST           | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AdultEST         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRAdultEST      | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHChronicEST     | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHVetEST         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHDisabilityEST  | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHFleeingDVEST   | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHAdultAgeAOEST  | int          | [Section 5.14 - Adult Age Population Identifiers](05 - LSAPerson.md#514-adult-age-population-identifiers--lsaperson)                         |
| HHAdultAgeACEST  | int          | [Section 5.14 - Adult Age Population Identifiers](05 - LSAPerson.md#514-adult-age-population-identifiers--lsaperson)                         |
| HHParentEST      | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AC3PlusEST       | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIREST           | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRHoHEST        | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| RRHAgeMin        | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| RRHAgeMax        | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| HHTypeRRH        | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HoHRRH           | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AdultRRH         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRAdultRRH      | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHChronicRRH     | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHVetRRH         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHDisabilityRRH  | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHFleeingDVRRH   | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHAdultAgeAORRH  | int          | [Section 5.14 - Adult Age Population Identifiers](05 - LSAPerson.md#514-adult-age-population-identifiers--lsaperson)                         |
| HHAdultAgeACRRH  | int          | [Section 5.14 - Adult Age Population Identifiers](05 - LSAPerson.md#514-adult-age-population-identifiers--lsaperson)                         |
| HHParentRRH      | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AC3PlusRRH       | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRRRH           | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRHoHRRH        | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| PSHAgeMin        | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| PSHAgeMax        | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| HHTypePSH        | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HoHPSH           | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AdultPSH         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRAdultPSH      | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHChronicPSH     | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHVetPSH         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHDisabilityPSH  | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHFleeingDVPSH   | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHAdultAgeAOPSH  | int          | [Section 5.14 - Adult Age Population Identifiers](05 - LSAPerson.md#514-adult-age-population-identifiers--lsaperson)                         |
| HHAdultAgeACPSH  | int          | [Section 5.14 - Adult Age Population Identifiers](05 - LSAPerson.md#514-adult-age-population-identifiers--lsaperson)                         |
| HHParentPSH      | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AC3PlusPSH       | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRPSH           | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| AIRHoHPSH        | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| RRHSOAgeMin      | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| RRHSOAgeMax      | int          | [Section 5.11 - AgeMin and AgeMax](05 - LSAPerson#511-estrrhpshrrhsoagemin-and-estrrhpshrrhsoagemax--lsaperson)                              |
| HHTypeRRHSONoMI  | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHTypeRRHSOMI    | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHTypeES         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHTypeSH         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HHTypeTH         | int          | [Section 5.13 - Project Group and Population Household Types](05 - LSAPerson.md#513-project-group-and-population-household-types--lsaperson) |
| HIV              | int          | [Section 5.4 - HIV](05 - LSAPerson.md#hiv)                                                                                                   |
| SMI              | int          | [Section 5.4 - SMI](05 - LSAPerson.md#smi)                                                                                                   |
| SUD              | int          | [Section 5.4 - SUD](05 - LSAPerson.md#sud)                                                                                                   |
| SSNValid         | int          | [Section 11 - SSNValid](11 - LSAReport.md#ssnvalid)                                                                                          |
| ReportID         | int          | LSAReport.ReportID                                                                                                                           |
| Step             | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record.    |

## ch_Exclude
Dates enrolled in TH or housed in RRH/PSH; used for LSAPerson chronic homelessness determination.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PersonalID | nvarchar(32) | [Section 5.7 - Get Dates to Exclude from Counts of ES/SH/Street Days](05 - LSAPerson.md#57-get-dates-to-exclude-from-counts-of-esshstreet-days-ch_exclude)  |
| excludeDate | date | [Section 5.7 - Get Dates to Exclude from Counts of ES/SH/Street Days](05 - LSAPerson.md#57-get-dates-to-exclude-from-counts-of-esshstreet-days-ch_exclude) |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## ch_Include
Dates in ES/SH or on the street; used for LSAPerson chronic homelessness determination.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PersonalID | nvarchar(32) | [Section 5.8 - Get Dates to Include in Counts of ES/SH/Street Days](05 - LSAPerson.md#58-get-dates-to-include-in-counts-of-esshstreet-days-ch_include) |
| ESSHStreetDate | date | [Section 5.8 - Get Dates to Include in Counts of ES/SH/Street Days](05 - LSAPerson.md#58-get-dates-to-include-in-counts-of-esshstreet-days-ch_include) |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## ch_Episodes
Holds episodes of ES/SH/Street time constructed from ch_Include for LSAPerson chronic homelessness determination.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PersonalID | nvarchar(32) | [Section 5.9 - Get ES/SH/Street Episodes](05 - LSAPerson.md#59-get-esshstreet-episodes-ch_episodes) |
| episodeStart | date | [Section 5.9 - Get ES/SH/Street Episodes](05 - LSAPerson.md#59-get-esshstreet-episodes-ch_episodes) |
| episodeEnd | date | [Section 5.9 - Get ES/SH/Street Episodes](05 - LSAPerson.md#59-get-esshstreet-episodes-ch_episodes) |
| episodeDays | int | [Section 5.9 - Get ES/SH/Street Episodes](05 - LSAPerson.md#59-get-esshstreet-episodes-ch_episodes) |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## tlsa_Household
A household-level precursor to LSAHousehold with a record for each unique combination of the head of household's PersonalID (HoHID) and household type (HHType) active in the report period.

Business logic associated with tlsa_Household begins in section [6.1 Get Distinct Households for LSAHousehold](06 - LSAHousehold.md#61-get-distinct-households-for-lsahousehold)

| Column Name | Data Type | Notes |
| --- | --- | --- |
| HoHID | nvarchar(32) | [Section 6.1 - Get Distinct Households for LSAHousehold](06 - LSAHousehold.md#61-get-distinct-households-for-lsahousehold) |
| HHType | int | [Section 6.1 - Get Distinct Households for LSAHousehold](06 - LSAHousehold.md#61-get-distinct-households-for-lsahousehold) |
| FirstEntry | date | [Section 6.9 - FirstEntry](06 - LSAHousehold.md#firstentry) |
| LastInactive | date | [Section 6.12 - Get Last Inactive Date](06 - LSAHousehold.md#612-get-last-inactive-date-sys_timepadded) |
| Stat | int | [Section 6.9 - Stat](06 - LSAHousehold.md#stat) |
| StatEnrollmentID | nvarchar(32) | [Section 6.9 - Previous Activity / StatEnrollmentID](06 - LSAHousehold.md#previous-activity--statenrollmentid) |
| ReturnTime | int | [Section 6.9 - ReturnTime](06 - LSAHousehold.md#returntime) |
| HHChronic | int | [Section 6.2 - HHChronic](06 - LSAHousehold.md#hhchronic) |
| HHVet | int | [Section 6.2 - HHVet, HHDisability, and HHParent](06 - LSAHousehold.md#hhvet-hhdisability-and-hhparent) |
| HHDisability | int | [Section 6.2 - HHVet, HHDisability, and HHParent](06 - LSAHousehold.md#hhvet-hhdisability-and-hhparent)|
| HHFleeingDV | int | [Section 6.2 - HHFleeingDV](06 - LSAHousehold.md#hhfleeingdv) |
| HoHRaceEthnicity | int | [Section 6.2 - HoHRaceEthnicity](06 - LSAHousehold.md#hohraceethnicity) |
| HHAdult | int | [Section 6.2 - HHAdult](06 - LSAHousehold.md#hhadult) |
| HHChild | int | [Section 6.2 - HHChild](06 - LSAHousehold.md#hhchild) |
| HHNoDOB | int | [Section 6.2 - HHNoDOB](06 - LSAHousehold.md#hhnodob) |
| HHAdultAge | int | [Section 6.2 - HHAdultAge](06 - LSAHousehold.md#hhadultage) |
| HHParent | int | [Section 6.2 - HHVet, HHDisability, and HHParent](06 - LSAHousehold.md#hhvet-hhdisability-and-hhparent) |
| ESTStatus | int | [Section 6.3 - EST/RRH/PSH/RRHSOStatus](06 - LSAHousehold.md#63-estrrhpshrrhsostatus--lsahousehold) |
| ESTGeography | int | [Section 6.5 - EST/RRH/PSHGeography](06 - LSAHousehold.md#65-estrrhpshgeography--lsahousehold) |
| ESTLivingSit | int | [Section 6.6 - EST/RRH/PSHLivingSit](06 - LSAHousehold.md#66-estrrhpshlivingsit--lsahousehold) |
| ESTDestination | int | [Section 6.7 - EST/RRH/PSHDestination – LSAHousehold](06 - LSAHousehold.md#67-estrrhpshdestination--lsahousehold) |
| ESTChronic | int | [Section 6.8 - EST/RRH/PSHChronic](06 - LSAHousehold.md#estrrhpshchronic) |
| ESTVet | int | [Section 6.8 - EST/RRH/PSHVet](06 - LSAHousehold.md#estrrhpshvet) |
| ESTDisability | int | [Section 6.8 - EST/RRH/PSHDisability](06 - LSAHousehold.md#estrrhpshdisability) |
| ESTFleeingDV | int | [Section 6.8 - EST/RRH/PSHFleeingDV](06 - LSAHousehold.md#estrrhpshfleeingdv)  |
| ESTAC3Plus | int | [Section 6.8 - EST/RRH/PSHAC3Plus](06 - LSAHousehold.md#estrrhpshac3plus) |
| ESTAdultAge | int | [Section 6.8 - EST/RRH/PSHAdultAge](06 - LSAHousehold.md#estrrhpshadultage) |
| ESTParent | int | [Section 6.8 - EST/RRH/PSHParent](06 - LSAHousehold.md#estrrhpshparent)  |
| RRHStatus | int | [Section 6.3 - EST/RRH/PSH/RRHSOStatus](06 - LSAHousehold.md#63-estrrhpshrrhsostatus--lsahousehold) |
| RRHMoveIn | int | [Section 6.4 - RRH/PSH/RRHSOMoveIn](06 - LSAHousehold.md#64-rrhpshrrhsomovein--lsahousehold) |
| RRHGeography | int | [Section 6.5 - EST/RRH/PSHGeography](06 - LSAHousehold.md#65-estrrhpshgeography--lsahousehold) |
| RRHLivingSit | int | [Section 6.6 - EST/RRH/PSHLivingSit](06 - LSAHousehold.md#66-estrrhpshlivingsit--lsahousehold)  |
| RRHDestination | int | [Section 6.7 - EST/RRH/PSHDestination – LSAHousehold](06 - LSAHousehold.md#67-estrrhpshdestination--lsahousehold) |
| RRHPreMoveInDays | int | [Section 6.15 - RRHPSHPreMoveInDays](06 - LSAHousehold.md#rrhpshpremoveindays) |
| RRHChronic | int | [Section 6.8 - EST/RRH/PSHChronic](06 - LSAHousehold.md#estrrhpshchronic) |
| RRHVet | int | [Section 6.8 - EST/RRH/PSHVet](06 - LSAHousehold.md#estrrhpshvet) |
| RRHDisability | int | [Section 6.8 - EST/RRH/PSHDisability](06 - LSAHousehold.md#estrrhpshdisability) |
| RRHFleeingDV | int | [Section 6.8 - EST/RRH/PSHFleeingDV](06 - LSAHousehold.md#estrrhpshfleeingdv) |
| RRHAC3Plus | int | [Section 6.8 - EST/RRH/PSHAC3Plus](06 - LSAHousehold.md#estrrhpshac3plus) |
| RRHAdultAge | int | [Section 6.8 - EST/RRH/PSHAdultAge](06 - LSAHousehold.md#estrrhpshadultage) |
| RRHParent | int | [Section 6.8 - EST/RRH/PSHParent](06 - LSAHousehold.md#estrrhpshparent)  |
| PSHStatus | int | [Section 6.3 - EST/RRH/PSH/RRHSOStatus](06 - LSAHousehold.md#63-estrrhpshrrhsostatus--lsahousehold) |
| PSHMoveIn | int | [Section 6.4 - RRH/PSH/RRHSOMoveIn](06 - LSAHousehold.md#64-rrhpshrrhsomovein--lsahousehold) |
| PSHGeography | int | [Section 6.5 - EST/RRH/PSHGeography](06 - LSAHousehold.md#65-estrrhpshgeography--lsahousehold) |
| PSHLivingSit | int | [Section 6.6 - EST/RRH/PSHLivingSit](06 - LSAHousehold.md#66-estrrhpshlivingsit--lsahousehold)  |
| PSHDestination | int | [Section 6.7 - EST/RRH/PSHDestination – LSAHousehold](06 - LSAHousehold.md#67-estrrhpshdestination--lsahousehold) |
| PSHHousedDays | int | [Section 6.15 - PSHHousedDays](06 - LSAHousehold.md#pshhouseddays) |
| PSHChronic | int | [Section 6.8 - EST/RRH/PSHChronic](06 - LSAHousehold.md#estrrhpshchronic) |
| PSHVet | int | [Section 6.8 - EST/RRH/PSHVet](06 - LSAHousehold.md#estrrhpshvet) |
| PSHDisability | int | [Section 6.8 - EST/RRH/PSHDisability](06 - LSAHousehold.md#estrrhpshdisability) |
| PSHFleeingDV | int | [Section 6.8 - EST/RRH/PSHFleeingDV](06 - LSAHousehold.md#estrrhpshfleeingdv)  |
| PSHAC3Plus | int | [Section 6.8 - EST/RRH/PSHAC3Plus](06 - LSAHousehold.md#estrrhpshac3plus) |
| PSHAdultAge | int | [Section 6.8 - EST/RRH/PSHAdultAge](06 - LSAHousehold.md#estrrhpshadultage) |
| PSHParent | int | [Section 6.8 - EST/RRH/PSHParent](06 - LSAHousehold.md#estrrhpshparent) |
| ESDays | int | [Section 6.15 - ESDays](06 - LSAHousehold.md#esdays) |
| THDays | int | [Section 6.15 - THDays](06 - LSAHousehold.md#thdays) |
| ESTDays | int | [Section 6.15 - ESTDays](06 - LSAHousehold.md#estdays) |
| RRHPSHPreMoveInDays | int | [Section 6.15 - RRHPSHPreMoveInDays](06 - LSAHousehold.md#rrhpshpremoveindays) |
| RRHHousedDays | int | [Section 6.15 - RRHHousedDays](06 - LSAHousehold.md#rrhhouseddays) |
| SystemDaysNotPSHHoused | int | [Section 6.15 - SystemDaysNotPSHHoused](06 - LSAHousehold.md#systemdaysnotpshhoused) |
| SystemHomelessDays | int | [Section 6.15 - SystemHomelessDays](06 - LSAHousehold.md#systemhomelessdays) |
| Other3917Days | int | [Section 6.15 - Other3917Days](06 - LSAHousehold.md#other3917days) |
| TotalHomelessDays | int | [Section 6.15 - TotalHomelessDays](06 - LSAHousehold.md#totalhomelessdays) |
| SystemPath | int | [Section 6.18 - Set SystemPath for LSAHousehold](06 - LSAHousehold.md#618-set-systempath-for-lsahousehold) |
| ESTAIR | int | [Section 6.17 - Set EST/RRH/PSHAIR](06 - LSAHousehold.md#617-set-estrrhpshair) |
| RRHAIR | int |  [Section 6.17 - Set EST/RRH/PSHAIR](06 - LSAHousehold.md#617-set-estrrhpshair) |
| PSHAIR | int |  [Section 6.17 - Set EST/RRH/PSHAIR](06 - LSAHousehold.md#617-set-estrrhpshair) |
| RRHSOStatus | int | [Section 6.3 - EST/RRH/PSH/RRHSOStatus](06 - LSAHousehold.md#63-estrrhpshrrhsostatus--lsahousehold) |
| RRHSOMoveIn | int | [Section 6.4 - RRH/PSH/RRHSOMoveIn](06 - LSAHousehold.md#64-rrhpshrrhsomovein--lsahousehold) |
| ReportID | int | LSAReport.**ReportID** |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |


## sys_Time
Used as the basis for counts of dates in ES/SH, TH, RRH/PSH (unhoused and housed), and ES/SH/StreetDates for LSAHousehold.

Business logic associated with sys_Time is in sections: 
- [6.11 Dates Housed in PSH or RRH](06 - LSAHousehold.md#611-dates-housed-in-psh-or-rrh-sys_time)
- [6.13 Get Dates of Other System Use](06 - LSAHousehold.md#613-get-dates-of-other-system-use-sys_time)

| Column Name | Data Type | Notes |
| --- | --- | --- |
| HoHID | nvarchar(32) |  |
| HHType | int |  |
| sysDate | date |  |
| sysStatus | int |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## sys_TimePadded
Used to identify households' last inactive date as a precursor to reporting on SystemPath in LSAHousehold.

See section [6.12 Get Last Inactive Date](06 - LSAHousehold.md#612-get-last-inactive-date-sys_timepadded) for business logic.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| HoHID | nvarchar(32) |  |
| HHType | int |  |
| Cohort | int |  |
| StartDate | date |  |
| EndDate | date |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## tlsa_Exit
A household-level precursor to LSAExit with a record for each unique combination of the head of household's PersonalID (HoHID), household type (HHType), and cohort with qualifying exits in the given cohort period.

Business logic begins in section [7.1 Identify Qualifying Exits in Exit Cohort Periods](07 - LSAExit.md#71-identify-qualifying-exits-in-exit-cohort-periods) and continues through the end of section 7.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| HoHID | nvarchar(32) | [Section 7.2 - Select Reportable Exits](07 - LSAExit.md#72-select-reportable-exits) |
| HHType | int | [Section 7.2 - Select Reportable Exits](07 - LSAExit.md#72-select-reportable-exits) |
| QualifyingExitHHID | nvarchar(32) | [Section 7.2 - QualifyingExitHHID](07 - LSAExit.md#qualifyingexithhid) |
| LastInactive | date | [Section 7.11 - Last Inactive Date for Exit Cohorts](07 - LSAExit.md#711-last-inactive-date-for-exit-cohorts) |
| Cohort | int | [Section 7.2 - Select Reportable Exits](07 - LSAExit.md#72-select-reportable-exits) |
| Stat | int | [Section 7.10 - Stat](07 - LSAExit.md#stat) |
| ExitFrom | int | [Section 7.2 - ExitFrom](07 - LSAExit.md#exitfrom) |
| ExitTo | int | [Section 7.2 - ExitTo](07 - LSAExit.md#exitto) |
| ReturnTime | int | [Section 7.3 - ReturnTime](07 - LSAExit.md#returntime) |
| HHVet | int | [Section 7.9 - HHVet](07 - LSAExit.md#hhvet) |
| HHChronic | int | [Section 7.9 - HHChronic](07 - LSAExit.md#hhchronic) |
| HHDisability | int | [Section 7.9 - HHDisability](07 - LSAExit.md#hhdisability) |
| HHFleeingDV | int | [Section 7.9 - HHFleeingDV](07 - LSAExit.md#hhfleeingdv) |
| HoHRaceEthnicity | int | [Section 7.9 - HoHRaceEthnicity](07 - LSAExit.md#hohraceethnicity) |
| HHAdultAge | int | [Section 7.9 - HHAdultAge](07 - LSAExit.md#hhadultage) |
| HHParent | int | [Section 7.9 - HHParent](07 - LSAExit.md#hhparent) |
| AC3Plus | int | [Section 7.9 - AC3Plus](07 - LSAExit.md#ac3plus) |
| SystemPath | int | [Section 7.12 - Set SystemPath for LSAExit](07 - LSAExit.md#712-set-systempath-for-lsaexit) |
| ReportID | int | LSAReport.**ReportID**  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## ch_Exclude_exit
An analog to ch_Exclude; used to hold dates in TH or housed in RRH/PSH for LSAExit chronic homelessness determination.

Business logic is in section [7.5 Get Dates to Exclude from Counts of ES/SH/Street Days (ch_Exclude_exit)](07 - LSAExit.md#75-get-dates-to-exclude-from-counts-of-esshstreet-days-ch_exclude_exit)

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PersonalID | nvarchar(32) |  |
| excludeDate | date |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## ch_Include_exit
An analog for ch_Include; holds dates in ES/SH or on the street for LSAExit chronic homelessness determination.

Business logic is in section [7.6 Get Dates to Include in Counts of ES/SH/Street Days (ch_Include_exit)](07 - LSAExit.md#76-get-dates-to-include-in-counts-of-esshstreet-days-ch_include_exit).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PersonalID | nvarchar(32) |  |
| ESSHStreetDate | date |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## ch_Episodes_exit
An analog for ch_Episodes; records of episodes of ES/SH/Street time constructed from ch_Include for LSAExit chronic homelessness determination.

Business logic is in section [7.7 Get ES/SH/Street Episodes (ch_Episodes_exit)](07 - LSAExit.md#77-get-esshstreet-episodes-ch_episodes_exit).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PersonalID | nvarchar(32) |  |
| episodeStart | date |  |
| episodeEnd | date |  |
| episodeDays | int |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## sys_TimePadded_exit
An analog for sys_TimePadded; used to identify households' last inactive date as a precursor to reporting on SystemPath in LSAExit.

Business logic is in section [7.11 Last Inactive Date for Exit Cohorts](07 - LSAExit.md#711-last-inactive-date-for-exit-cohorts).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| HoHID | nvarchar(32) |  |
| HHType | int |  |
| Cohort | int |  |
| StartDate | date |  |
| EndDate | date |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## tlsa_ExitHoHAdult

Used as the basis for reporting on chronic homelessness for LSAExit (which is limited to adults and head of household).

Business logic is in section [7.4 Identify HoH and Adult Members of Exit Cohorts](07 - LSAExit.md#74-identify-hoh-and-adult-members-of-exit-cohorts).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PersonalID | nvarchar(32) | [Section 7.4 - Record Selection](07 - LSAExit.md#record-selection) |
| QualifyingExitHHID | nvarchar(32) | [Section 7.4 - Record Selection](07 - LSAExit.md#record-selection) |
| Cohort | int | [Section 7.4 - Record Selection](07 - LSAExit.md#record-selection) |
| DisabilityStatus | int | [Section 7.4 - DisabilityStatus](07 - LSAExit.md#disabilitystatus) |
| CHStart | date | [Section 7.4 - CHStart](07 - LSAExit.md#chstart) |
| LastActive | date | [Section 7.4 - LastActive](07 - LSAExit.md#lastactive) |
| CHTime | int | [Section 7.4 - CHTime and CHTimeStatus](07 - LSAExit.md#chtime-and-chtimestatus) |
| CHTimeStatus | int | [Section 7.4 - CHTime and CHTimeStatus](07 - LSAExit.md#chtime-and-chtimestatus) |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## tlsa_AveragePops
Used to identify households in various populations and subpopulations for reporting on average # of days in section 8 based on tlsa_Household and tlsa_Exit.

Required populations, subpopulations, and associated criteria are in section [8.3 Populations for Average Days from LSAHousehold and LSAExit](08 - LSACalculated Averages.md#83-populations-for-average-days-from-lsahousehold-and-lsaexit).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PopID | int |  |
| Cohort | int |  |
| HoHID | nvarchar(32) |  |
| HHType | int |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## tlsa_CountPops
Used to identify people/households in various populations and subpopulations for active-in-residence counts in section 9.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PopID | int |  |
| PersonalID | nvarchar(32) |  |
| HouseholdID | nvarchar(32) |  |
| Step | nvarchar(10) | Not referenced in programming specifications; used by sample code to identify the query that created or most recently updated the record. |

## ref_Calendar
A table of dates between 10/1/2012 and 9/30/2030.  This is populated by 01 Temp Reporting and Reference Tables.sql and used in the sample code as a tool for counting days.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| theDate | date |  |
| yyyy | smallint |  |
| mm | tinyint |  |
| dd | tinyint |  |
| month_name | nvarchar(10) |  |
| day_name | nvarchar(10) |  |
| fy | smallint |  |

## ref_RowValues
A reference table of valid/required combinations of Cohort, Universe, and SystemPath values for each ReportRow in LSACalculated; this is populated by insert statements in 01 Temp Reporting and Reference Tables.sql based on requirements defined in:
- Section [8 - LSACalculated Averages](08 - LSACalculated Averages.md)
- Section [9 - LSACalculated Counts](09 - LSACalculated Counts.md)
- Section [10 - LSACalculated Data Quality Counts](10 - LSACalculated Data Quality Counts.md)

| Column Name | Data Type | Notes |
| --- | --- | --- |
| RowID | int |  |
| Cohort | int |  |
| Universe | int |  |
| SystemPath | int |  |

## ref_RowPopulations
A reference table of required populations/subpopulations for each ReportRow in LSACalculated; this is populated by insert statements in 01 Temp Reporting and Reference Tables.sql based on requirements defined in:
- Section [8 - LSACalculated Averages](08 - LSACalculated Averages.md)
- Section [9 - LSACalculated Counts](09 - LSACalculated Counts.md)
- Section [10 - LSACalculated Data Quality Counts](10 - LSACalculated Data Quality Counts.md).

| Column Name | Data Type | Notes |
| --- | --- | --- |
| RowMin | int |  |
| RowMax | int |  |
| ByPath | int |  |
| ByProject | int |  |
| PopID | int |  |
| Pop1 | int |  |
| Pop2 | int |  |

## ref_PopHHTypes
A reference table of household types associated with each population; this is populated by insert statements in 01 Temp Reporting and Reference Tables.sql based on criteria defined in sections 8 and 9.

| Column Name | Data Type | Notes |
| --- | --- | --- |
| PopID | int |  |
| HHType | int |  |

