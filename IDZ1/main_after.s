	.intel_syntax noprefix
	.text					# Начинает секцию 
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:		# функция для подсчета времни исполнения программы
#	endbr64	<- можно убрать
	push	rbp       			# Сохраняем rbp на стек
	mov	rbp, rsp  			# rbp := rsp
	mov	rax, rsi  			# rax := rsi
	mov	r8, rdi   			# r8 := rdi
	mov	rsi, r8   			# rsi := r8
	mov	rdi, r9   			# rdi := r9
	mov	rdi, rax  			# rdi := rax
	mov	QWORD PTR -32[rbp], rsi		
	mov	QWORD PTR -24[rbp], rdi	
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000		# nsecA *= 1000000000
	mov	QWORD PTR -8[rbp], rax		
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -8[rbp], rax		# nsecA += timeA.tv_nsec
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax	
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000		# nsecB *= 1000000000
	mov	QWORD PTR -16[rbp], rax	
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -16[rbp], rax	# nsecB += timeB.tv_nsec
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]	
	pop	rbp
	ret
	.size	timespecDiff, .-timespecDiff
	.comm	A,40000,32
	.comm	B,40000,32
	.comm	input,8,8
	.comm	output,8,8
	.section	.rodata		# .rodata
.LC0:
	.string	"%d"			# LC0: "%d"
.LC1:
	.string	"Elapsed: %ld ns"	# .LC1: "Elapsed: %ld ns"
.LC2:
	.string	"r"			# .LC2: "r"
.LC3:
	.string	"w"			# .LC3: "w"
	.text					# секция с кодом
	.globl	main
main:						
#	endbr64				можем убрать
	push	rbp				# Сохраняем rbp на стек
	mov	rbp, rsp			# rbp := rsp
	sub	rsp, 96			# rsp -= 96
	mov	DWORD PTR -84[rbp], edi	# rdi - 1-й - argc
	mov	QWORD PTR -96[rbp], rsi	# rsi - 2-й - argv
	cmp	DWORD PTR -84[rbp], 1		# if argc == 1
	jne	.L4				
	lea	rax, -40[rbp]			# rax := &(-40 на стеке)
	mov	rsi, rax			# rsi = rax
	lea	rdi, .LC0[rip]			# rdi := .LC0
	mov	eax, 0				# eax = 0
	call	__isoc99_scanf@PLT		# scanf("%d", &n)
	mov	eax, DWORD PTR -40[rbp]	# input n
	mov	edi, eax			# edi = n
	call	fill_arr_from_display@PLT 	# Вызов функции вывода #массива на консоль
	lea	rax, -64[rbp]			# rax := &(-64 на стеке)
	mov	rsi, rax			# rsi := rax
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# Запуск таймера
	mov	eax, DWORD PTR -40[rbp]	# eax := -40 на стеке
	mov	edi, eax			# edi = eax
	call	make_new_arr@PLT		# Вызов функции для массива В
	lea	rax, -80[rbp]			# rax := &(-80 на стеке)
	mov	rsi, rax			# rsi := rax
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# Остановка таймера
	mov	rax, QWORD PTR -64[rbp]	
	mov	rdx, QWORD PTR -56[rbp]	
	mov	rdi, QWORD PTR -80[rbp]
	mov	rsi, QWORD PTR -72[rbp]
	mov	rcx, rdx			# rcx := rdx
	mov	rdx, rax			# rdx := rax
	call	timespecDiff			# Расчет времени исполнения
	mov	QWORD PTR -24[rbp], rax	# elapsed_ns := rax
	mov	eax, DWORD PTR -40[rbp]	# eax := n 
	mov	edi, eax			# edi := n
	call	display_arr_in_console@PLT	# Выводим массив в консоль
	mov	rax, QWORD PTR -24[rbp]	# rax := elapsed_ns
	mov	rsi, rax			# rsi := elapsed_ns
	lea	rdi, .LC1[rip]			# rdi := .LC1
	mov	eax, 0				# eax := 0
	call	printf@PLT			# Перевод строки
	mov	edi, 10			# edi := 10
	call	putchar@PLT
	mov	eax, 0				# eax := 0
	jmp	.L8				# -> .L8
.L4:
	cmp	DWORD PTR -84[rbp], 2		# if argc == 2
	jne	.L6		
	lea	rax, -40[rbp]			# rax := &(-40 на стеке)
	mov	rsi, rax			# rsi := rax
	lea	rdi, .LC0[rip]			# rdi := .LC0
	mov	eax, 0				# eax := 0
	call	__isoc99_scanf@PLT		# scanf("%d", &n)
	mov	rax, QWORD PTR -96[rbp]	# rax := -96 на стеке
	mov	rax, QWORD PTR 8[rax]		# arg argv[1]	
	mov	QWORD PTR -32[rbp], rax	
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax			# rdi := rax
	call	atoi@PLT			# seed = atoi(arg)
	mov	DWORD PTR -36[rbp], eax
	mov	eax, DWORD PTR -36[rbp]	# eax := -36 на стеке
	mov	edi, eax			# edi := eax
	call	srand@PLT			# srand(seed)
	mov	eax, DWORD PTR -40[rbp]	# eax := n
	mov	edi, eax			# edi := eax
	call	fill_rand_arr@PLT		# Заполняем массив #рандомными элементами
	lea	rax, -64[rbp]			# rax := &(-64 на стеке)
	mov	rsi, rax			# rsi := rax
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# Запуск таймера
	mov	eax, DWORD PTR -40[rbp]	# eax := -40 на стеке
	mov	edi, eax			# edi := eax
	call	make_new_arr@PLT		# Задаем массив В
	lea	rax, -80[rbp]			# rax := &(-80 на стеке)
	mov	rsi, rax			# rsi := rax
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# Останавливаем таймер
	mov	rax, QWORD PTR -64[rbp]
	mov	rdx, QWORD PTR -56[rbp]
	mov	rdi, QWORD PTR -80[rbp]
	mov	rsi, QWORD PTR -72[rbp]
	mov	rcx, rdx			# rcx := rdx
	mov	rdx, rax			# rdx := rax
	call	timespecDiff			# elapsed_ns
	mov	QWORD PTR -24[rbp], rax	# elapsed_ns := rax
	mov	eax, DWORD PTR -40[rbp]	# eax := n
	mov	edi, eax			# edi := n
	call	display_arr_in_console@PLT	# Выводим массив в консоль
	mov	rax, QWORD PTR -24[rbp]	# rax := elapsed_ns
	mov	rsi, rax			# rsi := rax
	lea	rdi, .LC1[rip]			# rdi := .LC1
	mov	eax, 0				# eax := 0
	call	printf@PLT			# Пустая строка
	mov	edi, 10			# edi := 10
	call	putchar@PLT
	mov	eax, 0				# eax := 0
	jmp	.L8				# -> .L8
.L6:
	cmp	DWORD PTR -84[rbp], 3		# if argc == 3
	jne	.L7
	mov	rax, QWORD PTR -96[rbp]	# rax := -96 на стеке
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -96[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC2[rip]
	mov	rdi, rax			# rdi := rax
	call	fopen@PLT			# Открываем файл для чтения
	mov	QWORD PTR input[rip], rax	# Указатель на файл для #чтения
	mov	rax, QWORD PTR -16[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax			# rdi := rax
	call	fopen@PLT			# Открываем файл для записи
	mov	QWORD PTR output[rip], rax	# Указатель на файл для #записи
	mov	rax, QWORD PTR input[rip]	
	lea	rdx, -40[rbp]			# rdx := &(-40 на стеке)
	lea	rsi, .LC0[rip]			# rsi := .LC0
	mov	rdi, rax			# rdi := rax
	mov	eax, 0				# eax := 0
	call	__isoc99_fscanf@PLT		# Считываем n из файла
	mov	eax, DWORD PTR -40[rbp]	# eax := &(-40 на стеке)
	mov	edi, eax			# edi := eax
	call	fill_arr_from_file@PLT		# Заполняем массив из данныз #из файла
	lea	rax, -64[rbp]			# rax := &(-64 на стеке)
	mov	rsi, rax			# rsi := rax
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# Запускаем таймер
	mov	eax, DWORD PTR -40[rbp]	# eax := -40 на стеке
	mov	edi, eax			# edi := eax
	call	make_new_arr@PLT		# Задаем массив В
	lea	rax, -80[rbp]			# rax := &(-80 на стеке)
	mov	rsi, rax			# rsi := rax
	mov	edi, 1				# edi := 1
	call	clock_gettime@PLT		# Останавливаем таймер
	mov	rax, QWORD PTR -64[rbp]
	mov	rdx, QWORD PTR -56[rbp]
	mov	rdi, QWORD PTR -80[rbp]
	mov	rsi, QWORD PTR -72[rbp]
	mov	rcx, rdx			# rcx := rdx
	mov	rdx, rax			# edx := rax
	call	timespecDiff			# Рассчитываем время #исполнения
	mov	QWORD PTR -24[rbp], rax
	mov	eax, DWORD PTR -40[rbp]
	mov	edi, eax			# edi := eax
	call	display_arr_in_file@PLT	# Выводим массив в файл
	mov	rax, QWORD PTR output[rip]
	mov	rdx, QWORD PTR -24[rbp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax			# edi := rax
	mov	eax, 0				# eax := 0
	call	fprintf@PLT			# Выводим время исполнения
	mov	eax, 0				# eax := 0
	jmp	.L8				# -> .L8
.L7:
	mov	eax, 1				# eax := 1
.L8:
	leave					# Выход из функции
	ret					
	.size	main, .-main
