{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP response definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Response;

interface

uses
  ooHTTP.Response.Status;

type
{$REGION 'documentation'}
{
  @abstract(HTTP request response interface)
  @member(Status Status of the request)
}
{$ENDREGION}
  IHTTPResponse = interface
    ['{A416EE0B-A544-4D68-8FED-1547DAB26224}']
    function Status: IHTTPResponseStatus;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPResponse))
  @member(Status @seealso(IHTTPResponse.Status))
  @member(
    Create Object constructor
    @param(StatusCode Integer returned for the request execution)
  )
  @member(
    New Create a new @classname as interface
    @param(StatusCode Integer returned for the request execution)
  )
}
{$ENDREGION}

  THTTPResponse = class sealed(TInterfacedObject, IHTTPResponse)
  strict private
    _Status: IHTTPResponseStatus;
  public
    function Status: IHTTPResponseStatus;
    constructor Create(const StatusCode: Integer);
    class function New(const StatusCode: Integer): IHTTPResponse;
  end;

implementation

function THTTPResponse.Status: IHTTPResponseStatus;
begin
  Result := _Status;
end;

constructor THTTPResponse.Create(const StatusCode: Integer);
begin
  _Status := THTTPResponseStatus.New(THTTPResponseStatusCode(StatusCode));
end;

class function THTTPResponse.New(const StatusCode: Integer): IHTTPResponse;
begin
  Result := THTTPResponse.Create(StatusCode);
end;

end.
