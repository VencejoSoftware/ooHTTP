{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Client.Parallel_test;

interface

uses
  Classes, SysUtils,
  ooHTTP.Request, ooHTTP.Request.JSON.Mock,
  ooHTTP.Response.Stream,
  ooHTTP.Client, ooHTTP.Client.Parallel,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPClientParallelTest = class(TTestCase)
  published
    procedure SendSimpleRequest;
    procedure SendStackOfRequests;
    procedure SendStackOfRequestsWith4Threads;
    procedure SendFail;
  end;

implementation

procedure THTTPClientParallelTest.SendFail;
var
  Client: IHTTPClient;
begin
  Client := THTTPClientParallel.New;
  Client.Send(nil);
end;

procedure THTTPClientParallelTest.SendSimpleRequest;
var
  Request: IHTTPRequest;
  Client: IHTTPClient;
begin
  Request := THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1');
  Client := THTTPClientParallel.New;
  Client.Send(Request);
end;

procedure THTTPClientParallelTest.SendStackOfRequests;
var
  Client: IHTTPClient;
begin
  Client := THTTPClientParallel.New;
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/2'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/3'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/4'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/5'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/6'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/7'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/8'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/9'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/10'));
end;

procedure THTTPClientParallelTest.SendStackOfRequestsWith4Threads;
var
  Client: IHTTPClient;
begin
  Client := THTTPClientParallel.New(4);
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/2'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/3'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/4'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/5'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/6'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/7'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/8'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/9'));
  Client.Send(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/10'));
end;

initialization

RegisterTest(THTTPClientParallelTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
