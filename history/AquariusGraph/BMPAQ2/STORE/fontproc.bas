screen 9:cls
open"I",#1,"aqfont.txt"
open"O",#2,"font.dat"


for i = 1 to 256


input #1,a$: input #1,a$: input #1,a$

o$=""

for t= 1 to 8
input #1,d$
o$=o$+d$    
next t
print o$    
print #2,o$   
    
next i

close #2
close #1
