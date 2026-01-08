.data
INPUT_n: .quad 0
.text
__nonnull:
test %rdi, %rdi
jnz __nonnull_end
subq $8, %rbp
xorq %rdi, %rdi
callq perror
xorq %rdi, %rdi
incq %rdi
callq exit
__nonnull_end:
ret
_storestr:
pushq %rbp
movq %rsp, %rbp
pushq %rdi
pushq %rsi
movq (%rdi), %rdi
callq free
movq (%rsp), %rdi
callq strdup
movq %rax, %rdi
callq __nonnull
movq 8(%rsp), %rax
movq %rdi, (%rax)
addq $16, %rsp
popq %rbp
ret
INPUT:
pushq %rbp
movq %rsp, %rbp
pushq %rdi
pushq %rdi
movq (%rdi), %rdi
cmpq $0, %rdi
jz INPUT_null
callq strlen
jmp INPUT_getline
INPUT_null:
xorq %rax, %rax
INPUT_getline:
movq %rax, INPUT_n(%rip)
movq stdin(%rip), %rdx
leaq INPUT_n(%rip), %rsi
movq -8(%rbp), %rdi
callq getline
cmpq $-1, %rax
je INPUT_err
popq %rdi
movq (%rdi), %rdi
pushq %rdi
callq strlen
popq %rdi
movb $0, -1(%rdi, %rax, 1)
popq %rax
movq %rdi, (%rax)
popq %rbp
ret
INPUT_err:
movq -8(%rbp), %rax
movq (%rax), %rdi
callq free
movq $1, %rdi
callq malloc
movq %rax, -8(%rbp)
movq %rax, %rdi
callq __nonnull
movb $0, (%rdi)
popq %rax
movq %rdi, (%rax)
popq %rax
popq %rbp
ret
.globl main
main:
pushq %rbp
movq %rsp, %rbp
.file 1 "lex.bean"
.loc 1 3
.loc 1 4
.loc 1 5
.loc 1 6
.loc 1 7
.loc 1 8
.loc 1 9
.loc 1 10
.loc 1 11
.loc 1 12
.loc 1 13
.loc 1 14
.loc 1 15
.loc 1 16
.loc 1 17
.loc 1 18
.loc 1 19
.loc 1 20
leaq _S0(%rip), %rsi
leaq KEYWORDS(%rip), %rdi
callq _storestr
.loc 1 21
movq $1, RUNNING(%rip)
.loc 1 22
movq $1, LINENO(%rip)
.loc 1 23
movq $1, FIRSTPASS(%rip)
.loc 1 24
leaq LINE(%rip), %rdi
callq INPUT
.loc 1 25
leaq _S124(%rip), %rsi
movq LINE(%rip), %rdi
callq strcmp
xorq %rbx, %rbx
cmpq %rax, %rbx
jne 1f
.loc 1 26
leaq LINE(%rip), %rdi
callq INPUT
.loc 1 27
movq $0, I(%rip)
.loc 1 28
2:
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $'"', %r13
je 3f
.loc 1 29
incq I(%rip)
.loc 1 30
jmp 2b
3:
.loc 1 31
leaq _S149(%rip), %rdi
movq stdout(%rip), %rsi
callq fputs
.loc 1 32
2:
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $0, %r13
je 3f
.loc 1 33
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %rdi
callq putchar
.loc 1 34
incq I(%rip)
.loc 1 35
jmp 2b
3:
.loc 1 36
movq $'\n', %rdi
callq putchar
.loc 1 37
movq $3, LINENO(%rip)
.loc 1 38
movq $0, FIRSTPASS(%rip)
.loc 1 39
1:
.loc 1 40
1:
movq RUNNING(%rip), %rbx
cmpq $0, %rbx
je 2f
.loc 1 41
leaq _S158(%rip), %rdi
callq puts
.loc 1 42
movq LINENO(%rip), %rsi
leaq .fI(%rip), %rdi
xorb %al, %al
callq printf
movq $10, %rdi
callq putchar
.loc 1 43
incq LINENO(%rip)
.loc 1 44
xorq %rbx, %rbx
cmpq FIRSTPASS(%rip), %rbx
jne 3f
.loc 1 45
leaq LINE(%rip), %rdi
callq INPUT
.loc 1 46
3:
.loc 1 47
movq $0, FIRSTPASS(%rip)
.loc 1 48
movq LINE(%rip), %rdi
callq strlen
movq %rax, LEN(%rip)
.loc 1 49
movq LEN(%rip), %rbx
cmpq $0, %rbx
jne 3f
.loc 1 50
incq LINENO(%rip)
.loc 1 51
leaq LINE(%rip), %rdi
callq INPUT
.loc 1 52
movq LINE(%rip), %rdi
callq strlen
movq %rax, LEN(%rip)
.loc 1 53
movq LEN(%rip), %rbx
cmpq $0, %rbx
jne 4f
.loc 1 54
incq LINENO(%rip)
.loc 1 55
leaq LINE(%rip), %rdi
callq INPUT
.loc 1 56
movq LINE(%rip), %rdi
callq strlen
movq %rax, LEN(%rip)
.loc 1 57
movq LEN(%rip), %rbx
cmpq $0, %rbx
jne 5f
.loc 1 58
movq $0, RUNNING(%rip)
.loc 1 59
jmp 1b
.loc 1 60
5:
.loc 1 61
4:
.loc 1 62
3:
.loc 1 63
movq $0, I(%rip)
.loc 1 64
3:
movq I(%rip), %rbx
cmpq LEN(%rip), %rbx
jge 4f
.loc 1 65
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r11
movb %r11b, C(%rip)
.loc 1 66
movzbq C(%rip), %rbx
cmpq $' ', %rbx
jne 5f
.loc 1 67
incq I(%rip)
.loc 1 68
jmp 3b
.loc 1 69
5:
.loc 1 70
movzbq C(%rip), %rbx
cmpq $'\t', %rbx
jne 5f
.loc 1 71
incq I(%rip)
.loc 1 72
jmp 3b
.loc 1 73
5:
.loc 1 74
movzbq C(%rip), %rbx
cmpq $'/', %rbx
jne 5f
.loc 1 75
movq I(%rip), %r12
addq $1, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'/', %r13
jne 6f
.loc 1 76
addq $2, I(%rip)
.loc 1 77
jmp 3b
.loc 1 78
6:
.loc 1 79
5:
.loc 1 80
movzbq C(%rip), %rbx
cmpq $'"', %rbx
jne 5f
.loc 1 81
movq $'"', %rdi
callq putchar
.loc 1 82
incq I(%rip)
.loc 1 83
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r11
movb %r11b, C(%rip)
.loc 1 84
6:
movzbq C(%rip), %rbx
cmpq $'"', %rbx
je 7f
.loc 1 85
incq I(%rip)
.loc 1 86
movq LEN(%rip), %r12
addq $1, %r12
movq I(%rip), %rbx
cmpq %r12, %rbx
jle 8f
movq $0, RUNNING(%rip)
.loc 1 87
movq $'#', %rdi
callq putchar
.loc 1 87
movq $'\n', %rdi
callq putchar
.loc 1 87
movq LINENO(%rip), %rsi
leaq .fI(%rip), %rdi
xorb %al, %al
callq printf
movq $10, %rdi
callq putchar
.loc 1 88
leaq _S162(%rip), %rdi
callq puts
.loc 1 89
movb $'"', C(%rip)
.loc 1 90
jmp 6b
.loc 1 91
8:
.loc 1 92
movzbq C(%rip), %rdi
callq putchar
.loc 1 93
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r11
movb %r11b, C(%rip)
.loc 1 94
jmp 6b
7:
.loc 1 95
movq $'\n', %rdi
callq putchar
.loc 1 96
incq I(%rip)
.loc 1 97
jmp 3b
.loc 1 98
5:
.loc 1 99
movzbq C(%rip), %rdi
callq isalpha
xorq %rbx, %rbx
cmpq %rax, %rbx
je 5f
.loc 1 100
leaq WORDBUFFER(%rip), %rdi
movq LINE(%rip), %rsi
callq _storestr
.loc 1 101
movq $0, WORDBUFFERIDX(%rip)
.loc 1 102
movq WORDBUFFERIDX(%rip), %r12
movq WORDBUFFER(%rip), %rbx
movzbq C(%rip), %r11
movb %r11b, (%rbx, %r12, 1)
.loc 1 103
incq I(%rip)
.loc 1 104
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r11
movb %r11b, C(%rip)
.loc 1 105
movq $1, FAILED(%rip)
.loc 1 106
movzbq C(%rip), %rdi
callq isalnum
xorq %rbx, %rbx
cmpq %rax, %rbx
je 6f
.loc 1 107
movq $0, FAILED(%rip)
.loc 1 108
6:
.loc 1 109
movzbq C(%rip), %rbx
cmpq $'_', %rbx
jne 6f
.loc 1 110
movq $0, FAILED(%rip)
.loc 1 111
6:
.loc 1 112
6:
xorq %rbx, %rbx
cmpq FAILED(%rip), %rbx
jne 7f
.loc 1 113
incq WORDBUFFERIDX(%rip)
.loc 1 114
movq WORDBUFFERIDX(%rip), %r12
movq WORDBUFFER(%rip), %rbx
movzbq C(%rip), %r11
movb %r11b, (%rbx, %r12, 1)
.loc 1 115
incq I(%rip)
.loc 1 116
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r11
movb %r11b, C(%rip)
.loc 1 117
movq $1, FAILED(%rip)
.loc 1 118
movzbq C(%rip), %rdi
callq isalnum
xorq %rbx, %rbx
cmpq %rax, %rbx
je 8f
.loc 1 119
movq $0, FAILED(%rip)
.loc 1 120
8:
.loc 1 121
movzbq C(%rip), %rbx
cmpq $'_', %rbx
jne 8f
.loc 1 122
movq $0, FAILED(%rip)
.loc 1 123
8:
.loc 1 124
jmp 6b
7:
.loc 1 125
incq WORDBUFFERIDX(%rip)
.loc 1 126
movq WORDBUFFERIDX(%rip), %r12
movq WORDBUFFER(%rip), %rbx
movb $0, (%rbx, %r12, 1)
.loc 1 127
movq $0, J(%rip)
.loc 1 128
6:
movq KEYWORDS(%rip), %rbx
movq J(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $0, %r13
je 7f
.loc 1 129
movq $0, K(%rip)
.loc 1 130
8:
movq KEYWORDS(%rip), %rbx
movq J(%rip), %r12
movq WORDBUFFER(%rip), %r13
movq K(%rip), %r14
movzbq (%rbx, %r12, 1), %r15
movzbq (%r13, %r14, 1), %r11
cmpq %r11, %r15
jne 9f
.loc 1 131
incq J(%rip)
.loc 1 132
incq K(%rip)
.loc 1 133
jmp 8b
9:
.loc 1 134
movq KEYWORDS(%rip), %rbx
movq J(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $' ', %r13
jne 8f
.loc 1 135
movq WORDBUFFER(%rip), %rbx
movq K(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $0, %r13
jne 9f
.loc 1 136
movq $'.', %rdi
callq putchar
.loc 1 137
movq $0, K(%rip)
.loc 1 138
10:
movq WORDBUFFER(%rip), %rbx
movq K(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $0, %r13
je 11f
.loc 1 139
movq WORDBUFFER(%rip), %rbx
movq K(%rip), %r12
movzbq (%rbx, %r12, 1), %rdi
callq putchar
.loc 1 140
incq K(%rip)
.loc 1 141
jmp 10b
11:
.loc 1 142
movq $'\n', %rdi
callq putchar
.loc 1 143
10:
movq KEYWORDS(%rip), %rbx
movq J(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $0, %r13
je 11f
.loc 1 144
incq J(%rip)
.loc 1 145
jmp 10b
11:
.loc 1 146
xorq %rbx, %rbx
subq $1, %rbx
movq %rbx, WORDBUFFERIDX(%rip)
.loc 1 147
jmp 6b
.loc 1 148
9:
.loc 1 149
8:
.loc 1 150
8:
movq KEYWORDS(%rip), %rbx
movq J(%rip), %r12
movzbq (%rbx, %r12, 1), %r13
cmpq $' ', %r13
je 9f
.loc 1 151
incq J(%rip)
.loc 1 152
jmp 8b
9:
.loc 1 153
incq J(%rip)
.loc 1 154
jmp 6b
7:
.loc 1 155
xorq %rbx, %rbx
subq $1, %rbx
movq WORDBUFFERIDX(%rip), %r12
cmpq %rbx, %r12
jne 6f
.loc 1 156
jmp 3b
.loc 1 157
6:
.loc 1 158
movq $0, J(%rip)
.loc 1 159
6:
movq J(%rip), %rbx
cmpq WORDBUFFERIDX(%rip), %rbx
jge 7f
.loc 1 160
movq WORDBUFFER(%rip), %rbx
movq J(%rip), %r12
movzbq (%rbx, %r12, 1), %rdi
callq putchar
.loc 1 161
incq J(%rip)
.loc 1 162
jmp 6b
7:
.loc 1 163
movq $'\n', %rdi
callq putchar
.loc 1 164
jmp 3b
.loc 1 165
5:
.loc 1 166
movzbq C(%rip), %rdi
callq isdigit
xorq %rbx, %rbx
cmpq %rax, %rbx
je 5f
.loc 1 167
movzbq C(%rip), %rdi
callq putchar
.loc 1 168
incq I(%rip)
.loc 1 169
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r11
movb %r11b, C(%rip)
.loc 1 170
6:
movzbq C(%rip), %rdi
callq isdigit
cmpq $0, %rax
je 7f
.loc 1 171
movzbq C(%rip), %rdi
callq putchar
.loc 1 172
incq I(%rip)
.loc 1 173
movq LINE(%rip), %rbx
movq I(%rip), %r12
movzbq (%rbx, %r12, 1), %r11
movb %r11b, C(%rip)
.loc 1 174
jmp 6b
7:
.loc 1 175
movq $'\n', %rdi
callq putchar
.loc 1 176
jmp 3b
.loc 1 177
5:
.loc 1 178
movzbq C(%rip), %rbx
cmpq $'\'', %rbx
jne 5f
.loc 1 179
movq LEN(%rip), %rbx
subq $3, %rbx
movq I(%rip), %r12
cmpq %rbx, %r12
jle 6f
movq $0, RUNNING(%rip)
.loc 1 180
movq $'#', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 181
movq LINENO(%rip), %rsi
leaq .fI(%rip), %rdi
xorb %al, %al
callq printf
movq $10, %rdi
callq putchar
.loc 1 182
leaq _S180(%rip), %rdi
callq puts
.loc 1 183
jmp 3b
.loc 1 184
6:
.loc 1 185
movq I(%rip), %r12
addq $1, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'\\', %r13
jne 6f
.loc 1 186
movq LEN(%rip), %rbx
subq $4, %rbx
movq I(%rip), %r12
cmpq %rbx, %r12
jle 7f
movq $0, RUNNING(%rip)
.loc 1 187
movq $'#', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 188
movq LINENO(%rip), %rsi
leaq .fI(%rip), %rdi
xorb %al, %al
callq printf
movq $10, %rdi
callq putchar
.loc 1 189
leaq _S205(%rip), %rdi
callq puts
.loc 1 190
jmp 3b
.loc 1 191
7:
.loc 1 192
movq I(%rip), %r12
addq $3, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'\'', %r13
je 7f
movq $0, RUNNING(%rip)
.loc 1 193
movq $'#', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 194
movq LINENO(%rip), %rsi
leaq .fI(%rip), %rdi
xorb %al, %al
callq printf
movq $10, %rdi
callq putchar
.loc 1 195
leaq _S230(%rip), %rdi
callq puts
.loc 1 196
jmp 3b
.loc 1 197
7:
.loc 1 198
movq $'\'', %rdi
callq putchar
.loc 1 198
movq $'\\', %rdi
callq putchar
.loc 1 198
movq I(%rip), %r12
addq $2, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %rdi
callq putchar
.loc 1 198
movq $'\'', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 199
addq $4, I(%rip)
.loc 1 200
jmp 3b
.loc 1 201
6:
.loc 1 202
movq I(%rip), %r12
addq $2, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'\'', %r13
je 6f
movq $0, RUNNING(%rip)
.loc 1 203
movq $'#', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 204
movq LINENO(%rip), %rsi
leaq .fI(%rip), %rdi
xorb %al, %al
callq printf
movq $10, %rdi
callq putchar
.loc 1 205
leaq _S255(%rip), %rdi
callq puts
.loc 1 206
jmp 3b
.loc 1 207
6:
.loc 1 208
movq $'\'', %rdi
callq putchar
.loc 1 208
movq I(%rip), %r12
addq $1, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %rdi
callq putchar
.loc 1 208
movq $'\'', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 209
addq $3, I(%rip)
.loc 1 210
jmp 3b
.loc 1 211
5:
.loc 1 212
movzbq C(%rip), %rbx
cmpq $'<', %rbx
jne 5f
.loc 1 213
movq I(%rip), %r12
addq $1, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'-', %r13
jne 6f
.loc 1 214
movq $'<', %rdi
callq putchar
.loc 1 214
movq $'-', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 215
addq $2, I(%rip)
.loc 1 216
jmp 3b
.loc 1 217
6:
.loc 1 218
movq I(%rip), %r12
addq $1, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'>', %r13
jne 6f
.loc 1 219
movq $'<', %rdi
callq putchar
.loc 1 219
movq $'>', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 220
addq $2, I(%rip)
.loc 1 221
jmp 3b
.loc 1 222
6:
.loc 1 223
movq I(%rip), %r12
addq $1, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'=', %r13
jne 6f
.loc 1 224
movq $'<', %rdi
callq putchar
.loc 1 224
movq $'=', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 225
addq $2, I(%rip)
.loc 1 226
jmp 3b
.loc 1 227
6:
.loc 1 228
5:
.loc 1 229
movzbq C(%rip), %rbx
cmpq $'>', %rbx
jne 5f
.loc 1 230
movq I(%rip), %r12
addq $1, %r12
movq LINE(%rip), %rbx
movzbq (%rbx, %r12, 1), %r13
cmpq $'=', %r13
jne 6f
.loc 1 231
movq $'>', %rdi
callq putchar
.loc 1 231
movq $'=', %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 232
addq $2, I(%rip)
.loc 1 233
jmp 3b
.loc 1 234
6:
.loc 1 235
5:
.loc 1 236
movzbq C(%rip), %rdi
callq putchar
movq $10, %rdi
callq putchar
.loc 1 237
incq I(%rip)
.loc 1 238
jmp 3b
4:
.loc 1 239
jmp 1b
2:
.loc 1 240
