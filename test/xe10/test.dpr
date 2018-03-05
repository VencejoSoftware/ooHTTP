{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooHTTP.Method_test in '..\code\ooHTTP.Method_test.pas',
  ooHTTP.ContentType_test in '..\code\ooHTTP.ContentType_test.pas',
  ooHTTP.Field_test in '..\code\ooHTTP.Field_test.pas',
  ooHTTP.FieldList.Text_test in '..\code\ooHTTP.FieldList.Text_test.pas',
  ooHTTP.FieldList_test in '..\code\ooHTTP.FieldList_test.pas',
  ooHTTP.Message.Head_test in '..\code\ooHTTP.Message.Head_test.pas',
  ooHTTP.Proxy_test in '..\code\ooHTTP.Proxy_test.pas',
  ooHTTP.Response.Status_test in '..\code\ooHTTP.Response.Status_test.pas',
  ooHTTP.Connection_test in '..\code\ooHTTP.Connection_test.pas',
  ooHTTP.Request.JSON.Mock in '..\code\mock\ooHTTP.Request.JSON.Mock.pas',
  ooHTTP.Response_test in '..\code\ooHTTP.Response_test.pas',
  ooHTTP.Response.Stream_test in '..\code\ooHTTP.Response.Stream_test.pas',
  ooHTTP.Response.Text_test in '..\code\ooHTTP.Response.Text_test.pas',
  ooHTTP.Response.JSON_test in '..\code\ooHTTP.Response.JSON_test.pas',
  ooHTTP.Request.Stack_test in '..\code\ooHTTP.Request.Stack_test.pas',
  ooHTTP.Client.Parallel_test in '..\code\ooHTTP.Client.Parallel_test.pas',
  ooHTTP.RequestSend.Task_test in '..\code\ooHTTP.RequestSend.Task_test.pas',
  ooHTTP.RequestSend.Supervisor_test in '..\code\ooHTTP.RequestSend.Supervisor_test.pas',
  ooHTTP.Request_test in '..\code\ooHTTP.Request_test.pas',
  ooHTTP.Request.JSON_test in '..\code\ooHTTP.Request.JSON_test.pas',
  ooHTTP.Request.XML_test in '..\code\ooHTTP.Request.XML_test.pas',
  ooHTTP.Response.XML_test in '..\code\ooHTTP.Response.XML_test.pas',
  ooHTTP.Request.XML.Mock in '..\code\mock\ooHTTP.Request.XML.Mock.pas',
  ooHTTP.FieldList.JSON.Text_test in '..\code\ooHTTP.FieldList.JSON.Text_test.pas',
  ooHTTP.Field.Group_test in '..\code\ooHTTP.Field.Group_test.pas',
  ooHTTP.Client_test in '..\code\ooHTTP.Client_test.pas',
  ooHTTP.Request.Country.Mock in '..\code\mock\ooHTTP.Request.Country.Mock.pas',
  Country in '..\code\entity\Country.pas',
  ooHTTP.Client.Parallel in '..\..\code\ooHTTP.Client.Parallel.pas',
  ooHTTP.Client in '..\..\code\ooHTTP.Client.pas',
  ooHTTP.Connection in '..\..\code\ooHTTP.Connection.pas',
  ooHTTP.ContentType in '..\..\code\ooHTTP.ContentType.pas',
  ooHTTP.Field.Group in '..\..\code\ooHTTP.Field.Group.pas',
  ooHTTP.Field in '..\..\code\ooHTTP.Field.pas',
  ooHTTP.FieldList.JSON.Text in '..\..\code\ooHTTP.FieldList.JSON.Text.pas',
  ooHTTP.FieldList in '..\..\code\ooHTTP.FieldList.pas',
  ooHTTP.FieldList.Text in '..\..\code\ooHTTP.FieldList.Text.pas',
  ooHTTP.Message.Body.Fields in '..\..\code\ooHTTP.Message.Body.Fields.pas',
  ooHTTP.Message.Body in '..\..\code\ooHTTP.Message.Body.pas',
  ooHTTP.Message.Head in '..\..\code\ooHTTP.Message.Head.pas',
  ooHTTP.Method in '..\..\code\ooHTTP.Method.pas',
  ooHTTP.Proxy in '..\..\code\ooHTTP.Proxy.pas',
  ooHTTP.Request.JSON in '..\..\code\ooHTTP.Request.JSON.pas',
  ooHTTP.Request in '..\..\code\ooHTTP.Request.pas',
  ooHTTP.Request.Stack in '..\..\code\ooHTTP.Request.Stack.pas',
  ooHTTP.Request.XML in '..\..\code\ooHTTP.Request.XML.pas',
  ooHTTP.RequestSend.Supervisor in '..\..\code\ooHTTP.RequestSend.Supervisor.pas',
  ooHTTP.RequestSend.Task in '..\..\code\ooHTTP.RequestSend.Task.pas',
  ooHTTP.Response.JSON in '..\..\code\ooHTTP.Response.JSON.pas',
  ooHTTP.Response in '..\..\code\ooHTTP.Response.pas',
  ooHTTP.Response.Status in '..\..\code\ooHTTP.Response.Status.pas',
  ooHTTP.Response.Stream in '..\..\code\ooHTTP.Response.Stream.pas',
  ooHTTP.Response.Text in '..\..\code\ooHTTP.Response.Text.pas',
  ooHTTP.Response.XML in '..\..\code\ooHTTP.Response.XML.pas';

{R *.RES}

begin
  Run;

end.
