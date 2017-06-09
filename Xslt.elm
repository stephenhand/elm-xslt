module Xslt exposing (transform, TransformError)
import Native.Xslt

type alias TransformError = {
    code:Int,
    message:String}

transform : String -> String -> Result TransformError String

transform styleSheet =
    Native.Xslt.transform(styleSheet)
