module Xslt exposing (transform, TransformError)
import Native.Xslt

type alias TransformError = {
    code:Int,
    message:String}

transform : String -> String -> Result TransformError String

transform styleSheet =
    let
        partialResult : Result TransformError (String -> Result TransformError String)
        partialResult = Native.Xslt.transform(styleSheet)
    in
        case partialResult of
            Err error ->
                (\input -> Err error)
            Ok partial ->
                partial


