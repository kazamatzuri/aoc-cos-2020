Class Utils.Machine Extends %RegisteredObject
{

Property code As %Integer [ MultiDimensional ];

Property stopped As %Boolean [ InitialExpression = 0 ];

Property input As %DynamicArray;

Property output As %DynamicArray;

Property relbase As %Integer [ InitialExpression = 0 ];

Property ip As %Integer [ InitialExpression = 0 ];

Parameter ADD = 1;

Parameter MUL = 2;

Parameter INPUT = 3;

Parameter OUTPUT = 4;

Parameter JIT = 5;

Parameter JIF = 6;

Parameter LT = 7;

Parameter EQ = 8;

Parameter RELADJ = 9;

Parameter HALT = 99;

Property paramnums As %Integer [ MultiDimensional ];

Method %OnNew(code As %DynamicArray) As %Status
{
    
    #; we're doing this because accessing elements in a multidimensional array is less typing than
    #; than getting things out of a fancy %DynamicArrayObject
    Set iter=code.%GetIterator()    
	While iter.%GetNext(.key,.value) {
        #; w:debug key,":",value,!
        Set ..code(key)=value
    }    
    Set ..paramnums(..#ADD)=3
    Set ..paramnums(..#MUL)=3
    Set ..paramnums(..#INPUT)=1
    Set ..paramnums(..#OUTPUT)=1
    Set ..paramnums(..#JIT)=2
    Set ..paramnums(..#JIF)=2
    Set ..paramnums(..#LT)=3
    Set ..paramnums(..#EQ)=3
    Set ..paramnums(..#RELADJ)=1
    Set ..paramnums(..#HALT)=0

    Return $$$OK
}

Method isStopped()
{
    Return ..stopped
}

Method justify(val)
{
    Return $REPLACE($JUSTIFY(val,5)," ",0)
}

Method getAddress(pos, mode)
{
    
    If (mode+0=1)||(mode+0=0){
        If '$DATA(..code(pos)){
            Return 0
        }
        Return ..code(pos)
    } ElseIf (mode+0=2) {   
        Return ..relbase+..code(pos)
    }
}

Method hasInputs()
{
    Return ..input.%Size()>0
}

Method hasOutputs()
{
    Return ..output.%Size()>0
}

Method getValue(pos, mode)
{
    If ((mode+0)=0) {
        Set a=..getAddress(pos,mode)
        If '$DATA(..code(a)){
            Return 0
        }
        Return ..code(a)        
    } ElseIf ((mode+0)=1) {
        If '$DATA(..code(pos)) {
            Return 0
        }
        Return ..code(pos)
    }	 
    Else {
        Set a=..getAddress(pos,mode)
        If '$DATA(..code(a)){
            Return 0
        }
        Return ..code(a)
    }
}

Method run()
{
    Set debug=0
    Set op=1
    While (op'=..#HALT) {
        Write:debug !,"new:debug loop"
        Set val=..code(..ip)    
        Set op=..justify(val)
        Set modes=$EXTRACT(op,1,3)
        Write:debug !,"modes:",modes
        Set op= $EXTRACT(op,4,5)+0
        Write:debug !,"op:",op,!
        Set notskip=1
        If (op=..#ADD) {
            Set target=..getAddress(..ip+3,$EXTRACT(modes,1))
            Write:debug !,"target:",target
            Write:debug !,"v1:"
            Set v1=..getValue(..ip+1,$EXTRACT(modes,3))
            Write:debug v1," mode",$EXTRACT(modes,3),!
            Write:debug !,"v2:"
            Set v2=..getValue(..ip+2,$EXTRACT(modes,2))
            Write:debug v2," mode",$EXTRACT(modes,2),!
            Set ..code(target)=v1+v2
        }  ElseIf (op=..#MUL) {
            Set target=..getAddress(..ip+3,$EXTRACT(modes,1))
            Set v1=..getValue(..ip+1,$EXTRACT(modes,3))
            Write:debug !,"v1:",v1," mode",$EXTRACT(modes,3),!
            Set v2=..getValue(..ip+2,$EXTRACT(modes,2))
            Write:debug !,"v2:",v2," mode",$EXTRACT(modes,2),!
            
            Set ..code(target)=v1*v2
        } ElseIf (op=..#INPUT) {
            Set target=..getAddress(..ip+1,$EXTRACT(modes,3))
            If ..input.%Size()>0 {
                Set val=..input.%Remove(0)
                Set ..code(target)=val
            } Else {
                Return
            }

        } ElseIf (op=..#OUTPUT) {
            Set value=..getValue(..ip+1,$EXTRACT(modes,3))
            Write:debug !,"v1:",value," mode",$EXTRACT(modes,3),!
            Do ..output.%Push(value)            
        } ElseIf  (op=..#JIT) {
            Set value=..getValue(..ip+1,$EXTRACT(modes,3))
            If (value'=0){
                Set target=..getValue(..ip+2,$EXTRACT(modes,2))
                Set ..ip=target
                Set notskip=0
            }
        } ElseIf (op=..#JIF) {
            Set value=..getValue(..ip+1,$EXTRACT(modes,3))
            If (value=0){
                Set target=..getValue(..ip+2,$EXTRACT(modes,2))
                Set ..ip=target
                Set notskip=0
            }            
        } ElseIf (op=..#LT) {
            Set target=..getAddress(..ip+3,$EXTRACT(modes,1))
            Set v1=..getValue(..ip+1,$EXTRACT(modes,3))
            Write:debug !,"v1:",v1," mode",$EXTRACT(modes,3),!
            Set v2=..getValue(..ip+2,$EXTRACT(modes,2))
            Write:debug !,"v2:",v2," mode",$EXTRACT(modes,2),!
            If (v1<v2) {
                Set ..code(target)=1
            } Else {
                Set ..code(target)=0
            }
        } ElseIf (op=..#EQ){
            Set target=..getAddress(..ip+3,$EXTRACT(modes,1))
            Set v1=..getValue(..ip+1,$EXTRACT(modes,3))
            Write:debug !,"v1:",v1," mode",$EXTRACT(modes,3),!
            Set v2=..getValue(..ip+2,$EXTRACT(modes,2))
            Write:debug !,"v2:",v2," mode",$EXTRACT(modes,2),!
            If (v1=v2) {
                Set ..code(target)=1
            } Else {
                Set ..code(target)=0
            }
        } ElseIf (op=..#RELADJ) {
            Set value=..getValue(..ip+1,$EXTRACT(modes,3))
            Set ..relbase=..relbase+value
        }	 
        ElseIf (op=..#HALT) {
            Set ..stopped=1
            Return
        } Else {
            Write:debug !,"Invalid operation:",op,!
            Return
        }
        #; w:debug !
        #; s c=$O(..code(""))
        #; while (c'="") {
        #;     w:debug ..code(c),","
        #;     s c=$O(..code(c))
        #; }
        #; w:debug !
        Write:debug !,"op ",op,!
        If notskip {
            Set ..ip=..ip+..paramnums(op)+1
        }


    }
}

Method addInput(value)
{
    Do ..input.%Push(value)
}

Method addInputs(values)
{
    Set iter=values.%GetIterator()    
	While iter.%GetNext(.key,.value) {
        Do ..addInput((value))
    }
}

Method getMemory(pos) As %Integer
{
    Return ..code(pos)
}

Method setMemory(pos, value)
{
    Set ..code(pos)=value
}

Method getOutputs() As %DynamicArray
{
    Set result=##class(%DynamicArray).%FromJSON(..output.%ToJSON()) 
    Set ..output=[]
    Return result
}

Method getOutput() As %String
{
    Return ..output.%Remove(0)
}

Method load(code)
{
    Set iter=code.%GetIterator()
}

}
