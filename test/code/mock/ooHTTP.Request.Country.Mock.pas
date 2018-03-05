{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Request.Country.Mock;

interface

uses
  Classes,
  ooNet.Protocol,
  ooNet.Address.URL,
  ooNet.AccessPoint,
  ooNet.Encoding,
  SimpleXML,
  Country,
  ooHTTP.ContentType,
  ooHTTP.Field, ooHTTP.FieldList,
  ooHTTP.FieldList.Text,
  ooHTTP.Request,
  ooHTTP.Response.Status,
  ooHTTP.Method,
  ooHTTP.Message.Head,
  ooHTTP.Message.Body, ooHTTP.Message.Body.Fields,
  ooHTTP.Response.Stream,
  ooHTTP.Response.XML,
  ooHTTP.Request.XML;

type
  THTTPRequestCountryMock = class sealed(TInterfacedObject, IHTTPRequest)
  strict private
    _HTTPRequest: IHTTPRequest;
  private
    procedure OnResponseXML(const Request: IHTTPRequest; const Response: IHTTPResponseXML);
  public
    function AccesPoint: INetAccessPoint;
    function Method: IHTTPMethod;
    function Head: IHTTPMessageHead;
    function Body: IHTTPMessageBody;
    procedure ResolveResponse(const Response: IHTTPResponseStream);
    procedure ResolveFail(const ErrorCode: Integer; const Error: String);
    constructor Create(const URI: String);
    class function New(const URI: String): IHTTPRequest;
  end;

implementation

function THTTPRequestCountryMock.AccesPoint: INetAccessPoint;
begin
  Result := _HTTPRequest.AccesPoint;
end;

function THTTPRequestCountryMock.Head: IHTTPMessageHead;
begin
  Result := _HTTPRequest.Head;
end;

function THTTPRequestCountryMock.Body: IHTTPMessageBody;
begin
  Result := _HTTPRequest.Body;
end;

function THTTPRequestCountryMock.Method: IHTTPMethod;
begin
  Result := _HTTPRequest.Method;
end;

procedure THTTPRequestCountryMock.ResolveFail(const ErrorCode: Integer; const Error: String);
begin
  _HTTPRequest.ResolveFail(ErrorCode, Error);
end;

procedure THTTPRequestCountryMock.OnResponseXML(const Request: IHTTPRequest; const Response: IHTTPResponseXML);
var
  Country: ICountry;
  Code, Name: String;
  XmlNodeList: IXmlNodeList;
  i: Integer;
begin
  XmlNodeList := Response.Content.ChildNodes;
  for i := 0 to Pred(XmlNodeList.Count) do
  begin
    Code := XmlNodeList.Item[i].XML;
  end;
  // Seguir
  Code := Response.Content.SelectSingleNode('tCountryInfo').Text;
  Country := TCountry.New(Code, Name);
// _ResponseContent := Response.Content.XML;
end;

procedure THTTPRequestCountryMock.ResolveResponse(const Response: IHTTPResponseStream);
begin
  _HTTPRequest.ResolveResponse(Response);
end;

constructor THTTPRequestCountryMock.Create(const URI: String);
var
  AccesPoint: INetAccessPoint;
  Head: IHTTPMessageHead;
  Body: IHTTPMessageBody;
  Method: IHTTPMethod;
begin
  AccesPoint := TNetAccessPoint.New(TURL.New(URI), TNetProtocol.New(HTTP), nil);
  Head := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(XFORM), THTTPFieldListText.New);
  Method := THTTPMethod.New(POST);
  Body := THTTPMessageBodyFields.New(THTTPFieldListText.New);
  _HTTPRequest := THTTPRequestXML.New(AccesPoint, Method, Head, Body, OnResponseXML, nil)
end;

class function THTTPRequestCountryMock.New(const URI: String): IHTTPRequest;
begin
  Result := THTTPRequestCountryMock.Create(URI);
end;

end.
