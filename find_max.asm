mov rax, 0
mov rcx, 5
push 3
push 9
push 4
push 7
push 42
top:
  mov rbx, [rsp + rcx*8 - 8] ; -8 because jnz with index 0
  cmp rbx, rax
  jle skip
  mov rax, rbx
skip:
  dec rcx
  jnz top
