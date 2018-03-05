{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.FieldList.Text_test;

interface

uses
  SysUtils,
  ooHTTP.FieldList,
  ooHTTP.Field,
  ooHTTP.FieldList.Text,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPFieldListTextTest = class(TTestCase)
  published
    procedure EmptyItemsHasEmptyString;
    procedure OneItemHasZeroUnions;
    procedure TwoItemsHasUnions;
  end;

implementation

procedure THTTPFieldListTextTest.EmptyItemsHasEmptyString;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  CheckEquals(EmptyStr, THTTPFieldListText.New.Flatten(Fields));
end;

procedure THTTPFieldListTextTest.OneItemHasZeroUnions;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  Fields.Add(THTTPField.New('key1', 'value1'));
  CheckEquals('key1=value1', THTTPFieldListText.New.Flatten(Fields));
end;

procedure THTTPFieldListTextTest.TwoItemsHasUnions;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  Fields.Add(THTTPField.New('key1', 'value1'));
  Fields.Add(THTTPField.New('key2', 'value2'));
  CheckEquals('key1=value1&key2=value2', THTTPFieldListText.New.Flatten(Fields));
end;

initialization

RegisterTest(THTTPFieldListTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
