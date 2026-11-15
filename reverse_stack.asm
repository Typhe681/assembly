push 1
push 2
push 3
push 4
push 5
push 6
push 7
mov rcx, 0
mov rdx, 6

top:
  mov rax, [rsp + rcx*8]
  mov rbx, [rsp + rdx*8]
  mov [rsp + rcx*8], rbx
  mov [rsp + rdx*8], rax
  inc rcx
  dec rdx
  cmp rcx, rdx
  jl top ; if rcx < rdx, not all swapped yet
