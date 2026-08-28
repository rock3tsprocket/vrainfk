function Brainfk(...)
    " Get the Brainf**k code from the optional function argument
    let code = get(a:, 1, 0)
    " If `code` equals 0, then there was no argument, so read the code from
    " the buffer
    if code == 0
        let code = join(getline(1, '$'), "\n")
    endif

	let codelen = strlen(code) " Length of code
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
		if code[i] == "["
			call add(stack, i)
		elseif code[i] == "]"
			let jumptable[i] = remove(stack, -1)
			let jumptable[jumptable[i]] = i
		endif
	endfor

	" Main loop
	while ip < codelen
		if code[ip] ==# "+"
			let cells[dp] = (cells[dp] + 1) % 256
		elseif code[ip] ==# "-"
			let cells[dp] = (cells[dp] - 1) % 256
			if cells[dp] <= -1
				let cells[dp]+=256
			endif
		elseif code[ip] ==# "."
			echon nr2char(cells[dp])
		elseif code[ip] ==# ","
			let cells[dp] = char2nr(input("Input: "))
			echo "\n"
		elseif code[ip] ==# ">"
			let dp = (dp + 1) % 30000
		elseif code[ip] ==# "<"
			let dp = (dp - 1) % 30000
		elseif code[ip] ==# "[" && cells[dp] ==# 0
			let ip = jumptable[ip]
		elseif code[ip] ==# "]" && cells[dp] !=# 0
			let ip = jumptable[ip]
		endif
		
		let ip = ip + 1
	endwhile
endfunction

command! -nargs=? Vrainfk call Brainfk(<args>)
