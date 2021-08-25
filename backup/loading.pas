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
Loadingcolor = lightblue;//цвет
procedure loadings;
implementation

procedure loadings;
var
  i: byte;
begin
  clrscr;
  writeln(' ПРОЕКТ ');
  writeln(' По дисциплине: Основы  программирования');
  writeln(' тема работы: База данных студентов ');
  writeln(' вариант 28 , уровень 1 ');
  gotoxy(fortyfive, twentyfive);
  Write('Выполнил: ');
  gotoxy(fortyfive, twentysix);
  Write('Федосеев Е.А.');
  gotoxy(twentyeight, ten);
  Write(#10'Запуск программы...');
  gotoxy(twentyeight, ten+one);
  Write(#10#10'После запуска ознакомьтесь с инструкцией');
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


