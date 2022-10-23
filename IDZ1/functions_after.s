	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.globl	fill_rand_arr
	.type	fill_rand_arr, @function
fill_rand_arr:			# Заполнение массива рандоиными элементами
#	endbr64
	push	rbp		# Сохраняем rbp на стек
	mov	rbp, rsp	# rbp := rsp
	sub	rsp, 32	# rsp -= 32
	mov	DWORD PTR -20[rbp], edi	
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L3:
	call	rand@PLT	# rand()
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	shr	rdx, 32
	mov	ecx, edx	# ecx := edx
	sar	ecx, 5
	cdq
	sub	ecx, edx	# ecx -= edx
	mov	edx, ecx	# edx := ecx
	imul	edx, edx, 100
	sub	eax, edx	# eax -= edx
	mov	edx, eax	# edx := eax
	lea	ecx, -100[rdx]	
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]
	mov	DWORD PTR [rdx+rax], ecx
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L3
	nop
	nop
	leave				# Выход из функции
	ret
	.size	fill_rand_arr, .-fill_rand_arr
	.section	.rodata		# .rodata
.LC0:
	.string	"%d"			# .LC0 = "%d"
	.text					# Code
	.globl	fill_arr_from_file
	.type	fill_arr_from_file, @function
fill_arr_from_file:			# Заполнение массива из данных из #файла
#	endbr64 			<- можно убрать
	push	rbp			# Сохраняем rbp на стек
	mov	rbp, rsp		# rbp := rsp
	sub	rsp, 32		# rsp -= 32
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L5
.L6:
	mov	rax, QWORD PTR input[rip]	
	lea	rdx, -8[rbp]		# rdx := &(-8 на стеке)
	lea	rsi, .LC0[rip]		# rsi := .LC0
	mov	rdi, rax		# edi := rax
	mov	eax, 0			# eax := 0
	call	__isoc99_fscanf@PLT	# Считываем число из файла
	mov	eax, DWORD PTR -8[rbp]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, A[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -4[rbp], 1	# i += 1
.L5:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L6
	nop
	nop
	leave
	ret
	.size	fill_arr_from_file, .-fill_arr_from_file
	.globl	fill_arr_from_display
	.type	fill_arr_from_display, @function
fill_arr_from_display:			# Заполнение массива из консоли
# 	endbr64			можем убрать
	push	rbp			# Сохраняем rbp на стек
	mov	rbp, rsp		# rbp := rsp
	sub	rsp, 32		# rsp -= 32
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]
	add	rax, rdx		# rax += rdx
	mov	rsi, rax		# rsi := rax
	lea	rdi, .LC0[rip]
	mov	eax, 0			# eax := 0
	call	__isoc99_scanf@PLT	# Считываем число
	add	DWORD PTR -4[rbp], 1	# i += 1
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L9
	nop
	nop
	leave				# Выход из функции
	ret
	.size	fill_arr_from_display, .-fill_arr_from_display
	.globl	make_new_arr
	.type	make_new_arr, @function
make_new_arr:			# Расчет элементов массива В
#	endbr64		можем убрать
	push	rbp		# Сохраняем rbp на стек
	mov	rbp, rsp	# rbp := rsp
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L11
.L12:
	mov	eax, DWORD PTR -4[rbp]
	add	eax, 1		# eax += 1
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, A[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -4[rbp]		# eax := &(-4 на стеке)
	cdqe
	lea	rcx, 0[0+rax*4]
	lea	rax, A[rip]
	mov	eax, DWORD PTR [rcx+rax]
	mov	ecx, edx			# ecx := edx
	sub	ecx, eax			# ecx -= eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, B[rip]
	mov	DWORD PTR [rdx+rax], ecx
	add	DWORD PTR -4[rbp], 1
.L11:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1				# eax -= 1
	cmp	DWORD PTR -4[rbp], eax
	jl	.L12
	nop
	nop
	pop	rbp
	ret
	.size	make_new_arr, .-make_new_arr
	.section	.rodata		# .rodata
.LC1:
	.string	"%d "			# .LC1 = "%d"
	.text					# Code
	.globl	display_arr_in_file
	.type	display_arr_in_file, @function
display_arr_in_file:		# Вывод массива в файл
#	endbr64		можем убрать
	push	rbp		# Сохраняем rbp на стеке
	mov	rbp, rsp	#rbp := rsp
	sub	rsp, 32	# rsp -= 32
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L14
.L15:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, B[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	rax, QWORD PTR output[rip]
	lea	rsi, .LC1[rip]
	mov	rdi, rax		# rdi := rax
	mov	eax, 0			# eax := 0
	call	fprintf@PLT		# Выводим элемент в файл
	add	DWORD PTR -4[rbp], 1
.L14:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1			# eax -= 1
	cmp	DWORD PTR -4[rbp], eax
	jl	.L15
	mov	rax, QWORD PTR output[rip]
	mov	rsi, rax		# rsi := rax
	mov	edi, 10		# edi := 10
	call	fputc@PLT
	nop
	leave
	ret
	.size	display_arr_in_file, .-display_arr_in_file
	.globl	display_arr_in_console
	.type	display_arr_in_console, @function
display_arr_in_console:		# Вывод массива в консоль
#	endbr64			можем убрать
	push	rbp			# Сохраняем rbp на стек
	mov	rbp, rsp		# rbp := rsp
	sub	rsp, 32		# rsp -= 32
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L17
.L18:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, B[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax		# esi := eax
	lea	rdi, .LC1[rip]
	mov	eax, 0			# eax := 0
	call	printf@PLT		# Выводим элемент в консоль
	add	DWORD PTR -4[rbp], 1
.L17:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	cmp	DWORD PTR -4[rbp], eax
	jl	.L18
	mov	edi, 10
	call	putchar@PLT
	nop
	leave				# Выход из функции
	ret
	.size	display_arr_in_console, .-display_arr_in_console
