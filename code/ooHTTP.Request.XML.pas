{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP request definition to generate a XML response
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Request.XML;

interface

uses
  ooNet.AccessPoint,
  ooHTTP.Request,
  ooHTTP.Method,
  ooHTTP.Message.Head,
  ooHTTP.Message.Body,
  ooHTTP.Response.Stream,
  ooHTTP.Response.XML;

type
{$REGION 'documentation'}
{
  @abstract(Response with XML format event when the request received)
  @param(Request Request object sended)
  @param(Response XML response object created from request)
}
{$ENDREGION}
  TOnHTTPRequestResponseXML = reference to procedure(const Request: IHTTPRequest; const Response: IHTTPResponseXML);

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPRequest))
  @member(AccesPoint @seealso(IHTTPRequest.AccesPoint))
  @member(Method @seealso(IHTTPRequest.Method))
  @member(Head @seealso(IHTTPRequest.Head))
  @member(ResolveResponse @seealso(IHTTPRequest.ResolveResponse))
  @member(ResolveFail @seealso(IHTTPRequest.ResolveFail))
  @member(
    Create Object constructor
    @param(AccesPoint Address to send)
    @param(Method HTTP method)
    @param(Head Request header)
    @param(OnResponse Response with XML event callback)
    @param(OnFail Fail event callback)
  )
  @member(
    New Create a new @classname as interface
    @param(AccesPoint Address to send)
    @param(Method HTTP method)
    @param(Head Request header)
    @param(OnResponse Response with XML event callback)
    @param(OnFail Fail event callback)
  )
}
{$ENDREGION}

  THTTPRequestXML = class sealed(TInterfacedObject, IHTTPRequest)
  strict private
    _HTTPRequest: IHTTPRequest;
    _OnResponse: TOnHTTPRequestResponseXML;
  public
    function AccesPoint: INetAccessPoint;
    function Method: IHTTPMethod;
    function Head: IHTTPMessageHead;
    function Body: IHTTPMessageBody;
    procedure ResolveResponse(const Response: IHTTPResponseStream);
    procedure ResolveFail(const ErrorCode: Integer; const Error: String);
    constructor Create(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod; const Head: IHTTPMessageHead;
      const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseXML; const OnFail: TOnHTTPRequestFail);
    class function New(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod; const Head: IHTTPMessageHead;
      const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseXML; const OnFail: TOnHTTPRequestFail)
      : IHTTPRequest;
  end;

implementation

function THTTPRequestXML.AccesPoint: INetAccessPoint;
begin
  Result := _HTTPRequest.AccesPoint;
end;

function THTTPRequestXML.Head: IHTTPMessageHead;
begin
  Result := _HTTPRequest.Head;
end;

function THTTPRequestXML.Body: IHTTPMessageBody;
begin
  Result := _HTTPRequest.Body;
end;

function THTTPRequestXML.Method: IHTTPMethod;
begin
  Result := _HTTPRequest.Method;
end;

procedure THTTPRequestXML.ResolveFail(const ErrorCode: Integer; const Error: String);
begin
  _HTTPRequest.ResolveFail(ErrorCode, Error);
end;

procedure THTTPRequestXML.ResolveResponse(const Response: IHTTPResponseStream);
var
  ResponseXML: IHTTPResponseXML;
begin
  ResponseXML := THTTPResponseXML.NewFromStream(Response);
  if Assigned(_OnResponse) then
    _OnResponse(Self, ResponseXML);
end;

constructor THTTPRequestXML.Create(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod;
  const Head: IHTTPMessageHead; const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseXML;
  const OnFail: TOnHTTPRequestFail);
begin
  _HTTPRequest := THTTPRequest.New(AccesPoint, Method, Head, Body, nil, OnFail);
  _OnResponse := OnResponse;
end;

class function THTTPRequestXML.New(const AccesPoint: INetAccessPoint; const Method: IHTTPMethod;
  const Head: IHTTPMessageHead; const Body: IHTTPMessageBody; const OnResponse: TOnHTTPRequestResponseXML;
  const OnFail: TOnHTTPRequestFail): IHTTPRequest;
begin
  Result := THTTPRequestXML.Create(AccesPoint, Method, Head, Body, OnResponse, OnFail);
end;

end.
