function domObj = MATLABCode( code )



















R36
code string
end 

xmlDoc = matlab.io.xml.dom.Document( 'mscript' );
rootNode = getDocumentElement( xmlDoc );
setAttribute( rootNode,  ...
'xmlns:mwsh',  ...
'http://www.mathworks.com/namespace/mcode/v1/syntaxhighlight.dtd' )


codeNode = matlab.internal.codeToXML( xmlDoc, code );
appendChild( rootNode, codeNode );










domObj = javaimpl( xmlDoc );
end 

function domObj = libxsltimpl( xmlDoc )%#ok
xmlFile = strcat( tempname(  ), '.xml' );
xmlDoc.xmlwrite( xmlFile );
scopeRMXMLFile = onCleanup( @(  )delete( xmlFile ) );

xslFile = genXSLFile(  );
scopeRMXSLTFile = onCleanup( @(  )delete( xslFile ) );

htmlFile = strcat( tempname(  ), '.html' );
scopeRMHTMLFile = onCleanup( @(  )delete( htmlFile ) );

cmd = sprintf( 'xsltproc -o %s %s %s', htmlFile, xslFile, xmlFile );
system( cmd );

domObj = mlreportgen.dom.HTMLFile( htmlFile );
end 

function domObj = xalanimpl( xmlDoc )%#ok
domWriter = matlab.io.xml.dom.DOMWriter(  );
xmlSrcStr = domWriter.writeToString( xmlDoc );
srcDoc = matlab.io.xml.transform.SourceString( xmlSrcStr );




transformer = matlab.io.xml.transform.Transformer(  );
styleSrc = matlab.io.xml.transform.StylesheetSourceString( getSS(  ) );

htmlStr = transformToString( transformer, srcDoc, styleSrc );
domObj = mlreportgen.dom.HTML( htmlStr );
end 

function domObj = javaimpl( xmlDoc )
xslFile = genXSLFile(  );
scopeRMXSLTFile = onCleanup( @(  )delete( xslFile ) );

xmlFile = strcat( tempname(  ), '.xml' );
xmlDoc.xmlwrite( xmlFile );
scopeRMXMLFile = onCleanup( @(  )delete( xmlFile ) );

htmlFile = strcat( tempname(  ), '.html' );
scopeRMHTMLFile = onCleanup( @(  )delete( htmlFile ) );

xslt( xmlFile, xslFile, htmlFile );
domObj = mlreportgen.dom.HTMLFile( htmlFile );
end 

function eml2html = getSS(  )
eml2html = [ 
'<?xml version="1.0" encoding="utf-8"?>' ...
, '<xsl:stylesheet version="1.0"' ...
, '                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"' ...
, '               xmlns:mwsh="http://www.mathworks.com/namespace/mcode/v1/syntaxhighlight.dtd">' ...
, '<xsl:output method="html"' ...
, '            encoding="utf-8"' ...
, '            indent="no"/>' ...
, '<xsl:param name="code.keyword">#0e00ff</xsl:param>' ...
, '<xsl:param name="code.comment">#008013</xsl:param>' ...
, '<xsl:param name="code.string">#a709f5</xsl:param>' ...
, '<xsl:param name="code.untermstring">#902622</xsl:param>' ...
, '<xsl:param name="code.syscmd">#8b6606</xsl:param>' ...
, '<xsl:param name="code.typesection">#a0522c</xsl:param> ' ...
, '<xsl:template match="mscript">' ...
, '  <div style="padding:10px;font-family:Courier New,Courier,monospace;">' ...
, '    <xsl:apply-templates/>' ...
, '  </div>' ...
, '</xsl:template>' ...
, '<xsl:template match="mwsh:code"><pre style="margin:0;white-space:preserve"><xsl:apply-templates/></pre></xsl:template>' ...
, '<xsl:template match="mwsh:keywords">' ...
, '  <span style="color:{$code.keyword}"><xsl:value-of select="."/></span>' ...
, '</xsl:template>' ...
, '<xsl:template match="mwsh:strings">' ...
, '  <span style="color:{$code.string}"><xsl:value-of select="."/></span>' ...
, '</xsl:template>' ...
, '<xsl:template match="mwsh:comments">' ...
, '  <span style="color:{$code.comment}"><xsl:value-of select="."/></span>' ...
, '</xsl:template>' ...
, '<xsl:template match="mwsh:unterminated_strings">' ...
, '  <span style="color:{$code.untermstring}"><xsl:value-of select="."/></span>' ...
, '</xsl:template>' ...
, '<xsl:template match="mwsh:system_commands">' ...
, '  <span style="color:{$code.syscmd}"><xsl:value-of select="."/></span>' ...
, '</xsl:template>' ...
, '<xsl:template match="mwsh:type_section">' ...
, '  <span style="color:{$code.typesection}"><xsl:value-of select="."/></span>' ...
, '</xsl:template>' ...
, '<xsl:template match="title"/>' ...
, '<xsl:template match="emlName"/>' ...
, '</xsl:stylesheet>' ...
 ];
end 

function tempXSLFileName = genXSLFile(  )
tempXSLFileName = strcat( tempname, '.xsl' );
fid = fopen( tempXSLFileName, 'w+t', 'n', 'UTF-8' );
fwrite( fid, getSS(  ) );
fclose( fid );
end 


% Decoded using De-pcode utility v1.2 from file /tmp/tmpPqJP5A.p.
% Please follow local copyright laws when handling this file.

