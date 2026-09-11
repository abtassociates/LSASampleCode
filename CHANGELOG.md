# Changelog

Notable changes to the LSA sample code and sample data. Dates are when the change was merged; see each linked pull request for the full diff.

## 2026-09-11

- `Export.csv` no longer accumulates a row per export run. `vw_hmis_Export` selected from `hmis_Export` with no filter, so every export run appended another row that never got cleaned up; regenerated the Sample Data zips to match. Reported once before in [#1486](https://github.com/abtassociates/LSASampleCode/issues/1486), but that fix only cleaned the existing zip rather than the underlying query, so it recurred. ([#1513](https://github.com/abtassociates/LSASampleCode/pull/1513))

## 2026-08-19

- Sample Data ZIP files (`Sample HMIS Data.zip`, `Sample LSA Output.zip`, `Sample LSA Temp Tables.zip`, `Sample HIC Output.zip`, `Sample HIC Temp Tables.zip`) now contain the CSVs directly instead of wrapping them in a subfolder. ([#1505](https://github.com/abtassociates/LSASampleCode/pull/1505))
- Removed the unused `Step` column from `LSACalculated.csv` and corrected the SSN column order in `LSAReport.csv` (`SSN4Digit` now precedes `SSNNotProvided`); regenerated the Sample HIC and LSA Output data to match. ([#1504](https://github.com/abtassociates/LSASampleCode/pull/1504))

## 2026-08-18

- Regenerated the Sample HIC and LSA Output data to reflect the ReportRow 921 fix below. ([#1503](https://github.com/abtassociates/LSASampleCode/pull/1503))
- Fixed `10 LSACalculated Data Quality.sql` so the bed night date range used for ReportRow 921 no longer extends past `ReportEnd`. ([#1502](https://github.com/abtassociates/LSASampleCode/pull/1502))
