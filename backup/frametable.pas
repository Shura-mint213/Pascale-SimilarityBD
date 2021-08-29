unit FrameTable;

interface

uses crt;

const
  horizontal_line_max = 115;              //���ᨬ��쭠� ����� ��ਧ��⠫쭮� �����
  horizontal_line_max2 = 95;              ////���ᨬ��쭠� ����� ��ਧ��⠫쭮� ����� 2 ��
  horizontal_line_max3 = 115;              ////���ᨬ��쭠� ����� ��ਧ��⠫쭮� ����� 2 ��
  vertical_line_max = 25;                //���ᨨ���쭠� ���� ���⨪��쭮� �����
  horizontal_line = 99;                 //����� ��ਧ��⠫쭮� �����
  vertical_line = 24;                  //���� ���⨪��쭮� �����
  numbem_cell = 7;                    //������⢮ �⮫�殢 � ��४���ﬨ
  numbem_cell2 = 6;                  //������⢮ �⮫�殢 � ��४���ﬨ 2
  numbem_cell3 = 4;                 //������⢮ �⮫�殢 � ��४���ﬨ 3
  cell_width = 18;                 //����ﭨ� ����� ���⨪���. �����ﬨ
  cell_width2 = 18;               //����ﭨ� ����� ���⨪���. �����ﬨ 2
  cell_width3 = 30;              //����ﭨ� ����� ���⨪���. �����ﬨ 3
  cell_height = 2;              //����ﭨ� ����� ��ਧ���. ����ﬨ
  number_intersections = 12;   //������⢮ ����祭��  


procedure FirstFrameTable;
procedure SecondFrameTable;
procedure ThirdFrameTable;
implementation

procedure FirstFrameTable;
var
  Count, Count2, x, y: integer;
begin

  gotoxy(3, cell_height);
  Write('���');
  gotoxy(21, cell_height);
  Write('�६� ��砫�');
  gotoxy(38, cell_height);
  Write('�६� ����砭��');
  gotoxy(57, cell_height);
  Write('��� �ਥ��');
  gotoxy(75, cell_height);
  Write('��樥��');
  gotoxy(93, cell_height);
  Write('���');


    gotoxy(1, 1);
    Write(#201); //201    // ���� ���孨� �ࠩ
    gotoxy(1, vertical_line_max);
    Write(#200); //200    // ���� ������ �ࠩ


    y := 1;
    while y <= vertical_line_max do
    begin
      for x := 2 to horizontal_line_max do
      begin
        gotoxy(x, y);
        Write(#205); //205  // ��ਧ��⠫쭠� ������ �����
      end;
      y := y + cell_height;
    end;

    x := cell_width;
    y := 1;
    for Count := 2 to numbem_cell do
    begin
      gotoxy(x, y);
      Write(#203); //203  // ���孥� ��४��⨥ �祩��
      x := x + cell_width;
    end;

    x := cell_width;
    y := vertical_line_max;
    for Count := 2 to numbem_cell do
    begin
      gotoxy(x, y);
      Write(#202); //202  // ������ ��४��⨥ �祩��
      x := x + cell_width;
    end;

    for y := 2 to vertical_line do
    begin
      gotoxy(1, y);
      Write(#186); //186   // ���⨪��쭠� ����� ���
    end;

    for y := 2 to vertical_line do
    begin
      gotoxy(horizontal_line_max, y);
      Write(#186); //186   // ���⨪��쭠� �ࠢ�� ���
    end;

    x := cell_width;
    while x <= horizontal_line_max do
    begin
      for y := 2 to vertical_line do
      begin
        gotoxy(x, y);
        Write(#186); //186  // ���⨪��쭠� ��� �祩��
      end;
      x := x + cell_width;
    end;

    y := 3;
    for x := 2 to number_intersections do
    begin
      gotoxy(1, y);
      Write(#204); //204  // ��� �祥�
      y := y + cell_height;
    end;

    y := 3;
    for x := 2 to number_intersections do
    begin
      gotoxy(horizontal_line_max, y);
      Write(#185); //185  // ��� �祥�
      y := y + cell_height;
    end;

    gotoxy(horizontal_line_max, 1);
    Write(#187); //187   // �ࠢ� ���孨� �ࠩ
    gotoxy(horizontal_line_max, vertical_line_max);
    Write(#188); //188   //�ࠢ� ������ 㣮�

    x := cell_width;
    y := 3;
    for Count := 2 to numbem_cell do
    begin
      gotoxy(x, y);
      Write(#206); //206   // ��४��⨥ ��ࢮ� �祩��
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
        Write(#206); //206   // ��४��⨥ ��ࢮ� �祩��
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
    Write('�������');
    gotoxy(21, cell_height);
    Write('���');
    gotoxy(38, cell_height);
    Write('����⢮');
    gotoxy(57, cell_height);
    Write('���樠�쭮���');
    gotoxy(75, cell_height);
    Write('����� �������');


      gotoxy(1, 1);
      Write(#201); //201    // ���� ���孨� �ࠩ
      gotoxy(1, vertical_line_max);
      Write(#200); //200    // ���� ������ �ࠩ


      y := 1;
      while y <= vertical_line_max do
      begin
        for x := 2 to horizontal_line_max2 do
        begin
          gotoxy(x, y);
          Write(#205); //205  // ��ਧ��⠫쭠� ������ �����
        end;
        y := y + cell_height;
      end;

      x := cell_width2;
      y := 1;
      for Count := 2 to numbem_cell2 do
      begin
        gotoxy(x, y);
        Write(#203); //203  // ���孥� ��४��⨥ �祩��
        x := x + cell_width2;
      end;

      x := cell_width2;
      y := horizontal_line_max2;
      for Count := 2 to numbem_cell2 do
      begin
        gotoxy(x, y);
        Write(#202); //202  // ������ ��४��⨥ �祩��
        x := x + cell_width2;
      end;

      for y := 2 to vertical_line do
      begin
        gotoxy(1, y);
        Write(#186); //186   // ���⨪��쭠� ����� ���
      end;

      for y := 2 to vertical_line do
      begin
        gotoxy(horizontal_line_max2, y);
        Write(#186); //186   // ���⨪��쭠� �ࠢ�� ���
      end;

      x := cell_width2;
      while x <= horizontal_line_max2 do
      begin
        for y := 2 to vertical_line do
        begin
          gotoxy(x, y);
          Write(#186); //186  // ���⨪��쭠� ��� �祩��
        end;
        x := x + cell_width2;
      end;

      y := 3;
      for x := 2 to number_intersections do
      begin
        gotoxy(1, y);
        Write(#204); //204  // ��� �祥�
        y := y + cell_height;
      end;

      y := 3;
      for x := 2 to number_intersections do
      begin
        gotoxy(horizontal_line_max2, y);
        Write(#185); //185  // ��� �祥�
        y := y + cell_height;
      end;

      gotoxy(horizontal_line_max2, 1);
      Write(#187); //187   // �ࠢ� ���孨� �ࠩ
      gotoxy(horizontal_line_max2, vertical_line_max);
      Write(#188); //188   //�ࠢ� ������ 㣮�

      x := cell_width2;
      y := 3;
      for Count := 2 to numbem_cell2 do
      begin
        gotoxy(x, y);
        Write(#206); //206   // ��४��⨥ ��ࢮ� �祩��
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
          Write(#206); //206   // ��४��⨥ ��ࢮ� �祩��
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
  Write('�������');
  gotoxy(21, cell_height);
  Write('���');
  gotoxy(38, cell_height);
  Write('����⢮');
  gotoxy(57, cell_height);
  Write('����');
  gotoxy(75, cell_height);
  Write('����� �����');
  gotoxy(93, cell_height);
  Write('��� ����砭��');


  gotoxy(1, 1);
  Write(#201); //201    // ���� ���孨� �ࠩ
  gotoxy(1, vertical_line_max);
  Write(#200); //200    // ���� ������ �ࠩ


  y := 1;
  while y <= vertical_line_max do
  begin
    for x := 2 to horizontal_line_max do
    begin
      gotoxy(x, y);
      Write(#205); //205  // ��ਧ��⠫쭠� ������ �����
    end;
    y := y + cell_height;
  end;

  x := cell_width;
  y := 1;
  for Count := 2 to numbem_cell do
  begin
    gotoxy(x, y);
    Write(#203); //203  // ���孥� ��४��⨥ �祩��
    x := x + cell_width;
  end;

  x := cell_width;
  y := vertical_line_max;
  for Count := 2 to numbem_cell do
  begin
    gotoxy(x, y);
    Write(#202); //202  // ������ ��४��⨥ �祩��
    x := x + cell_width;
  end;

  for y := 2 to vertical_line do
  begin
    gotoxy(1, y);
    Write(#186); //186   // ���⨪��쭠� ����� ���
  end;

  for y := 2 to vertical_line do
  begin
    gotoxy(horizontal_line_max, y);
    Write(#186); //186   // ���⨪��쭠� �ࠢ�� ���
  end;

  x := cell_width;
  while x <= horizontal_line_max do
  begin
    for y := 2 to vertical_line do
    begin
      gotoxy(x, y);
      Write(#186); //186  // ���⨪��쭠� ��� �祩��
    end;
    x := x + cell_width;
  end;

  y := 3;
  for x := 2 to number_intersections do
  begin
    gotoxy(1, y);
    Write(#204); //204  // ��� �祥�
    y := y + cell_height;
  end;

  y := 3;
  for x := 2 to number_intersections do
  begin
    gotoxy(horizontal_line_max, y);
    Write(#185); //185  // ��� �祥�
    y := y + cell_height;
  end;

  gotoxy(horizontal_line_max, 1);
  Write(#187); //187   // �ࠢ� ���孨� �ࠩ
  gotoxy(horizontal_line_max, vertical_line_max);
  Write(#188); //188   //�ࠢ� ������ 㣮�

  x := cell_width;
  y := 3;
  for Count := 2 to numbem_cell do
  begin
    gotoxy(x, y);
    Write(#206); //206   // ��४��⨥ ��ࢮ� �祩��
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
      Write(#206); //206   // ��४��⨥ ��ࢮ� �祩��
      y := y + cell_height;
    end;
    x := x + cell_width;
  end;
end;

end.
