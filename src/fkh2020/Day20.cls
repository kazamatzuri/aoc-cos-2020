Class fkh2020.Day20 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,20)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 

       }

    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,20)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
       }
    Return erg
}

}
