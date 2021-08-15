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

;optimize.assignment()
;optimize.if_vs_ternary()
;optimize.evauluation()
;optimize.inc_dec()
optimize.concat()

ExitApp


Class optimize
{
    assignment()
    {
        ; Assignment performance test from fastest to slowest
        ; Iterations: 1,000,000,000
        ; Specifics: Assign a float, int, neg float, neg int, 0, word, var
        ; Results:
        ; Equals (=) with commas  = 88.88 seconds
        ; Equals (=) no commas    = 206.53 seconds
        ; Assign (:=) with commas = 301.58 seconds
        ; Assign (:=) no commas   = 413.59 seconds
        
        str := ""
        iterations := 1000000000
        four := 4
        
        qpx(1)
        Loop, % iterations
        {
            a := -2.2
            b := -1
            c := 0
            d := True
            e := 2.2
            f := "Three"
            g := four
        }
        str .= "`nAssign (:=), no commas: " qpx()
        ToolTip, done with := no comma
        
        qpx(1)
        Loop, % iterations
        {
             a := -2.2
            ,b := -1
            ,c := 0
            ,d := True
            ,e := 2.2
            ,f := "Three"
            ,g := four
        }
        str .= "`nAssign (:=), with commas: " qpx()
        ToolTip, done with := and comma
        
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
        ToolTip, done with = no comma
        
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
        ToolTip, done with = with comma
        
        MsgBox, % str
    }
    
    if_vs_ternary()
    {
        ; Test: Selection - If vs Ternary vs Switch Statement
        ; Iterations: 1,000,000,000
        ; Specifics: Increment A by 1 if true and B by 1 if false
        ; Results:
        ; Ternary      = 157.59 seconds
        ; If Statement = 274.80 seconds
        ; Switch       = 284.64 seconds
        iterations := 1000000000
        str := ""
        x := 3
        a := 0
        qpx(1)
        Loop, % iterations
        {
            If (x = 1)
                a++
            Else If (x = 2)
                a++
            Else If (x = 3)
                a++
        }
        str .= "`nIf statment: " qpx()
        
        a := 0
        qpx(1)
        Loop, % iterations
        {
            (x = 1)     ? a++
            : (x = 2)   ? a++
            : (x = 3)   ? a++
            : ""
        }
        str .= "`nTernary: " qpx()
        
        a := 0
        qpx(1)
        Loop, % iterations
        {
            Switch x
            {
                Case 1: a++
                Case 2: a++
                Case 3: a++
            }
        }
        str .= "`nSwitch: " qpx()
        
        MsgBox, % str
        Return
    }
    
    evauluation()
    {
        ; Test: Different evaluation types
        ; Iterations: 1,000,000,000
        ; Specifics: True: (x) = False: (!x) != <> GTLT: > < >= <=
        ; Results:
        ;      (x) = 61.38
        ;  (x = y) = 80.45
        ;     (!x) = 69.99 
        ; (x != y) = 84.04
        ; (x <> y) = 97.87
        ;  (x < y) = 92.00
        ;  (x > y) = 101.37
        ; (x >= y) = 85.37
        ; (x <= y) = 84.38
        
        iterations := 1000000000
        str := ""
        x := True
        y := False
        
        qpx(1)
        Loop, % iterations
        {
            (x) ? "" : ""
        }
        str .= "`n(x): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (!x) ? "" : ""
        }
        str .= "`n(!x): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (x = y) ? "" : ""
        }
        str .= "`n(x = y): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (x != y) ? "" : ""
        }
        str .= "`n(x != y): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (x <> y) ? "" : ""
        }
        str .= "`n(x <> y): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (x > y) ? "" : ""
        }
        str .= "`n(x > y): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (x < y) ? "" : ""
        }
        str .= "`n(x < y): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (x >= y) ? "" : ""
        }
        str .= "`n(x >= y): " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            (x >= y) ? "" : ""
        }
        str .= "`n(x <= y): " qpx()
        
        MsgBox, % str
        
        Return
    }
    
    inc_dec()
    {
        ; Test: Incrementation and decrementation
        ; Iterations: 1,000,000,000
        ; Specifics: a+1 a+x a++ ++a a-1 a-x a-- --a
        ; Results: 
        ; a+1 = 65.61
        ; a+x = 66.62
        ; a++ = 47.69
        ; ++a = 47.18
        ; a-1 = 78.18
        ; a-x = 80.82
        ; a-- = 47.57
        ; --a = 47.25
        
        iterations := 1000000000
        str := ""
        x := 1
        
        qpx(1)
        a := 0
        Loop, % iterations
            a := a+1
        str .= "`na+1: " qpx()
        
        qpx(1)
        a := 0
        Loop, % iterations
            a := a+x
        str .= "`na+x: " qpx()
        
        qpx(1)
        a := 0
        Loop, % iterations
            a++
        str .= "`na++: " qpx()
        
        qpx(1)
        a := 0
        Loop, % iterations
            ++a
        str .= "`n++a: " qpx()
        
        qpx(1)
        a := 0
        Loop, % iterations
            a := a-1
        str .= "`na-1: " qpx()
        
        qpx(1)
        a := 0
        Loop, % iterations
            a := a-x
        str .= "`na-x: " qpx()
        
        qpx(1)
        a := 0
        Loop, % iterations
            a--
        str .= "`na--: " qpx()
        
        qpx(1)
        a := 0
        Loop, % iterations
            --a
        str .= "`n--a: " qpx()
        
        MsgBox, % str
        
        Return
    }
    
    concat()
    {
        ; Test: Pre-allocating concatination vars
        ; Iterations: 100,000
        ; Specifics: Append Abc123 to a string 1000 times, with/without memory allocation
        ; Results:
        ; VarSetCapacity()     = 84.74 seconds
        ; Deafult capacity     = 133.99 seconds
        iterations := 1000
        appends := 1000
        str := ""
        obj := {}
        
        qpx(1)
        Loop, % iterations
        {
            var := ""
            Loop, % appends
                var .= "Abc123"
        }
        str .= "`nVar default: " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            VarSetCapacity(var, 1000000) ; = 1 MB
            Loop, % appends
                var .= "Abc123"
        }
        str .= "`nVar Pre-allocate: " qpx()
        
        MsgBox, % str
        
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
    
    ;~ ; Loading DLL library vs not


    ;~ ; Assigning multiple variables on 1 line
    ;~ ; var := ((a := 1) + (b := 2) + (c := 3) + (d := 4)) * e)
    ;~ ; vs
    ;~ ;  a := 1
    ;~ ; ,b := 2
    ;~ ; ,c := 3
    ;~ ; ,d := 4
    ;~ ; ,e := 5
    ;~ ; var := (a + b + c + d) * e


    ;~ ; Function call cost vs gosub vs not using either
    ;~ ; f1(a, b)
    ;~ ; {
    ;~ ;     Return (a+b)
    ;~ ; }
    ;~ ; vs
    ;~ ; GoSub f2
    ;~ ;     c := a + b
    ;~ ; Return
    ;~ ; vs
    ;~ ; c := a + b

    ;~ ; Using dllcall("psapi.dll\EmptyWorkingSet", "UInt", -1)

    ;~ qpx(1)
    ;~ Loop, % interation
    ;~ {
        
    ;~ }
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
