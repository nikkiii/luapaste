require('sys.controller')
require('sys.template')

function index(env, con)
	if not env.get or not env.get.paste then
		con:header('Location', '/')
		return
	end
	
	local id = env.get.paste
	
	local pasteq = dbh:prepare('SELECT paste FROM pastes WHERE id = ?')
	success, err = pasteq:execute(id)
	
	if not success then
		con:header('Location', '/')
		return
	end
	
	local paste = pasteq:fetch(true)
	
	local model = { ['env'] = env, ['buttons'] = {} }
	
	if env.get.act then
		if env.get.act == 'raw' then
			con:header('Content-Type', 'text/plain')
			con:puts(paste.paste)
			return
		elseif env.get.act == 'fork' then
			table.insert(model.buttons, {
				['link'] = 'javascript: createPaste()',
				['class'] = 'save',
				['text'] = 'Save'
			})
			
			model.env.post = { ['paste'] = paste.paste }
			
			con:puts(c:render('index', model))
			return
		end
	end
	
	model['paste'] = paste
	
	table.insert(model.buttons, {
		['link'] = '/' .. id .. '/raw',
		['text'] = 'Raw'
	})
	table.insert(model.buttons, {
		['link'] = '/' .. id .. '/fork',
		['text'] = 'Fork'
	})
	table.insert(model.buttons, {
		['link'] = '/',
		['text'] = 'New'
	})
	
	con:puts(c:render('view', model))
end