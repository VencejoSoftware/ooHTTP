{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP response with stream content handler definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Response.Stream;

interface

uses
  Classes,
  ooHTTP.Response,
  ooHTTP.Response.Status;

type
{$REGION 'documentation'}
{
  @abstract(HTTP request response with stream content handler interface)
  @member(Content Stream with data)
}
{$ENDREGION}
  IHTTPResponseStream = interface(IHTTPResponse)
    ['{27B82CFF-D94C-4886-9A94-639D696CC944}']
    function Content: TStream;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPResponseStream))
  @member(Content @seealso(IHTTPResponseStream.Content))
  @member(
    Create Object constructor
    @param(Response Base response with status)
    @param(Content Stream with data)
  )
  @member(
    New Create a new @classname as interface
    @param(Response Base response with status)
    @param(Content Stream with data)
  )
}
{$ENDREGION}

  THTTPResponseStream = class sealed(TInterfacedObject, IHTTPResponseStream)
  strict private
    _Response: IHTTPResponse;
    _Content: TStream;
  public
    function Status: IHTTPResponseStatus;
    function Content: TStream;
    constructor Create(const Response: IHTTPResponse; const Content: TStream);
    class function New(const Response: IHTTPResponse; const Content: TStream): IHTTPResponseStream;
  end;

implementation

function THTTPResponseStream.Status: IHTTPResponseStatus;
begin
  Result := _Response.Status;
end;

function THTTPResponseStream.Content: TStream;
begin
  Result := _Content;
end;

constructor THTTPResponseStream.Create(const Response: IHTTPResponse; const Content: TStream);
begin
  _Response := Response;
  _Content := Content;
end;

class function THTTPResponseStream.New(const Response: IHTTPResponse; const Content: TStream): IHTTPResponseStream;
begin
  Result := THTTPResponseStream.Create(Response, Content);
end;

end.
