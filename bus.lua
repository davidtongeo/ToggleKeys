local langs = {
	'us', --eng keyboard
	'latam',
}
function Getlang()
	local f = assert(io.popen("setxkbmap -print | awk -F'+' '/xkb_symbols/ {print $2}'" , "r"))
	local s = assert(f:read("a"))
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
	f:close()
	return s
end
function CheckNextIndex(index, table)
	if(index > #(table))then
		return 1
	else
		return index
	end
end
function ChangeLang()
	local lang = Getlang()
	for _, i in pairs(langs)do
		local nextindex = CheckNextIndex(_+1, langs)
		if(lang == i)then
			--print(i .. ' is the current lang. next lang in the list is: '.. langs[nextindex])
			os.execute('setxkbmap '.. langs[nextindex])
			break
		end
	end
end

ChangeLang()
