{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Response.Stream_test;

interface

uses
  Classes, SysUtils,
  ooHTTP.Response, ooHTTP.Response.Stream,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPResponseStreamTest = class(TTestCase)
  published
    procedure ResponeWithTextInStream;
    procedure ResponeWithStreamEmpty;
    procedure ResponseOKIs200;
  end;

implementation

procedure THTTPResponseStreamTest.ResponeWithStreamEmpty;
var
  Response: IHTTPResponseStream;
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Response := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    CheckEquals(0, Response.Content.Size);
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseStreamTest.ResponeWithTextInStream;
var
  Response: IHTTPResponseStream;
  Stream: TMemoryStream;
  Text: String;
  StringStream: TStringStream;
begin
  Stream := TMemoryStream.Create;
  try
    Text := 'test string';
    Stream.Write(Text[1], ByteLength(Text));
    Response := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    CheckEquals(22, Response.Content.Size);
    StringStream := TStringStream.Create(EmptyStr, TEncoding.Unicode);
    try
      Response.Content.Position := 0;
      StringStream.CopyFrom(Response.Content, Response.Content.Size);
      CheckEquals('test string', StringStream.DataString);
    finally
      StringStream.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseStreamTest.ResponseOKIs200;
var
  Response: IHTTPResponseStream;
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Response := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    CheckEquals('200', Response.Status.Text);
  finally
    Stream.Free;
  end;
end;

initialization

RegisterTest(THTTPResponseStreamTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
