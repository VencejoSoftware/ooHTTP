{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.FieldList_test;

interface

uses
  SysUtils,
  ooHTTP.Field, ooHTTP.FieldList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPFieldListTest = class(TTestCase)
  published
    procedure TwoItemsHasNotEmpty;
  end;

implementation

procedure THTTPFieldListTest.TwoItemsHasNotEmpty;
var
  Fields: IHTTPFieldList;
begin
  Fields := THTTPFieldList.New;
  Fields.Add(THTTPField.New('key1', 'value1'));
  Fields.Add(THTTPField.New('key2', 'value2'));
  CheckFalse(Fields.IsEmpty);
end;

initialization

RegisterTest(THTTPFieldListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
