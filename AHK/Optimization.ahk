;OPTIMIZATIONS START
#SingleInstance Force
#Warn
#NoEnv
#KeyHistory 0
Process, Priority, , A
SetBatchLines, -1
ListLines, 0
SetTitleMatchMode, 2
SetTitleMatchMode, Fast
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetWinDelay, 0

optimize.assignment()
optimize.if_vs_ternary()
ExitApp


Class optimize
{
    assignment()
    {
        ; Assignment performance test from fastest to slowest
        ; Iterations: 10,000,000
        ; Specifics: Assign a float, int, neg float, neg int, 0, word, var
        ; Results:
        ; Assign (:=) no commas   = 5.41 seconds
        ; Assign (:=) with commas = 3.48 seconds
        ; Equals (=) no commas    = 3.39 seconds
        ; Equals (=) with commas  = 0.96 seconds
        
        str := ""
        iterations := 10000000
        four := 4
        
        qpx(1)
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
        str .= "`nAssign (:=), no commas: " qpx()
        
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
        str .= "`nAssign (:=), with commas: " qpx()
        
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
        ; Test: If vs ternary
        ; Iterations: 10000000
        ; Specifics: Increment A by 1 if true and B by 1 if false
        ; Results:
        ; If statement      = 2.51 seconds
        ; Ternary           = 1.85 seconds
        ; Ternary w/ commas = 1.52 seconds
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
        ; Test: Different evaluation types
        ; Iterations: 10000000
        ; Specifics: (eval), (x = vaule), !
        ; Results:
        ; 
        ; If (true)
        ; If (
        ; If (x = y)
        ; If (x !=y )
        iterations := 10000000
        str := ""
        
        qpx(1)
        Loop, % iterations
        {
            
        }
        str .= "`n" qpx()
        
        qpx(1)
        Loop, % iterations
        {
        }
        str .= "`n" qpx()
        
        qpx(1)
        Loop, % iterations
        {
        }
        str .= "`n" qpx()
        
        qpx(1)
        Loop, % iterations
        {
        }
        str .= "`n" qpx()
        
        Return
    }
    
    _template()
    {
        ; Test: 
        ; Iterations: 10000000
        ; Specifics: 
        ; Results:
        ; 
        iterations := 10000000
        str := ""
        
        qpx(1)
        Loop, % iterations
        {
        }
        str .= "`n" qpx()
        
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
