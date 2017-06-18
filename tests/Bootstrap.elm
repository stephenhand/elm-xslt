module Bootstrap exposing (..)

{-| HOW TO RUN THIS EXAMPLE

1.  Run elm-reactor from the same directory as your tests' elm-package.json. (For example, if you have tests/elm-package.json, then cd into tests/ and
    run elm-reactor.)
2.  Visit <http://localhost:8000> and bring up this file.

-}

import Char
import Expect
import Fuzz exposing (..)
import String
import Test exposing (..)
import Test.Runner.Html
import XsltTest


main : Test.Runner.Html.TestProgram
main =
    [ XsltTest.suite
    ]
        |> concat
        |> Test.Runner.Html.run

