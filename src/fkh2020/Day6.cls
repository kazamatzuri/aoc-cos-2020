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
                    Set groupanswers($EXTRACT(val,i))=""
                }               
           } Else {
               Set c=0
               Set i=$ORDER(groupanswers(""))
               While i'="" {
                   Set c=c+1
                   Set i=$ORDER(groupanswers(i))                   
               }
            Set sum=sum+c
            #; Write c," ",sum,!
            Kill groupanswers
           }
       }
   Set c=0
               Set i=$ORDER(groupanswers(""))
               While i'="" {
                   Set c=c+1
                   Set i=$ORDER(groupanswers(i))                   
               }
            Set sum=sum+c
            #; Write c," ",sum,!
            Kill groupanswers
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
                For i=1:1:$LENGTH(val){
                    Set a=($EXTRACT(val,i))
                    If groupmembers=1{
                        Set groupanswers(a)=""
                    } Else {
                        Set t=$ORDER(groupanswers(""))
                        While t'="" {
                            If val'[t {
                                Kill groupanswers(t)
                            }
                            Set t=$ORDER(groupanswers(t))                   
                        }
                    }
                }               
           } Else {
               Set c=0
               Set i=$ORDER(groupanswers(""))
               While i'="" {
                   Set c=c+1
                   Set i=$ORDER(groupanswers(i))                   
               }
            Set sum=sum+c
            Write c," ",sum,!
            Kill groupanswers
            Set groupmembers=0
           }
       }
            Set c=0
               Set i=$ORDER(groupanswers(""))
               While i'="" {
                   Set c=c+1
                   Set i=$ORDER(groupanswers(i))                   
               }
            Set sum=sum+c
            Write c," ",sum,!
            Kill groupanswers
    Return sum
}

}
