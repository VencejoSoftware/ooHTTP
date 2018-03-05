{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP response with XML content format handler definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Response.XML;

interface

uses
  Classes, SysUtils,
  SimpleXML,
  ooHTTP.Response,
  ooHTTP.Response.Text,
  ooHTTP.Response.Stream,
  ooHTTP.Response.Status;

type
{$REGION 'documentation'}
{
  @abstract(HTTP request response with XML format content handler interface)
  @member(Content XML object with data)
}
{$ENDREGION}
  IHTTPResponseXML = interface(IHTTPResponse)
    ['{9C0BB84F-A7BE-4DE5-9DAD-18304E89536E}']
    function Content: IXmlDocument;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPResponseXML))
  @member(Content @seealso(IHTTPResponseXML.Content))
  @member(
    Create Object constructor
    @param(Response Base response with status)
    @param(Content String with data)
  )
  @member(
    New Create a new @classname as interface
    @param(Response Base response with status)
    @param(Content String with data)
  )
  @member(
    NewFromStream Create a new @classname as interface from response stream
    @param(ResponseStream Base response with status)
    @param(AsUnicode Is the stream is in unicode encoding)
  )
}
{$ENDREGION}

  THTTPResponseXML = class sealed(TInterfacedObject, IHTTPResponseXML)
  strict private
    _Response: IHTTPResponse;
    _Content: IXmlDocument;
  public
    function Status: IHTTPResponseStatus;
    function Content: IXmlDocument;
    constructor Create(const Response: IHTTPResponse; const Content: String);
    destructor Destroy; override;
    class function New(const Response: IHTTPResponse; const Content: String): IHTTPResponseXML;
    class function NewFromStream(const ResponseStream: IHTTPResponseStream; const AsUnicode: Boolean = False)
      : IHTTPResponseXML;
  end;

implementation

function THTTPResponseXML.Status: IHTTPResponseStatus;
begin
  Result := _Response.Status;
end;

function THTTPResponseXML.Content: IXmlDocument;
begin
  Result := _Content;
end;

constructor THTTPResponseXML.Create(const Response: IHTTPResponse; const Content: String);
begin
  if Length(Content) < 1 then
    _Content := CreateXmlDocument
  else
    _Content := LoadXmlDocumentFromXML(Content);
  _Response := Response;
end;

destructor THTTPResponseXML.Destroy;
begin
  inherited;
end;

class function THTTPResponseXML.New(const Response: IHTTPResponse; const Content: String): IHTTPResponseXML;
begin
  Result := THTTPResponseXML.Create(Response, Content);
end;

class function THTTPResponseXML.NewFromStream(const ResponseStream: IHTTPResponseStream; const AsUnicode: Boolean)
  : IHTTPResponseXML;
var
  ResponseText: IHTTPResponseText;
begin
  ResponseText := THTTPResponseText.NewFromStream(ResponseStream, AsUnicode);
  Result := THTTPResponseXML.Create(ResponseStream, ResponseText.Content);
end;

end.
