Class fkh2020.Day5 Extends fkh2020.Base
{

ClassMethod getRow(fullstring)
{
    
    Set start=0
    Set end=127
    Set decr=128
    For i=1:1:$LENGTH(fullstring){
        Set c=$EXTRACT(fullstring,i)
        Set decr=decr\2
        If c="F" {
            Set end=end-decr
        }
        If c="B"{
            Set start=start+decr
        }
        #; Write c,":",start,"-",end,!
    }
    #; Write start," ",end,!
    Return start
}

ClassMethod getCol(fullstring)
{
    Set start=0
    Set end=7
    Set decr=8
    For i=1:1:$LENGTH(fullstring){
        Set c=$EXTRACT(fullstring,i)
        Set decr=decr\2
        If c="L" {
            Set end=end-decr
        }
        If c="R"{
            Set start=start+decr
        }
        #; Write c,":",start,"-",end,!
    }
    #; Write start," ",end,!
    Return start
}

ClassMethod getSeatId(string)
{
    Set row=..getRow($EXTRACT(string,1,7))
    Set col=..getCol($EXTRACT(string,8,10))
    Set seatid=(row*8)+col
    Return seatid
}

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,5)
    Set erg=0 
    Set max=0
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) {            
           Set id=..getSeatId(val)
           If id>max{
               Set max=id
           }
       }

    Return max
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,5)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           Set id=..getSeatId(val)
           If id'=""{
           Set used(id)=""
           }
       }
    For i=0:1:908{
        Set map=$DATA(used(i-1))_$DATA(used(i))_$DATA(used(i+1))
        If map="101"{
            Return i
        }
    }
    Return erg
}

}
