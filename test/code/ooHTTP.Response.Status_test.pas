{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Response.Status_test;

interface

uses
  SysUtils,
  ooHTTP.Response.Status,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPResponseStatusTest = class(TTestCase)
  published
    procedure UnknownIsEmptyText;
    procedure BadRequestIs400;
  end;

implementation

procedure THTTPResponseStatusTest.BadRequestIs400;
begin
  CheckEquals('400', THTTPResponseStatus.New(BadRequest).Text);
end;

procedure THTTPResponseStatusTest.UnknownIsEmptyText;
begin
  CheckEquals(EmptyStr, THTTPResponseStatus.New.Text);
end;

initialization

RegisterTest(THTTPResponseStatusTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
