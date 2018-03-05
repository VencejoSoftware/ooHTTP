{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Defines a message header
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Message.Head;

interface

uses
  SysUtils,
  ooNet.Encoding,
  ooHTTP.ContentType,
  ooHTTP.Field, ooHTTP.FieldList, ooHTTP.FieldList.Text;

type
{$REGION 'documentation'}
{
  @abstract(Defines a HTTP header message)
  @member(Encoding Header encoding object)
  @member(ContentType Header content type object)
  @member(Fields Field lista object)
  @member(Text Head message value as text)
}
{$ENDREGION}
  IHTTPMessageHead = interface
    ['{E7718176-87AF-4247-9441-7BAFB26251F6}']
    function Encoding: INetEncoding;
    function ContentType: IHTTPContentType;
    function Fields: IHTTPFieldList;
    function Text: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPMessageHead))
  @member(Encoding @seealso(IHTTPMessageHead.Encoding))
  @member(ContentType @seealso(IHTTPMessageHead.ContentType))
  @member(Fields @seealso(IHTTPMessageHead.Fields))
  @member(Text @seealso(IHTTPMessageHead.Text))
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

  THTTPMessageHead = class sealed(TInterfacedObject, IHTTPMessageHead)
  strict private
    _Encoding: INetEncoding;
    _ContentType: IHTTPContentType;
    _Fields: IHTTPFieldList;
    _FieldListText: IHTTPFieldListText;
  public
    function Encoding: INetEncoding;
    function ContentType: IHTTPContentType;
    function Fields: IHTTPFieldList;
    function Text: String;
    constructor Create(const Encoding: INetEncoding; const ContentType: IHTTPContentType;
      const FieldListText: IHTTPFieldListText);
    class function New(const Encoding: INetEncoding; const ContentType: IHTTPContentType;
      const FieldListText: IHTTPFieldListText): IHTTPMessageHead;
  end;

implementation

function THTTPMessageHead.Encoding: INetEncoding;
begin
  Result := _Encoding;
end;

function THTTPMessageHead.ContentType: IHTTPContentType;
begin
  Result := _ContentType;
end;

function THTTPMessageHead.Fields: IHTTPFieldList;
begin
  Result := _Fields;
end;

function THTTPMessageHead.Text: String;
begin
  Result := _FieldListText.Flatten(_Fields);
end;

constructor THTTPMessageHead.Create(const Encoding: INetEncoding; const ContentType: IHTTPContentType;
  const FieldListText: IHTTPFieldListText);
begin
  _Encoding := Encoding;
  _ContentType := ContentType;
  _Fields := THTTPFieldList.New;
  _FieldListText := FieldListText;
end;

class function THTTPMessageHead.New(const Encoding: INetEncoding; const ContentType: IHTTPContentType;
  const FieldListText: IHTTPFieldListText): IHTTPMessageHead;
begin
  Result := THTTPMessageHead.Create(Encoding, ContentType, FieldListText);
end;

end.
