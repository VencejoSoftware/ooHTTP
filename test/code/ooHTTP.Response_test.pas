{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Response_test;

interface

uses
  SysUtils,
  ooHTTP.Response,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPResponseTest = class(TTestCase)
  published
    procedure ResponseOKIs200;
  end;

implementation

procedure THTTPResponseTest.ResponseOKIs200;
begin
  CheckEquals('200', THTTPResponse.New(200).Status.Text);
end;

initialization

RegisterTest(THTTPResponseTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
