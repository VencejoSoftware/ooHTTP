{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Request.XML.Mock;

interface

uses
  Classes,
  ooNet.Protocol,
  ooNet.Address.URL,
  ooNet.AccessPoint,
  ooNet.Encoding,
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
  THTTPRequestXMLMock = class sealed(TInterfacedObject, IHTTPRequest)
  strict private
    _HTTPRequest: IHTTPRequest;
    _ResponseContent: String;
  public
    function AccesPoint: INetAccessPoint;
    function Method: IHTTPMethod;
    function Head: IHTTPMessageHead;
    function Body: IHTTPMessageBody;
    function ResponseContent: String;
    procedure Callback(const Response: IHTTPResponseStream);
    procedure Failback(const ErrorCode: Integer; const Error: String);
    constructor Create(const URI: String);
    class function New(const URI: String): IHTTPRequest;
  end;

implementation

function THTTPRequestXMLMock.AccesPoint: INetAccessPoint;
begin
  Result := _HTTPRequest.AccesPoint;
end;

function THTTPRequestXMLMock.Head: IHTTPMessageHead;
begin
  Result := _HTTPRequest.Head;
end;

function THTTPRequestXMLMock.Body: IHTTPMessageBody;
begin
  Result := _HTTPRequest.Body;
end;

function THTTPRequestXMLMock.Method: IHTTPMethod;
begin
  Result := _HTTPRequest.Method;
end;

procedure THTTPRequestXMLMock.Failback(const ErrorCode: Integer; const Error: String);
begin
  _HTTPRequest.Failback(ErrorCode, Error);
end;

procedure THTTPRequestXMLMock.Callback(const Response: IHTTPResponseStream);
begin
  _HTTPRequest.Callback(Response);
end;

function THTTPRequestXMLMock.ResponseContent: String;
begin
  Result := _ResponseContent;
end;

constructor THTTPRequestXMLMock.Create(const URI: String);
var
  AccesPoint: INetAccessPoint;
  Head: IHTTPMessageHead;
  Body: IHTTPMessageBody;
  Method: IHTTPMethod;
  OnResponse: TOnHTTPRequestResponseXML;
begin
  AccesPoint := TNetAccessPoint.New(TURL.New(URI), TNetProtocol.New(HTTP), nil);
  Head := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(TextPlain), THTTPFieldListText.New);
  Method := THTTPMethod.New(GET);
  Body := THTTPMessageBodyFields.New(THTTPFieldListText.New);
  OnResponse := procedure(const Request: IHTTPRequest; const Response: IHTTPResponseXML)
    begin
      _ResponseContent := Response.Content.XML;
    end;
  _HTTPRequest := THTTPRequestXML.New(AccesPoint, Method, Head, Body, OnResponse, nil)
end;

class function THTTPRequestXMLMock.New(const URI: String): IHTTPRequest;
begin
  Result := THTTPRequestXMLMock.Create(URI);
end;

end.
