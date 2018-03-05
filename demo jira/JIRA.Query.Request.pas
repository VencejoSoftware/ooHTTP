unit JIRA.Query.Request;

interface

uses
  Classes,
  ooHTTP.ContentType,
  ooHTTP.Encoding,
  ooHTTP.Field, ooHTTP.FieldList,
  ooHTTP.FieldList.Text,
  ooHTTP.Request,
  ooHTTP.Response.Status,
  ooHTTP.Protocol,
  ooHTTP.Address,
  ooHTTP.Method,
  ooHTTP.Message.Head,
  ooHTTP.Response.Stream,
  ooHTTP.Response.JSON,
  ooHTTP.Request.JSON;

type
  TJIRAQueryRequest = class sealed(TInterfacedObject, IHTTPRequest)
  strict private
    _HTTPRequest: IHTTPRequest;
    _ResponseContent: String;
  public
    function URL: IHTTPAddress;
    function Method: IHTTPMethod;
    function Head: IHTTPMessageHead;
    function ResponseContent: String;
    procedure ResolveResponse(const Response: IHTTPResponseStream);
    procedure ResolveFail(const ErrorCode: Integer; const Error: String);
    constructor Create(const URI: String);
    class function New: IHTTPRequest;
  end;

implementation

function TJIRAQueryRequest.URL: IHTTPAddress;
begin
  Result := _HTTPRequest.URL;
end;

function TJIRAQueryRequest.Head: IHTTPMessageHead;
begin
  Result := _HTTPRequest.Head;
end;

function TJIRAQueryRequest.Method: IHTTPMethod;
begin
  Result := _HTTPRequest.Method;
end;

procedure TJIRAQueryRequest.ResolveFail(const ErrorCode: Integer; const Error: String);
begin
  _HTTPRequest.ResolveFail(ErrorCode, Error);
end;

procedure TJIRAQueryRequest.ResolveResponse(const Response: IHTTPResponseStream);
begin
  _HTTPRequest.ResolveResponse(Response);
end;

function TJIRAQueryRequest.ResponseContent: String;
begin
  Result := _ResponseContent;
end;

constructor TJIRAQueryRequest.Create(const URI: String);
var
  URL: IHTTPAddress;
  Method: IHTTPMethod;
  Head: IHTTPMessageHead;
  OnResponse: TOnHTTPRequestResponseJSON;
begin
  URL := THTTPAddress.New(THTTPProtocol.New(HTTPS), URI);
  Method := THTTPMethod.New(GET);
  Head := THTTPMessageHead.New(THTTPEncoding.New(UTF8), THTTPContentType.New(JSON), THTTPFieldListText.New);
  OnResponse := procedure(const Request: IHTTPRequest; const Response: IHTTPResponseJSON)
    begin
      _ResponseContent := Response.Content.toString;
    end;
  _HTTPRequest := THTTPRequestJSON.New(URL, Method, Head, OnResponse, nil)
end;

class function TJIRAQueryRequest.New: IHTTPRequest;
begin
  Result := TJIRAQueryRequest.Create('jira.gire.com/rest/api/2/search');
end;

end.
