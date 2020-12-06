Class fkh2020.Day6 Extends fkh2020.Base
{

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,6)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set groupanswers=""
    Set sum=0
   	While iterator.%GetNext(.key,.val) { 
            If $LENGTH(val)>0 {               
                For i=1:1:$LENGTH(val){
                    Set a=$EXTRACT(val,i)
                    If groupanswers'[a{
                        Set groupanswers=groupanswers_a
                    }                    
                }               
           } Else {               
                Set sum=sum+$LENGTH(groupanswers)
                #; Write c," ",sum,!
                Set groupanswers=""
           }
       }
    Set sum=sum+$LENGTH(groupanswers)
    #; Write c," ",sum,!
    Set groupanswers=""
    Return sum
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,6)
    Set erg=0 
	Set iterator=data.%GetIterator()
    Set groupanswers=""
    Set sum=0
    Set groupmembers=0
   	While iterator.%GetNext(.key,.val) { 
           Set groupmembers=groupmembers+1
           If $LENGTH(val)>0 {          
                If groupmembers=1 {
                    Set groupanswers=val                    
                } Else {   
                    Set tempa=groupanswers  
                    For i=1:1:$LENGTH(groupanswers){
                        Set a=$EXTRACT(groupanswers,i)                    
                        If val'[a{
                            Set tempa=$REPLACE(tempa,a,"")
                        }                    
                    }    
                    Set groupanswers=tempa   
                }        
           } Else {               
                Set sum=sum+$LENGTH(groupanswers)                
                #; Write c," ",sum,!
                Set groupanswers=""
                Set groupmembers=0
           }
       }
   Set sum=sum+$LENGTH(groupanswers)
    Return sum
}

}
