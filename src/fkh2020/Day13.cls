Class fkh2020.Day13 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,13)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	Do iterator.%GetNext(.key,.val) 
    Set earliest=val
    Do iterator.%GetNext(.key,.val) 
    Set busses=val
    For i=1:1:$L(busses,","){
        Set line=$P(busses,",",i)
        If line '="x"{
            Set bus(line)=""
        }
    }
    
    For i=earliest:1:earliest+100000{
        Set b=$O(bus(""))
        While b'="" {
            If (i#b)=0{
                Return (i-earliest)*b
            }
            Set b=$O(bus(b))

        }
    }

    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,13)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	Do iterator.%GetNext(.key,.val) 
    Do iterator.%GetNext(.key,.val) 
    Set busses=val
    Set crtpairs=""
    For i=1:1:$L(busses,","){
        Set line=$P(busses,",",i)
        If line '="x"{
            Set bus(line)=i
            Set crtpairs=crtpairs_$LB($LB(line-(i-1),line))            
        }
    }
    Set erg=##class(Utils.Base).crt(crtpairs)

    Return erg
}

}
