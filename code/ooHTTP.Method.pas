{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Address Method
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Method;

interface

type
{$REGION 'documentation'}
{
  @value GET The GET method requests a representation of the specified resource. Requests using GET should only retrieve data.
  @value HEAD The HEAD method asks for a response identical to that of a GET request, but without the response body.
  @value POST The POST method is used to submit an entity to the specified resource, often causing a change in state or side effects on the server
  @value PUT The PUT method replaces all current representations of the target resource with the request payload.
  @value DELETE The DELETE method deletes the specified resource.
  @value CONNECT The CONNECT method establishes a tunnel to the server identified by the target resource.
  @value OPTIONS The OPTIONS method is used to describe the communication options for the target resource.
  @value TRACE The TRACE method performs a message loop-back test along the path to the target resource.
  @value PATCH The PATCH method is used to apply partial modifications to a resource.
}
{$ENDREGION}
  THTTPMethodCode = (GET, HEAD, POST, PUT, DELETE, CONNECT, OPTIONS, TRACE, PATCH);

{$REGION 'documentation'}
{
  @abstract(URL Method object)
  Define the URL Method configuration
  @member(Code Valid code enumeration)
  @member(Text Text Method as text)
}
{$ENDREGION}

  IHTTPMethod = interface
    ['{8BC45D92-8D5C-4F55-AC07-18A2478B2B6F}']
    function Code: THTTPMethodCode;
    function Text: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPMethod))
  @member(Code @seealso(IHTTPMethod.Code))
  @member(Text @seealso(IHTTPMethod.Text))
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

  THTTPMethod = class sealed(TInterfacedObject, IHTTPMethod)
  strict private
    _Code: THTTPMethodCode;
  public
    function Code: THTTPMethodCode;
    function Text: String;
    constructor Create(const Code: THTTPMethodCode);
    class function New(const Code: THTTPMethodCode = GET): IHTTPMethod;
  end;

implementation

function THTTPMethod.Code: THTTPMethodCode;
begin
  Result := _Code;
end;

function THTTPMethod.Text: String;
const
  TEXT_VALUE: array [THTTPMethodCode] of string = ('GET', 'HEAD', 'POST', 'PUT', 'DELETE', 'CONNECT', 'OPTIONS',
    'TRACE', 'PATCH');
begin
  Result := TEXT_VALUE[Code];
end;

constructor THTTPMethod.Create(const Code: THTTPMethodCode);
begin
  _Code := Code;
end;

class function THTTPMethod.New(const Code: THTTPMethodCode): IHTTPMethod;
begin
  Result := THTTPMethod.Create(Code);
end;

end.
