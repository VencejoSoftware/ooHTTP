{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Message.Head_test;

interface

uses
  SysUtils,
  ooNet.Encoding,
  ooHTTP.ContentType,
  ooHTTP.Field, ooHTTP.FieldList, ooHTTP.FieldList.Text,
  ooHTTP.Message.Head,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPMessageHeadTest = class(TTestCase)
  published
    procedure EmptyFieldResolveEmptyText;
    procedure TwoFieldsAreSomething;
    procedure EncondingIsUTF8;
    procedure ContentTypeIsJSON;
  end;

implementation

procedure THTTPMessageHeadTest.ContentTypeIsJSON;
var
  HTTPMessageHead: IHTTPMessageHead;
begin
  HTTPMessageHead := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(JSON), THTTPFieldListText.New);
  CheckTrue(JSON = HTTPMessageHead.ContentType.Code);
end;

procedure THTTPMessageHeadTest.EmptyFieldResolveEmptyText;
var
  HTTPMessageHead: IHTTPMessageHead;
begin
  HTTPMessageHead := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(JSON), THTTPFieldListText.New);
  CheckEquals(EmptyStr, HTTPMessageHead.Text);
end;

procedure THTTPMessageHeadTest.EncondingIsUTF8;
var
  HTTPMessageHead: IHTTPMessageHead;
begin
  HTTPMessageHead := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(JSON), THTTPFieldListText.New);
  CheckTrue(UTF8 = HTTPMessageHead.Encoding.Code);
end;

procedure THTTPMessageHeadTest.TwoFieldsAreSomething;
var
  HTTPMessageHead: IHTTPMessageHead;
begin
  HTTPMessageHead := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(JSON), THTTPFieldListText.New);
  HTTPMessageHead.Fields.Add(THTTPField.New('key1', 'value1'));
  HTTPMessageHead.Fields.Add(THTTPField.New('key2', 'value2'));
  CheckEquals(2, HTTPMessageHead.Fields.Count);
  CheckEquals('key1=value1&key2=value2', HTTPMessageHead.Text);
end;

initialization

RegisterTest(THTTPMessageHeadTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
