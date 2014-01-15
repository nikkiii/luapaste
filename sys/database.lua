require('dbi')

dbh = false

function db_connect()
	dbh = dbi.Connect(config.database.driver, config.database.database, config.database.username, config.database.password, config.database.hostname)
	
	if not dbh then
		error('Unable to connect to database')
	end
	
	dbh:autocommit(true)
end