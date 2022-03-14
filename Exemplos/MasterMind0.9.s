.eqv N 4
.include "../MACROSv21.s"
.text
#addi sp,sp,-200			#cria pilha
#addi s0,sp,-200
#li s1, 0
#sw s1,-172(s0) #contador_de_rounds
#li s1, 3
#sw s1,-176(s0)
li s10, 0

#RECOMECO:
#.text
#li s1,0
#sw s1,-52(s0)
#sw s1,-72(s0)

.data
.include "fundo_marrom.data"
.include "fundo_preto2.0.data"
.include "proximoround.data"

ColorsPallete:	.word 	0xc0,0xff,0x17,0x3f,0x38,0x007,0x83,0x87
ColorsName:	.ascii "b","w","o","y","g","r","p","m"

Password:	.ascii "i","i","i","i"
Guess:		.ascii "a", "a", "a", "a"

Str1:		.string "Número de pinos brancos: "
Str2:		.string "Número de pinos pretos: "
Str3:		.string "Tentativa "
newl:		.string "\n"
contrabarra:	.string "\n"
# b = black
# w = white
# o = orange
# y = yellow
# g = green 
# r = red
# p = purple
# m = magenta

.text
	

TABULEIRO:	
        li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,fundo_preto2.0		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1: 	
        beq t1,t2,PREPARAPREPARAOPCOES		# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1
	
	
PREPARAPREPARAOPCOES:
	
        addi sp,sp,-200			#cria pilha
        addi s0,sp, 200
        
        li t5, 0
        sw t5, -144(s0)
        lw s1, -172(s0)
	

	li a7, 1
        mv a0, s10
        ecall
	
	li t1,3
	beq s10,t1,m_fim        
        
        addi t6, s10, 5		#aqui iremos adicionar ao valor de 5 cores, o valor de cores a mais em cada round			
        sw t6, -148(s0)		#estamos aumentando o limite de iterações
        li s1, 5
        sw s1, -124(s0)
        li s1, 25
        sw s1, -128(s0)
        li s1, 15
        sw s1, -132(s0)
        li s1, 25
        sw s1, -136(s0)
        li s1, 29
        sw s1, -156(s0)
        li s1, 25
        sw s1, -160(s0)
        
        j PREPARAOPCOES
        
        
PREPARAOPCOES:
        
        
        la s1, ColorsPallete   	#carrega endereço paleta de cores em s1
        lw t5, -144(s0)       	#carrega contador/iterador de opcoes (vai até 5)
        lw t6, -148(s0)
        la s2, ColorsName
        
        beq t5, t6, PREPARAJOGADA
        slli t5,t5,2          #multiplica por 4 pra alcançar a word adequada da paleta
        add s1,s1,t5          #endereço da paleta mais o indice
        lw s1, 0(s1)          #poe a cor em s1
        sw s1, -140(s0)	      #carrega cor da opcao em hexa
        srli t5,t5,2
        add s2,s2,t5
        lb s2, 0(s2)		
        sw s2, -152(s0)      #carrega caractere da cor
        
        
        j MOSTRAOPCOES
        
MOSTRAOPCOES:

        li a7, 47	#Colocamos os valores de inicio para começar a printar linha por linha a bola 
        lw a0, -124(s0)
        lw a1, -128(s0)
        lw a2, -132(s0)
        lw a3, -136(s0)     
        lw a4, -140(s0)
        li a5, 0	#O valor de frame = 0
        ecall           
        
        addi a0,a0,-1   
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a1,a1,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        li a7, 111	#Colocamos os valores de inicio para começar a printar linha por linha a bola 
        lw a0, -152(s0)
        lw a1, -156(s0)
        lw a2, -160(s0)
        li a3, 0x38
        li a4, 0	#O valor de frame = 0
        ecall
        
        lw t5, -144(s0)
        addi t5,t5,1
        sw t5,-144(s0)
        
        lw s1, -128(s0)
        addi s1,s1,24
        sw s1, -128(s0)
        
        lw s1,-136(s0)
        addi s1,s1,24
        sw s1,-136(s0)
        
        lw s1, -160(s0)
        addi s1,s1,24
        sw s1, -160(s0)
        
        		
        j PREPARAOPCOES
	

MAIN:		        	
			la s1,ColorsName		#armazena no slot ** o endereço do array de caractere ascci cores
			sw s1, -100(s0)
			
			la s1, ColorsPallete		#armazena as cores da palete em hexa
			sw s1,-104(s0)
			
                        la s6, Password          	#armazena senha no 11 slot da pilha
                        sw s6, -44(s0)                 	#armazena senha no 11 slot da pilha
                        			
			la s1, Guess			# Carrega o endereço base do array com o palpite
			sw s1, -48(s0)                  #armazena palpite no 12 slot da pilha
			
			li s1, 0
			sw s1, -52(s0)                  #armazena contador s2 no 13 slot da pilha
			
			li s1, 10
			sw s1, -56(s0)                  #armazena valor 10 no 14 slot da pilha
			
			li s1, 0
			sw s1, -68(s0)		# Zera a quantidade de  pinos brancos

			li s1, 0
			sw s1, -72(s0)		# Zera a quantidade de pinos pretos
			
			
			
			
			
m_loop:			
			li s1, 4
			lw s2, -72(s0)  #verifica se tem 4 pinos pretos, se tiver pula pro fim
			beq s1,s2, adiciona_pilha	#aqui acaba o programa, caso ocorra vitória
			
                        lw s3,-56(s0)	#10
                        lw s2,-52(s0)   #0
                        beq s2, s3, m_fim	#aqui acaba o programa, caso ocorra derrota
                        
				jal READ		# Lê o palpite do usuário e o armazena na memória
				
			
				li s1, 0
				sw s1,-60(s0)		#contador valor 0
			
				li s1, N
				sw s1,-64(s0)		#contador valor N (quantidade de cores)
			
				li s1, 0
				sw s1, -68(s0)		# Zera a quantidade de  pinos brancos

				li s1, 0
				sw s1, -72(s0)		# Zera a quantidade de pinos pretos

m_loop2:	        
                        lw t0, -60(s0)			#atribui o contador 0 ao registrador t0
                        lw t4, -64(s0)			#atribui o valor do contador N ao registrador t4
			beq t0, t4, m_fim2		# Iteração através do array...

				lw s1, -48(s0)		#carrega o ENDEREÇO do array de palpite no registrador s1
				lw t0, -60(s0)		#carrega o valor do iterador no registrador t0
				add t2, t0, s1		#adiciona o iterador ao endereço do palpite
				sw t2, -76(s0)		#Salva na pilha o ENDEREÇO
				
							
				lw t2, -76(s0)		# t2 recebe o ENDEREÇO do caractere (cor) no array de palpites
				lb a2, 0(t2)		# a2 recebe o caractere ASCII da cor
				lw a1, -44(s0)		# a1 recebe o endereço do array da senha
				li a3, N		# a3 recebe o comprimento do array/quantidade de cores
				
			
				jal IS_IN_PASSWORD		# Verifica se a cor está na senha, retornando 0 (false) ou 1 (true) em a0
			
				bne a0, zero, ok1		# Se a cor estiver na senha, segue para ok1 para conferir se ela está na posição certa.
				
				lw t0, -60(s0)			
				addi t0, t0, 1			# Incrementa o contador para iterar o proximo caractere do palpite
				sw t0, -60(s0)			
			
			li a4, 0xc7   				#adiciona a cor transparente ao registrador a0 para ser usado no print da bolinha
			j COLOREBOLINHARESPOSTA			#essa label printa a bolinha e retorna para o m_loop2
								

ok1:		        	lw t0, -60(s0)
                        	mv a3, t0			# a3 recebe o valor do iterador/contador, que servirá de índice do elemento para o procedimento.
				jal IS_IN_RIGHT_POSITION	# Verifica se a cor está na posição certa, retornando 0 (false) ou 1 (true) em a0.
			
				bne a0, zero, ok2		# Se a cor estiver na posição correta, segue para ok2
				
				lw t5, -68(s0)			
				addi t5, t5, 1			# Incrementa os pinos brancos
				sw t5, -68(s0)
								
				lw t0, -60(s0)			
				addi t0, t0, 1			# Incrementa o contador
				sw t0, -60(s0)			
			
			li a4, 0x0ff			        #adiciona a cor branca ao registrador para ser usado no print da bolinha
			j som_branca 				#reproduz o som da resposta branca
			
			
						
ok2:		        	lw t6, -72(s0)
                        	addi t6, t6, 1			# Incrementa os pinos pretos
                        	sw t6, -72(s0)	
                        			
				lw t0, -60(s0)		
				addi t0, t0, 1			# Incrementa o contador
				sw t0, -60(s0)				
			

			
			li a4, 0x00				#adiciona a cor preta ao registrador a0 para ser usado no print da bolinha
			j som_preto
			
						
						
m_fim2:				la a0, newl  #aqui são printadas as infos referente a fase e as fases e numero de pinos brancos e pretos
				li a7, 4
				ecall
			
				la a0, Str3
				li a7, 4
				ecall
			
				lw s2,-52(s0)
				mv a0, s2
				li a7, 1
				ecall
			
				la a0, newl
				li a7, 4
				ecall
			
				la a0, Str1
				li a7, 4
				ecall
					
				lw t5, -68(s0)
				mv a0, t5
				li a7, 1
				ecall
			
				la a0, newl
				li a7, 4
				ecall
			
				la a0, Str2
				li a7, 4
				ecall
			
				lw t6, -72(s0)
				mv a0, t6
				li a7, 1
				ecall
			
				la a0, newl
				li a7, 4
				ecall
			
				lw s2, -52(s0)
				addi s2, s2, 1		#incrementa no contador da main (até 10)
				sw s2, -52(s0)
				
				j atualiza_valores		#depois vai para o loop inicial do programa
				
																					
m_fim:				
				li a7, 10
				ecall
							
# ==================================================================================================== #
# ==================================================================================================== #

# O procedimento READ (R) lê um determinado número de caracteres ascii do teclado e os armazena na 
# memória.

READ:		        
                        li t1, 0	# Inicio da contagem (zera o contador)
                        sw t1, -112(s0)
                        
			li t2, 4	# Fim da contagem
			sw t2, -76(s0)	
					
r_loop:		        
			lw t1, -112(s0)
                        lw t2, -76(s0)
                        
                        beq t1, t2, r_fim 	# Caso o loop tenha terminado, finaliza a leitura
			
			li a7, 12		# Lê o caractere do teclado, que é armazenado em a0
			ecall		
			
			lw s1, -48(s0)
			add t3, t1, s1		# Atualiza a posição do array
			sw t3, -84(s0)
						
			sb a0, 0(t3)		# Armazena o caractere no array
							
			lw t1, -112(s0)													
			addi t1, t1, 1		# Incrementa o contador
			sw t1, -112(s0)
			
			sb a0 -20(s0)		#salva o caractere ascii para a tradução
			
			#j COLOREBOLINHA
			
			li t0, 8      	#carrega o limite da iteração
			sw t0, -92(s0)
		
			li t0, 0	#carrega iterador/indice 
			sw t0, -96(s0)
			
			j transformaemcor
					
		
r_fim:		ret	
	
# ==================================================================================================== #
# ==================================================================================================== #
			
# O procedimento IS_IN_RIGHT_POSITION (IIRP) analisa se um caractere ascii em uma determinada posição
# é igual ao caractere ascii da mesma posição em outro array.

# a0 é o booleano de retorno (0 é false, 1 é true)
# a1 é o endereço base do array password
# a2 é o byte com o char que representa a cor
# a3 é o índice do char

IS_IN_RIGHT_POSITION:				li a0, 0				# a0 = false

						add t1, a3, a1		# t1 = &password[idx]
						
						lb t1, 0(t1)		# t1 = password[idx]

						
						beq a2, t1, iirp_ok		# Se a palavra estiver na mesma posição, retorna true
						ret
						
iirp_ok:					li a0, 1				# a0 = true
						ret

# ==================================================================================================== #
# ==================================================================================================== #

# O procedimento IS_IN_PASSWORD (IIP) analisa se um caractere ascii está presente
# numa lista de caracteres.

# a0 é o booleano de retorno (0 é false, 1 é true)
# a1 é o endereço base do array password
# a2 é o byte com o char que representa a cor
# a3 é o comprimento do array
# t1 é o contador

IS_IN_PASSWORD:		                li t1, 0	# Inicio da contagem (zera o contador)
                                      	li a0, 0	# retorno = 0 = false
					
iip_loop:			        
                                        beq t1, a3, iip_fim_loop	# Se o contador for igual ao comprimento, acaba o loop
					
					
					add t2, t1, a1		#t2 é a soma do contador/iterador com o endereço do password
					sw t2, -76(s0)		# t2 = &password[i]				
					lb t3, 0(t2)
					sw t3, -84(s0)		# t3 = password[i]
								
					
					lw t3, -84(s0)
					
					beq a2, t3, iip_ok	#a2 apresenta o valor do caractere ASCII do palpite, já t3 apresenta o valor do caractere da senha
					
					
					addi t1, t1, 1		# Incrementa o contador
					

					j iip_loop		# Continua o loop
					
iip_ok:				li a0, 1			# Retorno = true, a cor está na senha

iip_fim_loop:			ret				# Retorna para o chamador do procedimento

# ==================================================================================================== #
# ==================================================================================================== #

PREPARAJOGADA: #aqui inicializa na pilha todos os valores iniciais das bolinhas
        
        li s1, 2
        sw s1, -88(s0) #carrega o limite do contador de bolinha de REPOSTA eixo X 
        
        li s1, 55 #valor do primeiro x
        sw s1, -4(s0) #salvando o valor de x na primeira word da pilha
        
        li s1, 7 #valor do primeiro y
        sw s1, -8(s0) #salva valor do primeiro y na segunda word da pilha
        
        li s1, 63 #valor do segundo x
        sw s1, -12(s0) #salva o valor do segundo x na terceira posição da pilha
        
        li s1, 7 #valor do segundo y
        sw s1, -16(s0) #salva valor do segundo y na quarta posição da pilha
          
        #li s1, 0x83 #valor da cor
        #sw s1, -20(s0) #salva o valor da cor na quinta posição da pilha
        
        li s1, 270 #valor do primeiro x da bolinha de resposta
        sw s1, -24(s0) 
        
        li s1, 3 #valor do primeiro y da bolinha de resposta
        sw s1, -28(s0) 
        
        li s1, 276 #valor do segundo x da bolinha de reposta
        sw s1, -32(s0) 
        
        li s1, 3 #valor do segundo y da bolinha de reposta
        sw s1, -36(s0)  
        
        li s1, 0
	sw s1, -188(s0) #iterador da geração de números randomicos
       
        j randomiza_senha
        

transformaemcor:
		# -20(s0) tem o caractere ascii que precisamos transformar em uma cor, baseado nos arrays la de cima
		
		lw t1, -92(s0) #contador limite
		lw t2, -96(s0) #contador iterador
		lw t3, -20(s0) #caracter ascii cor
		
		lw t4, -100(s0)	#salvando o endereço dos caracteres ascii no t4
		add t5,t4,t2	#endereço iterado
		
		lb t6, 0(t5)	#caractere do array de cores
		sw t6, -108(s0)	#aloca esse indice na RAM
		
		
		bne t3,t6, notequal	#casp as cores sejam iguais, vai ser executado o código a seguir
		
		lw t1, -104(s0)	#endereço da ColorsPallete
		lw t2, -96(s0) 	#salva o iterador em t2
		
		slli t2,t2,2	#multiplicamos o iterador por 4, pois aqui vamos trabalhar com words
		
		add t5, t1, t2 #alocamos a cor no
		 
		lb t3, 0(t5)
		sw t3, -108(s0) #aloca o valor em hexadecimal da cor 
		
		j COLOREBOLINHA
			
notequal:		
		#atualizando o indice na RAM
		lw t1, -96(s0)
		addi t1,t1,1	
		sw t1, -96(s0)
		
		j transformaemcor
        
        
        
COLOREBOLINHA:                                                                                                
        
        li a7, 47	#Colocamos os valores de inicio para começar a printar linha por linha a bola 
        lw a0, -4(s0)
        lw a1, -8(s0)
        lw a2, -12(s0)
        lw a3, -16(s0)     
        lw a4, -108(s0)
        li a5, 0	#O valor de frame = 0
        ecall           
        
        addi a0,a0,-1   
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a1,a1,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        lw s1, -4(s0)
        addi s1,s1,49
        sw s1, -4(s0)
        
        lw s1,-12(s0)
        addi s1,s1,49
        sw s1,-12(s0)
        
        j r_loop                                 
        
################################################----------------------------------------------------------------################################################

COLOREBOLINHARESPOSTA:        
        
        
        li a7, 47	#Aqui vamos atribuir os valores iniciais da bolinha de resposta aos valores ja colocados na memória
        lw a0, -24(s0)	
        lw a1, -28(s0)
        lw a2, -32(s0)
        lw a3, -36(s0)     
        li a5, 0
        ecall
                           
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,-1
        addi a1,a1,1
        addi a2,a2,1
        addi a3,a3,1
        
        li a7, 47
        ecall
        
       	addi a0,a0,-1
        addi a1,a1,1
       	addi a2,a2,1
       	addi a3,a3,1
       
       	li a7, 47
       	ecall
        
        
        addi a1,a1,1
        addi a3,a3,1
        li a7, 47
        ecall
        
        
        
        addi a0,a0,1
        addi a1,a1,1
	addi a2,a2,-1
        addi a3,a3,1
       
       	li a7, 47
       	ecall
        
        addi a0,a0,1
        addi a1,a1,1
       	addi a2,a2,-1
       	addi a3,a3,1
        
        li a7, 47
        ecall
        
        addi a0,a0,1
        addi a1,a1,1
        addi a2,a2,-1
        addi a3,a3,1
        
        li a7, 47
        ecall
	
	
	lw t0, -60(s0)
	lw t1, -88(s0)
	
	beq t1,t0,eixoy
	
	lw s1, -24(s0)
        addi s1,s1,26		#acrescenta 26 pixeis no eixo X
        sw s1, -24(s0)
        
        lw s2,-32(s0)
        addi s2,s2,26		#acrescenta 26 pixeis no eixo X
        sw s2,-32(s0)
        
        j m_loop2
	
eixoy:
	lw s1, -28(s0)
        addi s1,s1,7 
        sw s1, -28(s0)
        
        lw s1, -36(s0)
        addi s1,s1,7
        sw s1,-36(s0)
        
        lw s1, -24(s0)
        addi s1,s1,-26
        sw s1, -24(s0)
        
        lw s1,-32(s0)
        addi s1,s1,-26
        sw s1,-32(s0)
        
        j m_loop2

atualiza_valores:
	#Y
	lw s1, -8(s0)
        addi s1,s1,24 #aqui adicionamos 24 pixeis para distanciar o y
        sw s1, -8(s0)
        
        lw s1, -16(s0)
        addi s1,s1,24 #adicionar 24 pixeis para descer o y
        sw s1,-16(s0)
        
        #X
	lw s1, -4(s0)
        addi s1,s1,-196 #demos "reset" no x1 para voltar à origem
        sw s1, -4(s0)
        
        lw s1,-12(s0)
        addi s1,s1,-196 # "reset" no outro x2 para voltar à origem
        sw s1,-12(s0)
        
        #Xresposta
        lw s1, -24(s0)
        addi s1,s1, -52 # votlamos o X1 da bolinha de resposta
        sw s1, -24(s0)
        
        lw s2,-32(s0)
        addi s2,s2, -52 #voltamos o X2 da bolinha de resposta
        sw s2,-32(s0)
        
        #Yresposta
        lw s1, -28(s0)
        addi s1,s1,17  #descemos o Y1 da bolinha de resposta
        sw s1, -28(s0)
        
        lw s1, -36(s0)
        addi s1,s1,17 #descemos o Y2 da bolinha de resposta
        sw s1,-36(s0)
	
	j m_loop
	
	
adiciona_pilha:
	addi s10,s10,1 #adiciona mais um no contador de rounds 
	
			
        li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,proximoround		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP: 	
        beq t1,t2,musica_conclusao		# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP
	
musica_conclusao:
	li a2,5 #PIANO (0-7) VAI SER SEMPRE PIANO
	li a7, 33

	li a0, 62	#nota  D
	li a1, 100	#duração
	li a3, 100	#volume
	ecall

	li a0, 62	#nota  D
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 74	#nota  G
	li a1, 150	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 69	#nota  A
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 68	#nota  G#
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 67	#nota  G
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 65	#nota  F
	li a1, 200	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 67	#nota  G
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 62	#nota  D
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 65	#nota  F
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 67	#nota  G
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	li a0, 61	#nota  C
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	j TABULEIRO


som_branca:

	li a2,5 #PIANO (0-7) VAI SER SEMPRE PIANO


	li a7, 33
	li a0, 62	#nota	D
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	j COLOREBOLINHARESPOSTA
	
som_preto:

	li a2,5 #PIANO (0-7) VAI SER SEMPRE PIANO


	li a7, 33
	li a0, 67	#nota  G
	li a1, 100	#duração
	li a3, 100	#volume
	ecall
	
	j COLOREBOLINHARESPOSTA
	
	
randomiza_senha:
	
	mv s1, s10 #movendo o valor do round para s1
	
	addi s1, s1, 5
	
	#GERANDO NUMERO RANDOMICO EM a0#
	li a7, 42
	mv a1, s1	
        ecall			#retorna em a0 o número randomico de [0,t0] que vai servir de indice
        
        la s1, ColorsName
        add s2, s1, a0		#somando o valor do endereço com o indice randomico
        
	lb s1, 0(s2)		#salvando o valor do caractere em s1
	sw s1, -180(s0) 	#alocando na posição -180(s0) o valor do caractere
	
	###########PRINT STRING#############
	li a7,11
	mv a0, s1	
	ecall
	
	la a0, contrabarra
	li a7, 4
	ecall
	####################################
	
	li s1, 0
	sw s1, -184(s0)		#aloca o ireador em s0 - 184
	
	
loop_verifica_existencia:
	
	lw t0, -184(s0)
	
	la s1, Password
	add s1, s1, t0		#corrigindo o valor do endereço com o indice em -180(s0)
	
	lb s1, 0(s1)		#alocando o valor do char de colorsname em s1
	lw s2, -180(s0)		#alocando o valor do char a ser examinado em s2	
	
	beq s1,s2, randomiza_senha	#caso sejam iguais, montar a senha novamente
	
	li t0, 4		#limite da iteração (tamanho do array de cores)
	
	lw t1, -184(s0)
	addi t1, t1, 1		#Acrescenta ao contador
	sw t1, -184(s0)
	
	bne t1,t0, loop_verifica_existencia	#caso o contador termine, verifica que não há letras iguais
	
	
atribuir_valor:	#aqui iremos colocar o char na posição certa, depois de ter verificado se ele não esta presente no array

	lw s1, -180(s0) #carrega o caractere
	
	la s2, Password
	lw t1, -188(s0) #iterador
	add s2, s2, t1
	
	sb s1, 0(s2)	#carregando no indice CERTO o valor do char randomizado
	
	li t0, 4	#determina o limite da iteração
	
	lw t1, -188(s0)
	addi t1,t1, 1
	sw t1, -188(s0)	
	
	bne t0, t1, randomiza_senha	#caso ja tenha feito isso para os 4 números, voltar para a main
	
	j MAIN

			

.include "../SYSTEMv21.s"
