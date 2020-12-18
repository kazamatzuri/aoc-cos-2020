Class fkh2020.Day18 Extends fkh2020.Base [ Not ProcedureBlock ]
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,18)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set str=""
    Set sum=0
    Set stream=##class(%Stream.GlobalCharacter).%New()
   	While iterator.%GetNext(.key,.val) { 
           Set cmd="s sum=sum+("_val_")"
           Xecute cmd           
       }  
    Return sum
}

ClassMethod findfromright(string, search)
{
    For i=$L(string):-1:1{
        Set c=$E(string,i)
        If c=search {
            Return i
        }
    }
    Return -1
}

ClassMethod findMatchingClose(string, start)
{
    Set level=0    
    For i=start:1:$L(string){
        Set c=$E(string,i)
        
        If ((c=")") && (level=0))
        {
            Return i
        }
        If (c="(") {
            Set level=level+1
        }
        If (c=")") {
            Set level=level-1
        }        
    }
    Return -1
}

ClassMethod eval(string)
{
    New (string)
    Set m=##class(%Regex.Matcher).%New("\(")
    Set m.Text=string
    Set start=$LOCATE(string,"\(")
    While start { 
        Set end=..findMatchingClose(string,start+1)        
        Set middle=$E(string,start+1,end-1)
        Set left=$E(string,0,start-1)
        Set right=$E(string,end+1,$L(string))
        #; Write left,"--->",middle,"--->",right,!
        Set middle=..eval(middle)
        Write "replacement:",middle,!
        Set string=left_middle_right    
        Write string,!    
        Set start=$LOCATE(string,"\(")
    }
    Set start=$LOCATE(string,"\d+ \+ \d+",,,v)
    While start {
        Set v=$ZSTRIP(v,"<>W")
        Set op1=$ZSTRIP($P(v,"+",1),"<>W")
        Set op2=$ZSTRIP($P(v,"+",2),"<>W")
        Set res=op1+op2
        Set string=$REPLACE(string,v,res)
        Set start=$LOCATE(string,"\d+ \+ \d+",,,v)
    }
    Set cmd="s erg="_string
    Xecute cmd
    

    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,18)
    Set erg=0 
	Set iterator=data.%GetIterator()
    While iterator.%GetNext(.key,.val) {           
        Set erg=erg+..eval(val)           
       }
    Return erg
}

}
