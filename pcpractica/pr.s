# Autor: Camila Valentina Alonso Yepez
# Fecha ultima modificacion: 09/05/2023

# #include <iostream>

# const int n1 = 10;
# double v1[n1] = {10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0};
# const int n2 = 5;
# double v2[n2] = {5.5, 4.5, 4.25, 2.5, 2.5 };

# void printvec(double v[], const int n, std::string separador) {
#     for (int i = 0; i < n; i++)
#         std::cout << v[i] << separador;
# }

# int check(double a,double b) {
#     if (a < b ) return(-1);
#     else if (a == b) return(0);
#     else return(1);
# }

# int ordenado(double v[], const int n) {
#     int resultado = 1;
#     for (int i = 0; i < n-1; i++)
#         if ( check(v[i],v[i+1]) != 1 ) {
#             resultado = 0;
#             break;
#         }
#     return(resultado);
# }

# int main(void) {
#     std::cout << "\nVector con dimension " << n1 << std::endl;
#     printvec(v1,n1," ");
#     std::cout << std::endl;
#     int o = ordenado(v1,n1);
#     if (o == 1) std::cout << "\nVector ordenado estrictamente decrecite\n";
#     else std::cout << "\nVector NO ordenado estrictamente decrecite\n";

#     std::cout << "\nVector con dimension " << n2 << std::endl;
#     printvec(v2,n2," ");
#     std::cout << std::endl;
#     o = ordenado(v2,n2);
#     if (o == 1) std::cout << "\nVector ordenado estrictamente decrecite\n";
#     else std::cout << "\nVector NO ordenado estrictamente decrecite\n";

#     std::cout << "\nFIN DEL PROGRAMA\n";
#     return(0);
# }


size = 8     # bytes que ocupa cada elemento

  .data
v1:         .double 10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0
v2:         .double 5.5, 4.5, 4.25, 2.5, 2.5 
n1:         .word 10 # tamano del v1
n2:         .word 5 # numero eltos vector 2. Inicialmente suponemos vacios
space:      .asciiz " "
newline:    .asciiz "\n"
title:      .asciiz "\nMicroexamen práctico de Principio de Computadores.\n"
cabvec:     .asciiz "\nVector con dimension "
msg_ord:    .asciiz "\nVector ordenado estrictamente decrecite\n"
msg_no_ord: .asciiz "\nVector NO ordenado estrictamente decrecite\n"
msg_fin:    .asciiz "\nFIN DEL PROGRAMA.\n"

  .text

print_vect:

  addi $sp, -16
  sw $s0, 0($sp)
  sw $s1, 4($sp)
  sw $s2, 8($sp)
  sw $ra, 12($sp)

  move $s0, $a0
  move $s2, $a1
  move $s3, $a2

  move $s1, $zero #Counter

  print_vect_bucle:

    mul $t1, $s1, size
    add $t1, $t1, $s0
    l.d $f20, 0($t1)

    li $v0, 3
    mov.d $f12, $f20
    syscall    

    li $v0, 4
    move $a0, $s3
    syscall

    addi $s1, 1

    blt $s1, $s2, print_vect_bucle 

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, 16

    jr $ra

  print_vec_fin:  

check:

  mov.d $f16, $f12
  mov.d $f18, $f14

  c.eq.d $f16, $f18
  bc1t check_igual

  c.lt.d $f16, $f18
  bc1t check_menor

  bc1f check_mayor

  check_igual:

    li $v0, 0
    jr $ra

  check_menor:

    li $v0, -1
    jr $ra

  check_mayor:

    li $v0, 1
    jr $ra

ordenado:

  addi $sp, -24

  sw $s0, 0($sp)
  sw $s1, 4($sp)
  sw $s2, 8($sp)
  sw $s3, 12($sp)
  sw $s4, 16($sp)
  sw $ra, 20($sp)

  move $s0, $a0 #Dirección inicial
  move $s1, $a1 #Número de elementos

  li $s3, 1 #Resultado
  li $s4, 0 #Counter

  sub $s1, $s1, 1

  ordenado_bucle:

  mul $t1, $s4, size
  add $t1, $t1, $s0
  l.d $f12, 0($t1)

  addi $s4, 1
    
  add $t1, $t1, size
  l.d $f14, 0($t1)

  jal check 

  bne $v0, -1, no_decreciente
  blt $s4, $s1, ordenado_bucle

  li $v0, 0

  j ordenado_

  no_decreciente: 

  li $v0, 1
  jr $ra

  ordenado_:

  addi $sp, 24
  lw $s0, 0($sp)
  lw $s1, 4($sp)
  lw $s2, 8($sp)
  lw $s3, 12($sp)
  lw $s4, 16($sp)
  lw $ra, 20($sp)

  jr $ra
  ordenado_bucle_fin:

main:

  li $v0, 4
  la $a0, title
  syscall

  li $v0, 4
  la $a0, newline
  syscall

  la $a0, v1 #Guardamos en $a0 la direccion inicial de v1
  lw $a1, n1 #Numero de elementos de v1
  la $a2, space #Guardamos la direccion de la cadena de espacio

  jal print_vect

  li $v0, 4
  la $a0, newline
  syscall

  la $a0, v2 #Guardamos en $a0 la direccion inicial de v2
  lw $a1, n2 #Numero de elementos de v2
  la $a2, space #Guardamos la direccion de la cadena de espacio

  jal print_vect

  li $v0, 4
  la $a0, newline
  syscall

  la $a0, v1 #Guardamos en $a0 la direccion inicial de v1
  lw $a1, n1 #Numero de elementos
  
  jal ordenado

  li $v0, 4
  la $a0, newline
  syscall

  la $a0, v2 #Guardamos en $a0 la direccion inicial de v1
  lw $a1, n2 #Numero de elementos
  la $a2, space #Guardamos la direccion de la cadena de espacio

  jal print_vect
  
  li $v0, 4
  la $a0, newline
  syscall

    

final: 

  li $v0, 4
  la $a0, msg_fin
  syscall

  li $v0, 10
  syscall

