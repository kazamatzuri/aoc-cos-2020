Class Utils.Test Extends %RegisteredObject
{

ClassMethod printvalues(k, v)
{
    Write "key:",k,"  value:",v,!
}

ClassMethod uppertolower(k, v)
{
    Return $C($A(v)+32)
}

ClassMethod run()
{
    For i=1:1:26 {
        Set data(i,2)=$C(i+64)
    }
    Do ##class(Utils.Base).foreach(.data,"Utils.Test","printvalues")
    Do ##class(Utils.Base).map(.data,"Utils.Test","uppertolower")
    Do ##class(Utils.Base).foreach(.data,"Utils.Test","printvalues")
}

ClassMethod testPermutations()
{
    Set values($I(values))=-1
    Set values($I(values))=0
    Set values($I(values))=1
    Do ##class(Utils.Base).permutations(.values,3,.output)
    ZWrite output
}

ClassMethod testConvertDecTo()
{
    Write ##class(Utils.Base).convertDecTo(136,8)
}

}
