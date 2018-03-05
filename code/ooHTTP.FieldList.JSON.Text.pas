{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Flatten a list of fields converting to JSON string
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.FieldList.JSON.Text;

interface

uses
  SysUtils,
  ooHTTP.FieldList,
  ooHTTP.Field, ooHTTP.Field.Group,
  ooHTTP.FieldList.Text;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPFieldListText))
  Cast all fields in string with this JSON format
  @member(
    EnclosedValue Enclose a value between chars
    @param(Value Value to enclose)
    @param(Delimiter Delimiter char)
  )
  @member(
    FlattedField Convert field to text, checking for simple or array types
    @param(FieldGroup Field group object)
    @return(Text flatted)
  )
  @member(
    FlattedGroupField Convert field group to text
    @param(Field Field object)
    @return(Text flatted)
  )
  @member(Flatten @seealso(IHTTPFieldListText.Flatten))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  THTTPFieldListJSONText = class sealed(TInterfacedObject, IHTTPFieldListText)
  private
    function EnclosedValue(const Value: String; const Delimiter: Char): String;
    function FlattedField(const Field: IHTTPField): String;
    function FlattedGroupField(const FieldGroup: IHTTPFieldGroup): String;
  public
    function Flatten(const Fields: IHTTPFieldList): String;
    class function New: IHTTPFieldListText;
  end;

implementation

function THTTPFieldListJSONText.EnclosedValue(const Value: String; const Delimiter: Char): String;
begin
  Result := Delimiter + Value + Delimiter;
end;

function THTTPFieldListJSONText.FlattedGroupField(const FieldGroup: IHTTPFieldGroup): String;
var
  Field: IHTTPField;
begin
  Result := EmptyStr;
  for Field in FieldGroup.Items do
  begin
    if Length(Result) > 1 then
      Result := Result + ',';
    Result := Result + EnclosedValue(Field.Value, '"');
  end;
  Result := '[' + Result + ']'
end;

function THTTPFieldListJSONText.FlattedField(const Field: IHTTPField): String;
begin
  if Supports(Field, IHTTPFieldGroup) then
    Result := FlattedGroupField(IHTTPFieldGroup(Field))
  else
    Result := EnclosedValue(Field.Value, '"');
end;

function THTTPFieldListJSONText.Flatten(const Fields: IHTTPFieldList): String;
var
  Field: IHTTPField;
begin
  Result := EmptyStr;
  for Field in Fields do
  begin
    if Length(Result) > 1 then
      Result := Result + ',';
    Result := Result + EnclosedValue(Field.Key, '"') + ':' + FlattedField(Field);
  end;
  Result := '{' + Result + '}'
end;

class function THTTPFieldListJSONText.New: IHTTPFieldListText;
begin
  Result := THTTPFieldListJSONText.Create;
end;

end.
