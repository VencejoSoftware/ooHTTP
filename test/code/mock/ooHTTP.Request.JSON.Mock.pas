{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Request.JSON.Mock;

interface

uses
  Classes,
  ooNet.Address.URL,
  ooNet.Protocol,
  ooNet.AccessPoint,
  ooNet.Encoding,
  ooHTTP.ContentType,
  ooHTTP.Field, ooHTTP.FieldList,
  ooHTTP.FieldList.Text,
  ooHTTP.Request,
  ooHTTP.Response.Status,
  ooHTTP.Method,
  ooHTTP.FieldList.JSON.Text,
  ooHTTP.Message.Head,
  ooHTTP.Message.Body, ooHTTP.Message.Body.Fields,
  ooHTTP.Response.Stream,
  ooHTTP.Response.JSON,
  ooHTTP.Request.JSON;

type
  THTTPRequestJSONMock = class sealed(TInterfacedObject, IHTTPRequest)
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

function THTTPRequestJSONMock.AccesPoint: INetAccessPoint;
begin
  Result := _HTTPRequest.AccesPoint;
end;

function THTTPRequestJSONMock.Head: IHTTPMessageHead;
begin
  Result := _HTTPRequest.Head;
end;

function THTTPRequestJSONMock.Body: IHTTPMessageBody;
begin
  Result := _HTTPRequest.Body;
end;

function THTTPRequestJSONMock.Method: IHTTPMethod;
begin
  Result := _HTTPRequest.Method;
end;

procedure THTTPRequestJSONMock.Failback(const ErrorCode: Integer; const Error: String);
begin
  _HTTPRequest.Failback(ErrorCode, Error);
end;

procedure THTTPRequestJSONMock.Callback(const Response: IHTTPResponseStream);
begin
  _HTTPRequest.Callback(Response);
end;

function THTTPRequestJSONMock.ResponseContent: String;
begin
  Result := _ResponseContent;
end;

constructor THTTPRequestJSONMock.Create(const URI: String);
var
  AccesPoint: INetAccessPoint;
  Method: IHTTPMethod;
  Head: IHTTPMessageHead;
  Body: IHTTPMessageBody;
  OnResponse: TOnHTTPRequestResponseJSON;
begin
  AccesPoint := TNetAccessPoint.New(TURL.New(URI), TNetProtocol.New(HTTP), nil);
  Method := THTTPMethod.New(GET);
  Head := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(JSON), THTTPFieldListText.New);
  Body := THTTPMessageBodyFields.New(THTTPFieldListJSONText.New);
  OnResponse := procedure(const Request: IHTTPRequest; const Response: IHTTPResponseJSON)
    begin
      _ResponseContent := Response.Content.toString;
    end;
  _HTTPRequest := THTTPRequestJSON.New(AccesPoint, Method, Head, Body, OnResponse, nil)
end;

class function THTTPRequestJSONMock.New(const URI: String): IHTTPRequest;
begin
  Result := THTTPRequestJSONMock.Create(URI);
end;

end.
