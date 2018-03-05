{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Request.Stack_test;

interface

uses
  SysUtils,
  ooHTTP.Request, ooHTTP.Request.JSON.Mock,
  ooHTTP.Request.Stack,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPRequestStackTest = class(TTestCase)
  published
    procedure NewHas0InCount;
    procedure NewIsEmpty;
    procedure NewReturnNilInPop;
    procedure Push2Return2InCount;
    procedure Push2IsNotEmpty;
    procedure FirstPopIsPost1;
    procedure SecondPopIsPost2;
  end;

implementation

procedure THTTPRequestStackTest.FirstPopIsPost1;
var
  Stack: IHTTPRequestStack;
  Request: IHTTPRequest;
begin
  Stack := THTTPRequestStack.New;
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1'));
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/2'));
  Request := Stack.Pop;
  CheckEquals('http://jsonplaceholder.typicode.com/posts/1', Request.AccesPoint.Text);
  CheckEquals(1, Stack.Count);
end;

procedure THTTPRequestStackTest.NewHas0InCount;
begin
  CheckEquals(0, THTTPRequestStack.New.Count);
end;

procedure THTTPRequestStackTest.NewIsEmpty;
begin
  CheckTrue(THTTPRequestStack.New.IsEmpty);
end;

procedure THTTPRequestStackTest.NewReturnNilInPop;
begin
  CheckFalse(Assigned(THTTPRequestStack.New.Pop));
end;

procedure THTTPRequestStackTest.Push2IsNotEmpty;
var
  Stack: IHTTPRequestStack;
begin
  Stack := THTTPRequestStack.New;
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1'));
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/2'));
  CheckFalse(Stack.IsEmpty);
end;

procedure THTTPRequestStackTest.Push2Return2InCount;
var
  Stack: IHTTPRequestStack;
begin
  Stack := THTTPRequestStack.New;
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1'));
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/2'));
  CheckEquals(2, Stack.Count);
end;

procedure THTTPRequestStackTest.SecondPopIsPost2;
var
  Stack: IHTTPRequestStack;
  Request: IHTTPRequest;
begin
  Stack := THTTPRequestStack.New;
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1'));
  Stack.Push(THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/2'));
  Stack.Pop;
  Request := Stack.Pop;
  CheckEquals('http://jsonplaceholder.typicode.com/posts/2', Request.AccesPoint.Text);
  CheckEquals(0, Stack.Count);
end;

initialization

RegisterTest(THTTPRequestStackTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
