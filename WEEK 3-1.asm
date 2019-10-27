.data
aa:	.asciiz "Alpha " 
bb:	.asciiz "Bravo "
cc:	.asciiz "Charlie "
dd:	.asciiz "Delta "
ee:	.asciiz "Echo "
ff:	.asciiz "Foxtrot "
gg:	.asciiz "Golf "
hh:	.asciiz "Hotel "
ii:	.asciiz "India "
jj:	.asciiz "Juliet "
kk:	.asciiz "Kilo "
lll:	.asciiz "Lima "
mm:	.asciiz "Mike "
nn:	.asciiz "November "
oo:	.asciiz "Oscar "
pp:	.asciiz "Papa "
qq:	.asciiz "Quebec "
rr:	.asciiz "Romeo "
ss:	.asciiz "Sierra "
tt:	.asciiz "Tango "
uu:	.asciiz "Uniform "
vv:	.asciiz "Victor "
ww:	.asciiz "Whisky "
xx:	.asciiz "X-ray "
yy:	.asciiz "Yankee "
zz:	.asciiz "Zulu "
zero:	.asciiz "zero "    
one:	.asciiz "one "
two:	.asciiz "two "
three:	.asciiz "three "
four:	.asciiz "four "
five:	.asciiz "five "
six:	.asciiz "six "
seven:	.asciiz "seven "
eight:	.asciiz "eight "
nine:	.asciiz "nine "
star:	.asciiz "* "
alphabet: .word aa, bb, cc, dd, ee, ff, gg, hh, ii, jj, kk, lll, mm, nn, oo, pp ,qq, rr, ss, tt, uu, vv, ww, xx, yy, zz
num:	 .word zero, one, two, three, four, five, six, seven, eight, nine

.text
        .globl main
main:
	li $s0, 'z'
	li $s1, 'a'
	li $s2, 'Z'
	li $s3, 'A'
	li $s4, '9'
	li $s5, '0'
	
getkey:
	li $v0,12
	syscall
	
compare:
	li $t0,'?'
	beq $v0,$t0,deal
	
	#judge if is lowwer letter
	slt $t0,$s0,$v0 #s0<v0?
	bne $t0,$0,dispstar
	
	slt $t0,$v0,$s1 #v0<s1?
	beq $t0,$0,dispalph
	
	#judge if is upper letter
	
	slt $t0,$s2,$v0
	bne $t0, $0, dispstar
	slt $t0, $v0, $s3
	beq $t0, $0, dispalphc
	
	#judge if is number
	slt $t0, $s4, $v0
	bne $t0, $0, dispstar
	slt $t0, $v0, $s5
	beq $t0, $0, dispnum
	
	j dispstar
	
dispalphc:#upper letter +32 =>lowwer letter
	addi $v0,$v0,32
	
dispalph:
	sub $v0,$v0,$s1 #v0 = v0 -'a'
	sll $v0,$v0,2
	la $t0,alphabet
	add $t0,$t0,$v0
	lw $a0,($t0)
	li $v0,4
	syscall
	j getkey
dispnum:
	sub $v0, $v0, $s5 #v0 -= '0'
	sll $v0, $v0, 2
	la $t0, num
	add $t0, $t0, $v0
	lw $a0, ($t0)
	li $v0, 4
	syscall
	j getkey
	
dispstar:
	la $a0, star
	li $v0, 4
	syscall
	j getkey
	
deal:
