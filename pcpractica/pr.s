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

main:

  li $v0, 4
  la $a0, title
  syscall

final: 

  li $v0, 4
  la $a0, msg_fin
  syscall

  li $v0, 10
  syscall
  