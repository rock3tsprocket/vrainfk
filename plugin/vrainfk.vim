function Brainfk(code)
	let codelen = strlen(a:code) " Length of code
	let dp = 0 " Data pointer
	let ip = 0 " Instruction pointer

	" Doing cell things
	let cells = [] 
	for i in range(0, 29999)
		call add(cells, "")
	endfor

	" Jump table
	let stack = []
	let jumptable = []
	for i in range(0, codelen)
		call add(jumptable, "")
	endfor
	for i in range(0, codelen)
		if a:code[i] == "["
			call add(stack, i)
		elseif a:code[i] == "]"
			let jumptable[i] = remove(stack, -1)
			let jumptable[jumptable[i]] = i
		endif
	endfor

	" Main loop
	while ip < codelen
		if a:code[ip] ==# "+"
			let cells[dp] = (cells[dp] + 1) % 256
		elseif a:code[ip] ==# "-"
			let cells[dp] = (cells[dp] - 1) % 256
			if cells[dp] <= -1
				let cells[dp]+=256
			endif
		elseif a:code[ip] ==# "."
			echom nr2char(cells[dp])
		elseif a:code[ip] ==# ","
			let cells[dp] = char2nr(input("Input: "))
			echo "\n"
		elseif a:code[ip] ==# ">"
			let dp = (dp + 1) % 30000
		elseif a:code[ip] ==# "<"
			let dp = (dp - 1) % 30000
		elseif a:code[ip] ==# "[" && cells[dp] ==# 0
			let ip = jumptable[ip]
		elseif a:code[ip] ==# "]" && cells[dp] !=# 0
			let ip = jumptable[ip]
		endif
		
		let ip = ip + 1
	endwhile
endfunction
