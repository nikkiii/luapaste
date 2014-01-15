require('sys.controller')
require('sys.template')

function index(env, con)
	local model = { ['env'] = env, ['buttons'] = {} }
	
	if env.post then
		if env.post.paste and env.post.paste ~= '' then
			local time = os.time()
			local insert = dbh:prepare('INSERT INTO pastes (`paste`, `created_at`, `updated_at`) VALUES (?, ?, ?)')
			success, err = insert:execute(env.post.paste, time, time)
			
			if success then
				local id = dbh:insert_id()
				
				con:header('Location', '/' .. id)
				return
			end
			
			error(err)
		else
			-- Errors here later
		end
	end
	
	table.insert(model.buttons, {
		['link'] = 'javascript: createPaste()',
		['class'] = 'save',
		['text'] = 'Save'
	})
	
	con:puts(c:render('index', model))
end