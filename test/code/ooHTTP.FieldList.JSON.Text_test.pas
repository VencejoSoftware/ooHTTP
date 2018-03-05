{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.FieldList.JSON.Text_test;

interface

uses
  SysUtils,
  ooHTTP.Field, ooHTTP.Field.Group,
  ooHTTP.FieldList, ooHTTP.FieldList.Text,
  ooHTTP.FieldList.JSON.Text,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPFieldListJSONTextTest = class(TTestCase)
  published
    procedure EmptyItemsHasEmptyString;
    procedure OneItemHasZeroUnions;
    procedure TwoItemsHasUnions;
    procedure GroupItemHasValue;
  end;

implementation

procedure THTTPFieldListJSONTextTest.EmptyItemsHasEmptyString;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  CheckEquals('{}', THTTPFieldListJSONText.New.Flatten(Fields));
end;

procedure THTTPFieldListJSONTextTest.GroupItemHasValue;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  Fields.Add(THTTPField.New('key1', 'value1'));
  Fields.Add(THTTPField.New('key2', 'value2'));
  Fields.Add(THTTPFieldGroup.New('key3', [THTTPField.New('subkey1', 'sub value2'), THTTPField.New('subkey2',
    'sub value2'), THTTPField.New('subkey3', 'sub value2')]));
  CheckEquals('{"key1":"value1","key2":"value2","key3":["sub value2","sub value2","sub value2"]}',
    THTTPFieldListJSONText.New.Flatten(Fields));
end;

procedure THTTPFieldListJSONTextTest.OneItemHasZeroUnions;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  Fields.Add(THTTPField.New('key1', 'value1'));
  CheckEquals('{"key1":"value1"}', THTTPFieldListJSONText.New.Flatten(Fields));
end;

procedure THTTPFieldListJSONTextTest.TwoItemsHasUnions;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  Fields.Add(THTTPField.New('key1', 'value1'));
  Fields.Add(THTTPField.New('key2', 'value2'));
  CheckEquals('{"key1":"value1","key2":"value2"}', THTTPFieldListJSONText.New.Flatten(Fields));
end;

initialization

RegisterTest(THTTPFieldListJSONTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
