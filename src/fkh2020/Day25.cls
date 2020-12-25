Class fkh2020.Day25 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,25)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
         
       }

    s cardpk=12320657
    #; s cardpk=5764801
    s doorpk=9659666
    #; s doorpk=17807724

    s loop=..findLoop(7,cardpk)
    s doorloop=..findLoop(7,doorpk)
    
    #; s cardpk=1
    #; s doorpk=1

    
    s cardek=..transform(doorpk,loop)
    s doorek=..transform(cardpk,doorloop)
    w cardek, " ", doorek,!
    
    Return 0
}

ClassMethod findLoop(subject, target)
{
    s l=0
    s v=1
    do {
        s v=v*subject
        s v=v#20201227
        s l=l+1
    } while (target'=v)
   
    return l
}

ClassMethod transform(subject, loop)
{
    s v=1    
    for i=1:1:loop{
        s v=v*subject
        s v=v#20201227
        
    }
    return v
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,24)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
          
       }

    
    Return 2
}

}
