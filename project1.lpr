program project1;

uses
  Crt,
  FrameTable,
  loading;

const
  ColorUnselected_item = $7;//Цвет невыделеного пункта
  ColorSelected_item = $91;//Цвет выделенного пункта
  TableColorUnselected_item = $7;
  //Цвет невыделеного пункта таблицы
  TableColorSelected_item = $7;
  //Цвет выделеного пункта таблицы
  MaxItemMenu = 9;//Кол-во элементов в основном меню
  MaxSortItem = 6;//Кол-во элементов в меню сортировки
  nmax = 99;//Максимальное кол-во данных(размер массива)
  floorMax = 10000;
  //Максимальное кол-во данных(размер массива)
  markMax = 5; //Максимальная оценка
  lvlMax = 3;//Максимальный уровень задания
  variantmax = 40; //Максимальный вариант
  practanMax = 6;//Максимальный номер практической
  timefinishMax = 8;//Максимальное время на задания
  dayMax = 31;//Максимум дней
  yearMin = 1998;//Минимум допустимого года
  yearMax = 2020;//Максимум допустимого года
  monthmax = 12;//Максимум допустимого месяца
  homeX = 2;//Начальная X точка в меню таблице
  homeY = 4;//Начальная Y точка в меню таблице
  stringmax = 11;//Максимальное число строк
  RowsMax3 = 6;//Максимальное число строк 2
  RowsMax2 = 5;//Максимальное число строк 2
  RowsMax = 6;//Максимальное число столбцо
  pagenumbermax = 9;//Максимальное число страниц
  February = 2;//Номер Февраля в году
  April = 4; //Номер Апреля в году
  June = 6;//Номер Июня в году
  September = 9;//Номер Сентября в году
  November = 11;//Номер Ноября в году
  FebruaryMax = 29;//Количество дней в високосном феврале
  FebruaryMin = 28;//Количество дней в не високосном феврале
  one = 1;//Цифра 1
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

  //Procedure addName();       //Дабавление данных во 2 таблице
  //begin

  //end;
var
  menu: array[1..MaxItemMenu] of string;//названия пунктов меню}
  SortArray: array[1..MaxSortItem] of string;
  item, SortItem: integer;//номер выделенного пункта
  Key, Enter: char;//введенный символ
  x, y: integer;//координаты первой строки меню
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

  procedure RKEnter(var Enter: char);//Подпрограмма нажатия Enter
  begin
    writeln('Нажмите "Enter" для продолжения.');
    repeat
      Enter := readkey;
      if Enter = #13 then
        //(#10'Вы нажали не "Enter". Попробуйте ещё раз.'#10);
    until (Enter = #13);//13 - Enter
  end;

  //Проверки

  function CheckNumber(CountMax: integer): integer;
    //Функция для проверки ввода количества элементов  через readkey
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша
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
  //Подпрограмма проверяет правильность ввода
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
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;
    until (not error);
  end;

  function checkfiodoc: mystring;
    //Функция для проверки ввода ФИО через readkey, где
    //symbol - счетчик
    //s_DescriptionMark - ввод числа для проверки
    //key - клавиша

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
        //DescriptionMark-строка из который удалены символы,
        //length - номер символа, с которого удалять,
        //1 - кол-во символов
        Write(#8, ' ', #8);
        symbol := symbol - one;
      end;
      if FioDoc = '' then
        error := True;
    until (key = #13) and (not error);
    checkfiodoc := FioDoc;
  end;

  procedure Testfiodoc(var FioDoc: mystring; message: message_string);
  //Подпрограмма проверяет правильность ввода имени
  //i,j - счетчики
  //error - наличие ошибки
  //message - строка на вывод сообщения
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
    //Функция для проверки ввода фамилии через readkey
    //symbol - счетчик
    //s_DescriptionMark - ввод числа для проверки
    //key - клавиша
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
  //Подпрограмма проверяет правильность ввода фамилии
  //i,j - счетчики
  //error - наличие ошибки
  //message - строка на вывод}
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
    //Функция для проверки ввода типа приема через readkey
    //symbol - счетчик
    //s_DescriptionMark - ввод числа для проверки
    //key - клавиша
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
    //Функция для проверки ввода типа приема через readkey
    //symbol - счетчик
    //s_DescriptionMark - ввод числа для проверки
    //key - клавиша
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
    //Функция для проверки ввода типа приема через readkey
    //symbol - счетчик
    //s_DescriptionMark - ввод числа для проверки
    //key - клавиша
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
 //Подпрограмма проверяет правильность ввода фамилии
 //i,j - счетчики
 //error - наличие ошибки
 //message - строка на вывод}
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
 //Подпрограмма проверяет правильность ввода фамилии
 //i,j - счетчики
 //error - наличие ошибки
 //message - строка на вывод}
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
  //Подпрограмма проверяет правильность ввода фамилии
  //i,j - счетчики
  //error - наличие ошибки
  //message - строка на вывод}
  begin
      typeapp := a2[count].surname + ' ' + a2[count].Name+ ' '
      + a2[count].patronymic;
    gotoxy(one, twentyeight);
    clreol;
  end;
  procedure TestFIOSecond(var typeapp: mystring; count: integer;
    var p3: doctorType; var a3: doctorTypeArr);
  //Подпрограмма проверяет правильность ввода фамилии
  //i,j - счетчики
  //error - наличие ошибки
  //message - строка на вывод}
  begin
      typeapp := a3[count].surname + ' ' + a3[count].Name+ ' '
      + a3[count].patronymic;
    gotoxy(one, twentyeight);
    clreol;
  end;

procedure Testtypeapp(var typeapp: mystring; message: message_string);
  //Подпрограмма проверяет правильность ввода фамилии
  //i,j - счетчики
  //error - наличие ошибки
  //message - строка на вывод}
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
  //процедура проверяет правильность ввода фамилии имени отчества
  //i,j - счетчики
  //error - наличие ошибки
  //message - строка на вывод}
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
  //Подпрограмма проверяет правильность ввода специальности
  //i,j - счетчики
  //error - наличие ошибки
  //message - строка на вывод}
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
    //Функция для проверки ввода варианта через readkey, где
    //symbol - счетчик
    // s_key - ввод числа для проверки
    //key - клавиша
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
        //s_variant-строка из который удалены символы,
        //length - номер символа,с которого удалять,
        //1 - кол-во символов
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
  //Подпрограмма проверяет правильность ввода оценок студентов
  //s_age - ввод числа для проверки
  //age - возраст
  //code - переменная для защита
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('Введите вариант(макс.', variantmax, '):');
      variant := Checkvariant;
      gotoxy(one, twentyseven);
      clreol;
      if (variant < 0) or (variant > variantMax) then
      begin
        gotoxy(1, twentyeight);
        Write('Вы ввели некорректный вариант. Попробуйте снова.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checkpractan: integer;
    //Функция для проверки ввода варианта через readkey, где
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша

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
        //s_variant-строка из который удалены символы,
        //length - номер символа, с которого удалять,
        //1 - кол-во символов
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
  //Подпрограмма проверяет правильность ввода оценок студентов
  //s_practan - ввод числа для проверки
  //practan - номер практической
  //code - переменная для защиты
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('Введите номер практической работы (макс.',
        practanmax, '): ');
      practan := Checkpractan;
      gotoxy(one, twentyseven);
      clreol;
      if (practan < 0) or (practan > practanMax) then
      begin
        gotoxy(one, twentyeight);
        Write(
          'Вы ввели некорректный номер практической работы. Попробуйте снова.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checkpractansecond: integer;
    //Функция для проверки ввода варианта через readkey, где
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша
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
        //s_variant-строка из который удалены символы,
        //length - номер символа, с которого удалять,
        //1 - кол-во символов
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
  //Подпрограмма проверяет правильность ввода оценок студентов
  //s_practan - ввод числа для проверки
  //practansecond - номер практической
  //code - переменная для защита
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('Введите практическую работу (макс.',
        practanmax, '): ');
      practansecond := Checkpractansecond;
      gotoxy(one, twentyseven);
      clreol;
      if (practansecond < 0) or (practansecond > practanMax) then
      begin
        gotoxy(one, twentyeight);
        Write(
          'Вы ввели некорректную практической работы. Попробуйте снова.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checktimefinish: integer;
    //Функция для проверки ввода варианта через readkey, где
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша
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
        //s_variant-строка из который удалены символы,
        //length - номер символа, с которого удалять,
        //1 - кол-во символов
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
  //Подпрограмма проверяет правильность ввода оценок студентов
  //s_practan - ввод числа для проверки
  //practan - номер практической
  //code - переменная для защита
  var
    error: boolean;
  begin
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('Введите время на практическую работу (макс.', timefinishmax, '): ');
      timefinish := Checktimefinish;
      gotoxy(1, twentyseven);
      clreol;
      if (timefinish < 0) or (timefinish > timefinishMax) then
      begin
        gotoxy(1, twentyeight);
        Write('Вы ввели некорректное время на выполнение. Попробуйте снова.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
  end;

  function Checklvl: integer;
    //Функция для проверки ввода уровня через readkey
    //symbol - счетчик
    //s_key - ввод числа для проверки
    // key - клавиша}
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
  //Подпрограмма проверяет правильность ввода уровня
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('Введите уровень практической (макс.',
        lvlmax, '): ');
      lvl := Checklvl;
      gotoxy(one, twentyeight);
      clreol;
      gotoxy(one, twentyseven);
      clreol;
      if (lvl < one) or (lvl > lvlMax) then
      begin
        gotoxy(1, twentyeight);
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;
    until (not error);
  end;

  function Checkmark: integer;
    //Функция для проверки ввода оценки readkey
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша
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
  //Подпрограмма проверяет правильность ввода оценки
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('Введите оценку 1-5 (макс.', markmax, '): ');
      mark := Checkmark;
      gotoxy(1, twentyeight);
      clreol;
      gotoxy(1, twentyseven);
      clreol;
      if (mark < one) or (mark > markMax) then
      begin
        gotoxy(1, twentyeight);
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;
    until (not error);
  end;

  function Checkmarksecond: integer;
    //Функция для проверки ввода оценки readkey
    //symbol - счетчик
    // s_key - ввод числа для проверки
    // key - клавиша
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
  //Подпрограмма проверяет правильность ввода оценки
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('Введите прошлую оценку 1-5 (макс.', markmax, '): ');
      marksecond := Checkmarksecond;
      gotoxy(1, twentyeight);
      clreol;
      gotoxy(1, twentyseven);
      clreol;
      if (marksecond < one) or (marksecond > markMax) then
      begin
        gotoxy(1, twentyeight);
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;
    until (not error);
  end;


  //ДАТА
  function CheckDay: integer;
    //Функция для проверки ввода дня через readkey
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша
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
    //Функция для проверки ввода месяца через readkey
    //symbol - счетчик
    // s_key - ввод числа для проверки
    // key - клавиша
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
    //Функция для проверки ввода года через readkey}
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша
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
  //Подпрограмма проверяет дату
  //month - месяц
  //day - день
  //year - год
  //s_d - ввод числа для проверки
  //code - переменная для защиты
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('Введите день: ');
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
      Write('Введите месяц: ');
      d.Month := checkMonth;
      gotoxy(one, twentyseven);
      clreol;
      if (d.month > monthmax) then
      begin
        gotoxy(one, twentyeight);
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;
    until (not error);
    gotoxy(one, twentyeight);
    clreol;
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('Введите год: ');
      d.Year := checkYear;
      gotoxy(one, twentyseven);
      clreol;
      if (d.year < yearMin) or (d.year > yearMax) then
      begin
        gotoxy(one, twentyeight);
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;
    until (not error);
  end;

  procedure TestDate(var d: date_type);
  //Подпрограмма проверяет дату на правильность написания
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
          'Вы некорректно ввели день в коротком месяце. Попробуйте снова.'#10#13);
        error := True;
      end
      else
      if ((d.month = February) and (d.year > yearMin) and (d.year mod 4 = 0) and
        (d.day > FebruaryMax)) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          'Вы некорректно ввели дату високосного года. Попробуйте снова.'#10#13);
        error := True;
      end
      else
      if ((d.month = February) and ((d.year = yearMin) or (d.year mod 4 <> 0)) and
        (d.day > FebruaryMin)) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          'Вы некорректно ввели дату не високосного года. Попробуйте снова.'#10#13);
        error := True;
      end;
    until (not error);
    gotoxy(1, twentyeight);
    clreol;
  end;

  //ВРЕМЯ
  function CheckHour: integer;
    //Функция для проверки ввода часа через readkey
    //symbol - счетчик
    //s_key - ввод числа для проверки
    //key - клавиша
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
    //Функция для проверки ввода минут через readkey
    //symbol - счетчик
    // s_key - ввод числа для проверки
    // key - клавиша
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
  //Подпрограмма проверяет время
  //hour - часы
  //minute - минуты
  //s_d - ввод числа для проверки
  //code - переменная для защиты
  var
    error: boolean;
  begin
    TextBackground(0);
    TextColor(7);
    repeat
      error := False;
      gotoxy(1, twentyseven);
      Write('Введите час: ');
      t.Hour := CheckHour;
      gotoxy(one, twentyseven);
      clreol;
      if not (t.hour in [0..23]) then
      begin
        gotoxy(one, twentyeight);
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;

    until (not error);
    gotoxy(one, twentyeight);
    clreol;
    repeat
      error := False;
      gotoxy(one, twentyseven);
      Write('Введите минуты: ');
      t.Minute := checkMinute;
      gotoxy(one, twentyseven);
      clreol;
      if (t.minute > 59) then
      begin
        gotoxy(one, twentyeight);
        Write('Вы ввели некорректное число. Попробуйте снова.');
        error := True;
      end;
    until (not error);

  end;

  procedure TestTime(var t: time_type);
  //Подпрограмма проверяет дату время на правильность написания
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
          'Вы некорректно ввели минуты. Попробуйте снова.'#10#13);
        error := True;
      end
      else
      if (not (t.hour in [0..23])) then
      begin
        gotoxy(1, twentyeight);
        writeln(
          'Вы некорректно ввели часы. Попробуйте снова.'#10#13);
        error := True;
      end;

    until (not error);
    gotoxy(1, twentyeight);
    clreol;
  end;

  //Сортировки
{
  procedure SortlastName(var a: appointmentArr);
 //Подпрограмма сортировки массива по алфавиту по названию
 //i,j - счетчики
 //a - массив товаров
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
  //Подпрограмма сортировки массива по алфавиту, где
  //  i,j - счетчики
  //  a - массив студентов
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
  //Подпрограмма сортировки массива оценок
  //i,j - счетчики
  //  a - массив студентов
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
  //Подпрограмма сортировки массива по уровню
  //i,j - счетчики
  //  a - массив студентов
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
  //Функция сравнения дат
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
  //Подпрограмма сортировки массива по дате
  //i,j - счетчики
  //  a - массив студентов
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
  //таблицы

  procedure ViewFirstTable(var a: appointmentArr; var itemPage, itemPageMax: integer);
  //Вывод результатов в первую таблицу
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
          //пустая ячейка
          Write(d.day, '.', d.month, '.', d.year);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;
    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //if (t. <> 0) and (d.month <> 0) and (d.year <> 0) then   //пустая ячейка
        Write(timestart.hour, ':', timestart.minute);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        Write(timefinish.hour, ':', timefinish.minute);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //if typeapp <> 0 then //пустая ячейка
        Write(typeapp);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //пустая ячейка
        Write(FioDoc);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;
    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a[i] do
      begin
        gotoxy(x, y);
        //     if variant <> 0 then //пустая ячейка
        Write(FioPat);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := 111;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      //переход на следующую ячейку снизу
    end;

    gotoxy(111, 2);
    Write('I');
  end;

procedure ViewSecondTableNotNull(var a2: doctorTypeArr; var itemPage, itemPageMax: integer);
 //Вывод результатов в первую таблицу
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
       if (Name <> '') then  //пустая ячейка
       begin
       Write(Name);
       y := y + cell_height;
       end
       //переход на следующую ячейку снизу
     end;
   end;

   x := x + cell_width;
   //переход на следующую ячейку по горизонтали
   y := homeY;
   newX := x;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (surname <> '') then //пустая ячейка
       begin
       Write(surname);

       gotoXY(x, y);
       y := y + cell_height;
       end;
       //переход на следующую ячейку снизу
     end;
   end;

   x := x + cell_width;
   //переход на следующую ячейку по горизонтали
   y := homeY;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (patronymic <> '') then  //пустая ячейка
       begin
       Write(patronymic);
       y := y + cell_height;
       end;
       //переход на следующую ячейку снизу
     end;
   end;
   x := x + cell_width;
   //переход на следующую ячейку по горизонтали
   y := homeY;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (specialty <> '') then //пустая ячейка
       begin
       Write(specialty);
       y := y + cell_height;
       end;
       //переход на следующую ячейку снизу
     end;
   end;
   x := x + cell_width;
   //переход на следующую ячейку по горизонтали
   y := homeY;
   for i := itemPage to itemPageMax do
   begin
     with a2[i] do
     begin
       gotoxy(x, y);
       if (nemberCabinet <> 0) then //пустая ячейка
       begin
       Write(nemberCabinet);
       y := y + cell_height;
       end;
       //переход на следующую ячейку снизу
     end;
   end;
   x := 91;
   y := 4;
   for i := itemPage to itemPageMax do
   begin
     gotoxy(x, y);
     with a2[i] do
     if (nemberCabinet <> 0) then //пустая ячейка
     begin
     Write(i);
     y := y + cell_height;
     end;
     //переход на следующую ячейку снизу
   end;

   gotoxy(92, 2);
   Write('II');
 end;

  procedure ViewSecondTable(var a2: doctorTypeArr; var itemPage, itemPageMax: integer);
  //Вывод результатов в первую таблицу
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
        //if mark <> 0 then  //пустая ячейка
        Write(Name);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    newX := x;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //if typeapp <> 0 then //пустая ячейка

        Write(surname);

        gotoXY(x, y);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //пустая ячейка
        Write(patronymic);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;
    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //     if variant <> 0 then //пустая ячейка
        Write(specialty);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;
    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a2[i] do
      begin
        gotoxy(x, y);
        //     if variant <> 0 then //пустая ячейка
        Write(nemberCabinet);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;
    x := 91;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      //переход на следующую ячейку снизу
    end;

    gotoxy(92, 2);
    Write('II');
  end;

  procedure ViewThirdTableNotNull(var a3: patientTypeArr; var itemPage, itemPageMax: integer);
  //Вывод результатов в первую таблицу
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
        if (Name <> '') then  //пустая ячейка
        begin
        Write(Name);
        y := y + cell_height;
        end;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (surname <> '') then //пустая ячейка
        begin
        Write(surname);
        y := y + cell_height;
        end
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (patronymic <> '') then  //пустая ячейка
        begin
        Write(patronymic);
        y := y + cell_height;
        end;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (addres <> '') then  //пустая ячейка
        begin
        Write(addres);
        y := y + cell_height;
        end;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (numberPolis <> 0) then  //пустая ячейка
        begin
        Write(numberPolis);
        y := y + cell_height;
        end;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        if (numberPolis <> 0) then  //пустая ячейка
        begin
        Write(dateFinishPolis.hour, ':', dateFinishPolis.minute);
        y := y + cell_height;
        end;
        //переход на следующую ячейку снизу
      end;
    end;

    x := 111;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      if (numberPolis <> 0) then  //пустая ячейка
        begin
        gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      end;
      //переход на следующую ячейку снизу
    end;

    gotoxy(111, 2);
    Write('I');
  end;
  procedure ViewThirdTable(var a3: patientTypeArr; var itemPage, itemPageMax: integer);
  //Вывод результатов в первую таблицу
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
        //if mark <> 0 then  //пустая ячейка
        Write(Name);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        //if typeapp <> 0 then //пустая ячейка

        Write(surname);

        gotoXY(x, y);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        //if mark <> 0 then  //пустая ячейка
        Write(patronymic);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        Write(addres);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        Write(numberPolis);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := x + cell_width;
    //переход на следующую ячейку по горизонтали
    y := homeY;
    for i := itemPage to itemPageMax do
    begin
      with a3[i] do
      begin
        gotoxy(x, y);
        Write(dateFinishPolis.hour, ':', dateFinishPolis.minute);
        y := y + cell_height;
        //переход на следующую ячейку снизу
      end;
    end;

    x := 111;
    y := 4;
    for i := itemPage to itemPageMax do
    begin
      gotoxy(x, y);
      Write(i);
      y := y + cell_height;
      //переход на следующую ячейку снизу
    end;

    gotoxy(111, 2);
    Write('I');
  end;

procedure MenuAddThirdTable(var Key: char; var x, y: integer;
   {Процедура для передвижения и выбора места записи}
 var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
 var p3: patientType; var a3: patientTypeArr);
{Key-код нажатия клавиши
 x,y-координаты}
 var
   i, CountMax: integer;
 begin
   x := HomeX;       //начальная позиция X
   y := HomeY;       //начальная позиция Y
   gotoxy(x, y);
   CountMax := 2;
   StringNumber := one;
   RowsNumber := one;
   TextAttr := TableColorUnSelected_item;
   repeat
     gotoxy(one, twentyseven);
     write('Выберите врача и нажмите Enter');
     Key := readkey;
     if Key = char(0) then
     begin
       Key := readkey;
       case Key of
         chr(80):               //вниз
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
         chr(77):               //вправо
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
         chr(72):               //вверх
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
         chr(75):               //влево
         begin
           if (RowsNumber > one) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             RowsNumber := RowsNumber - one;
             x := x - cell_width;       //расстояние между
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(81):  //PageDown - Переход по страницам (след.)
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
             write('Выберите врача и нажмите Enter');
           end;
         end;
         chr(73):  //PageUp - Переход по страницам (пред.)
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
             write('Выберите врача и нажмите Enter');
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
   {Процедура для передвижения и выбора места записи}
 var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
 var p2: doctorType; var a2: doctorTypeArr);
{Key-код нажатия клавиши
 x,y-координаты}
 var
   i, CountMax: integer;
 begin
   x := HomeX;       //начальная позиция X
   y := HomeY;       //начальная позиция Y
   gotoxy(x, y);
   CountMax := 2;
   StringNumber := one;
   RowsNumber := one;
   TextAttr := TableColorUnSelected_item;
   repeat
     gotoxy(one, twentyseven);
     write('Выберите врача и нажмите Enter');
     Key := readkey;
     if Key = char(0) then
     begin
       Key := readkey;
       case Key of
         chr(80):               //вниз
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
         chr(77):               //вправо
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
         chr(72):               //вверх
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
         chr(75):               //влево
         begin
           if (RowsNumber > one) then
           begin
             gotoxy(x, y);
             TextAttr := TableColorUnselected_item;
             RowsNumber := RowsNumber - one;
             x := x - cell_width;       //расстояние между
             gotoXY(x, y);
             TextAttr := TableColorSelected_item;
           end;
         end;
         chr(81):  //PageDown - Переход по страницам (след.)
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
             write('Выберите врача и нажмите Enter');
           end;
         end;
         chr(73):  //PageUp - Переход по страницам (пред.)
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
             write('Выберите врача и нажмите Enter');
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
  //Подпрограмма ввода массива данными о приеме врачей
  //i,j - счетчики
  //  number - кол-во приемов
  //  s - данные о приеме
  //  a - массив приемов
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
        'Введите значение элемента, с которого хотите начать ввод/замену: ');
      gotoxy(one, twentyseven);
      clreol;
      for i := numberMin to numberMin do
        with a[i] do
        begin
          Testdate(d);
          TestTime(timestart);
          TestTime(timefinish);
          TestTypeapp(typeapp, 'Введите тип приема:  ');
          clrscr;
          SecondFrameTable;
          ViewSecondTableNotNull(a2, itemPage, itemPageMax);
          MenuAddSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p2, a2);
          TestNumber(numberMin, CountMax,
        'Введите значение элемента, с которого хотите начать ввод/замену: ');
          TestFIOSecond(fiodoc, numberMin, p2, a2);
          //TestFioDoc();
          clrscr;
          ThirdFrameTable;
          ViewThirdTableNotNull(a3, itemPage, itemPageMax);
          MenuAddThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p3, a3);
          TestNumber(numberMin, CountMax,
        'Введите значение элемента, с которого хотите начать ввод/замену: ');
          TestFIOThrid(fiopat, numberMin, p3, a3);

          writeln(' ');
        end;
    until (not error);
    writeln(' ');
  end;

  procedure WriteaDoctorArr(var p2: doctorType; var a2: doctorTypeArr);
  //Подпрограмма ввода массива данными о врачах
  //  i,j - счетчики
  //  number - кол-во приемов
  //  s - данные о приеме
  //  a - массив приемов
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
        'Введите значение элемента, с которого хотите начать ввод/замену: ');
      gotoxy(one, twentyseven);
      clreol;
      CountMax := 4;
      for i := numberMin to numberMin do
        with a2[i] do
        begin
          TestFIO(Name, ' Введите Фамилию: ');
          TestFIO(surname, ' Введите Имя: ');
          TestFIO(patronymic, ' Введите Отчество: ');
          TestSpecialty(specialty,
            ' Ввудите специальность врача ');
          TestNumber(nemberCabinet, CountMax,
            ' Введите номер кабинета ');
          writeln(' ');
        end;
    until (not error);
    writeln(' ');
  end;

  procedure WriteaPacientArr(var p3: patientType; var a3: patientTypeArr);
  //Подпрограмма ввода массива данными о пациентов
  //  i,j - счетчики
  //  number - кол-во приемов
  //  s - данные о приеме
  //  a - массив приемов
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
        'Введите значение элемента, с которого хотите начать ввод/замену: ');
      gotoxy(one, twentyseven);
      clreol;
      CountMax := 7;
      for i := numberMin to numberMin do
        with a3[i] do
        begin
          TestFIO(Name, ' Введите Фамилию: ');
          TestFIO(surname, ' Введите Имя: ');
          TestFIO(patronymic, ' Введите Отчество: ');
          TestSpecialty(addres,
            ' Введите адресс: ');
          TestNumber(numberPolis, CountMax,
            ' Введите номер полиса: ');
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
  {Подпрограмма изменения массива данными о приемах }
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
        'Выберете номер одного элемента, который вы желаете добавить/изменить: ');
      gotoxy(one, twentyseven);    //twentyseven
      clreol;
      with a[number] do
      begin
        Testdate(d);
        TestTime(timestart);
        TestTime(timefinish);
        TestTypeapp(typeapp, 'Введите тип приема:  ');
        TestFioDoc(fiodoc, ' Введите ФИО врача: ');
        TestFioPat(fiopat, ' Введите ФИО пациента: ');
        writeln(' ');
      end;
    until (not error);
    gotoxy(one, 60);
    clreol;
    gotoxy(x, y);
  end;

procedure DeleteDoctorArr(var p2: doctorType; var a2: doctorTypeArr;
 var number: integer);
 //Подпрограмма удаления в массиве данных о студенте
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
       Write('введен неправильный индекс')
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
  //Подпрограмма удаления в массиве данных о студенте
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
        Write('введен неправильный индекс')
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
  //Подпрограмма удаления в массиве данных о студенте
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
        Write('введен неправильный индекс')
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
  //Подпрограмма поиска массива по алфавиту по имени в первой таблице
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
    Write(' Введите имя для поиска:  ');
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
      Write('Такого нет.  ');
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
  {Внутренний цикл уже перебирает элементы и сравнивает между собой.}
  for j:=1 to nmax-i do
  begin
    {Если элемент, больше следующего, то меняем местами.}
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
  {Внутренний цикл уже перебирает элементы и сравнивает между собой.}
  for j:=1 to nmax-i do
  begin
    {Если элемент, больше следующего, то меняем местами.}
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
  {Внутренний цикл уже перебирает элементы и сравнивает между собой.}
  for j:=1 to nmax-i do
  begin
    {Если элемент, больше следующего, то меняем местами.}
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
    {Процедура для передвижения и выбора места записи}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p: appointments; var a: appointmentArr);
 {Key-код нажатия клавиши
  x,y-координаты}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //начальная позиция X
    y := HomeY;       //начальная позиция Y
    gotoxy(x, y);
    StringNumber := one;
    RowsNumber := one;
    CountMax := 2;
    TextAttr := TableColorUnSelected_item;
    gotoxy(one, twentyseven);
    write('выбурите сортировка 1 - тип приема 2 -  пациент 3 - врач ');
      Key := readkey;

        Key := readkey;
        case Key of
          chr(49):  //1   сортировака по типу приема
          begin
          SortTypeApp(p,a);
          end;
          chr(50):  //2 сортировака по Фио пациент
          begin
          SortFIOPatient(p,a);
          end;
          chr(51):  //3  ссортировака по Фио врача
          begin
          SortFIODoctor(p,a);
          end;
        end;
    x := HomeX;
    y := HomeY;
  end;

  procedure MenuFirstTable(var Key: char; var x, y: integer;
    {Процедура для передвижения и выбора места записи}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p: appointments; var a: appointmentArr; var p2: doctorType; var a2: doctorTypeArr);
 {Key-код нажатия клавиши
  x,y-координаты}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //начальная позиция X
    y := HomeY;       //начальная позиция Y
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
          chr(80):               //вниз
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
          chr(77):               //вправо
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
          chr(72):               //вверх
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
          chr(75):               //влево
          begin
            if (RowsNumber > one) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              RowsNumber := RowsNumber - one;
              x := x - cell_width;       //расстояние между
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(59):  //F1   - Добавить значение
          begin
            WriteappointmentArr(p, a, p2, a2, p3, a3);
            clrscr;
            ViewFirstTable(a, itemPage, itemPageMax);
    FirstFrameTable;
    MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
          end;
          chr(60):  //F2   - сортировать
          begin
            SortFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a);
            clrscr;
            ViewFirstTable(a, itemPage, itemPageMax);
    FirstFrameTable;
    MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
          end;
          chr(61):  //F3 - Удаление значения
          begin
            gotoxy(one, 60);
            TestNumber(number, CountMax,
              'Выберете номер одного элемента, который вы желаете удалить: ');
            gotoxy(1, 60);
            clreol;
            DeleteappointmentArr(p, a, number);
            ViewFirstTable(a, itemPage, itemPageMax);
            FirstFrameTable;
            MenuFirstTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p, a, p2, a2);
          end;
          chr(81):  //PageDown - Переход по страницам (след.)
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
          chr(73):  //PageUp - Переход по страницам (пред.)
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
          chr(8): //BackSpace - удаление по стрелкам
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
      if key = chr(8) then //BackSpace - удаление по стрелкам
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
    {Процедура для передвижения и выбора места записи}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p2: doctorType; var a2: doctorTypeArr);
 {Key-код нажатия клавиши
  x,y-координаты}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //начальная позиция X
    y := HomeY;       //начальная позиция Y
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
          chr(80):               //вниз
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
          chr(77):               //вправо
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
          chr(72):               //вверх
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
          chr(75):               //влево
          begin
            if (RowsNumber > one) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              RowsNumber := RowsNumber - one;
              x := x - cell_width;       //расстояние между
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(59):  //F1   - Добавить значение
          begin
            WriteaDoctorArr(p2, a2);
            ViewSecondTable(a2, itemPage, itemPageMax);
            SecondFrameTable;
            MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p2, a2);
          end;
          chr(61):  //F3 - Удаление значения
          begin
            gotoxy(one, 60);
            TestNumber(number, CountMax,
              'Выберете номер одного элемента, который вы желаете удалить: ');
            gotoxy(1, 60);
            clreol;
            DeleteDoctorArr(p2, a2, number);
            ViewSecondTable(a2, itemPage, itemPageMax);
            SecondFrameTable;
            MenuSecondTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
      itemPage, itemPageMax, p2, a2);
          end;
          chr(81):  //PageDown - Переход по страницам (след.)
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
          chr(73):  //PageUp - Переход по страницам (пред.)
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
          chr(8): //BackSpace - удаление по стрелкам
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
      if key = chr(8) then //BackSpace - удаление по стрелкам
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
    {Процедура для передвижения и выбора места записи}
  var StringNumber, RowsNumber, pagenumber, itemPage, itemPageMax: integer;
  var p3: patientType; var a3: patientTypeArr);
 {Key-код нажатия клавиши
  x,y-координаты}
  var
    i, CountMax: integer;
  begin
    x := HomeX;       //начальная позиция X
    y := HomeY;       //начальная позиция Y
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
          chr(80):               //вниз
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
          chr(77):               //вправо
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
          chr(72):               //вверх
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
          chr(75):               //влево
          begin
            if (RowsNumber > one) then
            begin
              gotoxy(x, y);
              TextAttr := TableColorUnselected_item;
              RowsNumber := RowsNumber - one;
              x := x - cell_width;       //расстояние между
              gotoXY(x, y);
              TextAttr := TableColorSelected_item;
            end;
          end;
          chr(59):  //F1   - Добавить значение
          begin
            WriteaPacientArr(p3, a3);
            ViewThirdTable(a3, itemPage, itemPageMax);
              ThirdFrameTable;
          end;
          chr(61):  //F3 - Удаление значения
          begin
            gotoxy(one, 60);
            TestNumber(number, CountMax,
              'Выберете номер одного элемента, который вы желаете удалить: ');
            gotoxy(1, 60);
            DeletePatientArr(p3, a3, number);
            clrscr;
            ViewThirdTable(a3, itemPage, itemPageMax);
            ThirdFrameTable;
            MenuThirdTable(Key, x, y, StringNumber, RowsNumber, pagenumber,
                itemPage, itemPageMax, p3, a3);
          end;
          chr(81):  //PageDown - Переход по страницам (след.)
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
          chr(73):  //PageUp - Переход по страницам (пред.)
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
          chr(8): //BackSpace - удаление по стрелкам
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
      if key = chr(8) then //BackSpace - удаление по стрелкам
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

  procedure MenuToScr; //вывод меню на экран
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
    Write(menu[item]); //выделение строки меню
    TextAttr := ColorUnSelected_item;
  end;

  procedure item1(var a: appointmentArr; var number: integer);
  //Первый пункт меню (Чтение таблицы)
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
      writeln('Ошибка открытия файла №', num)
    else
    begin
       {$I-}
      i := 1;
      while (not EOF(f)) and (num = 0) do
      begin
        num := IOresult;
        if num <> 0 then
          Write('Ошибка eof №', num)
        else
        begin
          Read(f, a[i]);
            {$I+}
          num := IOresult;
          if num <> 0 then
            Write('Ошибка чтения №', num)
          else
            Inc(i);
        end;
        if num = 0 then
        begin
          num := IOresult;
          if num <> 0 then
            Write('Ошибка eof №', num);
        end;
      end;
      number := i - one;
       {$I-}
      Close(f);
       {$I+}
      num := IOresult;
      if num <> 0 then
        Write('Ошибка закрытия файла №', num);
      writeln(' Файл успешно загружен ');
    end;

    RKEnter(Enter);
  end;

  procedure item2(a: appointmentArr);
  //Второй пункт меню (Запись таблицы)
  var
    i: integer;
  begin
    ClrScr;
    Assign(f, 'appointment.dat');
    rewrite(f);
    for i := one to nmax do
      Write(f, a[i]);
    Close(f);
    writeln(' Файл успешно сохранён ');
    RKEnter(Enter);
  end;

  procedure item3;   //Первая таблица
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

  procedure item4;   //Вторая таблица
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

  procedure item5;   //Третья таблица
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

  procedure item8;   //Справка по программе
  begin
    ClrScr;
    writeln(' F1 - Ввод/изменение сразу нескольких элементов в таблице');
    writeln(#10#13' F2 - Ввод/изменение одного элемента в списке(только в открытой таблице)');
    writeln(#10#13' F3 - Удаление одного элемента в списке по выбору');
    writeln(#10#13' BackSpace - Удаление одного элемента в списке по стрелкам');
    writeln(#10#13' PageUp - переход на предыдущую страницу');
    writeln(#10#13' PageDown - переход на следующую страницу');
    writeln(#10#13' Enter - Чтобы изменить одно значение введенного элемента');
    writeln(#10#13' ! Начинайте ввод информации с первой таблицы !');
    writeln(' ');
    RKEnter(Enter);
  end;

  procedure Arrow(var Key: char; var item: integer; var x, y: integer);
  //Процедура стрелок в меню
  begin
    key := ReadKey;
    case key of
      chr(80): //стрелка вниз
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
      chr(72): //стрелка вверх
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
  //Процедура выбора и использований меню
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
          8: key := chr(9);{выход}    //twentyseven
        end;
        MenuToScr;
      end;
    until (item = MaxItemMenu) and (key = chr(9));{27 - Esc}
  end;

begin
  //loadings;
  menu[1] := '  Чтение таблицы (Загрузить из файла) ';
  menu[2] := #10'  Запись таблицы (Сохранить в файл) ';
  menu[3] := #10#10'  1. Таблица Записи на прием';
  menu[4] := #10#10#10'  2. Таблица Врачи ';
  menu[5] := #10#10#10#10'  3. Таблица Пациенты  ';
  menu[6] := #10#10#10#10#10#10'  Поиск по программе ';
  menu[7] := #10#10#10#10#10#10#10'  Инструкция ';
  menu[8] := #10#10#10#10#10#10#10#10'  Выход ';
  item := one;
  x := homey;
  y := homey;
  textcolor(ColorUnSelected_item);
  MenuToScr;
  MenuControl;
end.
