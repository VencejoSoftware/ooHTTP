{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Field.Group_test;

interface

uses
  SysUtils,
  ooHTTP.Field,
  ooHTTP.Field.Group,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPFieldGroupTest = class(TTestCase)
  published
    procedure KeyIsSomething;
    procedure ValueEmpty;
    procedure ValueIsSomething;
  end;

implementation

procedure THTTPFieldGroupTest.KeyIsSomething;
begin
  CheckEquals('KEY1', THTTPFieldGroup.New('KEY1', []).Key);
end;

procedure THTTPFieldGroupTest.ValueEmpty;
begin
  CheckEquals(EmptyStr, THTTPFieldGroup.New('KEY1', []).Value);
end;

procedure THTTPFieldGroupTest.ValueIsSomething;
begin
  CheckEquals('value1,value2', THTTPFieldGroup.New('KEY1', [THTTPField.New('subkey1', 'value1'),
    THTTPField.New('subkey2', 'value2')]).Value);
end;

initialization

RegisterTest(THTTPFieldGroupTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
