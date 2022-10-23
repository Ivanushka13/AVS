	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.globl	fill_rand_arr
	.type	fill_rand_arr, @function
fill_rand_arr:			                # Заполнение массива рандоиными элементами
#	endbr64                             можем убрать
	push	rbp		                    # Сохраняем rbp на стек
	mov	rbp, rsp	                    # rbp := rsp
	sub	rsp, 32	                        # rsp -= 32
	mov	DWORD PTR -20[rbp], edi	        # n
	mov	DWORD PTR -4[rbp], 0            # i = 0
	jmp	.L2                             # -> .L2
.L3:
	call	rand@PLT	                # rand()
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	shr	rdx, 32
	mov	ecx, edx	                    # ecx := edx
	sar	ecx, 5
	cdq
	sub	ecx, edx	                    # ecx -= edx
	mov	edx, ecx	                    # edx := ecx
	imul	edx, edx, 100
	sub	eax, edx                        # eax -= edx
	mov	edx, eax	                    # edx := eax
	lea	ecx, -100[rdx]
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cdqe
	lea	rdx, 0[0+rax*4]                 # rdx := &0[i]
	lea	rax, A[rip]                     # rax := &A[i]
	mov	DWORD PTR [rdx+rax], ecx        # A[i] := ecx
	add	DWORD PTR -4[rbp], 1            # i += 1
.L2:
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cmp	eax, DWORD PTR -20[rbp]         # i < n
	jl	.L3                             # if i < n
	nop                                 # / else
	nop                                 #
	leave				                # Выход из функции
	ret
	.size	fill_rand_arr, .-fill_rand_arr
	.section	.rodata		            # .rodata
.LC0:
	.string	"%d"			            # .LC0 = "%d"
	.text					            # Code
	.globl	fill_arr_from_file
	.type	fill_arr_from_file, @function
fill_arr_from_file:			            # Заполнение массива из данных из #файла
#	endbr64 			                <- можно убрать
	push	rbp			                # Сохраняем rbp на стек
	mov	rbp, rsp		                # rbp := rsp
	sub	rsp, 32		                    # rsp -= 32
	mov	DWORD PTR -20[rbp], edi         # n = edi
	mov	DWORD PTR -4[rbp], 0            # i = 0
	jmp	.L5                             # -> .L5
.L6:
	mov	rax, QWORD PTR input[rip]	    # rax := num
	lea	rdx, -8[rbp]		            # rdx := &(-8 на стеке)
	lea	rsi, .LC0[rip]		            # rsi := &.LC0
	mov	rdi, rax		                # rdi := rax
	mov	eax, 0			                # eax := 0
	call	__isoc99_fscanf@PLT	        # Считываем число из файла
	mov	eax, DWORD PTR -8[rbp]          # eax := num
	mov	edx, DWORD PTR -4[rbp]          # edx := i
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]                 # rcx := &0[i]
	lea	rdx, A[rip]                     # rdx := &A[i]
	mov	DWORD PTR [rcx+rdx], eax        # A[i] := num
	add	DWORD PTR -4[rbp], 1	        # i += 1
.L5:
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cmp	eax, DWORD PTR -20[rbp]         # i < m
	jl	.L6                             # if i < n -> .L6
	nop                                 # / else
	nop                                 #
	leave                               # Выход из функции
	ret
	.size	fill_arr_from_file, .-fill_arr_from_file
	.globl	fill_arr_from_display
	.type	fill_arr_from_display, @function
fill_arr_from_display:			        # Заполнение массива из консоли
# 	endbr64			                    можем убрать
	push	rbp			                # Сохраняем rbp на стек
	mov	rbp, rsp		                # rbp := rsp
	sub	rsp, 32		                    # rsp -= 32
	mov	DWORD PTR -20[rbp], edi         # n := edi
	mov	DWORD PTR -4[rbp], 0            # i = 0
	jmp	.L8                             # -> .L8
.L9:
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]                     # rax := A[i]
	add	rax, rdx		                # rax += rdx
	mov	rsi, rax		                # rsi := rax
	lea	rdi, .LC0[rip]                  # rdi := &.LC0
	mov	eax, 0			                # eax := 0
	call	__isoc99_scanf@PLT	        # Считываем число
	add	DWORD PTR -4[rbp], 1	        # i += 1
.L8:
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cmp	eax, DWORD PTR -20[rbp]         # i < n
	jl	.L9                             # if i < n
	nop                                 # / else
	nop                                 #
	leave				                # Выход из функции
	ret
	.size	fill_arr_from_display, .-fill_arr_from_display
	.globl	make_new_arr
	.type	make_new_arr, @function
make_new_arr:			                # Расчет элементов массива В
#	endbr64		                        можем убрать
	push	rbp		                    # Сохраняем rbp на стек
	mov	rbp, rsp	                    # rbp := rsp
	mov	DWORD PTR -20[rbp], edi         # n = edi
	mov	DWORD PTR -4[rbp], 0            # i = 0
	jmp	.L11                            # -> .L11
.L12:
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	add	eax, 1		                    # i += 1
	cdqe
	lea	rdx, 0[0+rax*4]                 # A[i + 1]
	lea	rax, A[rip]                     # A[i]
	mov	edx, DWORD PTR [rdx+rax]        # B[i] = A[i + 1] - A[i]
	mov	eax, DWORD PTR -4[rbp]		    # eax := &(-4 на стеке)
	cdqe
	lea	rcx, 0[0+rax*4]                 # rcx = &A[i]
	lea	rax, A[rip]                     # A[i]
	mov	eax, DWORD PTR [rcx+rax]        # B[i] = A[i + 1] - A[i]
	mov	ecx, edx			            # ecx := edx
	sub	ecx, eax			            # ecx -= eax
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cdqe
	lea	rdx, 0[0+rax*4]                 # rdx := &A[i]
	lea	rax, B[rip]                     # rax := &B[i]
	mov	DWORD PTR [rdx+rax], ecx        # B[i] = A[i + 1] - A[i]
	add	DWORD PTR -4[rbp], 1            # i += 1
.L11:
	mov	eax, DWORD PTR -20[rbp]         # eax := n
	sub	eax, 1				            # eax -= 1
	cmp	DWORD PTR -4[rbp], eax          # i < n
	jl	.L12                            # if i < n -> .L12
	nop                                 # / else
	nop                                 #
	pop	rbp                             # clear
	ret
	.size	make_new_arr, .-make_new_arr
	.section	.rodata		            # .rodata
.LC1:
	.string	"%d "			            # .LC1 = "%d"
	.text					            # Code
	.globl	display_arr_in_file
	.type	display_arr_in_file, @function
display_arr_in_file:		            # Вывод массива в файл
#	endbr64		                        можем убрать
	push	rbp		                    # Сохраняем rbp на стеке
	mov	rbp, rsp	                    #rbp := rsp
	sub	rsp, 32	                        # rsp -= 32
	mov	DWORD PTR -20[rbp], edi         # n = edi
	mov	DWORD PTR -4[rbp], 0            # i = 0
	jmp	.L14                            # -> .L14
.L15:
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cdqe
	lea	rdx, 0[0+rax*4]                 # rdx := &A[i]
	lea	rax, B[rip]                     # rax := &B[i]
	mov	edx, DWORD PTR [rdx+rax]        # edx :=
	mov	rax, QWORD PTR output[rip]
	lea	rsi, .LC1[rip]
	mov	rdi, rax		                # rdi := rax
	mov	eax, 0			                # eax := 0
	call	fprintf@PLT		            # Выводим элемент в файл
	add	DWORD PTR -4[rbp], 1            # i += 1
.L14:
	mov	eax, DWORD PTR -20[rbp]         # eax := n
	sub	eax, 1			                # eax -= 1
	cmp	DWORD PTR -4[rbp], eax          # i = eax
	jl	.L15                            # jl -> .L15
	mov	rax, QWORD PTR output[rip]
	mov	rsi, rax		                # rsi := rax
	mov	edi, 10		                    # edi := 10
	call	fputc@PLT
	nop
	leave                               # / Выход из функции
	ret                                 #
	.size	display_arr_in_file, .-display_arr_in_file
	.globl	display_arr_in_console
	.type	display_arr_in_console, @function
display_arr_in_console:		            # Вывод массива в консоль
#	endbr64			                    можем убрать
	push	rbp			                # Сохраняем rbp на стек
	mov	rbp, rsp		                # rbp := rsp
	sub	rsp, 32		                    # rsp -= 32
	mov	DWORD PTR -20[rbp], edi         # n := edi
	mov	DWORD PTR -4[rbp], 0            # i = 0
	jmp	.L17                            # -> .L17
.L18:
	mov	eax, DWORD PTR -4[rbp]          # eax := i
	cdqe
	lea	rdx, 0[0+rax*4]                 #
	lea	rax, B[rip]                     #
	mov	eax, DWORD PTR [rdx+rax]        #
	mov	esi, eax		                # esi := eax
	lea	rdi, .LC1[rip]
	mov	eax, 0			                # eax := 0
	call	printf@PLT		            # Выводим элемент в консоль
	add	DWORD PTR -4[rbp], 1
.L17:
	mov	eax, DWORD PTR -20[rbp]         # eax := n
	sub	eax, 1                          # eax -= 1
	cmp	DWORD PTR -4[rbp], eax          # if i < eax
	jl	.L18                            # -> .L18
	mov	edi, 10                         # edi := 10
	call	putchar@PLT
	nop
	leave				                # Выход из функции
	ret                                 #
	.size	display_arr_in_console, .-display_arr_in_console
