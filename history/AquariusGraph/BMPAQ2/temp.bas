Screenres 1024,768,32: CLS
DIM garray(320 * 192) AS INTEGER
BLOAD "gang.bmp", @garray(0)
PUT (0,0),garray(0)
for x=0 to (320*192)
locate 3,50:print x;" - ";garray(x+1);"     "
b=int(x/320)
a=x-b

locate 4,50:print a;" - ";b;" - ";point(a,b);"         "
input j$

next x


input g$
