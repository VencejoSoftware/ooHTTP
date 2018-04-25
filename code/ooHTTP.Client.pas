{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Client to send synchronous requests
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Client;

interface

uses
  Classes,
  ooHTTP.Proxy,
  ooHTTP.Request,
  ooHTTP.Response, ooHTTP.Response.Stream,
  ooHTTP.Connection;

type
{$REGION 'documentation'}
{
  @abstract(HTTP Client interface)
  @member(
    ChangeProxy Change the connection proxy
    @param(Proxy Proxy object)
  )
  @member(
    Send Create a new connection and send the request
    @param(request Request object)
  )
}
{$ENDREGION}
  IHTTPClient = interface
    ['{0F637421-61B1-4B62-A866-BDCD70976E12}']
    procedure ChangeProxy(const Proxy: IHTTPProxy);
    procedure Send(const Request: IHTTPRequest);
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPClient))
  @member(ChangeProxy @seealso(IHTTPClient.ChangeProxy))
  @member(Send @seealso(IHTTPClient.Send))
  @member(
    OnSendFail Callback event when connection send fails
    @param(Request Request object)
    @param(ErrorCode Error code identification)
    @param(Error Message error)
  )
  @member(
    OnSendSuccess Callback event when connection send success
    @param(Request Request object)
    @param(StatusCode Response status code)
    @param(Stream Response data)
  )
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  THTTPClient = class sealed(TInterfacedObject, IHTTPClient)
  strict private
    _Proxy: IHTTPProxy;
  private
    procedure OnSendFail(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String);
    procedure OnSendSuccess(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream);
  public
    procedure ChangeProxy(const Proxy: IHTTPProxy);
    procedure Send(const Request: IHTTPRequest);
    class function New: IHTTPClient;
  end;

implementation

procedure THTTPClient.OnSendSuccess(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream);
var
  Response: IHTTPResponseStream;
begin
  Response := THTTPResponseStream.New(THTTPResponse.New(StatusCode), Stream);
  Request.Callback(Response);
end;

procedure THTTPClient.OnSendFail(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String);
begin
  Request.Failback(ErrorCode, Error);
end;

procedure THTTPClient.ChangeProxy(const Proxy: IHTTPProxy);
begin
  _Proxy := Proxy;
end;

procedure THTTPClient.Send(const Request: IHTTPRequest);
var
  Connection: IHTTPConnection;
begin
  Connection := THTTPConnection.New(OnSendSuccess, OnSendFail, _Proxy);
  Connection.Send(Request);
end;

class function THTTPClient.New: IHTTPClient;
begin
  Result := THTTPClient.Create;
end;

end.
