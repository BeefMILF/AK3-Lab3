.global lab3
.syntax unified

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	data: .asciz "kernel started\n"
	final: .asciz "Value in r3: "

__kernel_reset__:
    ldr r0, =data
    bl dbgput_line
	
	mov r0, #1  // a
    mov r1, #2  // b
    mov r2, #3  // c
    mov r4, #3  // 3

    // 2^c
    mov r3, #1
    lsl r3, r3, r2

    // (a - b) * 3 + 2^c
    sub r0, r1
    mla r3, r0, r4, r3
	mul r3, r2
    
	ldr r0, =final
	bl dbgput
	mov r0, r3
	bl dbgput_num

task_end:
        b task_end
