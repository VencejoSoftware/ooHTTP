{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Method_test;

interface

uses
  SysUtils,
  ooHTTP.Method,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPMethodTest = class(TTestCase)
  published
    procedure GetTextIsGET;
    procedure HeadTextIsHEAD;
    procedure PostTextIsPOST;
    procedure PutTextIsPUT;
    procedure DeleteTextIsDELETE;
    procedure IsConnectTextIsCONNECT;
    procedure OptionsTextIsOPTIONS;
    procedure TraceTextIsTRACE;
    procedure PatchTextIsPATCH;
  end;

implementation

procedure THTTPMethodTest.DeleteTextIsDELETE;
begin
  CheckEquals('DELETE', THTTPMethod.New(DELETE).Text);
end;

procedure THTTPMethodTest.GetTextIsGET;
begin
  CheckEquals('GET', THTTPMethod.New.Text);
end;

procedure THTTPMethodTest.HeadTextIsHEAD;
begin
  CheckEquals('HEAD', THTTPMethod.New(HEAD).Text);
end;

procedure THTTPMethodTest.IsConnectTextIsCONNECT;
begin
  CheckEquals('CONNECT', THTTPMethod.New(CONNECT).Text);
end;

procedure THTTPMethodTest.OptionsTextIsOPTIONS;
begin
  CheckEquals('OPTIONS', THTTPMethod.New(OPTIONS).Text);
end;

procedure THTTPMethodTest.PatchTextIsPATCH;
begin
  CheckEquals('PATCH', THTTPMethod.New(PATCH).Text);
end;

procedure THTTPMethodTest.PostTextIsPOST;
begin
  CheckEquals('POST', THTTPMethod.New(POST).Text);
end;

procedure THTTPMethodTest.PutTextIsPUT;
begin
  CheckEquals('PUT', THTTPMethod.New(PUT).Text);
end;

procedure THTTPMethodTest.TraceTextIsTRACE;
begin
  CheckEquals('TRACE', THTTPMethod.New(TRACE).Text);
end;

initialization

RegisterTest(THTTPMethodTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
