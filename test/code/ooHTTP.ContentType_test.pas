{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.ContentType_test;

interface

uses
  SysUtils,
  ooHTTP.ContentType,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPContentTypeTest = class(TTestCase)
  published
    procedure TextPlainResolvedAsTextPlain;
    procedure JSONResolvedAsText;
    procedure XMLResolvedAsText;
    procedure XFORMResolvedAsText;
  end;

implementation

procedure THTTPContentTypeTest.JSONResolvedAsText;
begin
  CheckEquals('application/json', THTTPContentType.New(JSON).Text);
end;

procedure THTTPContentTypeTest.XMLResolvedAsText;
begin
  CheckEquals('application/xml', THTTPContentType.New(XML).Text);
end;

procedure THTTPContentTypeTest.XFORMResolvedAsText;
begin
  CheckEquals('application/x-www-form-urlencoded', THTTPContentType.New(XFORM).Text);
end;

procedure THTTPContentTypeTest.TextPlainResolvedAsTextPlain;
begin
  CheckEquals('text/plain', THTTPContentType.New(TextPlain).Text);
end;

initialization

RegisterTest(THTTPContentTypeTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
