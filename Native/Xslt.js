/**
 * Created by stephen.hand on 05/06/2017.
 */


var _stephenhand$elm_xslt$Native_Xslt = function(){
    var XSLT_API;
    if (window && window.XSLTProcessor){
        XSLT_API = "MOZILLA";
    }
    else if (window && (window.ActiveXObject || "ActiveXObject" in window)){
        XSLT_API = "IE_ACTIVEX";
    }
    else{
        XSLT_API = "UNSUPPORTED";
    }

    var parser = new DOMParser();
    var serializer = new XMLSerializer();

    function createTransformer(stylesheet){
        var xslDoc, xmlDoc;
        if (XSLT_API==="MOZILLA"){
            xslDoc = parser.parseFromString(stylesheet, "text/xml");
            var processor = new XSLTProcessor();
            processor.importStylesheet(xslDoc);
            return function(xml){
                xmlDoc = parser.parseFromString(xml, "application/xml")
                return serializer.serializeToString(processor.transformToDocument(xmlDoc));
            }
        }
        else if (XSLT_API==="IE_ACTIVEX"){
            xslDoc =new ActiveXObject("Msxml2.DOMDocument.3.0");
            xslDoc.loadXML(stylesheet);
            return function(xml){
                xmlDoc =new ActiveXObject("Msxml2.DOMDocument.3.0");
                xmlDoc.loadXML(xml);
                return xmlDoc.transformNode(xslDoc);
            }
        }
        else return void(0);
    }

    return {
        transform : function(stylesheet){
            if (!stylesheet){
                return _elm_lang$core$Result$Err({
                    message:"Stylesheet not specified",
                    code:2
                });
            }
            var transformer;
            try{
                transformer = createTransformer(stylesheet);
            }
            catch(e){
                return _elm_lang$core$Result$Err({
                    message:"Error loading stylesheet:\r\n"+e.toString(),
                    code:3
                });
            }
            if (!transformer){
                _elm_lang$core$Result$Err({
                    message:"XSLT not supported.",
                    code:1
                });
            }
            return _elm_lang$core$Result$Ok(function(source){
                if (!source){
                    return _elm_lang$core$Result$Err({
                        message:"No source data",
                        code:4
                    });
                }
                try{
                    return _elm_lang$core$Result$Ok(transformer(source));
                }
                catch(e){
                    return _elm_lang$core$Result$Err({
                        message:"Error transforming source data:\r\n"+e.toString(),
                        code:6
                    });
                }
            });
        }
    }
}();