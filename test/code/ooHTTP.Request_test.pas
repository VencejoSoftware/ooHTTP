{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Request_test;

interface

uses
  Classes, SysUtils,
  ooNet.Protocol,
  ooNet.Address.URL,
  ooNet.AccessPoint,
  ooNet.Encoding,
  ooHTTP.Response.Status,
  ooHTTP.Field, ooHTTP.FieldList,
  ooHTTP.FieldList.Text,
  ooHTTP.Method,
  ooHTTP.Message.Head,
  ooHTTP.Message.Body, ooHTTP.Message.Body.Fields,
  ooHTTP.ContentType,
  ooHTTP.Response, ooHTTP.Response.Stream,
  ooHTTP.Request,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPRequestTest = class sealed(TTestCase)
  strict private
    _AccesPoint: INetAccessPoint;
    _Method: IHTTPMethod;
    _Head: IHTTPMessageHead;
    _Body: IHTTPMessageBody;
  protected
    procedure SetUp; override;
  published
    procedure AccesPointIsTestCom;
    procedure MethodIsPost;
    procedure HeadIsEmpty;
    procedure HeadHasFields;
    procedure Failback;
    procedure ResolveResponse;
  end;

implementation

procedure THTTPRequestTest.AccesPointIsTestCom;
var
  Request: IHTTPRequest;
begin
  Request := THTTPRequest.New(_AccesPoint, _Method, _Head, _Body, nil, nil);
  CheckEquals('http://test.com', Request.AccesPoint.Text);
end;

procedure THTTPRequestTest.HeadHasFields;
var
  Request: IHTTPRequest;
begin
  Request := THTTPRequest.New(_AccesPoint, _Method, _Head, _Body, nil, nil);
  Request.Head.Fields.Add(THTTPField.New('Key1', 'Value1'));
  CheckEquals('Key1=Value1', Request.Head.Text);
end;

procedure THTTPRequestTest.HeadIsEmpty;
var
  Request: IHTTPRequest;
begin
  Request := THTTPRequest.New(_AccesPoint, _Method, _Head, _Body, nil, nil);
  CheckEquals(EmptyStr, Request.Head.Text);
end;

procedure THTTPRequestTest.MethodIsPost;
var
  Request: IHTTPRequest;
begin
  Request := THTTPRequest.New(_AccesPoint, _Method, _Head, _Body, nil, nil);
  CheckEquals('POST', Request.Method.Text);
end;

procedure THTTPRequestTest.Failback;
var
  Request: IHTTPRequest;
  OnFail: TOnHTTPRequestFail;
begin
  OnFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
    begin
      CheckEquals(10, ErrorCode);
      CheckEquals('error test', Error);
    end;
  Request := THTTPRequest.New(_AccesPoint, _Method, _Head, _Body, nil, OnFail);
  Request.Failback(10, 'error test');
end;

procedure THTTPRequestTest.ResolveResponse;
var
  Request: IHTTPRequest;
  OnResponse: TOnHTTPRequestResponse;
  Stream: TStream;
begin
  OnResponse := procedure(const Request: IHTTPRequest; const Response: IHTTPResponseStream)
    begin
      CheckEquals(Ord(OK), Ord(Response.Status.Code));
      CheckEquals('test', TStringStream(Response.Content).DataString);
    end;
  Request := THTTPRequest.New(_AccesPoint, _Method, _Head, _Body, OnResponse, nil);
  Stream := TStringStream.Create('test');
  try
    Request.Callback(THTTPResponseStream.New(THTTPResponse.New(200), Stream));
  finally
    Stream.Free;
  end;
end;

procedure THTTPRequestTest.SetUp;
begin
  inherited;
  _AccesPoint := TNetAccessPoint.New(TURL.New('test.com'), TNetProtocol.New(HTTP), nil);
  _Method := THTTPMethod.New(POST);
  _Head := THTTPMessageHead.New(TNetEncoding.New(UTF8), THTTPContentType.New(JSON), THTTPFieldListText.New);
  _Body := THTTPMessageBodyFields.New(THTTPFieldListText.New);
end;

initialization

RegisterTest(THTTPRequestTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
