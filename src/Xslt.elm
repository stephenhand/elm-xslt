module Xslt exposing (transform, TransformError)

{-| XSLT Transformer

Used to apply an XSLT transform to source XML using the browser's XSLT functionality

@docs transform, TransformError

-}

import Native.Xslt

{-| describes what went wrong in a failed XSLT transform
-}
type alias TransformError = {
    code:Int,
    message:String}

{-| uses XSLT in the first string parameter to transform XML in the second string parameter.
-}
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


