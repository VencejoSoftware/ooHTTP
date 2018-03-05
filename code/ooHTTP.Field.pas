{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Defines a message field object
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Field;

interface

type
{$REGION 'documentation'}
{
  @abstract(HTTP message field object)
  @member(Key Identification key)
  @member(Value Store the value)
}
{$ENDREGION}
  IHTTPField = interface
    ['{E1E75A71-8FFE-4532-9417-36F005E9E176}']
    function Key: String;
    function Value: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPField))
  @member(Key @seealso(IHTTPField.Key))
  @member(Value @seealso(IHTTPField.Value))
  @member(
    Create Object constructor
    @param(Key Identification key)
    @param(Value Store the value)
  )
  @member(
    New Create a new @classname as interface
    @param(Key Identification key)
    @param(Value Store the value)
  )
}
{$ENDREGION}

  THTTPField = class sealed(TInterfacedObject, IHTTPField)
  strict private
    _Key, _Value: String;
  public
    function Key: String;
    function Value: String;
    constructor Create(const Key, Value: String);
    class function New(const Key, Value: String): IHTTPField;
  end;

implementation

function THTTPField.Key: String;
begin
  Result := _Key;
end;

function THTTPField.Value: String;
begin
  Result := _Value;
end;

constructor THTTPField.Create(const Key, Value: String);
begin
  _Key := Key;
  _Value := Value;
end;

class function THTTPField.New(const Key, Value: String): IHTTPField;
begin
  Result := THTTPField.Create(Key, Value);
end;

end.
