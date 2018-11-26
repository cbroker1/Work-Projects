EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'SendCallCenter',
@recipients = 'dummy@email.com',
@subject = 'Previous Week No-Shows',
@query = 
N'
Select 
	[NETEWLifePRODDBV1.8.7].[dbo].[tblClient].[fldFirstName],[fldLastName],[fldJHEDId]
	, 
	[NETEWLifePRODDBV1.8.7].[dbo].[tblClientSchedule].[fldDuration],[fldDate]
FROM 
	[NETEWLifePRODDBV1.8.7].[dbo].[tblClientSchedule] Inner Join [NETEWLifePRODDBV1.8.7].[dbo].[tblClient]
on
	[NETEWLifePRODDBV1.8.7].[dbo].[tblClientSchedule].[fldClientId]=[NETEWLifePRODDBV1.8.7].[dbo].[tblClient].[fldClientId]
WHERE
    [fldDate] >= DATEADD(dd, ((DATEDIFF(dd, ''17530101'', GETDATE()) / 7) * 7) - 7, ''17530101'') AND
    [fldDate] <= DATEADD(dd, ((DATEDIFF(dd, ''17530101'', GETDATE()) / 7) * 7) - 1, ''17530101'') AND
	[fldApptOutcomeId] = 4 AND
	[fldDuration] = ''02:00''',
@body = 'Attached you will find the Intake No-Shows from the previous week. After opening the attached in Excel: select all of column A, navigate to the ''Data'' tab, click on ''Text to Columns'', uncheck all boxes except for ''Comma'' and click ''Finish''. ',
@attach_query_result_as_file = 1,
@query_result_no_padding = 1,
@query_result_separator = ',',
@query_attachment_filename = 'Previous_week_intake_no_shows.csv'
