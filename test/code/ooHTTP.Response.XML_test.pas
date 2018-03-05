{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Response.XML_test;

interface

uses
  Classes, SysUtils,
  ooHTTP.Response,
  ooHTTP.Response.Stream,
  ooHTTP.Response.XML,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPResponseXMLTest = class(TTestCase)
  const
    XML_DATA = //
      '<?xml version="1.0" encoding="utf-8" standalone="yes"?>' + sLineBreak + //
      '<catalog>' + sLineBreak + //
      ' <book id="bk101">' + sLineBreak + //
      '  <author>Gambardella, Matthew</author>' + sLineBreak + //
      '  <title>XML Developers Guide</title>' + sLineBreak + //
      '  <genre>Computer</genre>' + sLineBreak + //
      '  <price>44.95</price>' + sLineBreak + //
      '  <publish_date>2000-10-01</publish_date>' + sLineBreak + //
      '  <description>An in-depth look at creating applications with XML.</description>' + sLineBreak + //
      ' </book>' + sLineBreak + //
      '</catalog>';
  published
    procedure ResponseOKIs200;
    procedure ContentValueIsTest;
    procedure ContentFromStreamIsTestAnsi;
    procedure ContentFromStreamIsTestUnicode;
  end;

implementation

procedure THTTPResponseXMLTest.ContentFromStreamIsTestAnsi;
var
  Response: IHTTPResponseXML;
  ResponseStream: IHTTPResponseStream;
  Stream: TMemoryStream;
  Text: AnsiString;
begin
  Stream := TMemoryStream.Create;
  try
    Text := XML_DATA;
    Stream.Write(Text[1], Length(Text));
    ResponseStream := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    Response := THTTPResponseXML.NewFromStream(ResponseStream, False);
    CheckEquals(XML_DATA, StringReplace(Response.Content.XML, #9, ' ', [rfReplaceAll]));
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseXMLTest.ContentFromStreamIsTestUnicode;
var
  Response: IHTTPResponseXML;
  ResponseStream: IHTTPResponseStream;
  Stream: TMemoryStream;
  Text: String;
begin
  Stream := TMemoryStream.Create;
  try
    Text := XML_DATA;
    Stream.Write(Text[1], ByteLength(Text));
    ResponseStream := THTTPResponseStream.New(THTTPResponse.New(200), Stream);
    Response := THTTPResponseXML.NewFromStream(ResponseStream, True);
    CheckEquals(XML_DATA, StringReplace(Response.Content.XML, #9, ' ', [rfReplaceAll]));
  finally
    Stream.Free;
  end;
end;

procedure THTTPResponseXMLTest.ContentValueIsTest;
var
  Response: IHTTPResponseXML;
begin
  Response := THTTPResponseXML.New(THTTPResponse.New(200), XML_DATA);
  Response.Content.PreserveWhiteSpace;
  CheckEquals(XML_DATA, StringReplace(Response.Content.XML, #9, ' ', [rfReplaceAll]));
end;

procedure THTTPResponseXMLTest.ResponseOKIs200;
var
  Response: IHTTPResponseXML;
begin
  Response := THTTPResponseXML.New(THTTPResponse.New(200), EmptyStr);
  CheckEquals('200', Response.Status.Text);
end;

initialization

RegisterTest(THTTPResponseXMLTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
