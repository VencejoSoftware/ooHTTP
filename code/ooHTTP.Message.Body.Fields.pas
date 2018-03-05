{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Defines a message body with fields
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Message.Body.Fields;

interface

uses
  Classes,
  ooHTTP.Field, ooHTTP.FieldList, ooHTTP.FieldList.Text,
  ooHTTP.Message.Body;

type
{$REGION 'documentation'}
{
  @abstract(Defines a HTTP body message with fields)
  @member(Fields Field lista object)
}
{$ENDREGION}
  IHTTPMessageBodyFields = interface(IHTTPMessageBody)
    ['{F9FEA9B7-A5D0-4E5D-AAC6-C8EA24A858C7}']
    function Fields: IHTTPFieldList;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPMessageBodyFields))
  @member(Fields @seealso(IHTTPMessageBodyFields.Fields))
  @member(Content @seealso(IHTTPMessageBody.Content))
  @member(
    Create Object constructor
    @param(Flater Flatter object)
  )
  @member(
    New Create a new @classname as interface
    @param(Flater Flatter object)
  )
}
{$ENDREGION}

  THTTPMessageBodyFields = class sealed(TInterfacedObject, IHTTPMessageBodyFields, IHTTPMessageBody)
  strict private
    _Fields: IHTTPFieldList;
    _Content: TStringStream;
    _FieldListText: IHTTPFieldListText;
  public
    function Fields: IHTTPFieldList;
    function Content: TStream;
    constructor Create(const FieldListText: IHTTPFieldListText);
    destructor Destroy; override;
    class function New(const FieldListText: IHTTPFieldListText): IHTTPMessageBodyFields;
  end;

implementation

function THTTPMessageBodyFields.Fields: IHTTPFieldList;
begin
  Result := _Fields;
end;

function THTTPMessageBodyFields.Content: TStream;
begin
  _Content.Clear;
  _Content.WriteString(_FieldListText.Flatten(_Fields));
  Result := _Content;
end;

constructor THTTPMessageBodyFields.Create(const FieldListText: IHTTPFieldListText);
begin
  _Fields := THTTPFieldList.New;
  _Content := TStringStream.Create;
  _FieldListText := FieldListText;
end;

destructor THTTPMessageBodyFields.Destroy;
begin
  _Content.Free;
  inherited;
end;

class function THTTPMessageBodyFields.New(const FieldListText: IHTTPFieldListText): IHTTPMessageBodyFields;
begin
  Result := THTTPMessageBodyFields.Create(FieldListText);
end;

end.
