module XsltTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, list, int, string)
import Test exposing (..)
import Xslt exposing (..)

testValidStyleSheet: String
testValidStyleSheet = """<?xml version="1.0"?>
                       <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
                         <xsl:template match="/test">
                         <output-doc>attribute:<xsl:value-of select="@test-attribute"/>;<xsl:apply-templates select="test-item"/> </output-doc>
                         </xsl:template>
                         <xsl:template match="test-item"> element:<xsl:value-of select="."/>;</xsl:template>
                       </xsl:stylesheet>
                       """


testValidInput = """<?xml version="1.0"?>
                   <test test-attribute="ATTRIBUTE_VALUE">
                    <test-item>ELEMENT_CONTENT</test-item>
                   </test>"""


suite : Test
suite =
    describe "Xslt module"
        [ describe "Xslt.transform"
            [test "returns Ok string with transformed output" <|
                \_ ->
                    testValidInput
                        |> Xslt.transform testValidStyleSheet
                        |> Expect.equal (Ok "<output-doc>attribute:ATTRIBUTE_VALUE; element:ELEMENT_CONTENT;</output-doc>")
            ]
        ]
