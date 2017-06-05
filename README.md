# elm-xslt
Work in progress project to expose XSLT transform functionality in Elm.

Currently a one method API:

transform: String -> String -> String

Basically pass in a string with your stylesheet contents in it, a string with your xml source content to be transformed, and out comes a string with your transformed content.

TODO:

* Internet Explorer support (Edge is supported along with other major browsers, just not IE just yet)

* Proper error handling / reporting (errors are just dumped to the output string in this version). This will likely change the transform API to return a Result.

* Potentially expand API to support inputs other than document contents as strings, like URLs or typed source data, but this will be on an 'as required' or 'on request' basis

This is not currently published as an elm package and may not be as it relies on interfacing with native components, which requires approval

