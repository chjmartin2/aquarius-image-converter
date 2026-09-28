#define WIN_INCLUDEALL

#include once "windows.bi"

function file_getname( byval hWnd as HWND ) as string

        dim ofn as OPENFILENAME
        dim filen as zstring * MAX_PATH+1
        dim filemask as string
        
        filemask = "BMP Files, (*.BMP)"+chr$(0)+"*.BMP"+chr$(0)+chr$(0)
        with ofn
                .lStructSize           = sizeof( OPENFILENAME )
                .hwndOwner             = hWnd
                .hInstance             = GetModuleHandle( NULL )
                .lpstrFilter           = strptr( filemask )
                .lpstrCustomFilter     = NULL
                .nMaxCustFilter        = 0
                .nFilterIndex          = 1
                .lpstrFile             = @filen
                .nMaxFile              = sizeof( filen )
                .lpstrFileTitle        = NULL
                .nMaxFileTitle         = 0
                .lpstrInitialDir       = NULL
                .lpstrTitle            = @"Select BMP File to Process..."
                .Flags                 = OFN_EXPLORER or OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST
                .nFileOffset           = 0
                .nFileExtension        = 0
                .lpstrDefExt           = NULL
                .lCustData             = 0
                .lpfnHook              = NULL
                .lpTemplateName        = NULL
        end with
        
        if( GetOpenFileName( @ofn ) = FALSE ) then
                return ""
        else
                return filen
        end if

end Function

DIM image(80, 72), charo(2, 3), COLL(16), codis(16, 16), outbmp(80, 72), outcol(40, 24, 2), outchar(40, 24), collok(16), FOUTCHAR(960), FOUTFORE(960), FOUTBACK(960)
Dim ret As String

CLS : LOCATE 1, 1
FILENAME$ = "-"
TOGGLE = 0

filename$=file_getname(NULL)
SAVENAME$=left(filename$,len(filename$)-4)+".AQ"

PRINT "Loading Color Distance Table"

FOR i = 1 TO 16
  FOR j = 1 TO 16
     READ codis(i, j)
     LOCATE 2, 1: PRINT "Index "; i; j
  NEXT j
NEXT i

LOCATE 3, 1

PRINT "Loading Color Lookup Table"

FOR i = 1 TO 16

  READ collok(i)
  LOCATE 4, 1: PRINT "Color "; i; collok(i)
NEXT i

gosub start

END: REM -- end of program

REM -----------------------------------
REM ---- load .BMP file subroutine ----
REM -----------------------------------
REM known bug: image not loaded properly when (XSIZEBMP MOD 4) <> 0

START:

SCREEN 9: CLS
B = 0
IPOS = 0
OPEN "I", 1, FILENAME$
OPEN "O", 2, SAVENAME$
FOR i = 0 TO 117
   B = ASC(INPUT$(1, #1))
   IF (IPOS = 0) AND (B <> 66) THEN GOTO NOTBMP: REM no header "B"
   IF (IPOS = 1) AND (B <> 77) THEN GOTO NOTBMP: REM no header "M"
   IF (IPOS = 18) THEN XSIZEBMP = B
   IF (IPOS = 19) THEN XSIZEBMP = XSIZEBMP + (B * 256)
   IF (IPOS = 22) THEN YSIZEBMP = B
   IF (IPOS = 23) THEN YSIZEBMP = YSIZEBMP + (B * 256)
   IF (IPOS = 28) AND (B <> 4) THEN GOTO NOT16: REM not 4 bits, 16 color
   IPOS = IPOS + 1
NEXT i
IF (XSIZEBMP <> 80 OR YSIZEBMP <> 72) THEN GOTO NOT8072: REM not right size
REM ---- pixels in .BMP are stored from bottom left to top right ----
xpos = 0
YPOS = YSIZEBMP - 1
LOCATE 2, 13: PRINT "Conversion in Process..."
LOCATE 3, 13: PRINT "Filename: "; FILENAME$
LOCATE 4, 13: PRINT "Output: "; SAVENAME$
WHILE (EOF(1) = 0)
   B = ASC(INPUT$(1, #1))
   PIXEL = INT(B / 16)
   PIXEL = B AND 15

LOCATE 5, 13: PRINT "X: "; xpos; " Y: "; YPOS; " C: "; PIXEL
WEND

   LOCATE 7, 13: PRINT "Reading Array..."
     FOR y = 1 TO 72
        FOR X = 1 TO 80

           LOCATE 8, 13:   PRINT "X: "; X; " Y: "; y; " C: "; image(X, y)
           PSET (X - 1, y + 80), image(X, y)

        NEXT X
     NEXT y

   LOCATE 9, 13: PRINT "Processing Array..."

   FOR row = 1 TO 72 STEP 3
     FOR X = 1 TO 80 STEP 2
       LOCATE 10, 13: PRINT "Col "; X; "Row "; row
       MAXI = 0: SEC = 0
       ERASE charo, COLL

       FOR g = 0 TO 1
         FOR h = 0 TO 2
           charo(g, h) = image(X + g, row + h) + 1
           COLL((image(X + g, row + h) + 1)) = COLL((image(X + g, row + h) + 1)) + 1
           LOCATE 11, 13: PRINT g; h; image(X + g, row + h)
         NEXT h
       NEXT g

       LOCATE 12, 13: PRINT "0 - "; COLL(1):  LOCATE 12, 21: PRINT "8 - "; COLL(9)
       LOCATE 13, 13: PRINT "1 - "; COLL(2):  LOCATE 13, 21: PRINT "9 - "; COLL(10)
       LOCATE 14, 13: PRINT "2 - "; COLL(3):  LOCATE 14, 21: PRINT "10 - "; COLL(11)
       LOCATE 15, 13: PRINT "3 - "; COLL(4):  LOCATE 15, 21: PRINT "11 - "; COLL(12)
       LOCATE 16, 13: PRINT "4 - "; COLL(5):  LOCATE 16, 21: PRINT "12 - "; COLL(13)
       LOCATE 17, 13: PRINT "5 - "; COLL(6):  LOCATE 17, 21: PRINT "13 - "; COLL(14)
       LOCATE 18, 13: PRINT "6 - "; COLL(7):  LOCATE 18, 21: PRINT "14 - "; COLL(15)
       LOCATE 19, 13: PRINT "7 - "; COLL(8):  LOCATE 19, 21: PRINT "15 - "; COLL(16)

       FOR S = 1 TO 16
         FOR h = 1 TO 16
           IF COLL(h) > COLL(S) THEN MAXI = h
         NEXT h
       NEXT S

       FOR V = 1 TO 16
         FOR j = 1 TO 16
           IF j <> MAXI AND COLL(j) > COLL(V) THEN SEC = j
         NEXT j
       NEXT V

       IF SEC = 0 THEN SEC = MAXI

       LOCATE 20, 13: PRINT "FIRST: "; MAXI; " SECOND: "; SEC

       

       outcol((X-1) / 2, (row-1) / 3, 1) = collok(MAXI)
       outcol((X-1) / 2, (row-1) / 3, 2) = collok(SEC)
      
       FOR F = 0 TO 1
          FOR o = 0 TO 2
            
            IF codis(MAXI, charo(F, o)) > codis(SEC, charo(F, o)) THEN charo(F, o) = SEC - 1 ELSE charo(F, o) = MAXI - 1
            LOCATE 20, 40: PRINT "Color Distance: "; codis(MAXI, charo(F, o)); codis(SEC, charo(F, o)); "    ";
          NEXT o
       NEXT F

       FOR g = 0 TO 1
         FOR h = 0 TO 2
           image(X + g, row + h) = charo(g, h)
           IF charo(g, h) = MAXI - 1 THEN outbmp(X + g, row + h) = 1 ELSE outbmp(X + g, row + h) = 0
           LOCATE 21, 13: PRINT "OUTPUT ARRAY:"; X + g; row + h; image(X + g, row + h)
           PSET (X + g - 1, row + h - 1), image(X + g, row + h)
           LOCATE 22, 13: PRINT "OUTPUT LINE:"; X + g; row + h; outbmp(X + g, row + h)
           PSET (X + g, row + h + 160), outbmp(X + g, row + h) * 15
           LOCATE 23, 13: PRINT "OUTPUT COLOR:"; INT(X / 2); INT(row / 3); outcol(INT(X / 2), INT(row / 3), 1); outcol(INT(X / 2), INT(row / 3), 2)
         NEXT h
       NEXT g
       VALUE = 1 * outbmp(X + 0, row + 0) + 2 * outbmp(X + 1, row + 0) + 4 * outbmp(X + 0, row + 1) + 8 * outbmp(X + 1, row + 1) + 16 * outbmp(X + 0, row + 2) + 32 * outbmp(X + 1, row + 2)
       'IF VALUE < 32 THEN VALUE = VALUE + 160 ELSE IF VALUE > 31 THEN VALUE = VALUE + 192
       outchar(INT(X / 2), INT(row / 3)) = VALUE
       LOCATE 1, 30: PRINT "V:"; VALUE; outbmp(X + 0, row + 0); outbmp(X + 1, row + 0); outbmp(X + 0, row + 1); outbmp(X + 1, row + 1); outbmp(X + 0, row + 2); outbmp(X + 1, row + 2)
       NEXT X
 NEXT row

PRINT #2, "1 PRINT CHR$(11)"
PRINT #2, "2 n=0"
PRINT #2, "3 READ c,A"
PRINT #2, "4 if c<32 then out=c+160"
PRINT #2, "5 if c>31 then out=c+192"
PRINT #2, "6 if out=1191 then goto 12"
PRINT #2, "7 FOR y=1 TO A"
PRINT #2, "8 poke n+12327+y,out"
PRINT #2, "9 NEXT y"
PRINT #2, "10 n=n+A"
PRINT #2, "11 GOTO 3"
PRINT #2, "12 n=0"
PRINT #2, "13 READ C,A"
PRINT #2, "14 IF C=999 THEN GOTO 20"
PRINT #2, "15 FOR y=1 TO A"
PRINT #2, "16 POKE n+13351+y,C*16"
PRINT #2, "17 NEXT y"
PRINT #2, "18 n=n+A"
PRINT #2, "19 GOTO 13"
PRINT #2, "20 n=0"
PRINT #2, "21 READ C,A"
PRINT #2, "22 IF C=999 THEN GOTO 28"
PRINT #2, "23 FOR y=1 TO A"
PRINT #2, "24 POKE n+13351+y,PEEK(n+13351+y)+C"
PRINT #2, "25 NEXT y"
PRINT #2, "26 n=n+A"
PRINT #2, "27 GOTO 21"
PRINT #2, "28 A$=INKEY$: IF A$="; CHR$(34); CHR$(34); " THEN GOTO 28"
PRINT #2, "29 PRINT CHR$(11)"

LOCATE 1, 40: PRINT "Transposing..."

   COUNT = 0
   FOR yy = 0 TO 23
     FOR xx = 0 TO 39
       COUNT = COUNT + 1
       FOUTCHAR(COUNT) = outchar(xx, yy)
       FOUTFORE(COUNT) = outcol(xx, yy, 1)
       FOUTBACK(COUNT) = outcol(xx, yy, 2)
       LOCATE 1, 55: PRINT FOUTCHAR(COUNT); FOUTFORE(COUNT); FOUTBACK(COUNT)
     NEXT xx
   NEXT yy

   LOCATE 2, 40: PRINT "Run Length Encoding..."

   LINENUM = 30
   LCOUNT = 1
   OUTCOUNT = 1
   X = 1
   PRINT #2, STR$(LINENUM); " DATA ";
   LINENUM = 31

REP:
   A$ = INKEY$: IF A$ <> "" THEN END
  
   IF OUTCOUNT = 12 THEN PRINT #2, STR$(LINENUM); " DATA "; : OUTCOUNT = 1: LINENUM = LINENUM + 1
  
   IF X = 960 THEN PRINT #2, STR$(OUT1); ","; STR$(LCOUNT); ","; : GOTO FORE

   OUT1 = FOUTCHAR(X)
   OUT2 = FOUTCHAR(X + 1)
  
   IF OUT2 = OUT1 THEN LCOUNT = LCOUNT + 1: X = X + 1: GOTO REP
   IF OUT2 <> OUT1 THEN LOCATE 2, 61:
       PRINT X; OUT1; LCOUNT:
       OUTCOUNT = OUTCOUNT + 1:
       OUTP$ = STR$(OUT1) + "," + STR$(LCOUNT):
       IF OUTCOUNT <> 12 THEN
            PRINT #2, OUTP$; ",";
            X = X + 1
            LCOUNT = 1
            GOTO REP
       ELSE
            PRINT #2, OUTP$
            X = X + 1
            LCOUNT = 1
            GOTO REP
       END IF
   PRINT #2, ""

FORE:
   
   LCOUNT = 1
   OUTCOUNT = 1
   X = 1
   PRINT #2, "999"; ","; "999"
   PRINT #2, STR$(LINENUM); " DATA ";
   
FOREREP:

   A$ = INKEY$: IF A$ <> "" THEN END
 
   IF OUTCOUNT = 12 THEN LINENUM = LINENUM + 1: PRINT #2, STR$(LINENUM); " DATA "; : OUTCOUNT = 1
 
   IF X = 960 THEN PRINT #2, STR$(OUT1); ","; STR$(LCOUNT); ","; : GOTO BACK:

   OUT1 = FOUTFORE(X)
   OUT2 = FOUTFORE(X + 1)
 
   IF OUT2 = OUT1 THEN LCOUNT = LCOUNT + 1: X = X + 1: GOTO FOREREP
   IF OUT2 <> OUT1 THEN LOCATE 2, 61:
       PRINT X; OUT1; LCOUNT:
       OUTCOUNT = OUTCOUNT + 1:
       OUTP$ = STR$(OUT1) + "," + STR$(LCOUNT):
       IF OUTCOUNT <> 12 THEN
            PRINT #2, OUTP$; ",";
            X = X + 1
            LCOUNT = 1
            GOTO FOREREP
       ELSE
            PRINT #2, OUTP$
            X = X + 1
            LCOUNT = 1
            GOTO FOREREP
       END IF
   PRINT #2, ""
BACK:
   LINENUM = LINENUM + 1
   LCOUNT = 1
   OUTCOUNT = 1
   X = 1
   PRINT #2, "999"; ","; "999"
   PRINT #2, STR$(LINENUM); " DATA ";
  
BACKREP:

   A$ = INKEY$: IF A$ <> "" THEN END

   IF OUTCOUNT = 12 THEN LINENUM = LINENUM + 1: PRINT #2, STR$(LINENUM); " DATA "; : OUTCOUNT = 1

   IF X = 960 THEN PRINT #2, STR$(OUT1); ","; STR$(LCOUNT); ","; : GOTO CLEANUP:

   OUT1 = FOUTBACK(X)
   OUT2 = FOUTBACK(X + 1)

   IF OUT2 = OUT1 THEN LCOUNT = LCOUNT + 1: X = X + 1: GOTO BACKREP
   IF OUT2 <> OUT1 THEN LOCATE 2, 61:
       PRINT X; OUT1; LCOUNT:
       OUTCOUNT = OUTCOUNT + 1:
       OUTP$ = STR$(OUT1) + "," + STR$(LCOUNT):
       IF OUTCOUNT <> 12 THEN
            PRINT #2, OUTP$; ",";
            X = X + 1
            LCOUNT = 1
            GOTO BACKREP
       ELSE
            PRINT #2, OUTP$
            X = X + 1
            LCOUNT = 1
            GOTO BACKREP
       END IF
   

CLEANUP:
   PRINT #2, "999"; ","; "999"


CLOSE #1
CLOSE #2
RETURN

560 REM -------------------------------
570 REM --- DRAW & WRITE SUBROUTINE ---
580 REM -------------------------------
590 PSET (xpos, YPOS), PIXEL
    IF YPOS > -1 THEN image(xpos + 1, YPOS + 1) = PIXEL
600 xpos = xpos + 1: IF xpos = 80 THEN xpos = 0
610 IF (xpos = 0) THEN YPOS = YPOS - 1
620 RETURN

630 REM ------------------------------------
640 REM -- wait for keypress subroutine ----
650 REM ------------------------------------
660 WAITKEY$ = ""
670 WHILE (WAITKEY$ = "")
680   WAITKEY$ = INKEY$
690 WEND
700 RETURN

REM -----------------
REM ---- errors  ----
REM -----------------

NOTBMP:
  PRINT "Not a bitmap file, error reading header, "; FILENAME$
END

NOT16:
  PRINT "Not a 16 color bitmap file, "; FILENAME$; ", expected 4 found "; B
END

NOT8072:
  PRINT "BMP Must be 80 x 72"
END

REM Color Distance Lookup Table:  16x16 Array

DATA 0,156,219,248,179,282,368,343,85,227,248,284,248,350,344,442
DATA 156,0,207,162,152,145,295,232,98,90,267,192,219,210,313,326
DATA 219,207,0,112,225,273,223,211,159,233,67,133,291,339,222,296
DATA 248,162,112,0,238,212,226,161,176,149,175,36,303,269,267,243
DATA 179,152,225,238,0,167,241,235,126,235,266,264,78,227,220,324
DATA 282,145,273,212,167,0,235,165,211,167,335,222,189,71,279,236
DATA 368,295,223,226,241,235,0,108,288,321,251,220,251,266,99,140
DATA 343,232,211,161,235,165,108,0,258,235,262,149,262,195,193,99
DATA 85,98,159,176,126,211,288,258,0,174,203,211,203,282,276,357
DATA 227,90,233,149,235,167,321,235,174,0,298,168,298,216,361,316
DATA 248,267,67,175,266,335,251,262,203,298,0,191,327,400,231,338
DATA 284,192,133,36,264,222,220,149,211,168,191,0,325,273,272,221
DATA 248,219,291,303,78,189,251,262,203,298,327,325,0,231,223,338
DATA 350,210,339,269,227,71,266,195,282,216,400,273,231,0,321,239
DATA 344,313,222,267,220,279,99,193,276,361,231,272,223,321,0,240
DATA 442,326,296,243,324,236,140,99,357,316,338,221,338,239,240,0
DATA 0,11,13,9,14,10,12,8,15,4,2,6,1,5,3,7
 


