; IN PROGRESS!!! theres no neighbor counting yet lol just board printing

section .text
global _start
_start:
mov r8, 8 ; width
mov r9, 8 ; height
mov rcx, r9
imul rcx, r8
save:
  and byte [board + rcx - 1], 1
  dec rcx
  jnz save
main:
  call print
  mov rax, 60 ; job is exit
  mov edi, 69 ; idfk
  syscall

print:
  mov r10, 0 ; board counter
  mov r12, 0 ; width counter
  mov r13, 0 ; height counter
  col:
    row:
      movzx rbx, byte [board + r10]
      lea rsi, [chars + rbx] ; which char
      call print_char
      inc r12
      inc r10
      cmp r12, r8
      jnz row
    mov r12, 0
    mov rsi, nl ; print newline
    call print_char
    inc r13
    cmp r13, r9
    jnz col
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
board: db "........"
       db "..#..#.."
       db "..#..#.."
       db "........"
       db ".#....#."
       db "..####.."
       db "........"
       db "........"
