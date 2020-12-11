Class fkh2020.Day10 Extends fkh2020.Base
{

ClassMethod part1()
{
    
    Do ##class(Utils.Base).load2(.data,2020,10)
    Set erg=0     	
    Set c=$ORDER(data(""))
    While c'=""{
        Set adapters($GET(data(c)))=""
        Set c=$ORDER(data(c))
    }
    Set adapters=data

    
    Set lowest=$ORDER(adapters(""))
    Set lastused=0
    
    While lowest'=""{
        #; Write lowest,!
        Set d=lowest-lastused
        Set used(d)=$GET(used(d),0)+1
        Set lastused=lowest
        #; Write "using ",lowest," d:",d,!
        Kill adapters(lowest)
        Set lowest=$ORDER(adapters(""))
    }
    Set used(3)=$GET(used(3),0)+1    
    Return $GET(used(1))*$GET(used(3))
}

ClassMethod enumerateChains(ByRef array, ByRef cache, current, target)
{
    #; Write $GET(array)," ",$GET(cache)," ",current," ",target,!
    #; Write "len ",array,!
    Set hash=$LISTBUILD($GET(array),current)
    If $DATA(cache(hash)){
        Return $GET(cache(hash))
    }
    Set count=0
    If (target-current)<=3{
        Set count=count+1
    }
    If array=0{
        Return count
    }
    #; ZWrite array
    Set first=$ORDER(array(""))
    Merge temp=array
    Kill temp(first)
    Set temp=temp-1
    If (first-current)<=3{
        Set count=count+..enumerateChains(.temp,.cache,first,target)
    }
    Set count=count+..enumerateChains(.temp,.cache,current,target)
    Set cache(hash)=count
    Return count
}

ClassMethod part2()
{
    Do ##class(Utils.Base).load2(.data,2020,10)
    Set erg=0     	
    Set c=$ORDER(data(""))
    While c'=""{
        Set adapters($GET(data(c)))=""
        Set c=$ORDER(data(c))
    }
    Set adapters=data
    Set target=$ORDER(adapters(""),-1)+3   
    Return ##class(fkh2020.Day10).enumerateChains(.adapters,.cache,0,target)
}

}
