;OPTIMIZATIONS START
#SingleInstance Force
#Warn
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0


;optimize.assignment()
optimize.if_vs_ternary()
ExitApp


Class optimize
{
    assignment()
    {
        ; Assignment performance test from fastest to slowest
        ; Iterations: 10000000 
        ; Test: Assign a float, int, neg float, neg int, 0, word, var
        ; := operator, no commas    = 14.64 seconds
        ; := operator, with commas  = 11.01 seconds
        ; = operator, no commas     =  9.11 seconds
        ; = operator, with commas   =  2.93 seconds
        
        str := ""
        qpx(1)
        iterations := 10000000
        four := 4
        
        Loop, % iterations
        {
            a := -2.2
            b := -1
            c := 0
            d := 1
            e := 2.2
            f := "Three"
            g := four
        }
        str .= "`nAssign op (:=), no commas: " qpx()
        
        qpx(1)
        Loop, % iterations
        {
             a := -2.2
            ,b := -1
            ,c := 0
            ,d := 1
            ,e := 2.2
            ,f := "Three"
            ,g := four
        }
        str .= "`nAssign op (:=), with commas: " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            a = -2.2
            b = -1
            c = 0
            d = 1
            e = 2.2
            f = Three
            g = %four%
        }
        str .= "`nEquality op (=), no commas: " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            ()
            ,a = -2.2
            ,b = -1
            ,c = 0
            ,d = 1
            ,e = 2.2
            ,f = Three
            ,g = %four%
        }
        str .= "`nEquality op (=), with commas: " qpx()
        
        MsgBox, % str
    }
    
    
    if_vs_ternary()
    {
        ; If vs ternary
        ; Iterations: 10000000
        ; Test: Increment A by 1 if true and B by 1 if false
        ; If statement      = 8.15
        ; Ternary           = 5.50
        ; Ternary w/ commas = 4.48
        
        iterations := 10000000
        str := ""
        a := 0
        b := 0
        qpx(1)
        Loop, % iterations
        {
            If (true)
                a++
            Else b++
            If (false)
                a++
            Else b++
        }
        str .= "`nIf statment: " qpx()
        
        a := 0
        b := 0
        qpx(1)
        Loop, % iterations
        {
            (true) ? a++ : b++
            (false) ? a++ : b++
        }
        str .= "`nTernary: " qpx()
        
        a := 0
        b := 0
        qpx(1)
        Loop, % iterations
        {
            (true) ? a++ : b++
            , (false) ? a++ : b++
        }
        str .= "`nTernary with commas: " qpx()
        
        MsgBox, % str
        Return
    }
    
    evauluation()
    {
        ; If vs ternary
        ; Iterations: 10000000
        ; Test: Increment A by 1 if true and B by 1 if false
        ; If statement      = 8.15
        ; Ternary           = 5.50
        ; Ternary w/ commas = 4.48
        Return
    }
}


ExitApp
*Escape::ExitApp

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
