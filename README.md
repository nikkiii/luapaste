LuaPaste
-----------------

This will NOT work without my version of luadbi, luafcgid, or chariot. I will upload them shortly into their own repositories.

Rewrite rules

- Lighttpd

```
	url.rewrite-once = (
		"^/(\d+)$" => "/paste.lua?paste=$1",
		"^/(\d+)/(raw|fork)$" => "/paste.lua?paste=$1&act=$2"
	)

```

Blocking rules (It is HIGHLY SUGGESTED that you use these, if you don't it will simply show a blank page for /sys and the template contents for /templates)

- Lighttpd

```
$HTTP["url"] =~ "^/(sys|templates)" {
    url.access-deny = ("")
}
```
