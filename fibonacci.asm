mov rax, 0
mov rbx, 1
mov rcx, 69 ; max of 93
top:
  add rbx, rax
  xchg rbx, rax
  dec rcx
  jnz top
