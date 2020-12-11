Class fkh2020.Day11 Extends fkh2020.Base
{

ClassMethod part1()
{
    #; Set data = ##class(Utils.Base).load(2020,11)
    #; Set erg=0 
	#; Set iterator=data.%GetIterator()
   	#; While iterator.%GetNext(.key,.val) { 

    #;    }
    Do ##class(Utils.Base).load2(.data,2020,11)
    ZWrite data
    Set r=$ORDER(data(""),1,v)    
    Set w=0,h=0
    While r'=""{
        #; ZWrite v
        For c=1:1:$LENGTH(v){            
            Set cs=$EXTRACT(v,c)
            Set seats(c,r)=cs
            If c>w{
                Set w=c
            }
        }
        If r>h{
            Set h=r
        }
        Set r=$ORDER(data(r),1,v)
    }    
    Set it=0    
    Write "loop",h," ",w,!
    Do {
        Set moved=0
        Merge nextgen=seats
        For y=1:1:h{
            For x=1:1:w{
                Set seat=$GET(seats(x,y),"")
                #; Set empty=..getAdjFree(.seats,x,y)
                Set occ=..getAdjOcc(.seats,x,y)
                #; Write x,":",y," e:",empty," o:",occ,!
                If (seat="L") && (occ=0){                
                    Set moved=moved+1
                    Set nextgen(x,y)="#"                
                }
                If (seat="#")&& (occ>=4){                    
                    Set moved=moved+1
                    Set nextgen(x,y)="L"
                }

            }
        }        
        Set it=it+1
        Merge seats=nextgen
        Write "----------",!
        For y=1:1:h{
            For x=1:1:w{
                Set seat=$GET(seats(x,y),"")
                Write seat
                If seat="#"{
                    Set c=c+1
                }

            }
            Write !
        }     
        #; ZWrite seatss
    } While moved>0

    Set c=0
    For y=1:1:h{
            For x=1:1:w{
                Set seat=$GET(seats(x,y),"")
                Write seat
                If seat="#"{
                    Set c=c+1
                }

            }
            Write !
        }            
    Return c
    Return it
}

ClassMethod getAdjFree(ByRef seats, x, y)
{
    Set check="L"
    Set free=0
    If $GET(seats(x-1,y),"")=check{
        Set free=free+1
    }
    If $GET(seats(x+1,y),"")=check{
        Set free=free+1
    }
    If $GET(seats(x-1,y-1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x-1,y+1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x,y+1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x,y-1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x+1,y-1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x+1,y-1),"")=check{
        Set free=free+1
    }
    Return free
}

ClassMethod getAdjOcc(ByRef seats, x, y)
{
    Set check="#"
    Set free=0
    If $GET(seats(x-1,y-1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x,y-1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x+1,y-1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x-1,y),"")=check{
        Set free=free+1
    }
    If $GET(seats(x+1,y),"")=check{
        Set free=free+1
    }
    If $GET(seats(x-1,y+1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x,y+1),"")=check{
        Set free=free+1
    }
    If $GET(seats(x+1,y+1),"")=check{
        Set free=free+1
    }
    Return free
}

ClassMethod getOccInView(ByRef seats, x, y)
{
    Set seen=0
    For dir=$LISTBUILD(-1,-1),$LISTBUILD(0,-1),$LISTBUILD(1,-1),$LISTBUILD(-1,0),$LISTBUILD(1,0),$LISTBUILD(-1,1),$LISTBUILD(0,1),$LISTBUILD(1,1) {
        Set f=1
        Set tx=x+($LISTGET(dir,1)*f)
        Set ty=y+($LISTGET(dir,2)*f)        
        Set g=$GET(seats(tx,ty))
        While g'="" {            
            Set tx=x+($LISTGET(dir,1)*f)
            Set ty=y+($LISTGET(dir,2)*f)        
            Set g=$GET(seats(tx,ty))
            If g="#" {
                Set seen=seen+1
                Set g=""
            }
            If g="L" {
                Set g=""
            }
            Set f=f+1
        }
    }
    Do $INCREMENT(a)
    Return seen
}

ClassMethod part2()
{
    Write !,!,!,!
    #; Set data = ##class(Utils.Base).load(2020,11)
    #; Set erg=0 
	#; Set iterator=data.%GetIterator()
   	#; While iterator.%GetNext(.key,.val) { 

    #;    }
    Do ##class(Utils.Base).load2(.data,2020,11)
    ZWrite data
    Set r=$ORDER(data(""),1,v)    
    Set w=0,h=0
    While r'=""{
        #; ZWrite v
        For c=1:1:$LENGTH(v){            
            Set cs=$EXTRACT(v,c)
            Set seats(c,r)=cs
            If c>w{
                Set w=c
            }
        }
        If r>h{
            Set h=r
        }
        Set r=$ORDER(data(r),1,v)
    }    
    Set it=0    
    Write "loop",h," ",w,!
    Do {
        Set moved=0
        Merge nextgen=seats
        For y=1:1:h{
            For x=1:1:w{
                Set seat=$GET(seats(x,y),"")
                #; Set empty=..getAdjFree(.seats,x,y)
                Set occ=..getOccInView(.seats,x,y)
                #; Write x,":",y," e:",empty," o:",occ,!
                If (seat="L") && (occ=0){                
                    Set moved=moved+1
                    Set nextgen(x,y)="#"                
                }
                If (seat="#")&& (occ>=5){                    
                    Set moved=moved+1
                    Set nextgen(x,y)="L"
                }

            }
        }        
        Set it=it+1
        Merge seats=nextgen
        Write "----------",!
        For y=1:1:h{
            For x=1:1:w{
                Set seat=$GET(seats(x,y),"")
                Write seat                
            }
            Write !
        }     
        #; ZWrite seatss
    } While moved>0

    Set c=0
    For y=1:1:h{
            For x=1:1:w{
                Set seat=$GET(seats(x,y),"")
                #; Write seat
                If seat="#"{
                    Set c=c+1
                }

            }
            #; Write !
        }            
    Return c
    Return it
}

}
