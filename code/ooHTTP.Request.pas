{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP request definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Request;

interface

uses
  Classes,
  ooNet.AccessPoint,
  ooHTTP.Method,
  ooHTTP.Message.Head,
  ooHTTP.Message.Body,
  ooHTTP.Response.Stream;

type
{$REGION 'documentation'}
{
  @abstract(HTTP request interface)
  Request definition to send
  @member(AccesPoint Resouce access point)
  @member(Method HTTP method)
  @member(Head Request header)
  @member(Body Request body)
  @member(
    Callback Procedure called for the connection when the server response
    @param(Response Response stream with raw stream)
  )
  @member(
    Failback Procedure called for the connection for exception raised
    @param(ErrorCode Code of error)
    @param(Error Error message)
  )
}
{$ENDREGION}
  IHTTPRequest = interface
    ['{611E8BEB-27F4-41D1-9DD3-7C5E09F11A85}']
    function AccesPoint: INetAccessPoint;
    function Method: IHTTPMethod;
    function Head: IHTTPMessageHead;
    function Body: IHTTPMessageBody;
    procedure Callback(const Response: IHTTPResponseStream);
    procedure Failback(const ErrorCode: Integer; const Error: String);
  end;

{$REGION 'documentation'}
{
  @abstract(Response event when the request received)
  @param(Request Request object sended)
  @param(Response Response object created from request)
}
{$ENDREGION}

  TOnHTTPRequestResponse = reference to procedure(const Request: IHTTPRequest; const Response: IHTTPResponseStream);
{$REGION 'documentation'}
{
  @abstract(Fail event when the request raised an exception)
  @param(Request Request object sended)
  @param(ErrorCode Code of error)
  @param(Error Error message)
}
{$ENDREGION}
  TOnHTTPRequestFail = reference to procedure(const Request: IHTTPRequest; const ErrorCode: Integer;
    const Error: String);

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
    @param(AccesPoint Resouce access point)
    @param(Method HTTP method)
    @param(Head Request header)
    @param(OnResponse Response event callback)
    @param(OnFail Fail event callback)
  )
  @member(
    New Create a new @classname as interface
    @param(AccesPoint Resouce access point)
    @param(Method HTTP method)
    @param(Head Request header)
    @param(OnResponse Response event callback)
    @param(OnFail Fail event callback)
  )
}
{$ENDREGION}

  THTTPRequest = class sealed(TInterfacedObject, IHTTPRequest)
  strict private
    _AccesPoint: INetAccessPoint;
    _Method: IHTTPMethod;
    _Head: IHTTPMessageHead;
    _Body: IHTTPMessageBody;
    _OnResponse: TOnHTTPRequestResponse;
    _OnFail: TOnHTTPRequestFail;
  public
    function AccesPoint: INetAccessPoint;
    function Method: IHTTPMethod;
    function Head: IHTTPMessageHead;
    function Body: IHTTPMessageBody;
    procedure Callback(const Response: IHTTPResponseStream);
    procedure Failback(const ErrorCode: Integer; const Error: String);
    constructor Create(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod; const Head: IHTTPMessageHead;
      const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponse; const OnFail: TOnHTTPRequestFail);
    class function New(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod; const Head: IHTTPMessageHead;
      const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponse; const OnFail: TOnHTTPRequestFail)
      : IHTTPRequest;
  end;

implementation

function THTTPRequest.AccesPoint: INetAccessPoint;
begin
  Result := _AccesPoint;
end;

function THTTPRequest.Method: IHTTPMethod;
begin
  Result := _Method;
end;

function THTTPRequest.Head: IHTTPMessageHead;
begin
  Result := _Head;
end;

function THTTPRequest.Body: IHTTPMessageBody;
begin
  Result := _Body;
end;

procedure THTTPRequest.Callback(const Response: IHTTPResponseStream);
begin
  if Assigned(_OnResponse) then
    _OnResponse(Self, Response);
end;

procedure THTTPRequest.Failback(const ErrorCode: Integer; const Error: String);
begin
  if Assigned(_OnFail) then
    _OnFail(Self, ErrorCode, Error);
end;

constructor THTTPRequest.Create(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod;
  const Head: IHTTPMessageHead; const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponse;
  const OnFail: TOnHTTPRequestFail);
begin
  _AccesPoint := AccesPoint;
  _Method := Method;
  _Head := Head;
  _Body := Body;
  _OnResponse := OnResponse;
  _OnFail := OnFail;
end;

class function THTTPRequest.New(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod;
  const Head: IHTTPMessageHead; const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponse;
  const OnFail: TOnHTTPRequestFail): IHTTPRequest;
begin
  Result := THTTPRequest.Create(AccesPoint, Method, Head, Body, OnResponse, OnFail);
end;

end.
