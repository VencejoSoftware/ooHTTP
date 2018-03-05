{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP response with JSON content format handler definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Response.JSON;

interface

uses
  Classes, SysUtils,
  uJSON,
  ooHTTP.Response,
  ooHTTP.Response.Text,
  ooHTTP.Response.Stream,
  ooHTTP.Response.Status;

type
{$REGION 'documentation'}
{
  @abstract(HTTP request response with JSON format content handler interface)
  @member(Content JSON object with data)
}
{$ENDREGION}
  IHTTPResponseJSON = interface(IHTTPResponse)
    ['{9C0BB84F-A7BE-4DE5-9DAD-18304E89536E}']
    function Content: TJSONObject;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPResponseJSON))
  @member(Content @seealso(IHTTPResponseJSON.Content))
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

  THTTPResponseJSON = class sealed(TInterfacedObject, IHTTPResponseJSON)
  strict private
    _Response: IHTTPResponse;
    _Content: TJSONObject;
  public
    function Status: IHTTPResponseStatus;
    function Content: TJSONObject;
    constructor Create(const Response: IHTTPResponse; const Content: String);
    destructor Destroy; override;
    class function New(const Response: IHTTPResponse; const Content: String): IHTTPResponseJSON;
    class function NewFromStream(const ResponseStream: IHTTPResponseStream; const AsUnicode: Boolean = False)
      : IHTTPResponseJSON;
  end;

implementation

function THTTPResponseJSON.Status: IHTTPResponseStatus;
begin
  Result := _Response.Status;
end;

function THTTPResponseJSON.Content: TJSONObject;
begin
  Result := _Content;
end;

constructor THTTPResponseJSON.Create(const Response: IHTTPResponse; const Content: String);
begin
  if Length(Content) < 1 then
    _Content := TJSONObject.Create
  else
    _Content := TJSONObject.Create(Content);
  _Response := Response;
end;

destructor THTTPResponseJSON.Destroy;
begin
  _Content.Free;
  inherited;
end;

class function THTTPResponseJSON.New(const Response: IHTTPResponse; const Content: String): IHTTPResponseJSON;
begin
  Result := THTTPResponseJSON.Create(Response, Content);
end;

class function THTTPResponseJSON.NewFromStream(const ResponseStream: IHTTPResponseStream; const AsUnicode: Boolean)
  : IHTTPResponseJSON;
var
  ResponseText: IHTTPResponseText;
begin
  ResponseText := THTTPResponseText.NewFromStream(ResponseStream, AsUnicode);
  Result := THTTPResponseJSON.Create(ResponseStream, ResponseText.Content);
end;

end.
