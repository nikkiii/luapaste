lf = require("luafcgid")

require('sys.config')
require('sys.database')

-- The main entry point, this is overridden because luafcgid only gives us the basics.
function main(env, con)

	-- Check database
	if not dbh or not dbh:ping() then
		db_connect()
	end
	
	-- Parse GET params
	if env.QUERY_STRING then
		env.get = lf.parse(env.QUERY_STRING)
	end

	-- Parse POST requests
	if env.REQUEST_METHOD == "POST" then
		env.post = lf.parse(con:gets())
	end
	
	index(env, con)
end