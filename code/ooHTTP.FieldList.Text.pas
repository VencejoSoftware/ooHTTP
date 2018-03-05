{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Flatten a list of fields converting to string
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.FieldList.Text;

interface

uses
  SysUtils,
  ooHTTP.FieldList,
  ooHTTP.Field;

type
{$REGION 'documentation'}
{
  @abstract(Flatten a list of fields converting to string)
  @member(
    Flatten Cast fielsd to strings
    @param(Fields A list of fields)
    @return(String with fields flattened)
  )
}
{$ENDREGION}
  IHTTPFieldListText = interface
    ['{332E65C6-6F97-4633-8C63-1036AD8C9DA6}']
    function Flatten(const Fields: IHTTPFieldList): String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPFieldListText))
  Cast all fields in string with this format: @code(KEY=VALUE&)
  @member(Flatten @seealso(IHTTPFieldListText.Flatten))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  THTTPFieldListText = class sealed(TInterfacedObject, IHTTPFieldListText)
  public
    function Flatten(const Fields: IHTTPFieldList): String;
    class function New: IHTTPFieldListText;
  end;

implementation

function THTTPFieldListText.Flatten(const Fields: IHTTPFieldList): String;
var
  Field: IHTTPField;
begin
  Result := EmptyStr;
  for Field in Fields do
  begin
    if Length(Result) > 1 then
      Result := Result + '&';
    Result := Result + Field.Key + '=' + Field.Value;
  end;
end;

class function THTTPFieldListText.New: IHTTPFieldListText;
begin
  Result := THTTPFieldListText.Create;
end;

end.
