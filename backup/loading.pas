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
Loadingcolor = lightblue;//����
procedure loadings;
implementation

procedure loadings;
var
  i: byte;
begin
  clrscr;
  writeln(' ������ ');
  writeln(' �� ����������: ������  ����������������');
  writeln(' ���� ������: ���� ������ ��������� ');
  writeln(' ������� 28 , ������� 1 ');
  gotoxy(fortyfive, twentyfive);
  Write('��������: ');
  gotoxy(fortyfive, twentysix);
  Write('�������� �.�.');
  gotoxy(twentyeight, ten);
  Write(#10'������ ���������...');
  gotoxy(twentyeight, ten+one);
  Write(#10#10'����� ������� ������������ � �����������');
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


