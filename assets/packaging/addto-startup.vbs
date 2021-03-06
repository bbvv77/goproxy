Option Explicit
Dim wsh, fso, ObjShell, BtnCode, ScriptDir, FilePath, link

Set wsh = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

Function CreateShortcut(FilePath)
    Set wsh = WScript.CreateObject("WScript.Shell")
    Set link = wsh.CreateShortcut(wsh.SpecialFolders("Startup") + "\goproxy.lnk")
    link.TargetPath = FilePath
    link.Arguments = ""
    link.WindowStyle = 7
    link.Description = "GoProxy"
    link.WorkingDirectory = wsh.CurrentDirectory
    link.Save()
End Function

BtnCode = wsh.Popup("是否将 goproxy.exe 加入到启动项？(本对话框 6 秒后消失)", 6, "GoProxy 对话框", 1+32)
If BtnCode = 1 Then
    ScriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
    FilePath = ScriptDir + "\goproxy-gui.exe"
    If Not fso.FileExists(FilePath) Then
        wsh.Popup "当前目录下不存在 goproxy-gui.exe ", 5, "GoProxy 对话框", 16
        WScript.Quit
    End If
    CreateShortcut(FilePath)
    wsh.Popup "成功加入 GoProxy 到启动项", 5, "GoProxy 对话框", 64
End If
