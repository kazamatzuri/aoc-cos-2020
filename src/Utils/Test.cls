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

}
