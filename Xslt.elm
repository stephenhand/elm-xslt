module Xslt exposing (transform)
import Native.Xslt

transform : String -> String -> String

transform styleSheet =
    Native.Xslt.transform(styleSheet)
