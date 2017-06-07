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
                throw new Error("XSLT not supported.");
            }
            var processor =  new XSLTProcessor();
            try{
                var xslDoc = parser.parseFromString(stylesheet, "text/xml");
                processor.importStylesheet(xslDoc);
            }
            catch(e){
                 return function(source){
                     return "Error loading stylesheet:\r\n"+e.toString()
                 }
            }
            return function(source){
                var xmlDoc;
                try{
                    xmlDoc = parser.parseFromString(source, "application/xml");
                }
                catch(e){
                    return "Error deserializing source data:\r\n"+e.toString();
                }
                try{

                    var outputDoc = processor.transformToDocument(xmlDoc);
                    return serializer.serializeToString(outputDoc);
                }
                catch(e){
                    return "Error transforming source data:\r\n"+e.toString();
                }
            }
        },
        transformSource : function(source, transformer){
            return transformer(source);
        }
    }
}();