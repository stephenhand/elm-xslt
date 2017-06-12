module Xslt exposing (transform, TransformError)
import Native.Xslt

type alias TransformError = {
    code:Int,
    message:String}

transform : String -> String -> Result TransformError String

transform styleSheet =
    let
        --Native layer produces a Result with either a partial function or a transformError structure
        partialResult : Result TransformError (String -> Result TransformError String)
        partialResult = Native.Xslt.transform(styleSheet)
    in
         --if first call generated an error, return it as the final result.
        case partialResult of
            Err error ->
                (\input -> Err error)
            Ok partial ->
                partial


