Class fkh2020.Day14 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,14)
    Set erg=0 
    Set mask=0
	Set iterator=data.%GetIterator()
    Set storage=0
   	While iterator.%GetNext(.key,.val) { 
           Set head=$E(val,1,3)
           If head="mem"{
               Set in=$P(val," ",3)
               Set inb=##clasS(Utils.Base).dec2bin(in)
               For i=36:-1:1 {
                   Set m=$E(mask,i)
                   If m="0" {
                       Set $BIT(inb,37-i)=0
                   }
                   If m="1" {
                       Set $BIT(inb,37-i)=1
                   }
               }
               Set add=##class(Utils.Base).bin2dec(inb)                   
               Set addr=$P(val," ",1)
               Set addr=$P(addr,"[",2)
               Set addr=$REPLACE(addr,"]","")

            #;    Write "adding ",add," to ",addr,!
               Set storage(addr)=add

           }
           If head="mas" {
               Set mask=$P(val," ",3)

           }

       }

    Set c=$O(storage(""),1,v)
    While c'="" {
        Set erg=erg+v
        Set c=$O(storage(c),1,v)
    }

    Return erg
}

ClassMethod setvalues(ByRef storage, ByRef floats, addrb, in, pos)
{
    Set faddr=$G(floats(pos),"")
    If faddr="" {
        Set decaddr=##clasS(Utils.Base).bin2dec(addrb)

        Set storage(decaddr)=in
        #; Write "writing ",in," to ",decaddr,!
        Return
    }
    Set $BIT(addrb,37-faddr)=1
    Do ..setvalues(.storage,.floats,addrb,in,pos+1)
    Set $BIT(addrb,37-faddr)=0
    Do ..setvalues(.storage,.floats,addrb,in,pos+1)
}

ClassMethod part2()
{
   Set data = ##class(Utils.Base).load(2020,14)
    Set erg=0 
    Set mask=0
	Set iterator=data.%GetIterator()
    Set storage=0
   	While iterator.%GetNext(.key,.val) { 
           Set head=$E(val,1,3)
           If head="mem"{
               Set in=$P(val," ",3)
               
               Set addr=$P(val," ",1)
               Set addr=$P(addr,"[",2)
               Set addr=$REPLACE(addr,"]","")
               Set addrb=##clasS(Utils.Base).dec2bin(addr)
               Kill floats
               Set numfloats=0
               For i=36:-1:1 {
                   Set m=$E(mask,i)
                   If m="1" {
                       Set $BIT(addrb,37-i)=1
                   }
                   If m="X"{
                       Set floats($I(floats))=i                       
                   }                   
               }
               Do ..setvalues(.storage,.floats,addrb,in,1)

           }
           If head="mas" {
               Set mask=$P(val," ",3)

           }

       }

    Set c=$O(storage(""),1,v)
    While c'="" {
        Set erg=erg+v
        Set c=$O(storage(c),1,v)
    }

    Return erg
}

}
