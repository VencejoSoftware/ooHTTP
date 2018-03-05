{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Defines a list of fields
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.FieldList;

interface

uses
  ooList.Enumerable,
  ooHTTP.Field;

type
{$REGION 'documentation'}
{
  @abstract(Defines a list of fields)
}
{$ENDREGION}
  IHTTPFieldList = interface(IGenericListEnumerable<IHTTPField>)
    ['{F8560E8B-94B4-404E-B907-5C3048E9299F}']
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPFieldList))
}
{$ENDREGION}

  THTTPFieldList = class sealed(TListEnumerable<IHTTPField>, IHTTPFieldList)
  public
    class function New: IHTTPFieldList;
  end;

implementation

class function THTTPFieldList.New: IHTTPFieldList;
begin
  Result := THTTPFieldList.Create(True);
end;

end.
