mov rax, 69420
mov r9, 0

start:
  mov rdx, 0
  mov rbx, 10
  div rbx
  add rdx, 48 ; ascii
  push rdx
  inc r9
  test rax, rax
  jnz start

printLoop:
  mov rax, 1
  mov rdi, 1
  mov rsi, rsp
  mov rdx, 1
  syscall
  add rsp, 8
  dec r9
  jnz printLoop
