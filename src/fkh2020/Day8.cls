Class fkh2020.Day8 Extends fkh2020.Base
{

ClassMethod part1()
{
    
    Set data = ##class(Utils.Base).load(2020,8)
    Set machine=##class(fkh2020.Machine).%New(data)
    #; Set machine.debug=1
    Do machine.run()
    Return machine.getAccumulator()
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,8)
    Set erg=0 
    Set pos=0
    Set acc=0

    Set iterator=data.%GetIterator()
    Set count=0
   	While iterator.%GetNext(.key,.val) {  
           Set count=count+1          
            Set cmd=$PIECE(val," ",1)
            Set arg=$PIECE(val," ",2)
            If cmd="jmp"{
                Set jmps(key)=""
            }
            If cmd="nop" {
                Set nops(key)=""
            }
       }

    Set machine=##class(fkh2020.Machine).%New(data)
    #; Set machine.debug=1
    #; Write "1",!
    Set c=$ORDER(nops(""))
    While c'="" {
        Do machine.reset()
        Do machine.flipOp(c)
        Do machine.run()
        If machine.ended=1{
            Return machine.getAccumulator()
        }    
        Do machine.flipOp(c)        
        Set c=$ORDER(nops(c))    
    }
    #; Write "2",!
    Set c=$ORDER(jmps(""))
    While c'="" {
        Do machine.reset()
        Do machine.flipOp(c)
        Do machine.run()
        If machine.ended{
            Return machine.getAccumulator()
        }    
        Do machine.flipOp(c)        
        Set c=$ORDER(jmps(c))      
    }
    
    Return erg
}

}
