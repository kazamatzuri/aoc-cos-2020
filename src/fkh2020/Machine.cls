Class fkh2020.Machine Extends %RegisteredObject
{

Property erg As %Integer [ InitialExpression = 0 ];

Property pos As %Integer [ InitialExpression = 0 ];

Property accumulator As %Integer;

Property op As %Integer [ MultiDimensional ];

Property arg As %Integer [ MultiDimensional ];

Property size As %Integer;

Property ended As %Integer;

Property looped As %Integer [ InitialExpression = 0 ];

Property debug As %Integer [ InitialExpression = 0 ];

Method %OnNew(code As %DynamicArray) As %Status
{
    Set iter=code.%GetIterator()
    Set count=0
    While iter.%GetNext(.key,.value) {        
        Set count=count+1
        Set cmd=$PIECE(value," ",1)
        Set a=$PIECE(value," ",2)
        Set ..op(key)=cmd
        Set ..arg(key)=a
    }
    Set ..size=count
    Set ..ended=0
    Return $$$OK
}

Method setOp(key, op)
{
    Set ..op(key)=op
}

Method setArg(key, arg)
{
    Set ..arg(key)=arg
}

Method flipOp(key, a = "jmp", b = "nop")
{
    If ..op(key)=a{
        Set ..op(key)=b
    } ElseIf ..op(key)=b{
        Set ..op(key)=a
    }
}

Method reset()
{
    Write:..debug "resetting",!
    Set ..pos=0
    Set ..ended=0
    Set ..looped=0
    Set ..accumulator=0
}

Method run()
{
    Kill visited
    If (..debug){
          Set c=$ORDER(..op(""))
        While c'="" {   
            Write $GET(..op(c)),","
            Set c=$ORDER(..op(c)) 
        }
        Write !
    }
    While $DATA(visited(..pos))'=1{
        If (..pos>=..size) {
            Set ..ended=1
            Quit
        }
        Set visited(..pos)=""
        Set cmd=$GET(..op(..pos),"")
        Set arg=$GET(..arg(..pos),"")
        Write:..debug "executing ",cmd," with ",arg,!
        If cmd="acc"{
            Set ..accumulator=..accumulator+arg
            Set ..pos=..pos+1
        } ElseIf cmd="jmp" {
            Set ..pos=..pos+arg
        } Else {
            Set ..pos=..pos+1
        }
    }
    Set ..looped=1
}

Method getAccumulator()
{
    Return ..accumulator
}

}
