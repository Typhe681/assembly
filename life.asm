section .text
global _start
_start:
mov r8, 9 ; width
mov r9, 16 ; height
; starting board down at the bottom
; default is a Pentadecathlon pattern
; width and height must match the board
mov rcx, r9
imul rcx, r8
save:
  and byte [board + rcx - 1], 1
  dec rcx
  jnz save
main:
  call print
  mov rax, 0
  mov rdi, 0
  lea rsi, [rsp-8]  ; trash byte
  mov rdx, 1
  syscall
  call tick
  jmp main

tick:
  mov r10, 0 ; board counter
  mov r12, 0 ; width counter
  mov r13, 0 ; height counter
  .col1:
    .row1:
      call neighbors
      call rules
      inc r12
      inc r10
      cmp r12, r8
      jnz .row1
    mov r12, 0
    inc r13
    cmp r13, r9
    jnz .col1
  
  mov r10, r9
  imul r10, r8
  .shift:
    shr byte [board + r10 - 1], 1; move flag into state
    dec r10
    jnz .shift
  ret

neighbors:
  mov r14, 0 ; neighbor counter
  mov rdx, -1 ; dy
  .yLoop:
    mov rcx, -1 ; dx
    .xLoop:
      cmp rcx, 0
      jne .notself ; not x0, cant be self
      cmp rdx, 0
      je .next ; dx/dy both 0, skip self
      .notself:
      lea rax, [r12 + rcx] ; x offset
      cmp rax, r8
      jae .next
      lea rbx, [r13 + rdx] ; y offset
      cmp rbx, r9
      jae .next
      imul rbx, r8
      add rbx, rax ; rbx is now index
      movzx rax, byte [board + rbx] ; read state
      and al, 1
      add r14, rax ; add state
    .next:
      inc rcx
      cmp rcx, 2
      jne .xLoop
    inc rdx
    cmp rdx, 2
    jne .yLoop
  ret

rules:
  cmp r14, 2 ; 2 neighbor, no change
  jne .skip1
  movzx rax, byte [board + r10] ; extract cell
  and al, 1 ; only state bit
  shl al, 1 ; move state to flag
  or [board + r10], al ; put flag into cell
  .skip1:
  cmp r14, 3; three neighbor, reproduce
  jne .skip2
  or byte [board + r10], 2
  .skip2:
  ; neighbors <2 or >3, cell dies (flag already zero)
  ret

print:
  mov r10, 0 ; board counter
  mov r12, 0 ; width counter
  mov r13, 0 ; height counter
  .col:
    .row:
      movzx rbx, byte [board + r10]
      lea rsi, [chars + rbx] ; which char
      call print_char
      inc r12
      inc r10
      cmp r12, r8
      jnz .row
    mov r12, 0
    mov rsi, nl ; print newline
    call print_char
    inc r13
    cmp r13, r9
    jnz .col
  mov rsi, nl
  call print_char
  ret

print_char:
  mov rax, 1      ; job is write
  mov rdi, 1      ; print to screen
                  ; char set before calling
  mov rdx, 1      ; how many bytes
  syscall
  ret

section .data
nl db 10 ; need data since rsi just address
chars: db ".#"
board: db "........."
       db "........."
       db "........."
       db "....#...."
       db "....#...."
       db "...#.#..."
       db "....#...."
       db "....#...."
       db "....#...."
       db "....#...."
       db "...#.#..."
       db "....#...."
       db "....#...."
       db "........."
       db "........."
       db "........."
