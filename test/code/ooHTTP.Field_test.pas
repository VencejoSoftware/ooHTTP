{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Field_test;

interface

uses
  SysUtils,
  ooHTTP.Field,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPFieldTest = class(TTestCase)
  published
    procedure KeyIsSomething;
    procedure ValueIsSomething;
  end;

implementation

procedure THTTPFieldTest.KeyIsSomething;
begin
  CheckEquals('KEY1', THTTPField.New('KEY1', 'value1').Key);
end;

procedure THTTPFieldTest.ValueIsSomething;
begin
  CheckEquals('value1', THTTPField.New('KEY1', 'value1').Value);
end;

initialization

RegisterTest(THTTPFieldTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
