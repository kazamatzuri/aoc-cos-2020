Class fkh2020.Day4 Extends fkh2020.Base
{

ClassMethod validate1(ByRef pass)
{
    Set valid=1
    For r="byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" {
        #; Write $GET(pass(r),""),!
        If $GET(pass(r),"")="" {
            Set valid=0
        }
    }
    Return valid
}

ClassMethod validate2(ByRef pass)
{
    Set colors("amb")=""
    Set colors("blu")=""
    Set colors("brn")=""
    Set colors("gry")=""
    Set colors("grn")=""
    Set colors("hzl")=""
    Set colors("oth")=""
    Set valid=1
    Set byr=$GET(pass("byr"))
    Set iyr=$GET(pass("iyr"))
    Set eyr=$GET(pass("eyr"))
    If (($LENGTH(byr)'=4)||(($LENGTH(iyr)'=4))||($LENGTH(eyr)'=4)){
        Write "invalid digit length",!
        Set valid=0
    }
    If (byr<1920 ) || (byr>2002){
        Write "invalid byr",byr,!
        Set valid=0
    }
    If (iyr<2010)||(iyr>2020){
        Write "invalid iyr",iyr,!
        Set valid=0
    }
    If (eyr<2020)||(eyr>2030){
        Write "invalid eyr",eyr,!
        Set valid=0
    }
    Set hgt=$GET(pass("hgt"))
    If (hgt["cm") {
        If (hgt<150)||(hgt>193){
            Write "invalid hgt",hgt,!
            Set valid=0
        }
    } ElseIf (hgt["in"){
        If (hgt<59)||(hgt>76){
            Write "invalid hgt",hgt,!
            Set valid=0
        }
    } Else {
        Write "invalid hgt",hgt,!
        Set valid=0
    }
    Set hcl=$GET(pass("hcl"))
    If $LENGTH(hcl)'=7{
        Write "invalid hcl length",hcl,!
        Set valid=0
    }
    For i=2:1:7{
        If "0123456789abcdef"'[$EXTRACT(hcl,i){
            Write "invalid hcl",hcl,!            
            Set valid=0
        }
    }


    Set ecl=$GET(pass("ecl"))
    If '$DATA(colors(ecl)){
        Write "invalid ecl",ecl,!
        Set valid=0
    }
    Set pid=$GET(pass("pid"))
    If $LENGTH(pid)'=9{
        Write "invalid pid",pid,!
        Set valid=0
    }
    For i=1:1:9{
        If ($ASCII($EXTRACT(pid,i))<48) ||($ASCII($EXTRACT(pid,i))>57){
            Write "invalid pid",pid,!
            Set valid=0
        }
    }
    Return valid
}

ClassMethod part1()
{
    Set data = ##class(Utils.Base).load(2020,4)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) {           
           If $LENGTH(val)>0 {               
               For i=1:1:$LENGTH(val," "){
                   Set item=$PIECE(val," ",i)
                   Set pass($PIECE(item,":",1))=$PIECE(item,":",2)
               }               
           } Else {
               Set valid=..validate1(.pass)
               If valid=1{
                   Set erg=erg+1
               }
               Kill pass
           }
       }
    #;    last line
    Set valid=..validate1(.pass)
    If valid=1{
        Set erg=erg+1
    }
    Return erg
}

ClassMethod part2()
{
    Set data = ##class(Utils.Base).load(2020,4)
    Set erg=0 
	Set iterator=data.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
            If $LENGTH(val)>0 {               
               For i=1:1:$LENGTH(val," "){
                   Set item=$PIECE(val," ",i)
                   Set pass($PIECE(item,":",1))=$PIECE(item,":",2)
               }               
           } Else {
               Write "-----",!
               Set valid=..validate1(.pass)
               Set valid2=1
               If valid=1{
                   Set valid2=..validate2(.pass)                   
                   If valid2=1{
                        Set erg=erg+1
                   }
               }
               Kill pass
           }
       }
    Return erg
}

}
