; r8/r9 temp
; r10 num of swaps
mov r11, 7 ; number of indices
; r12 just index counter
push 4
push 7
push 1
push 5
push 2
push 3
push 6

outer:
  mov r10, 0
  mov r12, r11
  dec r12 ; d12 - 1 = n pairs
inner:
  mov r8, [rsp + r12*8 - 8]
  mov r9, [rsp + r12*8]
  cmp r9, r8
  jge skip ; jle if descending
  mov [rsp + r12*8 - 8], r9
  mov [rsp + r12*8], r8
  inc r10
  skip:
    dec r12
    jnz inner
    test r10, r10
    jnz outer
