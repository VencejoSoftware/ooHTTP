{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to send/receive request against the server
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Connection;

interface

uses
  Classes, SysUtils,
  Synacode, httpsend, synautil, ssl_openssl, ssl_openssl_lib,
  ooHTTP.Proxy,
  ooHTTP.Request;

type
{$REGION 'documentation'}
{
  @abstract(Event when execution success)
  @param(Request Request sended)
  @param(StatusCode Request status code received)
  @param(Stream Stream received)
}
{$ENDREGION}
  TOnHTTPConnectionSuccess = reference to procedure(const Request: IHTTPRequest; const StatusCode: Integer;
    const Stream: TStream);
{$REGION 'documentation'}
{
  @abstract(Event when execution fail)
  @param(Request Request sended)
  @param(ErrorCode Error code generated)
  @param(Error Error message)
}
{$ENDREGION}
  TOnHTTPConnectionFail = reference to procedure(const Request: IHTTPRequest; const ErrorCode: Integer;
    const Error: String);

{$REGION 'documentation'}
{
  @abstract(Connection with the server to send/receive request)
  @member(
    Send Send the request
    @param(Request Request sended)
  )
}
{$ENDREGION}

  IHTTPConnection = interface
    ['{1815E8A8-1F52-4626-80D6-E5385623AE31}']
    procedure Send(const Request: IHTTPRequest);
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPConnection))
  Use a thread to connection actions, run once and auto destroy
  @member(Send @seealso(IHTTPConnection.Send))
  @member(Execute Run the thread)
  @member(
    Create Object constructor
    @param(OnSuccess Event to raise when send success)
    @param(OnFail Event to raise when send fail)
    @param(Proxy Optional proxy conenction settings)
  )
  @member(Destroy Object destructor)
  @member(
    New Create a new @classname as interface
    @param(OnSuccess Event to raise when send success)
    @param(OnFail Event to raise when send fail)
    @param(Proxy Optional proxy conenction settings)
  )
}
{$ENDREGION}

  THTTPConnection = class sealed(TInterfacedObject, IHTTPConnection)
  strict private
    _Proxy: IHTTPProxy;
    _OnSuccess: TOnHTTPConnectionSuccess;
    _OnFail: TOnHTTPConnectionFail;
  public
    procedure Send(const Request: IHTTPRequest);
    constructor Create(const OnSuccess: TOnHTTPConnectionSuccess; const OnFail: TOnHTTPConnectionFail;
      const Proxy: IHTTPProxy);
    class function New(const OnSuccess: TOnHTTPConnectionSuccess; const OnFail: TOnHTTPConnectionFail;
      const Proxy: IHTTPProxy = nil): IHTTPConnection;
  end;

implementation

procedure THTTPConnection.Send(const Request: IHTTPRequest);
var
  HTTPClient: THTTPSend;
begin
  HTTPClient := THTTPSend.Create;
  try
    try
      HTTPClient.MimeType := Request.Head.ContentType.Text;
// WriteStrToStream(HTTPClient.Document, AnsiString(Request.Head.Fields.Text));
      HTTPClient.Headers.Text := Request.Head.Text;
      HTTPClient.Document.LoadFromStream(Request.Body.Content);
      HTTPClient.MimeType := Request.Head.ContentType.Text;
      HTTPClient.HTTPMethod(Request.Method.Text, Request.AccesPoint.Address.Text);
      if Assigned(_OnSuccess) then
        _OnSuccess(Request, HTTPClient.ResultCode, HTTPClient.Document);
    except
      on E: Exception do
      begin
        if Assigned(_OnFail) then
          _OnFail(Request, 666, E.Message)
        else
          raise E;
      end;
    end;
  finally
    HTTPClient.Free;
  end;
end;

constructor THTTPConnection.Create(const OnSuccess: TOnHTTPConnectionSuccess; const OnFail: TOnHTTPConnectionFail;
  const Proxy: IHTTPProxy);
begin
  _Proxy := Proxy;
  _OnSuccess := OnSuccess;
  _OnFail := OnFail;
end;

class function THTTPConnection.New(const OnSuccess: TOnHTTPConnectionSuccess; const OnFail: TOnHTTPConnectionFail;
  const Proxy: IHTTPProxy): IHTTPConnection;
begin
  Result := THTTPConnection.Create(OnSuccess, OnFail, Proxy);
end;

end.
