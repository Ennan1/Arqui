.data 
 bienvenida: .asciiz "Cuantas personas ingresaras: "
 contador: .asciiz "\nEstas ingresando a la persona numero:  "
 edad: .asciiz "\n Ingrese su edad: "
 peso: .asciiz " Ingrese su peso en Kilogramos: "
 alturas: .asciiz "Ingrese su estatura en centimetros: "
 
imc: .asciiz "\n    Su imc es de:  "
riesgo1: .asciiz "\n    El reisgo es BAJO si su imc es menor a 22 y tienes menos de 45 a�os" 
riesgo2: .asciiz "\n    El riesgo MEDIO en cualquiero otro caso que falte " 
riesgo3: .asciiz "\n    El riesgo es ALTO si su imc es mayor a 22 y tienes mas de 45 a�os" 

resultado_n_cant: .asciiz "\n\n La cantidad de ninios es: "
resultado_n_prom: .asciiz "\n\n El promedio del peso de los ninios es: "
resultado_j_cant: .asciiz "\n La cantidad de jovenes es: "
resultado_j_prom: .asciiz "\n El promedio  del peso de los jovenes es: "
resultado_adu_cant: .asciiz "\n La cantidad de adultos es: "
resultado_adu_prom: .asciiz "\n El promedio del peso de los adultos es: "
resultado_anc_cant: .asciiz "\n La cantidad de ancianos es: "
resultado_anc_prom: .asciiz "\n El promedio  del peso de los ancianos es: "
.text
    
    main:
          li $v0, 4
          la $a0,bienvenida
          syscall 
          li $v0,4
           
          li $v0, 4
          la $a0,riesgo1
          syscall 
          li $v0, 4
          la $a0,riesgo2
          syscall 
          li $v0, 4
          la $a0,riesgo3
          syscall 
           addi $t1,$zero,0
           addi $t6,$zero,0
           addi $t8,$zero,0
           addi $s1,$zero,0
           addi $s3,$zero,0
           addi $t1, $t1,1   #i=0 
           while: 
                  bgt $t1,$t0,mostrar  
                  jal print 
                  addi $t1, $t1,1#i++
                  #ingreso de edad guardado en t2
                  li $v0,4
                  la $a0,edad
                  syscall 
                  li $v0, 5
                  syscall 
                  move $t2, $v0
                  li $v0,4
                  #ingreso del peso guardado en t3
                  li $v0,4
                  la $a0,peso
                  syscall 
                  li $v0, 5
                  syscall 
                  move $t3, $v0
                  li $v0,4
                  #ingreso de la altura  t4
                  li $v0,4
                  la $a0,alturas
                  syscall 
                  li $v0, 5
                  syscall 
                  move $t4, $v0
                  li $v0,4
                
                  #imc cal
                  jal calimc
                  #if nino
                  slti $s0,$t2,12 # if t2 es menor a 12 s0 = 1 
                  bne  $s0,$zero,nino #  if s0 != 0 , entonces se suma 1 al contador de ni�os
                  #if joven
                  slti $s0,$t2,29
                  bne  $s0,$zero,joven
                  #if adul
                  slti $s0,$t2,64
                  bne  $s0,$zero,adulto
                  #if anc
                  slti $s0,$t2,110
                  bne  $s0,$zero,anc
                  syscall
                  j while
             
      print:
           li $v0,4
           la $a0,contador
           syscall
           
           li $v0,1
           add $a0, $t1,$zero
           syscall  
           
           jr $ra
           
      calimc:
         #calculo imc
                  mul $s4,$t3,10000
                  mul $t4,$t4,$t4
                  div $t4,$s4,$t4
                  li $v0,4
                  la $a0,imc
                  syscall
                  li $v0,1
                  add $a0, $t4,$zero
                  syscall
                  
            jr $ra
          
      nino:
          addi $t5,$t5,1
          add $t6,$t6,$t3
         
          j while
          
      joven:
          addi $t7,$t7,1
          add $t8,$t8,$t3
          
          j while
      adulto:
          addi $t9,$t9,1
          add $s1,$s1,$t3
         
          j while
      anc:
          addi $s2,$s2,1
          add $s3,$s3,$t3
          
         
          j while
    
          
    
     mostrar:

          #mostrar cantidad ninos
           li $v0,4
           la $a0,resultado_n_cant
           syscall
           li $v0,1
           add $a0, $t5,$zero
           syscall
          
          #mostrar cantidad jovenes
           li $v0,4
           la $a0,resultado_j_cant
           syscall
           li $v0,1
           add $a0, $t7,$zero
           syscall
         
           #mostrar cantidad adultos
           li $v0,4
           la $a0,resultado_adu_cant
           syscall
           li $v0,1
           add $a0, $t9,$zero
           syscall
           #mostrar cantidad ancianos
           li $v0,4
           la $a0,resultado_anc_cant
           syscall
           li $v0,1
           add $a0, $s2,$zero
           syscall
         
           
           j promedio
         
     
     promedio:
           slti $s0,$t5,1
           bne  $s0,$zero,suma1
           slti $s0,$t7,1
           bne  $s0,$zero,suma2
           slti $s0,$t9,1
           bne  $s0,$zero,suma3
           slti $s0,$s2,1
           bne  $s0,$zero,suma4
           
        div $t6,$t6,$t5
        div $t8,$t8,$t7   
        div $s1,$s1,$t9  
        
          #mostrar cantidad ninos prom peso
           li $v0,4
           la $a0,resultado_n_prom
           syscall
           li $v0,1
           add $a0, $t6,$zero
           syscall
           #mostrar cantidad jovenes prom imc
           li $v0,4
           la $a0,resultado_j_prom
           syscall
           li $v0,1
           add $a0, $t8,$zero
           syscall
           #mostrar cantidad adultos prom imc
           li $v0,4
           la $a0,resultado_adu_prom
           syscall
           li $v0,1
           add $a0, $s1,$zero
           syscall 
           #mostrar cantidad ancianos prom imc
           li $v0,4
           la $a0,resultado_anc_prom
           syscall
           li $v0,1
           add $a0, $s3,$zero
           syscall
           
        j exit
        
         suma1:
         addi $t5,$t5,1
         j promedio
         suma2:
         addi $t7,$t7,1
         j promedio
         suma3:
         addi $t9,$t9,1
         j promedio
         suma4:
         addi $s2,$s2,1
         j promedio
        
        
         exit:
               li $v0,10
               syscall
