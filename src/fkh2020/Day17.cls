Class fkh2020.Day17 Extends fkh2020.Base
{

ClassMethod getActiveN2(ByRef data, x, y, z, w)
{
    Set act=0    
    For tx=(x-1):1:(x+1){
        For ty=(y-1):1:(y+1){
            For tz=(z-1):1:(z+1){    
                For tw=(w-1):1:(w+1){
                    Set v=$G(data(tx,ty,tz,tw),".")
                        If v="#" {
                            Set act=act+1
                        }
} 
            }
        }
    }    
    Set v=$G(data(x,y,z,w),".")
    If v="#"{
        Set act=act-1
    }

    Return act
}

ClassMethod getActiveN(ByRef data, x, y, z)
{
    Set act=0    
    For tx=(x-1):1:(x+1){
        For ty=(y-1):1:(y+1){
            For tz=(z-1):1:(z+1){     
                Set v=$G(data(tx,ty,tz),".")
                If v="#" {
                    Set act=act+1
                }
            }
        }
    }    
    Set v=$G(data(x,y,z),".")
    If v="#"{
        Set act=act-1
    }

    Return act
}

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,17)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           For i=1:1:$L(val){
               Set data(i,key,0)=$E(val,i)                              
           }
           Set maxx=$L(val)
       }
    
    Set maxy=data.%Size()
    #; ZWrite data
    Set maxz=0

    #; Return ..countAll(.data)
    Set dim=3
    Set r=0
    While r<6 {
        For tx=-(r+maxx+2):1:(r+maxx+2){
            For ty=-(r+maxy+2):1:(r+maxy+2){
                For tz=-(r+maxz+2):1:(r+maxz+2){                   
                    #; Write tx,ty,tz,!
                    Set v=$G(data(tx,ty,tz),".")
                    Set n=..getActiveN(.data,tx,ty,tz)                   
                    If (v="#"){                            
                            If ((n=2)||(n=3)){
                                #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                                Set newdata(tx,ty,tz)="#"                        
                            } Else {
                                Set newdata(tx,ty,tz)="."                        
                            }
                    }
                    If ((v=".")&&(n=3)){
                        #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                        Set newdata(tx,ty,tz)="#"
                    }
                }
        }            
        }
        Set r=r+1
        Kill data
        Merge data=newdata        
    }   
    Set all= ..countAll(.data)       
    Return all
}

ClassMethod countAll(ByRef data)
{
    Set act=0
    
    Set act=0
    Set minx=$O(data(""))
        Set maxx=$O(data(""),-1)
        Write minx,maxx,!
        For tx=minx:1:maxx{
            Set miny=$O(data(tx,""))
            Set maxy=$O(data(tx,""),-1)                    
            For ty=miny:1:(maxy){
                Set minz=$O(data(tx,ty,""))
                Set maxz=$O(data(tx,ty,""),-1)                    
                For tz=(minz):1:(maxz){                    
                    #; Write tx,ty,tz,!
                    Set v=$G(data(tx,ty,tz),".")
                    If v="#"{
                        Set act=act+1
                    }
                }
        }            
        }
        Return act
}

ClassMethod countAll2(ByRef data)
{
    Set act=0
    Set minx=$O(data(""))
    Set maxx=$O(data(""),-1)
    Write minx,maxx,!
    For tx=minx:1:maxx{
        Set miny=$O(data(tx,""))
        Set maxy=$O(data(tx,""),-1)                    
        For ty=miny:1:(maxy){
            Set minz=$O(data(tx,ty,""))
            Set maxz=$O(data(tx,ty,""),-1)                    
            For tz=(minz):1:(maxz){      
                Set minw=$O(data(tx,ty,tz,""))
                Set maxw=$O(data(tx,ty,tz,""),-1)                    
                For tw=(minw):1:(maxw){                   
                    #; Write tx,ty,tz,!
                    Set v=$G(data(tx,ty,tz,tw),".")
                    If v="#"{
                        Set act=act+1
                    }
                }
            }
        }
    }            
    Return act
}

ClassMethod part2()
{
   Set data = ##class(Utils.Base).load(2020,17)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
           For i=1:1:$L(val){
               Set data(i,key,0,0)=$E(val,i)                              
           }
           Set maxx=$L(val)
       }
    
    Set maxy=data.%Size()
    Set maxw=0
    #; ZWrite data
    Set maxz=0

    #; Return ..countAll(.data)
    Set dim=3
    Set r=0
    While r<6 {
        For tx=-(r+maxx+2):1:(r+maxx+2){
            For ty=-(r+maxy+2):1:(r+maxy+2){
                For tz=-(r+maxz+2):1:(r+maxz+2){   
                    For tw=-(r+maxw+2):1:(r+maxw+2){   
                        #; Write tx,ty,tz,!
                        Set v=$G(data(tx,ty,tz,tw),".")
                        Set n=..getActiveN2(.data,tx,ty,tz,tw)                   
                        If (v="#"){                            
                                If ((n=2)||(n=3)){
                                    #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                                    Set newdata(tx,ty,tz,tw)="#"                        
                                } Else {
                                    Set newdata(tx,ty,tz,tw)="."                        
                                }
                        }
                        If ((v=".")&&(n=3)){
                            #; Write r,"th round ",tx," ",ty," ",tz," act ",n,!
                            Set newdata(tx,ty,tz,tw)="#"
                        }
                    }
                }
            }            
        }
        Set r=r+1
        Kill data
        Merge data=newdata        
    }   
    Set all= ..countAll2(.data)       
    Return all
}

}
