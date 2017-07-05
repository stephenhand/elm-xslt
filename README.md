# elm-xslt
Project to expose XSLT transform functionality in Elm.

Currently a one function API:

~~~
transform: String -> String -> Result {code:Int, message:String} String
~~~

Basically pass in a string with your stylesheet contents in it, a string with your xml source content to be transformed, and out comes a result either with string with your transformed content or an error record.

Partially calling this API can give performance benefits. The stylesheet is loaded into the XSLT processing engine as soon as the first parameter is called, ready to transform the data loaded with the second parameter. If you plan to transform several source documents with the same stylesheet, you should set the stylesheet once, then reuse the returned function for each document you want to transform.

TODO:

* Potentially expand API to support inputs other than document contents as strings, like URLs or typed source data, but this will be on an 'as required' or 'on request' basis

This is not currently published as an elm package and may not be as it relies on interfacing with native components, which requires approval.

