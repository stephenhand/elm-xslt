/**
 * Created by stephen.hand on 05/06/2017.
 */


var _stephenhand$elm_xslt$Native_Xslt = function(){
    var isSupported = (window && (window.XSLTProcessor || window.ActiveXObject || "ActiveXObject" in window));

    var parser = new DOMParser();
    var serializer = new XMLSerializer();

    return {
        transform : function(stylesheet){
            if (!isSupported){
                return function(source){
                    _elm_lang$core$Result$Err({
                        message:"XSLT not supported.",
                        code:1
                    });
                }
            }
            if (!stylesheet){
                return function(source){
                    return _elm_lang$core$Result$Err({
                        message:"Stylesheet not specified",
                        code:2
                    });
                }
            }
            var processor =  new XSLTProcessor();
            try{
                var xslDoc = parser.parseFromString(stylesheet, "text/xml");
                processor.importStylesheet(xslDoc);
            }
            catch(e){
                 return function(source){
                     return _elm_lang$core$Result$Err({
                         message:"Error loading stylesheet:\r\n"+e.toString(),
                         code:3
                     });
                 }
            }
            return function(source){
                if (!source){
                    return _elm_lang$core$Result$Err({
                        message:"No source data",
                        code:4
                    });
                }
                var xmlDoc;
                try{
                    xmlDoc = parser.parseFromString(source, "application/xml");
                }
                catch(e){
                    return _elm_lang$core$Result$Err({
                        message:"Error deserializing source data:\r\n"+e.toString(),
                        code:5
                    });
                }
                try{

                    var outputDoc = processor.transformToDocument(xmlDoc);
                    return _elm_lang$core$Result$Ok(serializer.serializeToString(outputDoc));
                }
                catch(e){
                    return _elm_lang$core$Result$Err({
                        message:"Error transforming source data:\r\n"+e.toString(),
                        code:6
                    });
                }
            }
        },
        transformSource : function(source, transformer){
            return transformer(source);
        }
    }
}();