{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Response.Text_test;

interface

uses
  Classes, SysUtils,
  ooHTTP.Response,
  ooHTTP.Response.Stream,
  ooHTTP.Response.Text,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPResponseTextTest = class(TTestCase)
  published
    procedure ResponseOKIs200;
    procedure ContentValueIsTest;
    procedure ContentFromStreamIsTestAnsi;
    procedure ContentFromStreamIsTestUnicode;
  end;

implementation

procedure THTTPResponseTextTest.ContentFromStreamIsTestAnsi;
var
  Response: IHTTPResponseText;
  ResponseStream: IHTTPResponseStream;
  Stream: TMemoryStream;
  Text: AnsiString;
begin
  Stream := TMemoryStream.Create;
  try
    Text := 'test string';
    Stream.Write(Text[1], Length(Text));
    ResponseStream := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    Response := THTTPResponseText.NewFromStream(ResponseStream, False);
    CheckEquals('test string', Response.Content);
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseTextTest.ContentFromStreamIsTestUnicode;
var
  Response: IHTTPResponseText;
  ResponseStream: IHTTPResponseStream;
  Stream: TMemoryStream;
  Text: String;
begin
  Stream := TMemoryStream.Create;
  try
    Text := 'test string';
    Stream.Write(Text[1], ByteLength(Text));
    ResponseStream := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    Response := THTTPResponseText.NewFromStream(ResponseStream, True);
    CheckEquals('test string', Response.Content);
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseTextTest.ContentValueIsTest;
var
  Response: IHTTPResponseText;
begin
  Response := THTTPResponseText.New(THTTPResponse.New(200), 'Test');
  CheckEquals('Test', Response.Content);
end;

procedure THTTPResponseTextTest.ResponseOKIs200;
var
  Response: IHTTPResponseText;
begin
  Response := THTTPResponseText.New(THTTPResponse.New(200), EmptyStr);
  CheckEquals('200', Response.Status.Text);
end;

initialization

RegisterTest(THTTPResponseTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
