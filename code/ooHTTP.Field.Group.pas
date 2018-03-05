{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Defines a field with a group of fields inside
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Field.Group;

interface

uses
  SysUtils,
  ooHTTP.FieldList,
  ooHTTP.Field;

type
{$REGION 'documentation'}
{
  @abstract(HTTP head/body field object)
  @member(Items List of fields)
}
{$ENDREGION}
  IHTTPFieldGroup = interface(IHTTPField)
    ['{EB7C83EC-BD86-4BFE-BCEB-F3D83A23F123}']
    function Items: IHTTPFieldList;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPFieldGroup))
  @member(Key @seealso(IHTTPField.Key))
  @member(Value @seealso(IHTTPField.Value))
  @member(Items @seealso(IHTTPFieldGroup.Items))
  @member(
    Create Object constructor
    @param(Key Identification key)
    @param(Value Store the value)
  )
  @member(Destroy Object destructor)
  @member(
    New Create a new @classname as interface
    @param(Key Identification key)
    @param(Value Store the value)
  )
}
{$ENDREGION}

  THTTPFieldGroup = class sealed(TInterfacedObject, IHTTPFieldGroup, IHTTPField)
  strict private
    _Key: String;
    _Items: IHTTPFieldList;
  public
    function Key: String;
    function Value: String;
    function Items: IHTTPFieldList;
    constructor Create(const Key: String; const Items: array of IHTTPField);
    class function New(const Key: String; const Items: array of IHTTPField): IHTTPField;
  end;

implementation

function THTTPFieldGroup.Items: IHTTPFieldList;
begin
  Result := _Items;
end;

function THTTPFieldGroup.Key: String;
begin
  Result := _Key;
end;

function THTTPFieldGroup.Value: String;
const
  SEPARATOR = ',';
var
  Field: IHTTPField;
begin
  Result := EmptyStr;
  for Field in Items do
    Result := Result + Field.Value + SEPARATOR;
  if Length(Result) > 1 then
    Result := Copy(Result, 1, Pred(Length(Result)));
end;

constructor THTTPFieldGroup.Create(const Key: String; const Items: array of IHTTPField);
var
  i: Integer;
begin
  _Key := Key;
  _Items := THTTPFieldList.New;
  for i := Low(Items) to High(Items) do
    _Items.Add(Items[i]);
end;

class function THTTPFieldGroup.New(const Key: String; const Items: array of IHTTPField): IHTTPField;
begin
  Result := THTTPFieldGroup.Create(Key, Items);
end;

end.
