#SingleInstance Force
#Warn
if !A_IsAdmin || !(DllCall("GetCommandLine","Str")~=" /restart(?!\S)")
    Try Run % "*RunAs """ (A_IsCompiled?A_ScriptFullPath """ /restart":A_AhkPath """ /restart """ A_ScriptFullPath """")
    Finally ExitApp

data_type_calc.gui()
Return

*Esc::ExitApp

test()
{
    x := "p"
    MsgBox, % (x*0 = 0) ? "Yup" : "Nope"
}

class testingclass
{
}

Rounding_Mindfuck()
{
    percent := 50
    x := 255 * percent / 100
    y := 255 / 100 * percent
    MsgBox, % "Percent = " percent
            . "`nvar`tRounded`tFormula"
            . "`nx`t" Round(x) "`t255 * percent / 100"
            . "`ny`t" Round(y) "`t255 / 100 * percent"
            
    ;MsgBox, % "x: " x "`nRounded`nx: " Round(x) "`ny: " y "`ny: "Round(y)
    Return
}

to_hex(num){
    Return Format("{1:#x}", num)
}

; qpx(1) starts it and qpx() stops timer and returns time
qpx(N=0) {  ; Wrapper for QueryPerformanceCounter() by SKAN  | CD: 06/Dec/2009
    Local   ; www.autohotkey.com/forum/viewtopic.php?t=52083 | LM: 10/Dec/2009
    Static F:="", A:="", Q:="", P:="", X:=""
    If (N && !P)
        Return DllCall("QueryPerformanceFrequency",Int64P,F) + (X:=A:=0)
             + DllCall("QueryPerformanceCounter",Int64P,P)
    DllCall("QueryPerformanceCounter",Int64P,Q), A:=A+Q-P, P:=Q, X:=X+1
    Return (N && X=N) ? (X:=X-1)<<64 : (N=0 && (R:=A/X/F)) ? (R + (A:=P:=X:=0)) : 1
}

Class data_type_calc
{
    gui()
    {
        pad     := 10
        el_w    := 400
        el_h    := 500
        txt_h   := 20
        btn_w   := 75
        btn_h   := 25
        hwnd    := {}
        
        Gui, New
        Gui, Margin, % pad, % pad
        Gui, Add, Text, w%el_w% h%txt_h% xm ym, Paste function call here:
        Gui, Add, Edit, w%el_w% h%el_h% xm y+0 +HWNDhand
            hwnd.edit := hand
        Gui, Add, Button, w%btn_w% h%btn_h% xm y+%pad% +HWNDhand, Close
            hwnd.btn_close := hand
            this.control_method(hand, "quit")
        x := el_w + pad - btn_w
        Gui, Add, Button, w%btn_w% h%btn_h% x%x% yp +HWNDhand, Submit
            hwnd.btn_submit := hand
            this.control_method(hand, "get_size", hwnd)
        
        Gui, Show, Autosize
        
        Return
    }
    
    control_method(hwnd, method, params*)
    {
        bf := ObjBindMethod(this, method, params*)
        GuiControl, +g, % hwnd, % bf
        Return
    }
    
    quit()
    {
        ExitApp
        Return
    }
    
    get_size(hwnd)
    {
        MsgBox, % A_ThisFunc
        ; Get function text
        GuiControlGet, txt,, % hwnd.edit
        ; Parse by semicolon
        str := ""
        Loop, Parse, % txt, % ",", % " \t\r\n"
            str .= A_LoopField "`n"
        MsgBox, % str
        Return
    }
    
    ; Pass in the text of a data type and get back the required bytes
    ; is_x64    If script will run as 64-bit, set to true
    ; is_uni    If script will be dealing with unicode, set to true
    ;
    ; Return    Returns byte value or "error" if not found
    get_data_type_size(type, is_x64=1, is_uni=1)
    {
        dt  := {}
        dt["__int8"]             := 1      ,dt["HLOCAL"]     := "p"    ,dt["PLONG"]                 := "p"
        dt["__int16"]            := 2      ,dt["HMENU"]      := "p"    ,dt["PLONGLONG"]             := "p"
        dt["__int32"]            := 4      ,dt["HMETAFILE"]  := "p"    ,dt["PLONG_PTR"]             := "p"
        dt["__int64"]            := 8      ,dt["HMODULE"]    := "p"    ,dt["PLONG32"]               := "p"
        dt["__wchar_t"]          := 2      ,dt["HMONITOR"]   := "p"    ,dt["PLONG64"]               := "p"
        dt["bool"]               := 1      ,dt["HPALETTE"]   := "p"    ,dt["POINTER_32"]            := "p"
        dt["char"]               := 1      ,dt["HPEN"]       := "p"    ,dt["POINTER_64"]            := "p"
        dt["double"]             := 8      ,dt["HRESULT"]    := 4      ,dt["POINTER_SIGNED"]        := "p"
        dt["float"]              := 4      ,dt["HRGN"]       := "p"    ,dt["POINTER_UNSIGNED"]      := "p"
        dt["int"]                := 4      ,dt["HRSRC"]      := "p"    ,dt["PSHORT"]                := "p"
        dt["long"]               := 4      ,dt["HSZ"]        := "p"    ,dt["PSIZE_T"]               := "p"
        dt["long double"]        := 8      ,dt["HWINSTA"]    := "p"    ,dt["PSSIZE_T"]              := "p"
        dt["long long"]          := 8      ,dt["HWND"]       := "p"    ,dt["PSTR"]                  := "p"
        dt["short"]              := 2      ,dt["INT_PTR"]    := "p"    ,dt["PTBYTE"]                := "p"
        dt["signed char"]        := 1      ,dt["INT8"]       := 1      ,dt["PTCHAR"]                := "p"
        dt["unsigned int"]       := 4      ,dt["INT16"]      := 2      ,dt["PTSTR"]                 := "p"
        dt["unsigned __int8"]    := 1      ,dt["INT32"]      := 4      ,dt["PUCHAR"]                := "p"
        dt["unsigned __int16"]   := 2      ,dt["INT64"]      := 8      ,dt["PUHALF_PTR"]            := "p"
        dt["unsigned __int32"]   := 4      ,dt["LANGID"]     := 2      ,dt["PUINT"]                 := "p"
        dt["unsigned __int64"]   := 8      ,dt["LCID"]       := 4      ,dt["PUINT_PTR"]             := "p"
        dt["unsigned char"]      := 1      ,dt["LCTYPE"]     := 4      ,dt["PUINT8"]                := "p"
        dt["unsigned short"]     := 2      ,dt["LGRPID"]     := 4      ,dt["PUINT16"]               := "p"
        dt["unsigned long"]      := 4      ,dt["LONG"]       := 4      ,dt["PUINT32"]               := "p"
        dt["unsigned long long"] := 8      ,dt["LONGLONG"]   := 8      ,dt["PUINT64"]               := "p"
        dt["wchar_t"]            := 2      ,dt["LONG_PTR"]   := "p"    ,dt["PULONG"]                := "p"
        dt["ATOM"]               := 2      ,dt["LONG32"]     := 4      ,dt["PULONGLONG"]            := "p"
        dt["BOOL"]               := 4      ,dt["LONG64"]     := 8      ,dt["PULONG_PTR"]            := "p"
        dt["BOOLEAN"]            := 1      ,dt["LPARAM"]     := "p"    ,dt["PULONG32"]              := "p"
        dt["BYTE"]               := 1      ,dt["LPBOOL"]     := "p"    ,dt["PULONG64"]              := "p"
        dt["CCHAR"]              := 1      ,dt["LPBYTE"]     := "p"    ,dt["PUSHORT"]               := "p"
        dt["CHAR"]               := 1      ,dt["LPCOLORREF"] := "p"    ,dt["PVOID"]                 := "p"
        dt["COLORREF"]           := 4      ,dt["LPCSTR"]     := "p"    ,dt["PWCHAR"]                := "p"
        dt["DWORD"]              := 4      ,dt["LPCTSTR"]    := "p"    ,dt["PWORD"]                 := "p"
        dt["DWORDLONG"]          := 8      ,dt["LPCVOID"]    := 0      ,dt["PWSTR"]                 := "p"
        dt["DWORD_PTR"]          := "p"    ,dt["LPDWORD"]    := 4      ,dt["QWORD"]                 := 8
        dt["DWORD32"]            := 4      ,dt["LPHANDLE"]   := "p"    ,dt["SC_HANDLE"]             := "p"
        dt["DWORD64"]            := 8      ,dt["LPINT"]      := 4      ,dt["SC_LOCK"]               := "p"
        dt["HACCEL"]             := "p"    ,dt["LPLONG"]     := 4      ,dt["SERVICE_STATUS_HANDLE"] := "p"
        dt["HALF_PTR"]           := "h"    ,dt["LPVOID"]     := "p"    ,dt["SIZE_T"]                := "p"
        dt["HANDLE"]             := "p"    ,dt["LPWORD"]     := 2      ,dt["SSIZE_T"]               := "p"
        dt["HBITMAP"]            := "p"    ,dt["LRESULT"]    := "p"    ,dt["TBYTE"]                 := "u"
        dt["HBRUSH"]             := "p"    ,dt["PBOOL"]      := "p"    ,dt["TCHAR"]                 := "u"
        dt["HCOLORSPACE"]        := "p"    ,dt["PBOOLEAN"]   := "p"    ,dt["UCHAR"]                 := 1
        dt["HCONV"]              := "p"    ,dt["PBYTE"]      := "p"    ,dt["UHALF_PTR"]             := "h"
        dt["HCONVLIST"]          := "p"    ,dt["PCHAR"]      := "p"    ,dt["UINT"]                  := 4
        dt["HCURSOR"]            := "p"    ,dt["PDWORD"]     := "p"    ,dt["UINT_PTR"]              := "p"
        dt["HDC"]                := "p"    ,dt["PDWORDLONG"] := "p"    ,dt["UINT8"]                 := 1
        dt["HDDEDATA"]           := "p"    ,dt["PDWORD_PTR"] := "p"    ,dt["UINT16"]                := 2
        dt["HDESK"]              := "p"    ,dt["PDWORD32"]   := "p"    ,dt["UINT32"]                := 4
        dt["HDROP"]              := "p"    ,dt["PDWORD64"]   := "p"    ,dt["UINT64"]                := 8
        dt["HDWP"]               := "p"    ,dt["PFLOAT"]     := "p"    ,dt["ULONG"]                 := 4
        dt["HENHMETAFILE"]       := "p"    ,dt["PHALF_PTR"]  := "p"    ,dt["ULONGLONG"]             := 8
        dt["HFILE"]              := 4      ,dt["PHANDLE"]    := "p"    ,dt["ULONG_PTR"]             := "p"
        dt["HFONT"]              := "p"    ,dt["PHKEY"]      := "p"    ,dt["ULONG32"]               := 4
        dt["HGDIOBJ"]            := "p"    ,dt["PINT"]       := "p"    ,dt["ULONG64"]               := 8
        dt["HGLOBAL"]            := "p"    ,dt["PINT_PTR"]   := "p"    ,dt["USHORT"]                := 2
        dt["HHOOK"]              := "p"    ,dt["PINT8"]      := "p"    ,dt["USN"]                   := 8
        dt["HICON"]              := "p"    ,dt["PINT16"]     := "p"    ,dt["VOID"]                  := 0
        dt["HINSTANCE"]          := "p"    ,dt["PINT32"]     := "p"    ,dt["WCHAR"]                 := 2
        dt["HKEY"]               := "p"    ,dt["PINT64"]     := "p"    ,dt["WORD"]                  := 2
        dt["HKL"]                := "p"    ,dt["PLCID"]      := "p"    ,dt["WPARAM"]                := "p"
        
        bytes := dt[type]
        Return (bytes * 0 = 0) ? bytes              ; Bytes
             : (bytes == "p")  ? is_x64 ? 8 : 4     ; Pointer check
             : (bytes == "u")  ? is_uni ? 2 : 1     ; Unicode check
             : (bytes == "h")  ? is_x64 ? 4 : 2     ; Half Pointer check
             : "error"                              ; Not found
    }
}
