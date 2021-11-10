!This test storing bytes, halfwords and words into memory
.begin
str1: 0x12345678
str2: 0x9abcdef0
str3: 0xabcdabcd
	inc %r1
	sth %r1, [0]
	inc %r1
	sth %r1, [2]

	inc %r1
	stb %r1, [4]
	inc %r1
	stb %r1, [5]
	inc %r1
	stb %r1, [6]
	inc %r1
	stb %r1, [7]

	inc %r1
	sth %r1, [1]
	inc %r1
	sth %r1, [3]

	add %r0, 4, %r2
	st %r1, [str1]
	st %r1, %r2 + str1
	st %r1, %r0, str3
	st %r1, [1]
	st %r1, [2]
	st %r1, [3]
	halt
.end
