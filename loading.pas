unit loading;

interface

uses crt;
const
one=1;
sixtytwo=62;
eighty=80;
fortyfive=45;
ten=10;
twentyeight=28;
twentysix=26;
twentyfive=25;
fifteen=15;
eight=8;
Loadingcolor = lightblue;//梥�
procedure loadings;
implementation

procedure loadings;
var
  i: byte;
begin
  clrscr;
  writeln(' ������ ');
  writeln(' �� ���樯����: �᭮��  �ணࠬ��஢����');
  writeln(' ⥬� ࠡ���: ���� ������ ��㤥�⮢ ');
  writeln(' ��ਠ�� 28 , �஢��� 1 ');
  gotoxy(fortyfive, twentyfive);
  Write('�믮����: ');
  gotoxy(fortyfive, twentysix);
  Write('����ᥥ� �.�.');
  gotoxy(twentyeight, ten);
  Write(#10'����� �ணࠬ��...');
  gotoxy(twentyeight, ten+one);
  Write(#10#10'��᫥ ����᪠ ����������� � ������樥�');
  gotoxy(eight, wherey + one);
  textcolor(loadingcolor);
  for i := one to sixtytwo do
  begin
    gotoxy(wherex, fifteen);
    Write('+');
    delay(eighty);
  end;
  clrscr;

end;
end.


