Class fkh2020.Day8 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,8)
    Set erg=0 
    Set pos=0
    Set acc=0

    While $DATA(visited(pos))'=1{
        Set visited(pos)=""    
        Set cmd=$PIECE(data.%Get(pos)," ",1)
        Set arg=$PIECE(data.%Get(pos)," ",2)
        If cmd="acc" {
            Set acc=acc+arg
            Set pos=pos+1
        } ElseIf cmd="jmp" {
            Set pos=pos+arg
        } Else {
            Set pos=pos+1
        }
        #; Write pos,":",acc,!
    }
    
    Return acc
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

    Set c=$ORDER(jmps(""))
    While c'="" {
        Set ended=0,pos=0,acc=0
        Set data = ##class(Utils.Base).load(2020,8)
        Kill visited
        Do data.%Set(c,$REPLACE(data.%Get(c),"jmp","nop"))
        #; ZWrite data
        While ($DATA(visited(pos))'=1)&&(ended=0){
            If pos>=count{
                Set ended=1
                Write "end condition acc: ",pos,":",acc,!
                Set erg=acc
            }
            Set visited(pos)=""    
            Set cmd=$PIECE(data.%Get(pos)," ",1)
            Set arg=$PIECE(data.%Get(pos)," ",2)
            If cmd="acc" {
                #; Write "acc += ",arg,!
                Set acc=acc+arg
                Set pos=pos+1
            } ElseIf cmd="jmp" {
                #; Write "pos += ",arg,!
                Set pos=pos+arg
            } Else {
                Set pos=pos+1
            }
            #; Write pos,":",acc,!
        }
        #; If ended=0 {
        #;     Write "looped run:",acc,!
        #; }
        Set c=$ORDER(jmps(c))
    }

    Set c=$ORDER(nops(""))
    While c'="" {
        Set ended=0,pos=0,acc=0
        Set data = ##class(Utils.Base).load(2020,8)
        Kill visited
        Do data.%Set(c,$REPLACE(data.%Get(c),"nop","jmp"))
        #; ZWrite data
        While ($DATA(visited(pos))'=1)&&(ended=0){
            If pos>=count{
                Set ended=1
                Write "end condition acc: ",pos,":",acc,!
            }
            Set visited(pos)=""    
            Set cmd=$PIECE(data.%Get(pos)," ",1)
            Set arg=$PIECE(data.%Get(pos)," ",2)
            If cmd="acc" {
                #; Write "acc += ",arg,!
                Set acc=acc+arg
                Set pos=pos+1
            } ElseIf cmd="jmp" {
                #; Write "pos += ",arg,!
                Set pos=pos+arg
            } Else {
                Set pos=pos+1
            }
            #; Write pos,":",acc,!
        }
        #; If ended=0 {
        #;     Write "looped run:",acc,!
        #; }
        Set c=$ORDER(nops(c))
    }
    
    Return erg
}

}
