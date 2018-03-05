{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP response with string content handler definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Response.Text;

interface

uses
  Classes, SysUtils,
  ooHTTP.Response,
  ooHTTP.Response.Stream,
  ooHTTP.Response.Status;

type
{$REGION 'documentation'}
{
  @abstract(HTTP request response with string content handler interface)
  @member(Content String with data)
}
{$ENDREGION}
  IHTTPResponseText = interface(IHTTPResponse)
    ['{0ECD9DB3-197F-4298-B87D-72C3A21A5DAB}']
    function Content: String;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPResponseText))
  @member(Content @seealso(IHTTPResponseText.Content))
  @member(
    Create Object constructor
    @param(Response Base response with status)
    @param(Content String with data)
  )
  @member(
    New Create a new @classname as interface
    @param(Response Base response with status)
    @param(Content String with data)
  )
  @member(
    NewFromStream Create a new @classname as interface from response stream
    @param(ResponseStream Base response with status)
    @param(AsUnicode Is the stream is in unicode encoding)
  )
}
{$ENDREGION}

  THTTPResponseText = class sealed(TInterfacedObject, IHTTPResponseText)
  strict private
    _Response: IHTTPResponse;
    _Content: String;
  public
    function Status: IHTTPResponseStatus;
    function Content: String;
    constructor Create(const Response: IHTTPResponse; const Content: String);
    class function New(const Response: IHTTPResponse; const Content: String): IHTTPResponseText;
    class function NewFromStream(const ResponseStream: IHTTPResponseStream; const AsUnicode: Boolean = False)
      : IHTTPResponseText;
  end;

implementation

function THTTPResponseText.Status: IHTTPResponseStatus;
begin
  Result := _Response.Status;
end;

function THTTPResponseText.Content: String;
begin
  Result := _Content;
end;

constructor THTTPResponseText.Create(const Response: IHTTPResponse; const Content: String);
begin
  _Response := Response;
  _Content := Content;
end;

class function THTTPResponseText.New(const Response: IHTTPResponse; const Content: String): IHTTPResponseText;
begin
  Result := THTTPResponseText.Create(Response, Content);
end;

class function THTTPResponseText.NewFromStream(const ResponseStream: IHTTPResponseStream; const AsUnicode: Boolean)
  : IHTTPResponseText;
var
  StringStream: TStringStream;
begin
  if AsUnicode then
    StringStream := TStringStream.Create(EmptyStr, TEncoding.Unicode)
  else
    StringStream := TStringStream.Create(EmptyStr);
  try
    ResponseStream.Content.Position := 0;
    StringStream.CopyFrom(ResponseStream.Content, ResponseStream.Content.Size);
    Result := THTTPResponseText.Create(ResponseStream, StringStream.DataString);
  finally
    StringStream.Free;
  end;
end;

end.
