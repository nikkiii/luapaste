local chariot = require('chariot')

c = chariot:new()

c.base = './templates/'
c.extension = 'html'

c.open = '{'
c.close = '}'

c.cache = true