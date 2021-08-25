unit FrameTable;

interface

uses crt;

const
  horizontal_line_max = 115;              //максимальная длина горизонтальной линии
  horizontal_line_max2 = 95;              ////максимальная длина горизонтальной линии 2 таюл
  horizontal_line_max3 = 115;              ////максимальная длина горизонтальной линии 2 таюл
  vertical_line_max = 25;                //максиимальная высота вертикальной линии
  horizontal_line = 99;                 //длина горизонтальной линии
  vertical_line = 24;                  //высота вертикальной линии
  numbem_cell = 7;                    //количество столбцов с перекрестиями
  numbem_cell2 = 6;                  //количество столбцов с перекрестиями 2
  numbem_cell3 = 4;                 //количество столбцов с перекрестиями 3
  cell_width = 18;                 //расстояние между вертикаль. линимями
  cell_width2 = 18;               //расстояние между вертикаль. линимями 2
  cell_width3 = 30;              //расстояние между вертикаль. линимями 3
  cell_height = 2;              //расстояние между горизонт. линиями
  number_intersections = 12;   //количество пересечений  


procedure FirstFrameTable;
procedure SecondFrameTable;
procedure ThirdFrameTable;
implementation

procedure FirstFrameTable;
var
  Count, Count2, x, y: integer;
begin

  gotoxy(3, cell_height);
  Write('Дата');
  gotoxy(21, cell_height);
  Write('Время начала');
  gotoxy(38, cell_height);
  Write('Время окончания');
  gotoxy(57, cell_height);
  Write('Тип приема');
  gotoxy(75, cell_height);
  Write('Пациент');
  gotoxy(93, cell_height);
  Write('Врач');


    gotoxy(1, 1);
    Write(#201); //201    // левый верхний край
    gotoxy(1, vertical_line_max);
    Write(#200); //200    // левый нижний край


    y := 1;
    while y <= vertical_line_max do
    begin
      for x := 2 to horizontal_line_max do
      begin
        gotoxy(x, y);
        Write(#205); //205  // горизонтальная верхняя линия
      end;
      y := y + cell_height;
    end;

    x := cell_width;
    y := 1;
    for Count := 2 to numbem_cell do
    begin
      gotoxy(x, y);
      Write(#203); //203  // верхнее перекрестие ячейки
      x := x + cell_width;
    end;

    x := cell_width;
    y := vertical_line_max;
    for Count := 2 to numbem_cell do
    begin
      gotoxy(x, y);
      Write(#202); //202  // нижнее перекрестие ячейки
      x := x + cell_width;
    end;

    for y := 2 to vertical_line do
    begin
      gotoxy(1, y);
      Write(#186); //186   // вертикальная левая черта
    end;

    for y := 2 to vertical_line do
    begin
      gotoxy(horizontal_line_max, y);
      Write(#186); //186   // вертикальная правая черта
    end;

    x := cell_width;
    while x <= horizontal_line_max do
    begin
      for y := 2 to vertical_line do
      begin
        gotoxy(x, y);
        Write(#186); //186  // вертикальная черта ячейки
      end;
      x := x + cell_width;
    end;

    y := 3;
    for x := 2 to number_intersections do
    begin
      gotoxy(1, y);
      Write(#204); //204  // Края ячеек
      y := y + cell_height;
    end;

    y := 3;
    for x := 2 to number_intersections do
    begin
      gotoxy(horizontal_line_max, y);
      Write(#185); //185  // Края ячеек
      y := y + cell_height;
    end;

    gotoxy(horizontal_line_max, 1);
    Write(#187); //187   // правый верхний край
    gotoxy(horizontal_line_max, vertical_line_max);
    Write(#188); //188   //правый нижний угол

    x := cell_width;
    y := 3;
    for Count := 2 to numbem_cell do
    begin
      gotoxy(x, y);
      Write(#206); //206   // перекрестие первой ячейки
      y := 3;
      x := x + cell_width;
    end;

    x := cell_width;
    for Count2 := 2 to numbem_cell do
    begin
      y := 3;
      for Count := 2 to number_intersections do
      begin
        gotoxy(x, y);
        Write(#206); //206   // перекрестие Первой ячейки
        y := y + cell_height;
      end;
      x := x + cell_width;
    end;


end;

procedure SecondFrameTable;
var
  Count, Count2, y, x: integer;
begin
    //clrscr;

    gotoxy(3, cell_height);
    Write('Фамилия');
    gotoxy(21, cell_height);
    Write('Имя');
    gotoxy(38, cell_height);
    Write('Отчество');
    gotoxy(57, cell_height);
    Write('Специальность');
    gotoxy(75, cell_height);
    Write('Номер кабинета');


      gotoxy(1, 1);
      Write(#201); //201    // левый верхний край
      gotoxy(1, vertical_line_max);
      Write(#200); //200    // левый нижний край


      y := 1;
      while y <= vertical_line_max do
      begin
        for x := 2 to horizontal_line_max2 do
        begin
          gotoxy(x, y);
          Write(#205); //205  // горизонтальная верхняя линия
        end;
        y := y + cell_height;
      end;

      x := cell_width2;
      y := 1;
      for Count := 2 to numbem_cell2 do
      begin
        gotoxy(x, y);
        Write(#203); //203  // верхнее перекрестие ячейки
        x := x + cell_width2;
      end;

      x := cell_width2;
      y := horizontal_line_max2;
      for Count := 2 to numbem_cell2 do
      begin
        gotoxy(x, y);
        Write(#202); //202  // нижнее перекрестие ячейки
        x := x + cell_width2;
      end;

      for y := 2 to vertical_line do
      begin
        gotoxy(1, y);
        Write(#186); //186   // вертикальная левая черта
      end;

      for y := 2 to vertical_line do
      begin
        gotoxy(horizontal_line_max2, y);
        Write(#186); //186   // вертикальная правая черта
      end;

      x := cell_width2;
      while x <= horizontal_line_max2 do
      begin
        for y := 2 to vertical_line do
        begin
          gotoxy(x, y);
          Write(#186); //186  // вертикальная черта ячейки
        end;
        x := x + cell_width2;
      end;

      y := 3;
      for x := 2 to number_intersections do
      begin
        gotoxy(1, y);
        Write(#204); //204  // Края ячеек
        y := y + cell_height;
      end;

      y := 3;
      for x := 2 to number_intersections do
      begin
        gotoxy(horizontal_line_max2, y);
        Write(#185); //185  // Края ячеек
        y := y + cell_height;
      end;

      gotoxy(horizontal_line_max2, 1);
      Write(#187); //187   // правый верхний край
      gotoxy(horizontal_line_max2, vertical_line_max);
      Write(#188); //188   //правый нижний угол

      x := cell_width2;
      y := 3;
      for Count := 2 to numbem_cell2 do
      begin
        gotoxy(x, y);
        Write(#206); //206   // перекрестие первой ячейки
        y := 3;
        x := x + cell_width2;
      end;

      x := cell_width2;
      for Count2 := 2 to numbem_cell2 do
      begin
        y := 3;
        for Count := 2 to number_intersections do
        begin
          gotoxy(x, y);
          Write(#206); //206   // перекрестие Первой ячейки
          y := y + cell_height;
        end;
        x := x + cell_width2;
      end;


end;
procedure ThirdFrameTable;
var
  Count, Count2, x, y: integer;
begin

  gotoxy(3, cell_height);
  Write('Фамилия');
  gotoxy(21, cell_height);
  Write('Имя');
  gotoxy(38, cell_height);
  Write('Отчество');
  gotoxy(57, cell_height);
  Write('Адрес');
  gotoxy(75, cell_height);
  Write('Номер полиса');
  gotoxy(93, cell_height);
  Write('Дата окончания');


  gotoxy(1, 1);
  Write(#201); //201    // левый верхний край
  gotoxy(1, vertical_line_max);
  Write(#200); //200    // левый нижний край


  y := 1;
  while y <= vertical_line_max do
  begin
    for x := 2 to horizontal_line_max do
    begin
      gotoxy(x, y);
      Write(#205); //205  // горизонтальная верхняя линия
    end;
    y := y + cell_height;
  end;

  x := cell_width;
  y := 1;
  for Count := 2 to numbem_cell do
  begin
    gotoxy(x, y);
    Write(#203); //203  // верхнее перекрестие ячейки
    x := x + cell_width;
  end;

  x := cell_width;
  y := vertical_line_max;
  for Count := 2 to numbem_cell do
  begin
    gotoxy(x, y);
    Write(#202); //202  // нижнее перекрестие ячейки
    x := x + cell_width;
  end;

  for y := 2 to vertical_line do
  begin
    gotoxy(1, y);
    Write(#186); //186   // вертикальная левая черта
  end;

  for y := 2 to vertical_line do
  begin
    gotoxy(horizontal_line_max, y);
    Write(#186); //186   // вертикальная правая черта
  end;

  x := cell_width;
  while x <= horizontal_line_max do
  begin
    for y := 2 to vertical_line do
    begin
      gotoxy(x, y);
      Write(#186); //186  // вертикальная черта ячейки
    end;
    x := x + cell_width;
  end;

  y := 3;
  for x := 2 to number_intersections do
  begin
    gotoxy(1, y);
    Write(#204); //204  // Края ячеек
    y := y + cell_height;
  end;

  y := 3;
  for x := 2 to number_intersections do
  begin
    gotoxy(horizontal_line_max, y);
    Write(#185); //185  // Края ячеек
    y := y + cell_height;
  end;

  gotoxy(horizontal_line_max, 1);
  Write(#187); //187   // правый верхний край
  gotoxy(horizontal_line_max, vertical_line_max);
  Write(#188); //188   //правый нижний угол

  x := cell_width;
  y := 3;
  for Count := 2 to numbem_cell do
  begin
    gotoxy(x, y);
    Write(#206); //206   // перекрестие первой ячейки
    y := 3;
    x := x + cell_width;
  end;

  x := cell_width;
  for Count2 := 2 to numbem_cell do
  begin
    y := 3;
    for Count := 2 to number_intersections do
    begin
      gotoxy(x, y);
      Write(#206); //206   // перекрестие Первой ячейки
      y := y + cell_height;
    end;
    x := x + cell_width;
  end;
end;

end.
