Function GetColor(x As Integer,y As Integer) As Uinteger
  If x<0 Or x>254 Then Return 0
  If y<0 Or y>254 Then Return 0
  Dim a As Single = (y/127.0)*3.14159
  Dim w As Single = x/254.0
  Dim c As Single = iif(w<0.5,255.0*w,255.0*(1.0-w))
  w*=255.0
  Dim As Integer r = Int(w+c*Cos(a))
  Dim As Integer g = Int(w+c*Cos(a+2*3.14159/3.0))
  Dim As Integer b = Int(w+c*Cos(a+4*3.14159/3.0))
  Return RGB(r,g,b)
End Function

Private Function get_rgb(dec As Long) as string
Dim red, green, blue As Integer

    red = dec And 255
    green = (dec And 65280) \ 256
    blue = (dec And 16711680) \ 65536

get_rgb = red & "," & green & "," & blue 
End Function



Dim As Integer mx,my
ScreenRes 355,255,32
ScreenLock
bload"gang.bmp"
ScreenUnlock
While Inkey=""
  If GetMouse(mx,my)=0 Then
    WindowTitle get_rgb(GetColor(mx,my))
    line(280,100)-(320,150),point(mx,my),bf 'DISLAY COLOR BLOCK
  Else
    Sleep(50)
  End If
Wend
End
