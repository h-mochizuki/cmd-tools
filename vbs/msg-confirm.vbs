Option Explicit
Dim msg
Dim i
Dim re
If WScript.Arguments.Count < 1 Then
    msg = "OK?"
Else
    for i=1 to WScript.Arguments.Count
        If Len(msg) > 1 Then msg = msg & vbCrLf
        msg = msg & WScript.Arguments.Item(i-1)
    next
End If
re = msgbox(msg, vbOKCancel + vbQuestion) - 1
WScript.Quit(re)