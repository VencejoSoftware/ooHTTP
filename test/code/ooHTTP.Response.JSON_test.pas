{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Response.JSON_test;

interface

uses
  Classes, SysUtils,
  ooHTTP.Response,
  ooHTTP.Response.Stream,
  ooHTTP.Response.JSON,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPResponseJSONTest = class(TTestCase)
  published
    procedure ResponseOKIs200;
    procedure ContentValueIsTest;
    procedure ContentFromStreamIsTestAnsi;
    procedure ContentFromStreamIsTestUnicode;
  end;

implementation

procedure THTTPResponseJSONTest.ContentFromStreamIsTestAnsi;
var
  Response: IHTTPResponseJSON;
  ResponseStream: IHTTPResponseStream;
  Stream: TMemoryStream;
  Text: AnsiString;
begin
  Stream := TMemoryStream.Create;
  try
    Text := '{"name":"India"}';
    Stream.Write(Text[1], Length(Text));
    ResponseStream := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    Response := THTTPResponseJSON.NewFromStream(ResponseStream, False);
    CheckEquals('{"name":"India"}', Response.Content.toString);
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseJSONTest.ContentFromStreamIsTestUnicode;
var
  Response: IHTTPResponseJSON;
  ResponseStream: IHTTPResponseStream;
  Stream: TMemoryStream;
  Text: String;
begin
  Stream := TMemoryStream.Create;
  try
    Text := '{"name":"India"}';
    Stream.Write(Text[1], ByteLength(Text));
    ResponseStream := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    Response := THTTPResponseJSON.NewFromStream(ResponseStream, True);
    CheckEquals('{"name":"India"}', Response.Content.toString);
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseJSONTest.ContentValueIsTest;
var
  Response: IHTTPResponseJSON;
begin
  Response := THTTPResponseJSON.New(THTTPResponse.New(200), '{"name":"India"}');
  CheckEquals('{"name":"India"}', Response.Content.toString);
end;

procedure THTTPResponseJSONTest.ResponseOKIs200;
var
  Response: IHTTPResponseJSON;
begin
  Response := THTTPResponseJSON.New(THTTPResponse.New(200), EmptyStr);
  CheckEquals('200', Response.Status.Text);
end;

initialization

RegisterTest(THTTPResponseJSONTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
