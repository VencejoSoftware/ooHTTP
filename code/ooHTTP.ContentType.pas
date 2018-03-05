{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Content type definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.ContentType;

interface

type
{$REGION 'documentation'}
{
  @value TextPlain Text/Plain content type
  @value JSON JSON content type
  @value XML XML content type
  @value XFORM X-Form content type
}
{$ENDREGION}
  THTTPContentTypeCode = (TextPlain, HTML, JSON, XML, XFORM);

{$REGION 'documentation'}
{
  @abstract(URL ContentType object)
  Define the URL ContentType configuration
  @member(Code Valid code enumeration)
  @member(FileExtension MIME content file extension)
  @member(Text Text ContentType as text)
}
{$ENDREGION}

  IHTTPContentType = interface
    ['{983FEBDE-4418-466C-90BB-49733C345AC9}']
    function Code: THTTPContentTypeCode;
    function FileExtension: String;
    function Text: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPContentType) for simple HTTP)
  @member(Code @seealso(IHTTPContentType.Code))
  @member(Text @seealso(IHTTPContentType.FileExtension))
  @member(Text @seealso(IHTTPContentType.Text))
  @member(
    Create Object constructor
    @param(Code Valid code enumeration)
  )
  @member(
    New Create a new @classname as interface
    @param(Code Valid code enumeration)
  )
}
{$ENDREGION}

  THTTPContentType = class sealed(TInterfacedObject, IHTTPContentType)
  strict private
    _Code: THTTPContentTypeCode;
  public
    function Code: THTTPContentTypeCode;
    function FileExtension: String;
    function Text: String;
    constructor Create(const Code: THTTPContentTypeCode);
    class function New(const Code: THTTPContentTypeCode = TextPlain): IHTTPContentType;
  end;

implementation

function THTTPContentType.Code: THTTPContentTypeCode;
begin
  Result := _Code;
end;

function THTTPContentType.Text: String;
const
  TEXT_VALUE: array [THTTPContentTypeCode] of string = ('text/plain', 'text/html', 'application/json',
    'application/xml', 'application/x-www-form-urlencoded');
begin
  Result := TEXT_VALUE[Code];
end;

function THTTPContentType.FileExtension: String;
const
  FILE_EXTENSION: array [THTTPContentTypeCode] of string = ('txt', 'html', 'json', 'xml', '');
begin
  Result := FILE_EXTENSION[Code];
end;

constructor THTTPContentType.Create(const Code: THTTPContentTypeCode);
begin
  _Code := Code;
end;

class function THTTPContentType.New(const Code: THTTPContentTypeCode): IHTTPContentType;
begin
  Result := THTTPContentType.Create(Code);
end;

end.
