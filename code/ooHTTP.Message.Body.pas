{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Defines a message body
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Message.Body;

interface

uses
  Classes;

type
{$REGION 'documentation'}
{
  @abstract(Defines a HTTP body message with fields)
  @member(Content Stream with body data)
}
{$ENDREGION}
  IHTTPMessageBody = interface
    ['{31D6103F-4903-468B-8BCA-1CB1D4A2615B}']
    function Content: TStream;
  end;

implementation

end.
