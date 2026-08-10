/*

	1. Turn on SQLCMD Mode (Query menu option in SSMS)
	2. Set the path variable below to the folder with script files
	3. Hit F5 to execute

*/

:setvar path "C:\Users\MollyMcEvilley\OneDrive - Square Peg Data\GitHub\LSASampleCodev8\"



:r $(path)"01 Temp Reporting and Reference Tables.sql"
:r $(path)"02 LSA Output Tables.sql"
:r $(path)"03_01a LSA Parameters and Metadata-Annual Systemwide.sql "

	declare @id int;

	insert into x_lsa_ReportHistory (StartTime, ReportID, ReportDate, ReportStart, ReportEnd, Scope, notes)
	select getdate(), ReportID, ReportDate, ReportStart, ReportEnd, case when LSAScope = 3 then 'HIC' else 'LSA' end
		, ''
	from lsa_Report; 
	set @id = @@identity; 

	declare @s datetime;
	set @s = getdate();
:r $(path)"03_02 to 03_06 HMIS Households and Enrollments.sql"
	update x_lsa_ReportHistory set sec3 = datediff(ss, @s, getdate()) where id = @id;


:r $(path)"04_01 Get Project Records.sql"
:r $(path)"04_02 to 04_07 Get Other PDDEs.sql"


	set @s = getdate();
:r $(path)"05_01 to 05_11 LSAPerson Records and Demographics.sql"
	update x_lsa_ReportHistory set sec51 = datediff(ss, @s, getdate()) where id = @id;

	set @s = getdate();
:r $(path)"05_12 to 05_15 LSAPerson Project Group and Population Household Types.sql"
	update x_lsa_ReportHistory set sec52 = datediff(ss, @s, getdate()) where id = @id;

	set @s = getdate();
:r $(path)"06 LSAHousehold.sql"
	update x_lsa_ReportHistory set sec6 = datediff(ss, @s, getdate()) where id = @id;

	set @s = getdate();
:r $(path)"07 LSAExit.sql"
	update x_lsa_ReportHistory set sec7 = datediff(ss, @s, getdate()) where id = @id;

	set @s = getdate();
:r $(path)"08 LSACalculated Averages for LSAHousehold and LSAExit.sql"
	update x_lsa_ReportHistory set sec8 = datediff(ss, @s, getdate()) where id = @id;

	set @s = getdate();
:r $(path)"09 LSACalculated AIR Counts.sql"
	update x_lsa_ReportHistory set sec9 = datediff(ss, @s, getdate()) where id = @id;

:r $(path)"10 LSACalculated Data Quality.sql"
:r $(path)"11 LSAReport DQ and ReportDate.sql"
	update x_lsa_ReportHistory 
	set EndTime = getdate()
	where id = @id;
		
	update x_lsa_ReportHistory 
	set RunMinutes = datediff(mi, StartTime, EndTime)
	where id = @id;
	
	update x_lsa_ReportHistory
	set RunSeconds = datediff(ss, StartTime, EndTime)%60
	where id = @id;

	update x
	set x.ActiveClients = rpt.UnduplicatedClient
		, x.ReportDate = rpt.ReportDate
		, x.ReportStart = rpt.ReportStart
		, x.ReportEnd = rpt.ReportEnd
	from x_lsa_ReportHistory x
	inner join lsa_Report rpt on rpt.ReportID = x.ReportID 
	where x.id = @id;

	exec sp_LSAExportPrep; 