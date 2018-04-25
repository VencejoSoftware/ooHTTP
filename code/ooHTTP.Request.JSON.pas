{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP request definition to generate a JSON response
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Request.JSON;

interface

uses
  ooNet.AccessPoint,
  ooHTTP.Request,
  ooHTTP.Method,
  ooHTTP.Message.Head,
  ooHTTP.Message.Body,
  ooHTTP.Response.Stream,
  ooHTTP.Response.JSON;

type
{$REGION 'documentation'}
{
  @abstract(Response with JSON format event when the request received)
  @param(Request Request object sended)
  @param(Response JSON response object created from request)
}
{$ENDREGION}
  TOnHTTPRequestResponseJSON = reference to procedure(const Request: IHTTPRequest; const Response: IHTTPResponseJSON);

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPRequest))
  @member(AccesPoint @seealso(IHTTPRequest.AccesPoint))
  @member(Method @seealso(IHTTPRequest.Method))
  @member(Head @seealso(IHTTPRequest.Head))
  @member(Body @seealso(IHTTPRequest.Body))
  @member(Callback @seealso(IHTTPRequest.Callback))
  @member(Failback @seealso(IHTTPRequest.Failback))
  @member(
    Create Object constructor
    @param(AccesPoint Address to send)
    @param(Method HTTP method)
    @param(Head Request header)
    @param(OnResponse Response with JSON event callback)
    @param(OnFail Fail event callback)
  )
  @member(
    New Create a new @classname as interface
    @param(AccesPoint Address to send)
    @param(Method HTTP method)
    @param(Head Request header)
    @param(OnResponse Response with JSON event callback)
    @param(OnFail Fail event callback)
  )
}
{$ENDREGION}

  THTTPRequestJSON = class sealed(TInterfacedObject, IHTTPRequest)
  strict private
    _HTTPRequest: IHTTPRequest;
    _OnResponse: TOnHTTPRequestResponseJSON;
  public
    function AccesPoint: INetAccessPoint;
    function Method: IHTTPMethod;
    function Head: IHTTPMessageHead;
    function Body: IHTTPMessageBody;
    procedure Callback(const Response: IHTTPResponseStream);
    procedure Failback(const ErrorCode: Integer; const Error: String);
    constructor Create(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod; const Head: IHTTPMessageHead;
      const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseJSON; const OnFail: TOnHTTPRequestFail);
    class function New(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod; const Head: IHTTPMessageHead;
      const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseJSON; const OnFail: TOnHTTPRequestFail)
      : IHTTPRequest;
  end;

implementation

function THTTPRequestJSON.AccesPoint: INetAccessPoint;
begin
  Result := _HTTPRequest.AccesPoint;
end;

function THTTPRequestJSON.Head: IHTTPMessageHead;
begin
  Result := _HTTPRequest.Head;
end;

function THTTPRequestJSON.Body: IHTTPMessageBody;
begin
  Result := _HTTPRequest.Body;
end;

function THTTPRequestJSON.Method: IHTTPMethod;
begin
  Result := _HTTPRequest.Method;
end;

procedure THTTPRequestJSON.Failback(const ErrorCode: Integer; const Error: String);
begin
  _HTTPRequest.Failback(ErrorCode, Error);
end;

procedure THTTPRequestJSON.Callback(const Response: IHTTPResponseStream);
var
  ResponseJSON: IHTTPResponseJSON;
begin
  ResponseJSON := THTTPResponseJSON.NewFromStream(Response);
  if Assigned(_OnResponse) then
    _OnResponse(Self, ResponseJSON);
end;

constructor THTTPRequestJSON.Create(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod;
  const Head: IHTTPMessageHead; const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseJSON;
  const OnFail: TOnHTTPRequestFail);
begin
  _HTTPRequest := THTTPRequest.New(AccesPoint, Method, Head, Body, nil, OnFail);
  _OnResponse := OnResponse;
end;

class function THTTPRequestJSON.New(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod;
  const Head: IHTTPMessageHead; const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseJSON;
  const OnFail: TOnHTTPRequestFail): IHTTPRequest;
begin
  Result := THTTPRequestJSON.Create(AccesPoint, Method, Head, Body, OnResponse, OnFail);
end;

end.
