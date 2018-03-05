{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Response estatus definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Response.Status;

interface

uses
  SysUtils;

type
{$REGION 'documentation'}
{
  @value Unknown Unknown ResponseStatus
  @value 100 Continue
  @value 101 Switching Protocols
  @value 102 Processing (WebDAV - RFC 2518)
  @value 103 Checkpoint
  @value 200 OK
  @value 201 Created
  @value 202 Accepted
  @value 203 Non-Authoritative Information (since HTTP/1.1)
  @value 204 No Content
  @value 205 Reset Content
  @value 206 Partial Content (RFC 7233)
  @value 207 Multi-Status (WebDAV; RFC 4918)
  @value 208 Already Reported (WebDAV; RFC 5842)
  @value 226 IM Used (RFC 3229)
  @value 300 Multiple Choices
  @value 301 Moved Permanently
  @value 302 Found
  @value 303 See Other (since HTTP/1.1)
  @value 304 Not Modified (RFC 7232)
  @value 305 Use Proxy (since HTTP/1.1)
  @value 306 Switch Proxy
  @value 307 Temporary Redirect (since HTTP/1.1)
  @value 308 Permanent Redirect (RFC 7538)
  @value 400 Bad Request
  @value 401 Unauthorized (RFC 7235)
  @value 402 Payment Required
  @value 403 Forbidden
  @value 404 Not Found
  @value 405 Method Not Allowed
  @value 406 Not Acceptable
  @value 407 Proxy Authentication Required (RFC 7235)
  @value 408 Request Timeout
  @value 409 Conflict
  @value 410 Gone
  @value 411 Length Required
  @value 412 Precondition Failed (RFC 7232)
  @value 413 Payload Too Large (RFC 7231)
  @value 414 URI Too Long (RFC 7231)
  @value 415 Unsupported Media Type
  @value 416 Range Not Satisfiable (RFC 7233)
  @value 417 Expectation Failed
  @value 418 I'm a teapot (RFC 2324)
  @value 421 Misdirected Request (RFC 7540)
  @value 422 Unprocessable Entity (WebDAV; RFC 4918)
  @value 423 Locked (WebDAV; RFC 4918)
  @value 424 Failed Dependency (WebDAV; RFC 4918)
  @value 426 Upgrade Required
  @value 428 Precondition Required (RFC 6585)
  @value 429 Too Many Requests (RFC 6585)
  @value 431 Request Header Fields Too Large (RFC 6585)
  @value 451 Unavailable For Legal Reasons (RFC 7725)
  @value 500 Internal Server Error
  @value 501 Not Implemented
  @value 502 Bad Gateway
  @value 503 Service Unavailable
  @value 504 Gateway Timeout
  @value 505 HTTP Version Not Supported
  @value 506 Variant Also Negotiates (RFC 2295)
  @value 507 Insufficient Storage (WebDAV; RFC 4918)
  @value 508 Loop Detected (WebDAV; RFC 5842)
  @value 510 Not Extended (RFC 2774)
  @value 511 Network Authentication Required (RFC 6585)
}
{$ENDREGION}
  THTTPResponseStatusCode = (Unknown = -1, //
    Continue = 100, Switching = 101, Processing = 102, Checkpoint = 103, //
    OK = 200, Created = 201, Accepted = 202, NonAuthoritative = 203, NoContent = 204, ResetContent = 205,
    PartialContent = 206, MultiStatus = 207, AlreadyReported = 208, IMUsed = 226, //
    MultipleChoices = 300, MovedPermanently = 301, Found = 302, SeeOther = 303, NotModified = 304, UseProxy = 305,
    SwitchProxy = 306, TemporaryRedirect = 307, PermanentRedirect = 308, //
    BadRequest = 400, Unauthorized = 401, PaymentRequired = 402, Forbidden = 403, NotFound = 404,
    MethodNotAllowed = 405, NotAcceptable = 406, ProxyAuthenticationRequired = 407, RequestTimeout = 408,
    Conflict = 409, Gone = 410, LengthRequired = 411, PreconditionFailed = 412, PayloadTooLarge = 413, URITooLong = 414,
    UnsupportedMediaType = 415, RangeNotSatisfiable = 416, ExpectationFailed = 417, Imateapot = 418,
    MisdirectedRequest = 421, UnprocessableEntity = 422, Locked = 423, FailedDependency = 424, UpgradeRequired = 426,
    PreconditionRequired = 428, TooManyRequests = 429, RequestHeaderFieldsTooLarge = 431,
    UnavailableForLegalReasons = 451, //
    InternalServerError = 500, NotImplemented = 501, BadGateway = 502, ServiceUnavailable = 503, GatewayTimeout = 504,
    HTTPVersionNotSupported = 505, VariantAlsoNegotiates = 506, InsufficientStorage = 507, LoopDetected = 508,
    NotExtended = 510, NetworkAuthenticationRequired = 511 //
    );

{$REGION 'documentation'}
{
  @abstract(URL ResponseStatus object)
  Define the URL ResponseStatus configuration
  @member(Code Valid code enumeration)
  @member(Text ResponseStatus value as text)
}
{$ENDREGION}

  IHTTPResponseStatus = interface
    ['{EC0CAF29-7A86-478E-8523-020207FE6E23}']
    function Code: THTTPResponseStatusCode;
    function Text: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPResponseStatus))
  @member(Code @seealso(IHTTPResponseStatus.Code))
  @member(Text @seealso(IHTTPResponseStatus.Text))
  @member(
    Create Object constructor
    @param(Code Valid code enumeration)
  )
  @member(
    New Create a new @classname as interface
    @param(Code Valid code enumeration)
  )
}
{$ENDREGION}

  THTTPResponseStatus = class sealed(TInterfacedObject, IHTTPResponseStatus)
  strict private
    _Code: THTTPResponseStatusCode;
  public
    function Code: THTTPResponseStatusCode;
    function Text: String;
    constructor Create(const Code: THTTPResponseStatusCode);
    class function New(const Code: THTTPResponseStatusCode = Unknown): IHTTPResponseStatus;
  end;

implementation

function THTTPResponseStatus.Code: THTTPResponseStatusCode;
begin
  Result := _Code;
end;

function THTTPResponseStatus.Text: String;
begin
  if Code = Unknown then
    Result := EmptyStr
  else
    Result := IntToStr(Ord(Code));
end;

constructor THTTPResponseStatus.Create(const Code: THTTPResponseStatusCode);
begin
  _Code := Code;
end;

class function THTTPResponseStatus.New(const Code: THTTPResponseStatusCode): IHTTPResponseStatus;
begin
  Result := THTTPResponseStatus.Create(Code);
end;

end.
