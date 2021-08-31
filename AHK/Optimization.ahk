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
;optimize.concat()
;optimize.inline_assign()
;optimize.varsetcapicty_fill_nofill()
;optimize.assign_vs_numput()
;optimize.var_vs_numget()
ExitApp

!Escape::ExitApp


Class optimize
{
    /*
    new_test()
    {
        ; What it does
        ; Iterations: 1,000,000
        ; Specifics: How it does it
        ; Results:
        
        str := ""
        iterations := 1000000
        four := 4
        
        qpx(1)
        Loop, % iterations
        {
            A_Index
        }
        str .= "" qpx()
        ToolTip, % str
        
        qpx(1)
        Loop, % iterations
        {
            A_Index
        }
        str .= "`n" qpx()
        
        MsgBox, % str
        Return
    }
    */
    
    var_vs_numget()
    {
        ; Check how much faster getting a var is compared to NumGet
        ; Iterations: 100,000,000
        ; Specifics: Get number from  predefined variable
        ; Results:
        ; Get Var:  8.646610
        ; NumGet:  13.262087
        
        str := ""
        iterations := 100000000
        four := 4
        
        a := 1
        qpx(1)
        Loop, % iterations
        {
            b := a
        }
        str .= "Get var: " qpx()
        ToolTip, % str
        
        VarSetCapacity(a, 4, 0x1)
        qpx(1)
        Loop, % iterations
        {
            b := NumGet(a, 0, "Int")
        }
        str .= "`nNumGet: " qpx()
        
        MsgBox, % str
        Return
    }
    
    assign_vs_numput()
    {
        ; Check how much faster assigning by var is compared to numput
        ; Iterations: 100,000,000
        ; Specifics: Store 1 to variable using different methods.
        ; Results:
        ; Set Var:  7.964768
        ; NumPut:  11.830504
        
        str := ""
        iterations := 100000000
        four := 4
        
        qpx(1)
        Loop, % iterations
        {
            a := 1
        }
        str .= "Assignment: " qpx()
        ToolTip, % str
        
        qpx(1)
        a := ""
        Loop, % iterations
        {
            NumPut(1, a, 0, "Int")
        }
        str .= "`nNumPut: " qpx()
        
        MsgBox, % str
        Return
    }
    
    varsetcapicty_fill_nofill()
    {
        ; Testing time difference when using fill bytes in varsetcapacity
        ; Iterations: 1,000,000,000
        ; Specifics: Various sizes. With/without fill bytes. Different fill nums.
        ; Results: 
        ;    8 bytes, no fill, BLANK:     82.465528
        ;    8 bytes,    fill,     0:    119.211875
        ;    8 bytes,    fill,   128:    119.255844
        ; 1024 bytes, no fill, BLANK:     82.682783
        ; 1024 bytes, no fill,     0:    119.402025
        ; 1024 bytes, no fill,   128:    119.348265
        
        str := ""
        iterations := 1000000000
        four := 4
        
        qpx(1)
        Loop, % iterations
            VarSetCapacity(struct, 8)
        str .= "8 bytes, no fill: " qpx()
        ToolTip, % str
        
        qpx(1)
        Loop, % iterations
        {
            VarSetCapacity(struct, 8, 0)
        }
        str .= "`n8 bytes, fill, 0: " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            VarSetCapacity(struct, 8, 128)
        }
        str .= "`n8 bytes, fill, 128: " qpx()
        
        qpx(1)
        Loop, % iterations
            VarSetCapacity(struct, 1024)
        str .= "`n8 bytes, no fill: " qpx()
        ToolTip, % str
        
        qpx(1)
        Loop, % iterations
            VarSetCapacity(struct, 1024, 0)
        str .= "`n8 bytes, no fill: " qpx()
        ToolTip, % str
        
        qpx(1)
        Loop, % iterations
            VarSetCapacity(struct, 1024, 128)
        str .= "`n8 bytes, no fill: " qpx()
        ToolTip, % str
        
        MsgBox, % str
        Return
    }

    assignment()
    {
        ; Assignment performance test from fastest to slowest
        ; Iterations: 1,000,000,000
        ; Specifics: Assign a float, int, neg float, neg int, 0, word, var
        ; Results:
        ; Equals (=) with commas  =  88.88 seconds
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
        str .= "Assign (:=), no commas: " qpx()
        ToolTip, % str
        
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
        ToolTip, % str
        
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
        ToolTip, % str
        
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
        ; Equal
        ;      (x) =  61.38
        ;  (x = y) =  80.45
        ; Not Equal
        ;     (!x) =  69.99 
        ; (x != y) =  84.04
        ; (x <> y) =  97.87
        ; Greater/Less Than
        ; (x <= y) =  84.38
        ; (x >= y) =  85.37
        ;  (x < y) =  92.00
        ;  (x > y) = 101.37
        
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
        ; Increment
        ; ++a = 56.95
        ; a++ = 56.96
        ; a+1 = 93.01
        ; a+x = 99.61
        ; Decrement
        ; --a = 56.25
        ; a-- = 56.56
        ; a-1 = 94.19
        ; a-x = 99.43
        
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
        ; VarSetCapacity() =  84.74 seconds
        ; Deafult capacity = 133.99 seconds
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
    
    inline_assign()
    {
        ; Test: Assigning multiple variables on 1 line
        ; Iterations: 1,000,000,000
        ; Specifics: Assign and math 5 variables inline vs assigning then mathing
        ; Results:
        ; multi-line equals =  87.12 seconds
        ; inline assign     = 323.85 seconds
        ; multi-line assign = 381.05 seconds
        
        iterations := 1000000000
        str := ""
        
        qpx(1)
        Loop, % iterations
        {
            var := ((a := 1) + (b := 2) + (c := 3) + (d := 4)) * (e := 5)
        }
        str .= "`nInline assign: " qpx()
        
        qpx(1)
        Loop, % iterations
        {
             a := 1
            ,b := 2
            ,c := 3
            ,d := 4
            ,e := 5
            ,var := (a + b + c + d) * e
        }
        str .= "`nMulti-line assign: " qpx()
        
        qpx(1)
        Loop, % iterations
        {
            ()
            ,a = 1
            ,b = 2
            ,c = 3
            ,d = 4
            ,e = 5
            ,var := (a + b + c + d) * e
        }
        str .= "`nMulti-line equals: " qpx()
        
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
        
        MsgBox, % str
        
        Return
    }
    
    ;~ ; Loading DLL library vs not
    
    ;~ ; Object assignment/calling methods.
    ;~ ; InsertAt vs obj.index vs Pop vs etc...

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
