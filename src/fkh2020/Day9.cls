Class fkh2020.Day9 Extends fkh2020.Base
{

ClassMethod valid(ByRef data, pos, lookback)
{
    Set valid=0
    For a=pos-lookback-1:1:pos-1{
        For b=pos-lookback-1:1:pos-1{
            If (($GET(data(a))+$GET(data(b)))=$GET(data(pos))){
                Return 1
            }
        
        }
    }
    Return valid
}

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,9)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           Set array(key)=val
       }
    Set count=data.%Size()
    Set preamble=25
    Set pos=preamble
    For p=pos:1:count{
        If ##class(fkh2020.Day9).valid(.array,p,preamble)'=1 {
            Return $GET(array(p))
        }
    }

    Return erg
}

ClassMethod arraysubsum(ByRef array, n, sum)
{
    Write sum,!
    For i=0:1:n{
        Set current=$GET(array(i))
        Set j=i+1
        While j<=n{
            If current=sum{
                Write "found result",i," -> ",j-1,!
                Set min=$GET(array(i))
                Set max=$GET(array(j-1))
                For c=i:1:j-1{
                    Set v=$GET(array(c))
                    If v<min{
                        Set min=v
                    }
                    If v>max{
                        Set max=v
                    }
                }
                #; Write "sum:",min,"+",max,"=",min+max,!  
                Return min+max              
            }

            If (current>sum) || (j=n){
                Quit
            }
            Set current=current+$GET(array(j))
            Set j=j+1
        }
    }
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,9)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           Set array(key)=val
       }
    Set count=data.%Size()

    Set sum=1639024365
    Set erg= ##class(fkh2020.Day9).arraysubsum(.array,count,sum)
    Return erg
}

}
