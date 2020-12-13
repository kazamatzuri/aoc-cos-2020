Class Utils.Base Extends %RegisteredObject
{

Parameter Folder = "/irisdev/app/";

// true if element in array

ClassMethod inList(element, list) As %Boolean
{
	Set result=0
	For i=1:1:$LL(list){
		If $LG(list,i)=element{
			Return 1			
		}
	}
	Return result
}

ClassMethod powM(a, b, m)
{
	Set res=1
	Set a=a#m
	While (b>0){
		If (b#2)=1{
			Set res=(res*a)#m
		}
		Set b=b\2
		Set a=(a*a)#m
	}
	Return res
}

ClassMethod egcd(a, b)
{
	If a=0{
		Return $LB(b,0,1)
	}Else {
		Set r=..egcd(b#a,a)
		Set g=$LG(r,1)
		Set y=$LG(r,2)
		Set x=$LG(r,3)
		Return $LB(g,x-((b\a)*y),y)
	}
}

ClassMethod modInv(a, m)
{
	Write "a:",a," m:",m,!
	Set r=..egcd(a,m)
	ZWrite r
	Set g=$LG(r,1)
	Set x=$LG(r,2)
	Set y=$LG(r,3)
	If g'=1{
		Write "inv doesn't exist ",a," ",m,!
		Break
	} Else {
		Return x#m
	}
}

ClassMethod inArray(element, ByRef array) As %Boolean
{
	Return $D(array(element))
}

ClassMethod gcd(a, b) As %Integer
{
	If (a<0){
		Set a=-a
	}
	If (b<0) {
		Set b=-b
	}	
	If (a=0){
		Return b
	}
	If (b=0){
		Return a
	}

	While (a'=b) {
		
		If (a>b){
			Set a=a-b
		} Else {
			Set b=b-a
		}		
	}
	Return a
}

ClassMethod manhattandist(a, b)
{
	Set sum=0
	For i=1:1:$LL(a) {
		Set sum=sum +$ZABS($LG(a,i)-$LG(b,i))
	}
	Return sum
}

// returns Levenshtein distance

ClassMethod levenshtein(a, b) As %Integer
{
	If $L(a)'=$L(b){
		Return -1
	}
	Set d=0
	For t=1:1:$L(a) {
		Set:($E(a,t)'=$E(b,t)) d=d+1
	}
	Return d
}

// true if element not in array

ClassMethod notinArray(element, ByRef array) As %Boolean
{
	Return '..inArray(element,.array)
}

// binary and

ClassMethod band(a, b)
{
	Set ab=..dec2bin(a)
	Set bb=..dec2bin(b)
	
	Return ..bin2dec($BITLOGIC(ab&bb))
}

// binary or 

ClassMethod bor(a, b)
{
	Set ab=..dec2bin(a)
	Set bb=..dec2bin(b)
	Return ..bin2dec($BITLOGIC(ab|bb))
}

// binary xor

ClassMethod bxor(a, b)
{
	Set ab=..dec2bin(a)
	Set bb=..dec2bin(b)
	Return ..bin2dec($BITLOGIC(ab^bb))
}

// binary not

ClassMethod bnot(a)
{
	Set ab=..dec2bin(a)
	Return ..bin2dec($BITLOGIC(~ab))
}

ClassMethod bin2dec(x)
{
 Set decval=""
 For loop=1:1:64 {
 	Set power=loop-1
 	Set binbit=$BIT(x,loop)
 	If binbit=1 Set decval=decval+(2**power)
 }
 //w power,!
 Set:decval="" decval=0
 Return decval
}

ClassMethod dec2bin(x)
{
	Set p=0
	For p=0:1:63{
		Set $BIT(eb,p+1)=(x#2)
		Set x=x\2
	}
	Return eb
}

ClassMethod sum(ByRef array)
{
	Set sum=0
	Set iterator=array.%GetIterator()
   	While iterator.%GetNext(.key,.val) { 
		   Set sum=sum+val
		  
		   }
}

// load input data

ClassMethod load(y, d, t = 0)
{
	Set fname=..#Folder_"/"_y_"/"_"input"_d_".txt"
	Set:t fname=..#Folder_"/"_y_"/"_"input"_d_".test.txt"
	//w fname,!
	Set fs=##clasS(%Stream.FileCharacter).%New()
	Do fs.LinkToFile(fname)
	//s x = fs.ReadLine(),i=0
	Set data=[]
	While 'fs.AtEnd{
		Set x=fs.ReadLine()
		Do data.%Push(x)	
	}
	Return data
}

ClassMethod load2(ByRef data, y, d, t = 0)
{
	Set fname=..#Folder_"/"_y_"/"_"input"_d_".txt"
	Set:t fname=..#Folder_"/"_y_"/"_"input"_d_".test.txt"
	//w fname,!
	Set fs=##clasS(%Stream.FileCharacter).%New()
	Do fs.LinkToFile(fname)
	
	// Set data=[]
	While 'fs.AtEnd{
		Set x=fs.ReadLine()
		Set data($I(data))=x				
	}
	Return $$$OK
}

ClassMethod loadSplit(y, d)
{
	Set data= ..load(y,d)
	Set result=[]	
	Set iter=data.%GetIterator()
	While iter.%GetNext(.key,.value) {		
		Set length=$L(value,",")
		For i=1:1:length {
			Set row=$P(value,",",i)
			Do result.%Push(row)
		}
	}
	Return result
}

ClassMethod crt(params)
{
	
	Set m=1
	For i=1:1:$LL(params){
		Set pair=$LG(params,i)
		Set a=$LG(pair,1)
		Set b=$LG(pair,2)
		Set m=m*b
	}
	#; Write "debug ",m,!
	Set erg=0
	
	For i=1:1:$LL(params){
		Set pair=$LG(params,i)
		Set a=$LG(pair,1)
		Set b=$LG(pair,2)
		
		Set t=m\b
		Set erg=erg+((a*t)*..powM(t,b-2,b))
		Set erg=erg#m
	}

	Return erg
}

ClassMethod test()
{
	Set array(1)="hallo"
	Set array(2)="test"
	Set array(3)="something"
	Set element="test"
	Write ..inArray(element,.array),!
	Write ..inArray("bla",.array),!
	Write ..notinArray("bla",.array),!
}

}
