program project1;

uses
  Crt,
  FrameTable,
  loading;

const
  ColorUnselected_item = $7;//���� ���뤥������ �㭪�
  ColorSelected_item = $91;//���� �뤥������� �㭪�
  TableColorUnselected_item = $7;
  //���� ���뤥������ �㭪� ⠡����
  TableColorSelected_item = $7;
  //���� �뤥������ �㭪� ⠡����
  MaxItemMenu = 9;//���-�� ����⮢ � �᭮���� ����
  MaxSortItem = 6;//���-�� ����⮢ � ���� ���஢��
  nmax = 99;//���ᨬ��쭮� ���-�� ������(ࠧ��� ���ᨢ�)
  floorMax = 10000;
  //���ᨬ��쭮� ���-�� ������(ࠧ��� ���ᨢ�)
  markMax = 5; //���ᨬ��쭠� �業��
  lvlMax = 3;//���ᨬ���� �஢��� �������
  variantmax = 40; //���ᨬ���� ��ਠ��
  practanMax = 6;//���ᨬ���� ����� �ࠪ��᪮�
  timefinishMax = 8;//���ᨬ��쭮� �६� �� �������
  dayMax = 31;//���ᨬ� ����
  yearMin = 1998;//������ �����⨬��� ����
  yearMax = 2020;//���ᨬ� �����⨬��� ����
  monthmax = 12;//���ᨬ� �����⨬��� �����
  homeX = 2;//��砫쭠� X �窠 � ���� ⠡���
  homeY = 4;//��砫쭠� Y �窠 � ���� ⠡���
  stringmax = 11;//���ᨬ��쭮� �᫮ ��ப
  RowsMax3 = 6;//���ᨬ��쭮� �᫮ ��ப 2
  RowsMax2 = 5;//���ᨬ��쭮� �᫮ ��ப 2
  RowsMax = 6;//���ᨬ��쭮� �᫮ �⮫��
  pagenumbermax = 9;//���ᨬ��쭮� �᫮ ��࠭��
  February = 2;//����� ���ࠫ� � ����
  April = 4; //����� ��५� � ����
  June = 6;//����� ��� � ����
  September = 9;//����� ������� � ����
  November = 11;//����� ����� � ����
  FebruaryMax = 29;//������⢮ ���� � ��᮪�᭮� 䥢ࠫ�
  FebruaryMin = 28;//������⢮ ���� � �� ��᮪�᭮� 䥢ࠫ�
  one = 1;//���� 1
  fortyeight = 48;
  fiftyseven = 57;
  twentyseven = 27;
  twentyeight = 28;
type
  message_string = string

    [255];
type
  mystring = string

    [15];
type
  myStringFIO = string

    [25];
type
  myLongString = string

    [100];

type
  date_type = record
    day: 1..dayMax;
    month: 1..monthmax;
    year: integer;
  end;

type
  time_type = record
    hour: 7..20;
    minute: 0..59;
  end;

type
  appointments = record
    d: date_type;
    timestart: time_type;
    timefinish: time_type;
    typeapp: mystring;
    fiodoc: mystring;
    fiopat: mystring;
  end;

type
  doctorType = record
    Name: myStringFIO;
    surname: myStringFIO;
    patronymic: myStringFIO;
    specialty: myLongString;
    nemberCabinet: integer;
  end;

type
  patientType = record
    Name: myStringFIO;
    surname: myStringFIO;
    patronymic: myStringFIO;
    addres: myLongString;
    numberPolis: integer;
    dateFinishPolis: time_type;
  end;

  type
    allElementType = record
      elementAppointments:appointments;
      elemtntDoctor:doctorType;
      elementPatient:patientType;
    end;

type                              // i need to finish it
  appointmentArr = array [1..nmax] of appointments;
type
  doctorTypeArr = array [1..nmax] of doctorType;
type
  patientTypeArr = array [1..nmax] of patientType;
type
  allArray = record
    arrElementAppointment:appointmentArr;
    arrElementDoctor:doctorTypeArr;
    arrElemtntPatient:patientTypeArr;
  end;

type
  addDoctorData = object Name: string

  end;

  //Procedure addName();       //���������� ������ �� 2 ⠡���
  //begin

  //end;
var
  menu: array[1..MaxItemMenu] of string;//�������� �㭪⮢ ����}
  SortArray: array[1..MaxSortItem] of string;
  item, SortItem: integer;//����� �뤥������� �㭪�
  Key, Enter: char;//�������� ᨬ���
  x, y: integer;//���न���� ��ࢮ� ��ப� ����
  p: appointments;
  p2: doctorType;
  p3: patientType;
  a: appointmentArr;
  a2: doctorTypeArr;
  a3: patientTypeArr;

  number, pagenumber, itemPage, itemPageMax: integer;
var
  StringNumber, RowsNumber: integer;
var
  f: file of appointments;

  procedure RKEnter(var Enter: char);//����ணࠬ�� ������ Enter
  begin
    writeln('������ "Enter" ��� �த�������.');
    repeat
      Enter := readkey;
      if Enter = #13 then
        //(#10'�� ������ �� "Enter". ���஡�� ��� ࠧ.'#10);
    until (Enter = #13);//13 - Enter
  end;

  //�஢�ન

  function CheckNumber(CountMax: integer): integer;
    //�㭪�� ��� �஢�ન ����� ������⢠ ����⮢  �१ readkey
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    Number, symbol: integer;
    key: char;
    s_Number: string;
    error: boolean;
  begin
    s_Number := '';
    symbol := 0;
    Number := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= fortyeight) and (Ord(key) <= fiftyseven)) and
        (symbol < CountMax) then
      begin
        s_Number := s_Number + key;
        symbol := symbol + one;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= 1) then
      begin
        Delete(s_Number, length(s_Number), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_Number = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_Number, Number, symbol);
    checkNumber := Number;
  end;

  procedure TestNumber(var Number: integer; var CountMax: integer;
    message: message_string);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� �����
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write(message);
      Number := CheckNumber(CountMax);
      gotoxy(one, twentyeight);
      clreol;
      gotoxy(one, twentyseven);
      clreol;
      if (Number < one) or (Number > 9999999) then
      begin
        gotoxy(one, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
  end;

  function checkfiodoc: mystring;
    //�㭪�� ��� �஢�ન ����� ��� �१ readkey, ���
    //symbol - ���稪
    //s_DescriptionMark - ���� �᫠ ��� �஢�ન
    //key - ������

  var
    symbol: integer;
    key: char;
    FioDoc: mystring;
    error: boolean;
  begin
    FioDoc := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if key = #0 then
      begin
        key := readkey;
        error := True;
      end
      else
      if (((Ord(key) >= 65) and (Ord(key) <= 90)) or
        ((Ord(key) >= 97) and (Ord(key) <= 122)) or
        ((Ord(key) >= 128) and (Ord(key) <= 175)) or
        ((Ord(key) >= 224) and (Ord(key) <= 241))) and (symbol < 20) then
      begin
        FioDoc := FioDoc + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(FioDoc, length(FioDoc), one);
        //DescriptionMark-��ப� �� ����� 㤠���� ᨬ����,
        //length - ����� ᨬ����, � ���ண� 㤠����,
        //1 - ���-�� ᨬ�����
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if FioDoc = '' then
        error := True;
    until (key = #13) and (not error);
    checkfiodoc := FioDoc;
  end;

  procedure Testfiodoc(var FioDoc: mystring; message: message_string);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �����
  //i,j - ���稪�
  //error - ����稥 �訡��
  //message - ��ப� �� �뢮� ᮮ�饭��
  var
    error: boolean;
  begin
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      Write(message);
      FioDoc := Checkfiodoc;
      gotoxy(one, twentyseven);
      clreol;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checkfiopat: mystring;
    //�㭪�� ��� �஢�ન ����� 䠬���� �१ readkey
    //symbol - ���稪
    //s_DescriptionMark - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    symbol: integer;
    key, key2: char;
    fiopat: mystring;
    error: boolean;
  begin
    fiopat := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if key = #0 then
      begin
        key2 := readkey;
        error := True;
      end
      else
      if (((Ord(key) >= 65) and (Ord(key) <= 90)) or
        ((Ord(key) >= 97) and (Ord(key) <= 122)) or
        ((Ord(key) >= 128) and (Ord(key) <= 175)) or
        ((Ord(key) >= 224) and (Ord(key) <= 241))) and (symbol < 20) then
      begin
        fiopat := fiopat + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(fiopat, length(fiopat), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if fiopat = '' then
        error := True;
      if fiopat[1] = #32 then
        error := True;
    until (key = #13) and (not error);
    Checkfiopat := fiopat;
  end;

  procedure Testfiopat(var fiopat: mystring; message: message_string);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� 䠬����
  //i,j - ���稪�
  //error - ����稥 �訡��
  //message - ��ப� �� �뢮�}
  var
    error: boolean;
  begin
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      Write(message);
      fiopat := Checkfiopat;
      gotoxy(one, twentyseven);
      clreol;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;


     //case Key of
     //     chr(80):
  function Checktypeapp: mystring;
    //�㭪�� ��� �஢�ન ����� ⨯� �ਥ�� �१ readkey
    //symbol - ���稪
    //s_DescriptionMark - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    symbol: integer;
    key, key2: char;
    typeapp: mystring;
    error: boolean;
  begin
    typeapp := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if key = #0 then
      begin
        key2 := readkey;
        error := True;
      end
      else
      if (((Ord(key) >= 65) and (Ord(key) <= 90)) or
        ((Ord(key) >= 97) and (Ord(key) <= 122)) or
        ((Ord(key) >= 128) and (Ord(key) <= 175)) or
        ((Ord(key) >= 224) and (Ord(key) <= 241))) and (symbol < 20) then
      begin
        typeapp := typeapp + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(typeapp, length(typeapp), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if typeapp = '' then
        error := True;
      if typeapp[1] = #32 then
        error := True;
    until (key = #13) and (not error);
    Checktypeapp := typeapp;
  end;

  function CheckFIO: myStringFIO;
    //�㭪�� ��� �஢�ન ����� ⨯� �ਥ�� �१ readkey
    //symbol - ���稪
    //s_DescriptionMark - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    symbol: integer;
    key, key2: char;
    typeapp: myStringFIO;
    error: boolean;
  begin
    typeapp := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if key = #0 then
      begin
        key2 := readkey;
        error := True;
      end
      else
      if (((Ord(key) >= 65) and (Ord(key) <= 90)) or
        ((Ord(key) >= 97) and (Ord(key) <= 122)) or
        ((Ord(key) >= 128) and (Ord(key) <= 175)) or
        ((Ord(key) >= 224) and (Ord(key) <= 241))) and (symbol < 20) then
      begin
        typeapp := typeapp + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(typeapp, length(typeapp), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if typeapp = '' then
        error := True;
      if typeapp[1] = #32 then
        error := True;
    until (key = #13) and (not error);
    CheckFIO := typeapp;
  end;

  function CheckSpecialty: myLongString;
    //�㭪�� ��� �஢�ન ����� ⨯� �ਥ�� �१ readkey
    //symbol - ���稪
    //s_DescriptionMark - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    Count: integer;
    symbol: integer;
    key, key2: char;
    typeapp: myStringFIO;
    error: boolean;
  begin
    Count := 0;
    typeapp := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if key = #0 then
      begin
        key2 := readkey;
        error := True;
      end
      else
      if (((Ord(key) >= 65) and (Ord(key) <= 90)) or
        ((Ord(key) >= 97) and (Ord(key) <= 122)) or
        ((Ord(key) >= 128) and (Ord(key) <= 175)) or
        ((Ord(key) >= 224) and (Ord(key) <= 241)) or (Ord(key) = 32)) and
        (symbol < 100) then
      begin
        typeapp := typeapp + key;
        symbol := symbol + one;
        Count := Count + 1;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if ((Ord(key) = 32) and (Count < 3)) then
      begin
        typeapp := typeapp + key;
        symbol := symbol + one;
        Count := Count + 1;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(typeapp, length(typeapp), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if typeapp = '' then
        error := True;
      if typeapp[1] = #32 then
        error := True;
    until (key = #13) and (not error);
    CheckSpecialty := typeapp;
  end;


procedure TestFIODoctor(var typeapp: mystring; message: message_string);
 //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� 䠬����
 //i,j - ���稪�
 //error - ����稥 �訡��
 //message - ��ப� �� �뢮�}
 var
   error: boolean;
 begin
   repeat
     TextBackground(0);
     TextColor(7);
     error := False;
     gotoxy(one, twentyseven);
     Write(message);
     typeapp := Checktypeapp;
     gotoxy(one, twentyseven);
     clreol;
   until (not error);
   gotoxy(one, twentyeight);
   clreol;
 end;

procedure TestFIOThtid(var typeapp: mystring; count: integer;
   var p3: patientType; var a3: patientTypeArr);
 //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� 䠬����
 //i,j - ���稪�
 //error - ����稥 �訡��
 //message - ��ப� �� �뢮�}
 var
   error: boolean;
 begin
     typeapp := a3[count].surname + ' ' + a3[count].Name+ ' '
     + a3[count].patronymic;
   gotoxy(one, twentyeight);
   clreol;
 end;
   procedure TestFIOThrid(var typeapp: mystring; count: integer;
    var p2: patientType; var a2: patientTypeArr);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� 䠬����
  //i,j - ���稪�
  //error - ����稥 �訡��
  //message - ��ப� �� �뢮�}
  begin
      typeapp := a2[count].surname + ' ' + a2[count].Name+ ' '
      + a2[count].patronymic;
    gotoxy(one, twentyeight);
    clreol;
  end;
  procedure TestFIOSecond(var typeapp: mystring; count: integer;
    var p3: doctorType; var a3: doctorTypeArr);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� 䠬����
  //i,j - ���稪�
  //error - ����稥 �訡��
  //message - ��ப� �� �뢮�}
  begin
      typeapp := a3[count].surname + ' ' + a3[count].Name+ ' '
      + a3[count].patronymic;
    gotoxy(one, twentyeight);
    clreol;
  end;

procedure Testtypeapp(var typeapp: mystring; message: message_string);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� 䠬����
  //i,j - ���稪�
  //error - ����稥 �訡��
  //message - ��ப� �� �뢮�}
  var
    error: boolean;
  begin
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      Write(message);
      typeapp := Checktypeapp;
      gotoxy(one, twentyseven);
      clreol;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  procedure TestFIO(var typeapp: myStringFIO; message: message_string);
  //��楤�� �஢���� �ࠢ��쭮��� ����� 䠬���� ����� ����⢠
  //i,j - ���稪�
  //error - ����稥 �訡��
  //message - ��ப� �� �뢮�}
  var
    error: boolean;
  begin
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      Write(message);
      typeapp := CheckFIO;
      gotoxy(one, twentyseven);
      clreol;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  procedure TestSpecialty(var typeapp: myLongString; message: message_string);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� ᯥ樠�쭮��
  //i,j - ���稪�
  //error - ����稥 �訡��
  //message - ��ப� �� �뢮�}
  var
    error: boolean;
  begin
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      Write(message);
      typeapp := CheckSpecialty;
      gotoxy(one, twentyseven);
      clreol;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checkvariant: integer;
    //�㭪�� ��� �஢�ન ����� ��ਠ�� �१ readkey, ���
    //symbol - ���稪
    // s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    variant, symbol: integer;
    key: char;
    s_variant: string;
    error: boolean;
  begin
    s_variant := '';
    symbol := 0;
    variant := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 3) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_variant := s_variant + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_variant, length(s_variant), 1);
        //s_variant-��ப� �� ����� 㤠���� ᨬ����,
        //length - ����� ᨬ����,� ���ண� 㤠����,
        //1 - ���-�� ᨬ�����
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_variant = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_variant, variant, symbol);
    Checkvariant := variant;
  end;

  procedure testvariant(var variant: integer);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �業�� ��㤥�⮢
  //s_age - ���� �᫠ ��� �஢�ન
  //age - ������
  //code - ��६����� ��� ����
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('������ ��ਠ��(����.', variantmax, '):');
      variant := Checkvariant;
      gotoxy(one, twentyseven);
      clreol;
      if (variant < 0) or (variant > variantMax) then
      begin
        gotoxy(1, twentyeight);
        Write('�� ����� �����४�� ��ਠ��. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checkpractan: integer;
    //�㭪�� ��� �஢�ન ����� ��ਠ�� �१ readkey, ���
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������

  var
    practan, symbol: integer;
    key: char;
    s_practan: string;
    error: boolean;
  begin
    s_practan := '';
    symbol := 0;
    practan := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 3) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_practan := s_practan + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_practan, length(s_practan), 1);
        //s_variant-��ப� �� ����� 㤠���� ᨬ����,
        //length - ����� ᨬ����, � ���ண� 㤠����,
        //1 - ���-�� ᨬ�����
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_practan = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_practan, practan, symbol);
    checkpractan := practan;
  end;

  procedure testpractan(var practan: integer);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �業�� ��㤥�⮢
  //s_practan - ���� �᫠ ��� �஢�ન
  //practan - ����� �ࠪ��᪮�
  //code - ��६����� ��� �����
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('������ ����� �ࠪ��᪮� ࠡ��� (����.',
        practanmax, '): ');
      practan := Checkpractan;
      gotoxy(one, twentyseven);
      clreol;
      if (practan < 0) or (practan > practanMax) then
      begin
        gotoxy(one, twentyeight);
        Write(
          '�� ����� �����४�� ����� �ࠪ��᪮� ࠡ���. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checkpractansecond: integer;
    //�㭪�� ��� �஢�ન ����� ��ਠ�� �१ readkey, ���
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    practansecond, symbol: integer;
    key: char;
    s_practansecond: string;
    error: boolean;
  begin
    s_practansecond := '';
    symbol := 0;
    practansecond := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 3) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_practansecond := s_practansecond + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_practansecond, length(s_practansecond), 1);
        //s_variant-��ப� �� ����� 㤠���� ᨬ����,
        //length - ����� ᨬ����, � ���ண� 㤠����,
        //1 - ���-�� ᨬ�����
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_practansecond = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_practansecond, practansecond, symbol);
    checkpractansecond := practansecond;
  end;

  procedure testpractansecond(var practansecond: integer);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �業�� ��㤥�⮢
  //s_practan - ���� �᫠ ��� �஢�ન
  //practansecond - ����� �ࠪ��᪮�
  //code - ��६����� ��� ����
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('������ �ࠪ����� ࠡ��� (����.',
        practanmax, '): ');
      practansecond := Checkpractansecond;
      gotoxy(one, twentyseven);
      clreol;
      if (practansecond < 0) or (practansecond > practanMax) then
      begin
        gotoxy(one, twentyeight);
        Write(
          '�� ����� �����४��� �ࠪ��᪮� ࠡ���. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checktimefinish: integer;
    //�㭪�� ��� �஢�ન ����� ��ਠ�� �१ readkey, ���
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    timefinish, symbol: integer;
    key: char;
    s_timefinish: string;
    error: boolean;
  begin
    s_timefinish := '';
    symbol := 0;
    timefinish := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 3) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_timefinish := s_timefinish + key;
        symbol := symbol + one;
        if error = False then
        begin
          Write(key);
        end;
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_timefinish, length(s_timefinish), one);
        //s_variant-��ப� �� ����� 㤠���� ᨬ����,
        //length - ����� ᨬ����, � ���ண� 㤠����,
        //1 - ���-�� ᨬ�����
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_timefinish = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_timefinish, timefinish, symbol);
    checktimefinish := timefinish;
  end;

  procedure testtimefinish(var timefinish: integer);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �業�� ��㤥�⮢
  //s_practan - ���� �᫠ ��� �஢�ન
  //practan - ����� �ࠪ��᪮�
  //code - ��६����� ��� ����
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('������ �६� �� �ࠪ����� ࠡ��� (����.', timefinishmax, '): ');
      timefinish := Checktimefinish;
      gotoxy(1, twentyseven);
      clreol;
      if (timefinish < 0) or (timefinish > timefinishMax) then
      begin
        gotoxy(1, twentyeight);
        Write('�� ����� �����४⭮� �६� �� �믮������. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checklvl: integer;
    //�㭪�� ��� �஢�ન ����� �஢�� �१ readkey
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    // key - ������}
  var
    lvl, symbol: integer;
    key: char;
    s_lvl: string;
    error: boolean;
  begin
    s_lvl := '';
    symbol := 0;
    lvl := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= fortyeight) and (Ord(key) <= fiftyseven)) and (symbol < 8) then
      begin
        s_lvl := s_lvl + key;
        symbol := symbol + 1;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_lvl, length(s_lvl), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_lvl = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_lvl, lvl, symbol);
    checklvl := lvl;
  end;

  procedure Testlvl(var lvl: longint);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �஢��
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('������ �஢��� �ࠪ��᪮� (����.',
        lvlmax, '): ');
      lvl := Checklvl;
      gotoxy(one, twentyeight);
      clreol;
      gotoxy(one, twentyseven);
      clreol;
      if (lvl < one) or (lvl > lvlMax) then
      begin
        gotoxy(1, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
  end;

  function Checkmark: integer;
    //�㭪�� ��� �஢�ન ����� �業�� readkey
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    mark, symbol: integer;
    key: char;
    s_mark: string;
    error: boolean;
  begin
    s_mark := '';
    symbol := 0;
    mark := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= fortyeight) and (Ord(key) <= fiftyseven)) and (symbol < 4) then
      begin
        s_mark := s_mark + key;
        symbol := symbol + 1;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_mark, length(s_mark), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_mark = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_mark, mark, symbol);
    checkmark := mark;
  end;

  procedure testmark(var mark: integer);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �業��
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('������ �業�� 1-5 (����.', markmax, '): ');
      mark := Checkmark;
      gotoxy(1, twentyeight);
      clreol;
      gotoxy(1, twentyseven);
      clreol;
      if (mark < one) or (mark > markMax) then
      begin
        gotoxy(1, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
  end;

  function Checkmarksecond: integer;
    //�㭪�� ��� �஢�ન ����� �業�� readkey
    //symbol - ���稪
    // s_key - ���� �᫠ ��� �஢�ન
    // key - ������
  var
    marksecond, symbol: integer;
    key: char;
    s_marksecond: string;
    error: boolean;
  begin
    s_marksecond := '';
    symbol := 0;
    marksecond := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= fortyeight) and (Ord(key) <= fiftyseven)) and (symbol < 4) then
      begin
        s_marksecond := s_marksecond + key;
        symbol := symbol + 1;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_marksecond, length(s_marksecond), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_marksecond = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_marksecond, marksecond, symbol);
    checkmarksecond := marksecond;
  end;

  procedure testmarksecond(var marksecond: integer);
  //����ணࠬ�� �஢���� �ࠢ��쭮��� ����� �業��
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('������ ����� �業�� 1-5 (����.', markmax, '): ');
      marksecond := Checkmarksecond;
      gotoxy(1, twentyeight);
      clreol;
      gotoxy(1, twentyseven);
      clreol;
      if (marksecond < one) or (marksecond > markMax) then
      begin
        gotoxy(1, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
  end;


  //����
  function CheckDay: integer;
    //�㭪�� ��� �஢�ન ����� ��� �१ readkey
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    d: date_type;
    symbol: integer;
    key: char;
    s_Day: string;
    error: boolean;
  begin
    s_Day := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 2) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_Day := s_Day + key;
        symbol := symbol + 1;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_Day, length(s_Day), 1);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_Day = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_Day, d.Day, symbol);
    checkDay := d.Day;
  end;

  function CheckMonth: integer;
    //�㭪�� ��� �஢�ન ����� ����� �१ readkey
    //symbol - ���稪
    // s_key - ���� �᫠ ��� �஢�ન
    // key - ������
  var
    d: date_type;
    symbol: integer;
    key: char;
    s_Month: string;
    error: boolean;
  begin
    s_Month := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 2) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_Month := s_Month + key;
        symbol := symbol + one;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_Month, length(s_Month), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_Month = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_Month, d.Month, symbol);
    checkMonth := d.Month;
  end;

  function CheckYear: integer;
    //�㭪�� ��� �஢�ન ����� ���� �१ readkey}
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    d: date_type;
    symbol: integer;
    key: char;
    s_Year: string;
    error: boolean;
  begin
    s_Year := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 4) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_Year := s_Year + key;
        symbol := symbol + one;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= 1) then
      begin
        Delete(s_Year, length(s_Year), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_Year = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_Year, d.Year, symbol);
    checkYear := d.Year;
  end;

  procedure CheckDate(var d: date_type);
  //����ணࠬ�� �஢���� ����
  //month - �����
  //day - ����
  //year - ���
  //s_d - ���� �᫠ ��� �஢�ન
  //code - ��६����� ��� �����
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('������ ����: ');
      d.Day := CheckDay;
      gotoxy(one, twentyseven);
      clreol;
      if not (d.day in [one..31]) then
        error := True;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('������ �����: ');
      d.Month := checkMonth;
      gotoxy(one, twentyseven);
      clreol;
      if (d.month > monthmax) then
      begin
        gotoxy(one, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('������ ���: ');
      d.Year := checkYear;
      gotoxy(one, twentyseven);
      clreol;
      if (d.year < yearMin) or (d.year > yearMax) then
      begin
        gotoxy(one, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);
  end;

  procedure TestDate(var d: date_type);
  //����ணࠬ�� �஢���� ���� �� �ࠢ��쭮��� ����ᠭ��
  var
    error: boolean;
  begin
    repeat
      error := False;
      CheckDate(d);
      if ((d.month in [April, June, September, November]) and (d.day = dayMax)) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          '�� �����४⭮ ����� ���� � ���⪮� �����. ���஡�� ᭮��.'#10#13);
        error := True;
      end
      else
      if ((d.month = February) and (d.year > yearMin) and (d.year mod 4 = 0) and
        (d.day > FebruaryMax)) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          '�� �����४⭮ ����� ���� ��᮪�᭮�� ����. ���஡�� ᭮��.'#10#13);
        error := True;
      end
      else
      if ((d.month = February) and ((d.year = yearMin) or (d.year mod 4 <> 0)) and
        (d.day > FebruaryMin)) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          '�� �����४⭮ ����� ���� �� ��᮪�᭮�� ����. ���஡�� ᭮��.'#10#13);
        error := True;
      end;
    until (not error);
    gotoxy(1, twentyeight);
    clreol;
  end;

  //�����
  function CheckHour: integer;
    //�㭪�� ��� �஢�ન ����� �� �१ readkey
    //symbol - ���稪
    //s_key - ���� �᫠ ��� �஢�ન
    //key - ������
  var
    t: time_type;
    symbol: integer;
    key: char;
    s_Hour: string;
    error: boolean;
  begin
    s_Hour := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 2) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_Hour := s_Hour + key;
        symbol := symbol + 1;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_Hour, length(s_Hour), 1);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_Hour = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_Hour, t.Hour, symbol);
    checkHour := t.Hour;
  end;

  function CheckMinute: integer;
    //�㭪�� ��� �஢�ન ����� ����� �१ readkey
    //symbol - ���稪
    // s_key - ���� �᫠ ��� �஢�ન
    // key - ������
  var
    t: time_type;
    symbol: integer;
    key: char;
    s_Minute: string;
    error: boolean;
  begin
    s_Minute := '';
    symbol := 0;
    repeat
      error := False;
      key := readkey;
      if ((Ord(key) >= 47) and (Ord(key) <= 58)) and (symbol < 2) then
      begin
        if ((Ord(key)) = 72) or ((Ord(key)) = 77) or ((Ord(key)) = 80) or
          ((Ord(key)) = 75) then
          error := True
        else
          s_Minute := s_Minute + key;
        symbol := symbol + one;
        if error = False then
          Write(key);
      end;
      if (key = #8) and (symbol >= one) then
      begin
        Delete(s_Minute, length(s_Minute), one);
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if s_Minute = '' then
        error := True;
    until (key = #13) and (not error);
    Val(s_Minute, t.Minute, symbol);
    checkMinute := t.Minute;
  end;

  procedure CheckTime(var t: time_type);
  //����ணࠬ�� �஢���� �६�
  //hour - ���
  //minute - ������
  //s_d - ���� �᫠ ��� �஢�ન
  //code - ��६����� ��� �����
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('������ ��: ');
      t.Hour := CheckHour;
      gotoxy(one, twentyseven);
      clreol;
      if not (t.hour in [0..23]) then
      begin
        gotoxy(one, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;

    until (not error);
    gotoxy(one, twentyeight);
    clreol;
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('������ ������: ');
      t.Minute := checkMinute;
      gotoxy(one, twentyseven);
      clreol;
      if (t.minute > 59) then
      begin
        gotoxy(one, twentyeight);
        Write('�� ����� �����४⭮� �᫮. ���஡�� ᭮��.');
        error := True;
      end;
    until (not error);

  end;

  procedure TestTime(var t: time_type);
  //����ணࠬ�� �஢���� ���� �६� �� �ࠢ��쭮��� ����ᠭ��
  var
    error: boolean;
  begin
    repeat
      error := False;
      CheckTime(t);
      if (not (t.minute in [0..59])) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          '�� �����४⭮ ����� ������. ���஡�� ᭮��.'#10#13);
        error := True;
      end
      else
      if (not (t.hour in [0..23])) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          '�� �����४⭮ ����� ���. ���஡�� ᭮��.'#10#13);
        error := True;
      end;

    until (not error);
    gotoxy(1, twentyeight);
    clreol;
  end;

  //����஢��
{
  procedure SortlastName(var a: appointmentArr);
 //����ணࠬ�� ���஢�� ���ᨢ� �� ��䠢��� �� ��������
 //i,j - ���稪�
 //a - ���ᨢ ⮢�஢
  var
    i, j: integer;
  begin
    for i := 1 to nmax do
      for j := 1 to nmax - i do
        with a[i] do
          if a[j].lastname < a[j + 1].lastname then
          begin
            P := a[j];
            a[j] := a[j + 1];
            a[j + 1] := P;
          end;
  end;

  procedure SortFirstName(var a: appointmentArr);
  //����ணࠬ�� ���஢�� ���ᨢ� �� ��䠢���, ���
  //  i,j - ���稪�
  //  a - ���ᨢ ��㤥�⮢
  var
    i, j: integer;
  begin
    for i := 1 to nmax do
      for j := 1 to nmax - i do
        with a[i] do
        begin
          if a[j].firstname > a[j + one].firstname then
          begin
            p := a[j];
            a[j] := a[j + one];
            a[j + one] := p;
          end;
        end;
  end;

  procedure Sortmark(var a: appointmentArr);
  //����ணࠬ�� ���஢�� ���ᨢ� �業��
  //i,j - ���稪�
  //  a - ���ᨢ ��㤥�⮢
  var
    i, j: integer;
  begin
    for i := one to nmax do
      for j := one to nmax - i do
        with a[i] do
          if a[j].mark < a[j + one].mark then
          begin
            p := a[j];
            a[j] := a[j + one];
            a[j + one] := p;
          end;
  end;

  procedure Sortlvl(var a: appointmentArr);
  //����ணࠬ�� ���஢�� ���ᨢ� �� �஢��
  //i,j - ���稪�
  //  a - ���ᨢ ��㤥�⮢
  var
    i, j: integer;
  begin
    for i := one to nmax do
      for j := one to nmax - i do
        with a[i] do
          if a[j].lvl < a[j + one].lvl then
          begin
            p := a[j];
            a[j] := a[j + one];
            a[j + one] := p;
          end;
  end;

  function CompareDate(a, b: appointments): boolean;
  //�㭪�� �ࠢ����� ���
  var
    flag: boolean;
  begin
    flag := False;
    if a.d.year < b.d.year then
      flag := True
    else if a.d.month < b.d.month then
      flag := True
    else if a.d.day < b.d.day then
      flag := True;
    CompareDate := flag;
  end;

  procedure SortDate(var a: appointmentArr);
  //����ணࠬ�� ���஢�� ���ᨢ� �� ���
  //i,j - ���稪�
  //  a - ���ᨢ ��㤥�⮢
  var
    i, j: integer;
  begin
    for i := one to nmax do
      for j := one to nmax - i do
        with a[i] do
          if CompareDate(a[j - one], a[j]) then
          begin
            p := a[j - one];
            a[j - one] := a[j];
            a[j] := p;
          end;
  end;

 }
  //⠡����

  procedure ViewFirstTable(var a: appointmentArr; var itemPage, itemPageMax: integer);
  //�뢮� १���⮢ � ����� ⠡����
  var
    i: integer;
  begin
    x := homeX;
    y := homeY;

    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        if (d.day <> 0) and (d.month <> 0) and (d.year <> 0) then
          //����� �祩��
          Write(d.day, '.', d.month, '.', d.year);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;
    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //if (t. <> 0) and (d.month <> 0) and (d.year <> 0) then   //����� �祩��
        Write(timestart.hour, ':', timestart.minute);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        Write(timefinish.hour, ':', timefinish.minute);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //if typeapp <> 0 then //����� �祩��
        Write(typeapp);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //����� �祩��
        Write(FioDoc);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;
    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //     if variant <> 0 then //����� �祩��
        Write(FioPat);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := 111;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      //���室 �� ᫥������ �祩�� ᭨��
    end;

    gotoxy(111, 2);
    Write('I');
  end;

procedure ViewSecondTableNotNull(var a2: doctorTypeArr; var itemPage, itemPageMax: integer);
 //�뢮� १���⮢ � ����� ⠡����
 var
   Count: integer;
   i: integer;
   newX: integer;
 begin
   Count := 0;
   x := homeX;
   y := homeY;
   newX := x;

   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (Name <> '') then  //����� �祩��
       begin
       Write(Name);
       y := y + cell_height;
       end
       //���室 �� ᫥������ �祩�� ᭨��
     end;
   end;

   x := x + cell_width;
   //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
   y := homeY;
   newX := x;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (surname <> '') then //����� �祩��
       begin
       Write(surname);

       gotoXY(x, y);
       y := y + cell_height;
       end;
       //���室 �� ᫥������ �祩�� ᭨��
     end;
   end;

   x := x + cell_width;
   //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
   y := homeY;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (patronymic <> '') then  //����� �祩��
       begin
       Write(patronymic);
       y := y + cell_height;
       end;
       //���室 �� ᫥������ �祩�� ᭨��
     end;
   end;
   x := x + cell_width;
   //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
   y := homeY;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (specialty <> '') then //����� �祩��
       begin
       Write(specialty);
       y := y + cell_height;
       end;
       //���室 �� ᫥������ �祩�� ᭨��
     end;
   end;
   x := x + cell_width;
   //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
   y := homeY;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (nemberCabinet <> 0) then //����� �祩��
       begin
       Write(nemberCabinet);
       y := y + cell_height;
       end;
       //���室 �� ᫥������ �祩�� ᭨��
     end;
   end;
   x := 91;
   y := 4;
   for i := itemPage to itemPageMax do
   begin
     gotoxy(x, y);
     with a2[i] do
     if (nemberCabinet <> 0) then //����� �祩��
     begin
     Write(i);
     y := y + cell_height;
     end;
     //���室 �� ᫥������ �祩�� ᭨��
   end;

   gotoxy(92, 2);
   Write('II');
 end;

  procedure ViewSecondTable(var a2: doctorTypeArr; var itemPage, itemPageMax: integer);
  //�뢮� १���⮢ � ����� ⠡����
  var
    Count: integer;
    i: integer;
    newX: integer;
  begin
    Count := 0;
    x := homeX;
    y := homeY;
    newX := x;

    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //����� �祩��
        Write(Name);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    newX := x;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //if typeapp <> 0 then //����� �祩��

        Write(surname);

        gotoXY(x, y);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //����� �祩��
        Write(patronymic);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;
    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //     if variant <> 0 then //����� �祩��
        Write(specialty);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;
    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //     if variant <> 0 then //����� �祩��
        Write(nemberCabinet);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;
    x := 91;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      //���室 �� ᫥������ �祩�� ᭨��
    end;

    gotoxy(92, 2);
    Write('II');
  end;

  procedure ViewThirdTableNotNull(var a3: patientTypeArr; var itemPage, itemPageMax: integer);
  //�뢮� १���⮢ � ����� ⠡����
  var
    i: integer;
  begin
    x := homeX;
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (Name <> '') then  //����� �祩��
        begin
        Write(Name);
        y := y + cell_height;
        end;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (surname <> '') then //����� �祩��
        begin
        Write(surname);
        y := y + cell_height;
        end
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (patronymic <> '') then  //����� �祩��
        begin
        Write(patronymic);
        y := y + cell_height;
        end;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (addres <> '') then  //����� �祩��
        begin
        Write(addres);
        y := y + cell_height;
        end;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (numberPolis <> 0) then  //����� �祩��
        begin
        Write(numberPolis);
        y := y + cell_height;
        end;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (numberPolis <> 0) then  //����� �祩��
        begin
        Write(dateFinishPolis.hour, ':', dateFinishPolis.minute);
        y := y + cell_height;
        end;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := 111;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      if (numberPolis <> 0) then  //����� �祩��
        begin
        gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      end;
      //���室 �� ᫥������ �祩�� ᭨��
    end;

    gotoxy(111, 2);
    Write('I');
  end;
  procedure ViewThirdTable(var a3: patientTypeArr; var itemPage, itemPageMax: integer);
  //�뢮� १���⮢ � ����� ⠡����
  var
    i: integer;
  begin
    x := homeX;
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //����� �祩��
        Write(Name);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        //if typeapp <> 0 then //����� �祩��

        Write(surname);

        gotoXY(x, y);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //����� �祩��
        Write(patronymic);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        Write(addres);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        Write(numberPolis);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := x + cell_width;
    //���室 �� ᫥������ �祩�� �� ��ਧ��⠫�
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        Write(dateFinishPolis.hour, ':', dateFinishPolis.minute);
        y := y + cell_height;
        //���室 �� ᫥������ �祩�� ᭨��
      end;
    end;

    x := 111;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      //���室 �� ᫥������ �祩�� ᭨��
    end;

    gotoxy(111, 2);
    Write('I');
  end;

procedure MenuAddThirdTable(var Key: char; var x, y: integer;
   {��楤�� ��� ��।������� � �롮� ���� �����}
 var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
 var p3: patientType; var a3: patientTypeArr);
{Key-��� ������ ������
 x,y-���न����}
 var
   i, CountMax: integer;
 begin
   x := HomeX;       //��砫쭠� ������ X
   y := HomeY;       //��砫쭠� ������ Y
   gotoxy(x, y);
   CountMax := 2;
   StringNumber := one;
   RowsNumber := one;
   TextAttr := TableColorUnSelected_item;
   repeat
     gotoxy(one, twentyseven);
     write('�롥�� ��� � ������ Enter');
     Key := readkey;
     if Key = char(0) then
     begin
       Key := readkey;
       case Key of
         chr(80):               //����
         begin
           if (StringNumber < StringMax) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             Inc(StringNumber);
             y := y + cell_height;
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(77):               //��ࠢ�
         begin
           if (RowsNumber < RowsMax2) then
           begin
             gotoXY(x, y);
             TextAttr := TableColorUnselected_item;
             Inc(RowsNumber);
             x := x + cell_width;
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(72):               //�����
         begin
           if (StringNumber > 1) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             StringNumber := StringNumber - 1;
             y := y - cell_height;
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(75):               //�����
         begin
           if (RowsNumber > one) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             RowsNumber := RowsNumber - one;
             x := x - cell_width;       //����ﭨ� �����
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(81):  //PageDown - ���室 �� ��࠭�栬 (᫥�.)
         begin
           if (pagenumber < pagenumbermax) then
           begin
             pagenumber := pagenumber + one;
             itemPage := itemPage + stringmax;
             itemPageMax := itemPageMax + stringmax;
             ClrScr;
             ViewThirdTable(a3, itemPage, itemPageMax);
             ThirdFrameTable;
             MenuAddThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
               itemPage, itemPageMax, p3, a3);
             gotoxy(one, twentyseven);
             write('�롥�� ��� � ������ Enter');
           end;
         end;
         chr(73):  //PageUp - ���室 �� ��࠭�栬 (�।.)
         begin
           if (pagenumber > one) then
           begin
             pagenumber := pagenumber - one;
             itemPage := itemPage - stringmax;
             itemPageMax := itemPageMax - stringmax;
             ClrScr;
             ViewThirdTable(a3, itemPage, itemPageMax);
             ThirdFrameTable;
             gotoxy(one, twentyseven);
             write('�롥�� ��� � ������ Enter');
             MenuAddThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
               itemPage, itemPageMax, p3, a3);
           end;
         end;
       end;
     end
     else
   until Key = chr(13);//twentyseven
   x := HomeX;
   y := HomeY;
 end;

procedure MenuAddSecondTable(var Key: char; var x, y: integer;
   {��楤�� ��� ��।������� � �롮� ���� �����}
 var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
 var p2: doctorType; var a2: doctorTypeArr);
{Key-��� ������ ������
 x,y-���न����}
 var
   i, CountMax: integer;
 begin
   x := HomeX;       //��砫쭠� ������ X
   y := HomeY;       //��砫쭠� ������ Y
   gotoxy(x, y);
   CountMax := 2;
   StringNumber := one;
   RowsNumber := one;
   TextAttr := TableColorUnSelected_item;
   repeat
     gotoxy(one, twentyseven);
     write('�롥�� ��� � ������ Enter');
     Key := readkey;
     if Key = char(0) then
     begin
       Key := readkey;
       case Key of
         chr(80):               //����
         begin
           if (StringNumber < StringMax) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             Inc(StringNumber);
             y := y + cell_height;
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(77):               //��ࠢ�
         begin
           if (RowsNumber < RowsMax2) then
           begin
             gotoXY(x, y);
             TextAttr := TableColorUnselected_item;
             Inc(RowsNumber);
             x := x + cell_width;
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(72):               //�����
         begin
           if (StringNumber > 1) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             StringNumber := StringNumber - 1;
             y := y - cell_height;
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(75):               //�����
         begin
           if (RowsNumber > one) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             RowsNumber := RowsNumber - one;
             x := x - cell_width;       //����ﭨ� �����
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(81):  //PageDown - ���室 �� ��࠭�栬 (᫥�.)
         begin
           if (pagenumber < pagenumbermax) then
           begin
             pagenumber := pagenumber + one;
             itemPage := itemPage + stringmax;
             itemPageMax := itemPageMax + stringmax;
             ClrScr;
             ViewSecondTable(a2, itemPage, itemPageMax);
             SecondFrameTable;
             MenuAddSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
               itemPage, itemPageMax, p2, a2);
             gotoxy(one, twentyseven);
             write('�롥�� ��� � ������ Enter');
           end;
         end;
         chr(73):  //PageUp - ���室 �� ��࠭�栬 (�।.)
         begin
           if (pagenumber > one) then
           begin
             pagenumber := pagenumber - one;
             itemPage := itemPage - stringmax;
             itemPageMax := itemPageMax - stringmax;
             ClrScr;
             ViewSecondTable(a2, itemPage, itemPageMax);
             SecondFrameTable;
             gotoxy(one, twentyseven);
             write('�롥�� ��� � ������ Enter');
             MenuAddSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
               itemPage, itemPageMax, p2, a2);
           end;
         end;
       end;
     end
     else
   until Key = chr(13);//twentyseven
   x := HomeX;
   y := HomeY;
 end;

  procedure WriteappointmentArr(var p: appointments; var a: appointmentArr;
    var p2: doctorType; var a2:doctorTypeArr;
    var p3: patientType; var  patientTypeArr);
  //����ணࠬ�� ����� ���ᨢ� ����묨 � �ਥ�� ��祩
  //i,j - ���稪�
  //  number - ���-�� �ਥ���
  //  s - ����� � �ਥ��
  //  a - ���ᨢ �ਥ���
  var
    error: boolean;
    i, count: integer;
    numberMin, numberMax, CountMax: integer;
  begin
    CountMax := 2;
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      TestNumber(numberMin, CountMax,
        '������ ���祭�� �����, � ���ண� ��� ����� ����/������: ');
      gotoxy(one, twentyseven);
      clreol;
      for i := numberMin to numberMin do
        with a[i] do
        begin
          Testdate(d);
          TestTime(timestart);
          TestTime(timefinish);
          TestTypeapp(typeapp, '������ ⨯ �ਥ��:  ');
          clrscr;
          SecondFrameTable;
          ViewSecondTableNotNull(a2, itemPage, itemPageMax);
          MenuAddSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p2, a2);
          TestNumber(numberMin, CountMax,
        '������ ���祭�� �����, � ���ண� ��� ����� ����/������: ');
          TestFIOSecond(fiodoc, numberMin, p2, a2);
          //TestFioDoc();
          clrscr;
          ThirdFrameTable;
          ViewThirdTableNotNull(a3, itemPage, itemPageMax);
          MenuAddThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p3, a3);
          TestNumber(numberMin, CountMax,
        '������ ���祭�� �����, � ���ண� ��� ����� ����/������: ');
          TestFIOThrid(fiopat, numberMin, p3, a3);

          writeln(' ');
        end;
    until (not error);
    writeln(' ');
  end;

  procedure WriteaDoctorArr(var p2: doctorType; var a2: doctorTypeArr);
  //����ணࠬ�� ����� ���ᨢ� ����묨 � ����
  //  i,j - ���稪�
  //  number - ���-�� �ਥ���
  //  s - ����� � �ਥ��
  //  a - ���ᨢ �ਥ���
  var
    error: boolean;
    i: integer;
    numberMin, numberMax, CountMax: integer;
  begin
    CountMax := 2;
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      TestNumber(numberMin, CountMax,
        '������ ���祭�� �����, � ���ண� ��� ����� ����/������: ');
      gotoxy(one, twentyseven);
      clreol;
      CountMax := 4;
      for i := numberMin to numberMin do
        with a2[i] do
        begin
          TestFIO(Name, ' ������ �������: ');
          TestFIO(surname, ' ������ ���: ');
          TestFIO(patronymic, ' ������ ����⢮: ');
          TestSpecialty(specialty,
            ' ��㤨� ᯥ樠�쭮��� ��� ');
          TestNumber(nemberCabinet, CountMax,
            ' ������ ����� ������� ');
          writeln(' ');
        end;
    until (not error);
    writeln(' ');
  end;

  procedure WriteaPacientArr(var p3: patientType; var a3: patientTypeArr);
  //����ணࠬ�� ����� ���ᨢ� ����묨 � ��樥�⮢
  //  i,j - ���稪�
  //  number - ���-�� �ਥ���
  //  s - ����� � �ਥ��
  //  a - ���ᨢ �ਥ���
  var
    error: boolean;
    i: integer;
    numberMin, numberMax, CountMax: integer;
  begin
    CountMax := 2;
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      TestNumber(numberMin, CountMax,
        '������ ���祭�� �����, � ���ண� ��� ����� ����/������: ');
      gotoxy(one, twentyseven);
      clreol;
      CountMax := 7;
      for i := numberMin to numberMin do
        with a3[i] do
        begin
          TestFIO(Name, ' ������ �������: ');
          TestFIO(surname, ' ������ ���: ');
          TestFIO(patronymic, ' ������ ����⢮: ');
          TestSpecialty(addres,
            ' ������ �����: ');
          TestNumber(numberPolis, CountMax,
            ' ������ ����� �����: ');
          TestTime(dateFinishPolis);
          writeln(' ');
        end;
      {    patronymic: myStringFIO;
    addres: myLongString;
    numberPolis: integer;
    dateFinishPolis: time_type;}
    until (not error);
    writeln(' ');
  end;

  procedure ChangeappointmentArr(var p: appointments; var a: appointmentArr);
  {����ணࠬ�� ��������� ���ᨢ� ����묨 � �ਥ��� }
  var
    error: boolean;
    number, CountMax: integer;
  begin
    CountMax := 2;
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      gotoxy(one, twentyseven);
      TestNumber(number, CountMax,
        '�롥�� ����� ������ �����, ����� �� ������ ��������/��������: ');
      gotoxy(one, twentyseven);    //twentyseven
      clreol;
      with a[number] do
      begin
        Testdate(d);
        TestTime(timestart);
        TestTime(timefinish);
        TestTypeapp(typeapp, '������ ⨯ �ਥ��:  ');
        TestFioDoc(fiodoc, ' ������ ��� ���: ');
        TestFioPat(fiopat, ' ������ ��� ��樥��: ');
        writeln(' ');
      end;
    until (not error);
    gotoxy(one, 60);
    clreol;
    gotoxy(x, y);
  end;

procedure DeleteDoctorArr(var p2: doctorType; var a2: doctorTypeArr;
 var number: integer);
 //����ணࠬ�� 㤠����� � ���ᨢ� ������ � ��㤥��
 var
   error: boolean;
   n, i: integer;
 begin
   n := nmax;
   repeat
     TextBackground(0);
     TextColor(7);
     error := False;
     if (number < 1) or (number > n) then
       Write('������ ���ࠢ���� ������')
     else
     begin
       for i := number to n - 1 do
         a2[i] := a2[i + one];
       n := n - one;
     end;
     writeln(' ');
   until (not error);
   gotoxy(one, twentyeight);
   clrscr;
   gotoxy(x, y);
 end;

  procedure DeletePatientArr(var p3: patientType; var a3: patientTypeArr;
  var number: integer);
  //����ணࠬ�� 㤠����� � ���ᨢ� ������ � ��㤥��
  var
    error: boolean;
    n, i: integer;
  begin
    n := nmax;
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      if (number < 1) or (number > n) then
        Write('������ ���ࠢ���� ������')
      else
      begin
        for i := number to n - 1 do
          a3[i] := a3[i + one];
        n := n - one;
      end;
      writeln(' ');
    until (not error);
    gotoxy(one, twentyeight);
    clrscr;
    gotoxy(x, y);
  end;

  procedure DeleteappointmentArr(var p: appointments; var a: appointmentArr;
  var number: integer);
  //����ணࠬ�� 㤠����� � ���ᨢ� ������ � ��㤥��
  var
    error: boolean;
    n, i: integer;
  begin
    n := nmax;
    repeat
      TextBackground(0);
      TextColor(7);
      error := False;
      if (number < 1) or (number > n) then
        Write('������ ���ࠢ���� ������')
      else
      begin
        for i := number to n - 1 do
          a[i] := a[i + one];
        n := n - one;
      end;
      writeln(' ');
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
    gotoxy(x, y);
  end;

 {
  procedure SearchName(var p: appointments; var a: appointmentArr);
  //����ணࠬ�� ���᪠ ���ᨢ� �� ��䠢��� �� ����� � ��ࢮ� ⠡���
  var
    str: mystring;
    i, z: integer;
    error: boolean;
    y: integer;
  begin
    clrscr;
    FirstFrameTable;
    textbackground(0);
    error := True;
    gotoxy(one, twentyseven);
    textbackground(0);
    Write(' ������ ��� ��� ���᪠:  ');
    str := CheckfirstName;

    for i := 1 to nmax do
    begin
      with a[i] do
      begin
        if (str = firstName) then
        begin
          mark += one;
          if mark = one then
          begin
            z := -2;
          end;
          z += 2;

          gotoxy(3, one + z);
          Write(firstname);
          gotoxy(15, one + z);
          Write(lastname);
          gotoxy(30, one + z);
          Write(lvl);
          gotoxy(44, one + z);
          Write(mark);
          gotoxy(58, 1 + z);
          Write(variant);
          gotoxy(71, one + z);
          Write(practan);
          gotoxy(86, one + z);
          Write(d.day, '.', d.month, '.', d.year);
          error := False;
        end;
      end;
    end;
    if error = True then
    begin
      gotoxy(one, twentyeight);
      Write('������ ���.  ');
    end;
    gotoxy(2, 29);
  end;
 }

   {appointments = record
    d: date_type;
    timestart: time_type;
    timefinish: time_type;
    typeapp: mystring;
    fiodoc: mystring;
    fiopat: mystring;
    }
Procedure SortTypeApp(var p: appointments; var a: appointmentArr);
var j, i: integer;
  str1, str2, str3: string;
  str4: date_type;
  str5, str6: time_type;
begin
      for i:=1 to nmax-1 do
      begin
  {����७��� 横� 㦥 ��ॡ�ࠥ� ������ � �ࠢ������ ����� ᮡ��.}
  for j:=1 to nmax-i do
  begin
    {�᫨ �����, ����� ᫥���饣�, � ���塞 ���⠬�.}
    if a[j].typeapp > a[j+1].typeapp then
    begin
      str1 := a[j].typeapp;
      str2 := a[j].fiodoc;
      str3 := a[j].fiopat;
      str4 := a[j].d;
      str5 := a[j].timefinish;
      str6 := a[j].timestart;
      a[j].typeapp := a[j+1].typeapp;
      a[j].fiodoc := a[j+1].fiodoc;
      a[j].fiopat := a[j+1].fiopat;
      a[j].d := a[j+1].d;
      a[j].timefinish := a[j+1].timefinish;
      a[j].timestart := a[j+1].timestart;
      a[j+1].typeapp:=str1;
      a[j+1].fiodoc:=str2;
      a[j+1].fiopat:=str3;
      a[j+1].d:=str4;
      a[j+1].timefinish:=str5;
      a[j+1].timestart:=str6;
    end;
  end;
    end
end;

Procedure SortFIODoctor(var p: appointments; var a: appointmentArr);
var j, i: integer;
  str1, str2, str3: string;
  str4: date_type;
  str5, str6: time_type;
begin
      for i:=1 to nmax-1 do
      begin
  {����७��� 横� 㦥 ��ॡ�ࠥ� ������ � �ࠢ������ ����� ᮡ��.}
  for j:=1 to nmax-i do
  begin
    {�᫨ �����, ����� ᫥���饣�, � ���塞 ���⠬�.}
    if a[j].fiodoc > a[j+1].fiodoc then
    begin
      str1 := a[j].typeapp;
      str2 := a[j].fiodoc;
      str3 := a[j].fiopat;
      str4 := a[j].d;
      str5 := a[j].timefinish;
      str6 := a[j].timestart;
      a[j].typeapp := a[j+1].typeapp;
      a[j].fiodoc := a[j+1].fiodoc;
      a[j].fiopat := a[j+1].fiopat;
      a[j].d := a[j+1].d;
      a[j].timefinish := a[j+1].timefinish;
      a[j].timestart := a[j+1].timestart;
      a[j+1].typeapp:=str1;
      a[j+1].fiodoc:=str2;
      a[j+1].fiopat:=str3;
      a[j+1].d:=str4;
      a[j+1].timefinish:=str5;
      a[j+1].timestart:=str6;
    end;
  end;
    end
end;

Procedure SortFIOPatient(var p: appointments; var a: appointmentArr);
var j, i: integer;
  str1, str2, str3: string;
  str4: date_type;
  str5, str6: time_type;
begin
      for i:=1 to nmax-1 do
      begin
  {����७��� 横� 㦥 ��ॡ�ࠥ� ������ � �ࠢ������ ����� ᮡ��.}
  for j:=1 to nmax-i do
  begin
    {�᫨ �����, ����� ᫥���饣�, � ���塞 ���⠬�.}
    if a[j].fiopat > a[j+1].fiopat then
    begin
      str1 := a[j].typeapp;
      str2 := a[j].fiodoc;
      str3 := a[j].fiopat;
      str4 := a[j].d;
      str5 := a[j].timefinish;
      str6 := a[j].timestart;
      a[j].typeapp := a[j+1].typeapp;
      a[j].fiodoc := a[j+1].fiodoc;
      a[j].fiopat := a[j+1].fiopat;
      a[j].d := a[j+1].d;
      a[j].timefinish := a[j+1].timefinish;
      a[j].timestart := a[j+1].timestart;
      a[j+1].typeapp:=str1;
      a[j+1].fiodoc:=str2;
      a[j+1].fiopat:=str3;
      a[j+1].d:=str4;
      a[j+1].timefinish:=str5;
      a[j+1].timestart:=str6;
    end;
  end;
    end
end;

procedure SortFirstTable(var Key: char; var x, y: integer;
    {��楤�� ��� ��।������� � �롮� ���� �����}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p: appointments; var a: appointmentArr);
 {Key-��� ������ ������
  x,y-���न����}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //��砫쭠� ������ X
    y := HomeY;       //��砫쭠� ������ Y
    gotoxy(x, y);
    StringNumber := one;
    RowsNumber := one;
    CountMax := 2;
    TextAttr := TableColorUnSelected_item;
    gotoxy(one, twentyseven);
    write('����� ���஢�� 1 - ⨯ �ਥ�� 2 -  ��樥�� 3 - ��� ');
      Key := readkey;

        Key := readkey;
        case Key of
          chr(49):  //1   ���஢��� �� ⨯� �ਥ��
          begin
          SortTypeApp(p,a);
          end;
          chr(50):  //2 ���஢��� �� ��� ��樥��
          begin
          SortFIOPatient(p,a);
          end;
          chr(51):  //3  ����஢��� �� ��� ���
          begin
          SortFIODoctor(p,a);
          end;
        end;
    x := HomeX;
    y := HomeY;
  end;

  procedure MenuFirstTable(var Key: char; var x, y: integer;
    {��楤�� ��� ��।������� � �롮� ���� �����}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p: appointments; var a: appointmentArr; var p2: doctorType; var a2: doctorTypeArr);
 {Key-��� ������ ������
  x,y-���न����}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //��砫쭠� ������ X
    y := HomeY;       //��砫쭠� ������ Y
    gotoxy(x, y);
    StringNumber := one;
    RowsNumber := one;
    CountMax := 2;
    TextAttr := TableColorUnSelected_item;
    repeat
      Key := readkey;
      if Key = char(0) then
      begin
        Key := readkey;
        case Key of
          chr(80):               //����
          begin
            if (StringNumber < StringMax) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              Inc(StringNumber);
              y := y + cell_height;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(77):               //��ࠢ�
          begin
            if (RowsNumber < RowsMax) then
            begin
              gotoXY(x, y);
              TextAttr := TableColorUnselected_item;
              Inc(RowsNumber);
              x := x + cell_width;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(72):               //�����
          begin
            if (StringNumber > 1) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              StringNumber := StringNumber - 1;
              y := y - cell_height;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(75):               //�����
          begin
            if (RowsNumber > one) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              RowsNumber := RowsNumber - one;
              x := x - cell_width;       //����ﭨ� �����
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(59):  //F1   - �������� ���祭��
          begin
            WriteappointmentArr(p, a, p2, a2, p3, a3);
            clrscr;
            ViewFirstTable(a, itemPage, itemPageMax);
    FirstFrameTable;
    MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
          end;
          chr(60):  //F2   - ���஢���
          begin
            SortFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a);
            clrscr;
            ViewFirstTable(a, itemPage, itemPageMax);
    FirstFrameTable;
    MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
          end;
          chr(61):  //F3 - �������� ���祭��
          begin
            gotoxy(one, 60);
            TestNumber(number, CountMax,
              '�롥�� ����� ������ �����, ����� �� ������ 㤠����: ');
            gotoxy(1, 60);
            clreol;
            DeleteappointmentArr(p, a, number);
            ViewFirstTable(a, itemPage, itemPageMax);
            FirstFrameTable;
            MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
          end;
          chr(81):  //PageDown - ���室 �� ��࠭�栬 (᫥�.)
          begin
            if (pagenumber < pagenumbermax) then
            begin
              pagenumber := pagenumber + one;
              itemPage := itemPage + stringmax;
              itemPageMax := itemPageMax + stringmax;
              ClrScr;
              FirstFrameTable;
              ViewFirstTable(a, itemPage, itemPageMax);
              MenuFirstTable(Key, x, y, StringNumber, RowsNumber,
                pagenumber, itemPage, itemPageMax, p, a, p2, a2);
            end;
          end;
          chr(73):  //PageUp - ���室 �� ��࠭�栬 (�।.)
          begin
            if (pagenumber > one) then
            begin
              pagenumber := pagenumber - one;
              itemPage := itemPage - stringmax;
              itemPageMax := itemPageMax - stringmax;
              ClrScr;
              FirstFrameTable;
              ViewFirstTable(a, itemPage, itemPageMax);
              MenuFirstTable(Key, x, y, StringNumber, RowsNumber,
                pagenumber, itemPage, itemPageMax, p, a, p2, a2);
            end;
          end;
          chr(8): //BackSpace - 㤠����� �� ��५���
          begin
            i := (StringNumber + itempage) - one;
            DeleteappointmentArr(p, a, i);
            ViewFirstTable(a, itemPage, itemPageMax);
            FirstFrameTable;
            MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
          end;
        end;
      end
      else
      if key = chr(8) then //BackSpace - 㤠����� �� ��५���
      begin
        i := (StringNumber + itempage) - 1;
        DeleteappointmentArr(p, a, i);
        clrscr;
        ViewFirstTable(a, itemPage, itemPageMax);
    FirstFrameTable;
    MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
      end;
    until Key = chr(9);  //twentyseven
    x := HomeX;
    y := HomeY;
  end;

  procedure MenuSecondTable(var Key: char; var x, y: integer;
    {��楤�� ��� ��।������� � �롮� ���� �����}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p2: doctorType; var a2: doctorTypeArr);
 {Key-��� ������ ������
  x,y-���न����}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //��砫쭠� ������ X
    y := HomeY;       //��砫쭠� ������ Y
    gotoxy(x, y);
    CountMax := 2;
    StringNumber := one;
    RowsNumber := one;
    TextAttr := TableColorUnSelected_item;
    repeat
      Key := readkey;
      if Key = char(0) then
      begin
        Key := readkey;
        case Key of
          chr(80):               //����
          begin
            if (StringNumber < StringMax) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              Inc(StringNumber);
              y := y + cell_height;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(77):               //��ࠢ�
          begin
            if (RowsNumber < RowsMax2) then
            begin
              gotoXY(x, y);
              TextAttr := TableColorUnselected_item;
              Inc(RowsNumber);
              x := x + cell_width;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(72):               //�����
          begin
            if (StringNumber > 1) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              StringNumber := StringNumber - 1;
              y := y - cell_height;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(75):               //�����
          begin
            if (RowsNumber > one) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              RowsNumber := RowsNumber - one;
              x := x - cell_width;       //����ﭨ� �����
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(59):  //F1   - �������� ���祭��
          begin
            WriteaDoctorArr(p2, a2);
            ViewSecondTable(a2, itemPage, itemPageMax);
            SecondFrameTable;
            MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p2, a2);
          end;
          chr(61):  //F3 - �������� ���祭��
          begin
            gotoxy(one, 60);
            TestNumber(number, CountMax,
              '�롥�� ����� ������ �����, ����� �� ������ 㤠����: ');
            gotoxy(1, 60);
            clreol;
            DeleteDoctorArr(p2, a2, number);
            ViewSecondTable(a2, itemPage, itemPageMax);
            SecondFrameTable;
            MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p2, a2);
          end;
          chr(81):  //PageDown - ���室 �� ��࠭�栬 (᫥�.)
          begin
            if (pagenumber < pagenumbermax) then
            begin
              pagenumber := pagenumber + one;
              itemPage := itemPage + stringmax;
              itemPageMax := itemPageMax + stringmax;
              ClrScr;
              ViewSecondTable(a2, itemPage, itemPageMax);
              SecondFrameTable;
              MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
                itemPage, itemPageMax, p2, a2);
            end;
          end;
          chr(73):  //PageUp - ���室 �� ��࠭�栬 (�।.)
          begin
            if (pagenumber > one) then
            begin
              pagenumber := pagenumber - one;
              itemPage := itemPage - stringmax;
              itemPageMax := itemPageMax - stringmax;
              ClrScr;
              ViewSecondTable(a2, itemPage, itemPageMax);
              SecondFrameTable;
              MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
                itemPage, itemPageMax, p2, a2);
            end;
          end;
          chr(8): //BackSpace - 㤠����� �� ��५���
          begin
            i := (StringNumber + itempage) - one;
            DeleteDoctorArr(p2, a2, i);
            ViewSecondTable(a2, itemPage, itemPageMax);
            SecondFrameTable;
            gotoxy(x, y);
          end;
        end;
      end
      else
      if key = chr(8) then //BackSpace - 㤠����� �� ��५���
      begin
        i := (StringNumber + itempage) - 1;
          DeleteDoctorArr(p2, a2, i);
        ViewSecondTable(a2, itemPage, itemPageMax);
        SecondFrameTable;
        MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
         itemPage, itemPageMax, p2, a2);
      end;
    until Key = chr(9);//twentyseven
    x := HomeX;
    y := HomeY;
  end;

  procedure MenuThirdTable(var Key: char; var x, y: integer;
    {��楤�� ��� ��।������� � �롮� ���� �����}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p3: patientType; var a3: patientTypeArr);
 {Key-��� ������ ������
  x,y-���न����}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //��砫쭠� ������ X
    y := HomeY;       //��砫쭠� ������ Y
    gotoxy(x, y);
    CountMax := 2;
    StringNumber := one;
    RowsNumber := one;
    TextAttr := TableColorUnSelected_item;
    repeat
      Key := readkey;
      if Key = char(0) then
      begin
        Key := readkey;
        case Key of
          chr(80):               //����
          begin
            if (StringNumber < StringMax) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              Inc(StringNumber);
              y := y + cell_height;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(77):               //��ࠢ�
          begin
            if (RowsNumber < RowsMax2) then
            begin
              gotoXY(x, y);
              TextAttr := TableColorUnselected_item;
              Inc(RowsNumber);
              x := x + cell_width;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(72):               //�����
          begin
            if (StringNumber > 1) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              StringNumber := StringNumber - 1;
              y := y - cell_height;
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(75):               //�����
          begin
            if (RowsNumber > one) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              RowsNumber := RowsNumber - one;
              x := x - cell_width;       //����ﭨ� �����
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(59):  //F1   - �������� ���祭��
          begin
            WriteaPacientArr(p3, a3);
            ViewThirdTable(a3, itemPage, itemPageMax);
              ThirdFrameTable;
          end;
          chr(61):  //F3 - �������� ���祭��
          begin
            gotoxy(one, 60);
            TestNumber(number, CountMax,
              '�롥�� ����� ������ �����, ����� �� ������ 㤠����: ');
            gotoxy(1, 60);
            DeletePatientArr(p3, a3, number);
            clrscr;
            ViewThirdTable(a3, itemPage, itemPageMax);
            ThirdFrameTable;
            MenuThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
                itemPage, itemPageMax, p3, a3);
          end;
          chr(81):  //PageDown - ���室 �� ��࠭�栬 (᫥�.)
          begin
            if (pagenumber < pagenumbermax) then
            begin
              pagenumber := pagenumber + one;
              itemPage := itemPage + stringmax;
              itemPageMax := itemPageMax + stringmax;
              ClrScr;
              ViewThirdTable(a3, itemPage, itemPageMax);
              ThirdFrameTable;
              MenuThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
                itemPage, itemPageMax, p3, a3);
            end;
          end;
          chr(73):  //PageUp - ���室 �� ��࠭�栬 (�।.)
          begin
            if (pagenumber > one) then
            begin
              pagenumber := pagenumber - one;
              itemPage := itemPage - stringmax;
              itemPageMax := itemPageMax - stringmax;
              ClrScr;
              ViewThirdTable(a3, itemPage, itemPageMax);
              ThirdFrameTable;
              MenuThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
                itemPage, itemPageMax, p3, a3);
            end;
          end;
          chr(8): //BackSpace - 㤠����� �� ��५���
          begin
            i := (StringNumber + itempage) - one;
            DeletePatientArr(p3, a3, i);
            ViewThirdTable(a3, itemPage, itemPageMax);
            ThirdFrameTable;
            gotoxy(x, y)
          end;
        end;
      end
      else
      if key = chr(8) then //BackSpace - 㤠����� �� ��५���
      begin
        i := (StringNumber + itempage) - 1;
          DeletePatientArr(p3, a3, i);
        ViewThirdTable(a3, itemPage, itemPageMax);
              ThirdFrameTable;
              MenuThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
                itemPage, itemPageMax, p3, a3);
      end;
    until Key = chr(9);//twentyseven
    x := HomeX;
    y := HomeY;
  end;

  procedure MenuToScr; //�뢮� ���� �� �࠭
  var
    i: integer;
  begin
    ClrScr;
    for i := 1 to MaxItemMenu do
    begin
      GoToXY(x, y + i - one);
      Write(menu[i]);
    end;
    TextAttr := ColorSelected_item;
    GoToXY(x, y + item - one);
    Write(menu[item]); //�뤥����� ��ப� ����
    TextAttr := ColorUnSelected_item;
  end;

  procedure item1(var a: appointmentArr; var number: integer);
  //���� �㭪� ���� (�⥭�� ⠡����)
  var
    i: integer;
    num: integer;
  begin
    ClrScr;
    Assign(f, 'appointment.dat');
     {$I-}
    reset(f);
     {$I+}
    num := IOresult;
    if num <> 0 then
      writeln('�訡�� ������ 䠩�� �', num)
    else
    begin
       {$I-}
      i := 1;
      while (not EOF(f)) and (num = 0) do
      begin
        num := IOresult;
        if num <> 0 then
          Write('�訡�� eof �', num)
        else
        begin
          Read(f, a[i]);
            {$I+}
          num := IOresult;
          if num <> 0 then
            Write('�訡�� �⥭�� �', num)
          else
            Inc(i);
        end;
        if num = 0 then
        begin
          num := IOresult;
          if num <> 0 then
            Write('�訡�� eof �', num);
        end;
      end;
      number := i - one;
       {$I-}
      Close(f);
       {$I+}
      num := IOresult;
      if num <> 0 then
        Write('�訡�� ������� 䠩�� �', num);
      writeln(' ���� �ᯥ譮 ����㦥� ');
    end;

    RKEnter(Enter);
  end;

  procedure item2(a: appointmentArr);
  //��ன �㭪� ���� (������ ⠡����)
  var
    i: integer;
  begin
    ClrScr;
    Assign(f, 'appointment.dat');
    rewrite(f);
    for i := one to nmax do
      Write(f, a[i]);
    Close(f);
    writeln(' ���� �ᯥ譮 ��࠭� ');
    RKEnter(Enter);
  end;

  procedure item3;   //��ࢠ� ⠡���
  begin
    ClrScr;
    pagenumber := one;
    itemPage := one;
    itemPageMax := stringmax;
    ViewFirstTable(a, itemPage, itemPageMax);
    FirstFrameTable;
    MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
  end;

  procedure item4;   //���� ⠡���
  begin
    ClrScr;
    pagenumber := one;
    itemPage := one;
    itemPageMax := stringmax;
    ViewSecondTable(a2, itemPage, itemPageMax);
    SecondFrameTable;
    MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p2, a2);
  end;

  procedure item5;   //����� ⠡���
  begin
    ClrScr;
    pagenumber := one;
    itemPage := one;
    itemPageMax := stringmax;
    ViewThirdTable(a3, itemPage, itemPageMax);
    ThirdFrameTable;
    MenuThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p3, a3);
  end;

  procedure item8;   //��ࠢ�� �� �ணࠬ��
  begin
    ClrScr;
    writeln(' F1 - ����/��������� �ࠧ� ��᪮�쪨� ����⮢ � ⠡���');
    writeln(#10#13' F2 - ����/��������� ������ ����� � ᯨ᪥(⮫쪮 � ����⮩ ⠡���)');
    writeln(#10#13' F3 - �������� ������ ����� � ᯨ᪥ �� �롮��');
    writeln(#10#13' BackSpace - �������� ������ ����� � ᯨ᪥ �� ��५���');
    writeln(#10#13' PageUp - ���室 �� �।����� ��࠭���');
    writeln(#10#13' PageDown - ���室 �� ᫥������ ��࠭���');
    writeln(#10#13' Enter - �⮡� �������� ���� ���祭�� ���������� �����');
    writeln(#10#13' ! ��稭��� ���� ���ଠ樨 � ��ࢮ� ⠡���� !');
    writeln(' ');
    RKEnter(Enter);
  end;

  procedure Arrow(var Key: char; var item: integer; var x, y: integer);
  //��楤�� ��५�� � ����
  begin
    key := ReadKey;
    case key of
      chr(80): //��५�� ����
        if item < MaxItemMenu then
        begin
          GoToXY(x, y + item - one);
          Write(menu[item]);
          item := item + 1;
          TextAttr := ColorSelected_item;
          GoToXY(x, y + item - one);
          Write(menu[item]);
          TextAttr := ColorUnSelected_item;
        end;
      chr(72): //��५�� �����
        if item > one then
        begin
          GoToXY(x, y + item - one);
          Write(menu[item]);
          item := item - one;
          TextAttr := ColorSelected_item;
          GoToXY(x, y + item - one);
          Write(menu[item]);
          TextAttr := ColorUnSelected_item;
        end;
    end;
  end;

  procedure MenuControl;
  //��楤�� �롮� � �ᯮ�짮����� ����
  begin
    repeat
      key := ReadKey;
      if key = char(0) then
        Arrow(Key, item, x, y)
      else
      if key = chr(13) then  {Enter}
      begin
        case item of
          1: item1(a, number);
          2: item2(a);
          3: item3;
          4: item4;
          5: item5;
          6: ;//item7;
          7: item8;
          8: key := chr(9);{��室}    //twentyseven
        end;
        MenuToScr;
      end;
    until (item = MaxItemMenu) and (key = chr(9));{27 - Esc}
  end;

begin
  //loadings;
  menu[1] := '  �⥭�� ⠡���� (����㧨�� �� 䠩��) ';
  menu[2] := #10'  ������ ⠡���� (���࠭��� � 䠩�) ';
  menu[3] := #10#10'  1. ������ ����� �� �ਥ�';
  menu[4] := #10#10#10'  2. ������ ��� ';
  menu[5] := #10#10#10#10'  3. ������ ��樥���  ';
  menu[6] := #10#10#10#10#10#10'  ���� �� �ணࠬ�� ';
  menu[7] := #10#10#10#10#10#10#10'  �������� ';
  menu[8] := #10#10#10#10#10#10#10#10'  ��室 ';
  item := one;
  x := homey;
  y := homey;
  textcolor(ColorUnSelected_item);
  MenuToScr;
  MenuControl;
end.
