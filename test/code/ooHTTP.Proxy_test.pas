{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Proxy_test;

interface

uses
  SysUtils,
  ooNet.Protocol,
  ooNet.Address.URL,
  ooNet.Credential,
  ooNet.AccessPoint,
  ooHTTP.Proxy,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPProxyTest = class(TTestCase)
  published
    procedure AddressIsNil;
    procedure AuthenticationIsNil;
    procedure AddressIsSomething;
    procedure UserPassPresent;
  end;

implementation

procedure THTTPProxyTest.AddressIsNil;
begin
  CheckFalse(Assigned(THTTPProxy.New(TNetAccessPoint.New(nil, nil, nil)).Address));
end;

procedure THTTPProxyTest.AuthenticationIsNil;
begin
  CheckFalse(Assigned(THTTPProxy.New(TNetAccessPoint.New(nil, nil, nil)).Credential));
end;

procedure THTTPProxyTest.AddressIsSomething;
var
  HTTPProxy: IHTTPProxy;
begin
  HTTPProxy := THTTPProxy.New(TNetAccessPoint.New(TURL.New('www.test.com', 8080), TNetProtocol.New(HTTP), nil));
  CheckEquals('http://www.test.com:8080', HTTPProxy.Text);
end;

procedure THTTPProxyTest.UserPassPresent;
var
  HTTPProxy: IHTTPProxy;
begin
  HTTPProxy := THTTPProxy.New(TNetAccessPoint.New(nil, nil, TNetCredential.New('user', '12345')));
  CheckEquals('user', HTTPProxy.Credential.User);
  CheckEquals('12345', HTTPProxy.Credential.Password);
end;

initialization

RegisterTest(THTTPProxyTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
