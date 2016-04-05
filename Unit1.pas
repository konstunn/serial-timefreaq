unit Unit1; //ГЛАВНАЯ ПРОГРАММА

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, Menus, ExtCtrls, TeeProcs, TeEngine, Chart, Series, Math,FileCtrl,
	DbChart, TeeFunci, Spin, ComCtrls, shellapi,Grids,inifiles,Registry,
	IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, ScktComp;

function _FInitDrvFDA(FInit_Success,FInit_Error : DWORD):DWORD; external 'drv2fda.dll';
function _FCardsDrvFDA(FCards_Count : DWORD):DWORD; external 'drv2fda.dll';
function _FOpenCardDrvFDA(card: DWORD) : Boolean; external 'drv2fda.dll';


type

	TMySProc = procedure(const S: AnsiString);
	TBaudRate = (cbr110, cbr300, cbr600, cbr1200, cbr2400, cbr4800, cbr9600,
		cbr14400, cbr19200, cbr38400, cbr56000, cbr57600, cbr115200, cbr128000, cbr256000);
		TForm1 = class(TForm)
		GPSndx: TLabel;
		MainMenu1: TMainMenu;
		N1: TMenuItem;
		N2: TMenuItem;
		N3: TMenuItem;
		Glonnam: TLabel;
		N4: TMenuItem;
		PrefFile: TMenuItem;
		N6: TMenuItem;
		N8: TMenuItem;
		N9: TMenuItem;
		N11: TMenuItem;
		N12: TMenuItem;
		NVRAM1: TMenuItem;
		N15: TMenuItem;
		N17: TMenuItem;
		N19: TMenuItem;
		N20: TMenuItem;
		N21: TMenuItem;
		B1: TMenuItem;
		C1: TMenuItem;
		D1: TMenuItem;
		N16: TMenuItem;
		N22: TMenuItem;
		USNO1: TMenuItem;
		SaveDialog1: TSaveDialog;
		N3642: TMenuItem;
		N24: TMenuItem;
		N7: TMenuItem;
		N25: TMenuItem;
		N26: TMenuItem;
		N27: TMenuItem;
		N10: TMenuItem;
		N51: TMenuItem;
		N23: TMenuItem;
		RT1: TMenuItem;
		USNO2: TMenuItem;
		N28: TMenuItem;
		N29: TMenuItem;
		Panel2: TPanel;
		Label15: TLabel;
		Label21: TLabel;
		Label22: TLabel;
		Label23: TLabel;
		Label24: TLabel;
		SR6201: TMenuItem;
		N18: TMenuItem;
		N33: TMenuItem;
		N34: TMenuItem;
		N35: TMenuItem;
		t3200: TMenuItem;
		Label1: TLabel;
		Label9: TLabel;
		Label6: TLabel;
		N5: TMenuItem;
		N13: TMenuItem;
		N14: TMenuItem;
		XAXB1: TMenuItem;
		Label18: TLabel;
		Label19: TLabel;
		Calibrat: TMenuItem;
		N37: TMenuItem;
		N38: TMenuItem;
		Label27: TLabel;
		Label2: TLabel;
		Label7: TLabel;
		Label8: TLabel;
		Label10: TLabel;
		Prefix: TEdit;
		Label3: TLabel;
		Label11: TLabel;
		CS1: TClientSocket;
		Memo1: TMemo;
		stars: TMenuItem;
		Read1: TMenuItem;
		CMD1: TMenuItem;
		INI1: TMenuItem;
		sigma11: TMenuItem;
		sigma21: TMenuItem;
		Label4: TLabel;
		Label5: TLabel;
		chA: TSpinEdit;
		chB: TSpinEdit;
		ExtInt: TCheckBox;
		BaseMode1: TMenuItem;

procedure messlen;//Длина сообщения
procedure groups;// Состояние группировки - номера GPS и литерные ГЛОНАСС
procedure FormShow(Sender: TObject);
procedure Datas;
procedure Number;
procedure Elev;
procedure Dopler;
procedure N3Click(Sender: TObject);
procedure PrefFileClick(Sender: TObject);
procedure rec_data;
procedure N6Click(Sender: TObject);
procedure PrefixKeyPress(Sender: TObject; var Key: Char);
procedure N12Click(Sender: TObject);
function  TRemoveDir(sDir : String) : Boolean;
procedure NVRAM1Click(Sender: TObject);
procedure N18Click(Sender: TObject);
procedure N19Click(Sender: TObject);
procedure ReadINIFile;
procedure SaveINIFile;
procedure N21Click(Sender: TObject);
procedure B1Click(Sender: TObject);
procedure C1Click(Sender: TObject);
procedure D1Click(Sender: TObject);
procedure N22Click(Sender: TObject);
procedure USNO1Click(Sender: TObject);
procedure N24Click(Sender: TObject);
procedure mx;//Обработка
procedure Laundry;//Медианная фильтрация
procedure N7Click(Sender: TObject);
procedure N25Click(Sender: TObject);//Фильтрация
procedure GetMJD;
function Julian_Date_of_Year(yer : double) : double;
function DOY(yr,mo,dy : word) : word;
procedure N26Click(Sender: TObject);
procedure N27Click(Sender: TObject);
function StCopyFile( InFile,OutFile: String; From_F,Count_F: Longint ): Longint;
procedure Scale_count;
procedure GONOmess;//  Offset_GPS,Offset_ГЛОНАСС .
procedure coords_geo;
procedure N51Click(Sender: TObject);
procedure N23Click(Sender: TObject);
procedure USNO2Click(Sender: TObject);
procedure N28Click(Sender: TObject);
procedure N29Click(Sender: TObject);
procedure SR6201Click(Sender: TObject);
procedure FormCreate(Sender: TObject);
procedure N34Click(Sender: TObject);
procedure N35Click(Sender: TObject);
procedure izmer620;
procedure N13Click(Sender: TObject);
procedure N14Click(Sender: TObject);
procedure XAXB1Click(Sender: TObject);
procedure timtr;
procedure gCalibrator;
procedure Show1Click(Sender: TObject);
procedure Becar1Click(Sender: TObject);
procedure N37Click(Sender: TObject);
procedure N38Click(Sender: TObject);
procedure SoLongGNSS;
procedure Repository;
procedure Dir_Exists;
procedure CS1Connect(Sender: TObject; Socket: TCustomWinSocket);
procedure CS1Read(Sender: TObject; Socket: TCustomWinSocket);
procedure FirstDialog;
procedure find_beg;
procedure dir_set;//Sigma
procedure Event_XA;
procedure Event_XB;
procedure starsClick(Sender: TObject);
procedure CMD1Click(Sender: TObject);
procedure INI1Click(Sender: TObject);
procedure Connecting;
procedure sigma11Click(Sender: TObject);
procedure sigma21Click(Sender: TObject);
procedure t3200Click(Sender: TObject);//Соединение...
function METER_ReaddWord(address: byte): dword;
procedure InitAll;
procedure CalRes;
procedure izmer_t3200;
procedure chAChange(Sender: TObject);
procedure chBChange(Sender: TObject);
procedure Tic_enable;
procedure ExtIntClick(Sender: TObject);
procedure BaseMode1Click(Sender: TObject);

	private
		{ Declarations private }
		kont_ichas:Double;
	public
		{ Declarations published }
		sistr,nnstr,sumstr:string;
		fl_connect:byte;
		stext,btext:string;
		pos_go,pos_no:word;//Позиция в файле GO,NO
		address_IP,password:string;//IP адрес приемника , если он подключен в сетку.
		control_wrd,int_ext,cs_counter:dword;
		Disc,GlobalDir:string;
		fhour_jps,fcommon_jps:File;
		clock_corr:Real;//Поправка на генератор измерителя T3100
		sclock_corr:string;//Поправка на генератор измерителя T3100(текст)
		sendf:byte;//1-пересылка в mailbox; 0-без таковой.
		fl_calibr,fcalibr,calib_on:byte;//Сообщение от калибратора
		GPSRef:byte;//Опорное время для режима XA&XB
		fixpos:byte;
		cabdelay:Integer;//Компенсационная кабельная задержка.
		tot_read:dword;
		hr,mr,sr,sc_ndx:Longint;
		hb,mb,sb:Longint;
		hourtochange,hourtocopy:word;//Момент переключения суток и момент копирования файлов
		dir_h,dir_c,dir_t:string;//Директории в репозитории,кудабудут копироваться файлы
		str_dev:array[1..40] of byte;
		Flag_bad_value:byte;
		rectype_1:byte;//Тип приемника:sigma1=1;sigma2=2
		copycounter:word;
		fl_dev,no_show:byte;//Какой TIC в работе,без показа данных
		result_cal:Boolean;//Результат калибровки T2600
		ffirstrun:byte;
		piece_of_datas:byte;//Когда пишем-тогда и на форму.
		messervice:boolean;//Флаг разрешения рассылки сообщений.
		str_rep,target_dir,copy_dir:String;//Адрес машины-приемника сообщений и репозитория файлов.
		SendSize: integer;//Размер передаваемого в репозиторий файла
		Result_F,IntName,UintName:Integer;
		MS: TMemoryStream; // Рождаем буфер для файла
		SendFileName_h,SendFileName_c,SendFileName_t:shortstring;//Файл с данными для передачи по сети.
		f_log_mess:Shortstring;//Файл сообщений для передачи по сети
		f_lt_mess:TextFile;    //Файл сообщений для передачи по сети
		emerg_message:string;//Текст сообщения операторам.
		f_log:Shortstring;//Логфайл сбоев
		f_lt:TextFile;    //Логфайл сбоев
		sDir,NewName,delnames,names,ff:string;
		ext_int:byte;//Внешняя(0) Внутренняя(1)  опора
		tied_on:byte;//Привязка к опорной шкале(USNO) времени (1-да; 0-нет)
		not_busy_counter:byte;//Флаг занятости потока измерителя
		totalsat:byte;//Общее число спутников(G+N)
		repts:byte;//Кол-во попыток чтения измерителя.
		elmask:String;//Маска  угла
		showdatas:string;//Какие данные принимаем.
		fshow:byte;//Флаг этих данных
		cmdstring:array[0..100] of shortstring;//Из CMD-файла
		us,ru:byte;
		prepare:byte;           //Флаг начальных сообщений
		tmj,tmfr:string;
		qwant_rus:byte;         //Количество бортов Глонасс из NN
		number_of_days:word;    //Число дней от начала года
		jd:Double;
		eltime:LongInt;//Время в работе программы.
		rectify:byte;           //Данные в график : отфильтрованные(1) или нет(2)
		Ms_gln,Mt_gln,Ms_gps,Mt_gps:Double;
		med:byte;
		nextime:LongInt;//Для записи в файл
		startprogtime:LongInt;           //время запуска программы
		itime_local:Double;
		flag_countdown:byte;    //Флаг .
		Rec_Int,countdown:Integer;//Период записи в файл и счетчик для этого.
		flag_TR:byte;          //Запуск потока(1) или останов(0) Ч3-64
		f_work:byte;
		rtext:array[1..40] of Integer;
		ndx:array[1..40]   of char;
		text1,text2,vch3151,buftowr:String;
		dplr_ru:array[1..40]   of Real;
		dplr_us:array[1..40]   of Real;
		azim_sat:array[1..40]   of word;
		elev_sat:array[1..40]   of byte;
		ru_azim_sat:array[1..40]   of word;
		us_azim_sat:array[1..40]   of word;
		ru_elev_sat:array[1..40]   of byte;
		us_elev_sat:array[1..40]   of byte;
		sat_tim_r:array[1..40] of Double;
		sat_tim_u:array[1..40] of Double;
		rus_nom:array[1..24] of integer;
		all_sat:array[1..40]   of integer;
		rus_lit:array[1..40]   of integer;
		usa_sat:array[1..40]   of integer;
		mass:array[1..8192] of char;
		arr_n:array[0..86400] of Double;
		arr_g:array[0..86400] of Double;
		fdelay:array[1..14] of String;
		calendar:array[1..12] of byte;

		ga:array[1..150] of char;
		ge:array[1..150] of char;
		na:array[1..150] of char;
		ne:array[1..150] of char;

		gal,nal,gel,nel,gcall:Integer;//Длина сообщения GA NA GE NE
		gab,nab,geb,neb:char;   //Предыдущие сообщения GA NA GE NE
		gaf,naf,gef,nef,gcal:byte;   //Флаги пойманных сообщений GA NA GE NE

		sPort,hPort: THandle;
		DeviceIndex,bytesread :dword;
		comportname,ticport:String;
		bmpname:string;
		Flag_writefile,C:byte;
		pos_begn,pos_end,Flag_tuning:byte;
		rec_port,time_r:string;
		date_for_files:shortstring;
		hh,mh,sh,mst:word;
		RYear, RMonth, RDay,Rhour,Rmin,Rsec,Rmsec:word;//Эпоха приемника
		Year, Month, Day,hour,min,sec,msec:word;//Системная эпоха
		Filname_ord:byte;           //Сквозное имя.
		Filname_dat:byte;           //Имя по дате.
		prefx:ShortString;
		fil_out:TextFile;
		FlagNewFile:byte;
		ord_com_file,ord_recent_file:Integer;
		flag_switch_on_writing:byte;//Флаг включения записи в файлы .
		fl_elapsed,f_start:byte;
		fl_date_en:byte;            //Разрешение синхронизации даты и времени.
		f_buf,year_r,mon_r,day_r:integer;
		ichas:Double;
		xa_chas_ms:Double;
		xb_chas_ms:Double;
		xa_chas_ns:Double;
		xb_chas_ns:Double;
		exefile:byte;              // Текст.файл
		rus_s,usa_s,date_r,datetosend:ShortString;
		gln,gps,tgln,tgps:Double;
		new_datas:byte;
		glotimesend:byte;
		count:dword;
		Selected_Device_Serial_Number : String;
		Selected_Device_Description : String;
	end;

type METER_INT_RESULT = record
	dwCounter : DWORD; { number of interrupts received }
	dwLost : DWORD; { number of interrupts yet to be handled }
	fStopped : BOOL; { was interrupt disabled during wait }
end;
type PMETER_INT_RESULT = ^METER_INT_RESULT;
type METER_INT_HANDLER = procedure(pWorker : POINTER; intResult :
	PMETER_INT_RESULT) stdcall;

var
	ninifile: tinifile;
	Form1: TForm1;
	fc64h:TextFile;
	fc64c:TextFile;
	fil_inn:File of byte;


	addr:DWORD;
	card,data:DWORD;
	Valstr:string;
	calibrs,resl:Double;
	tr1,tr2:Integer;

implementation

uses unit3,unit5,D2XXUnit,Unit4;



{$R *.dfm}
var

	sFileName :String;
	a:char;
	cnt: array[1..10] of byte;
	PrefDir:byte;//Для ввода префикса(1) либо интервала записи(2) либо...
	ready_data:byte;
	Present: TDateTime;
	h,m,s,rectime:ShortString;
	rec_port_ini:String;
	tim_text:String;//Время из сообщения 'ТМ' .
	hPort: THandle;
	DCB: TDCB;
	CommTimeOuts:TCommTimeOuts;
	Xmax,Xmin,group_change,num,count_f:LongInt;
	lims,h_ep,m_ep,s_ep,p,n_rus,n_usa,indx,size_file,size_f:LongInt;
	L1,L2,L3,L4,L5:char;
	fp_ini:ShortString;
	no_string:ShortString;
	go_string:ShortString;
	za_string:ShortString;
	zb_string:ShortString;
	tt,base_str:ShortString;
	p2:LongInt;
	pos_time:Longint;
	cnt_sat:Longint;
	Ymax,Ymin:real;
	fl_off,k1,k2,f_new:byte;
	f_view:byte;
	BytesRead:dword;
	fl_com:byte;
	fil_out_com:TextFile;
	tst,fp_out_com:ShortString;
	fl_mess:byte;
	c:String;

function TForm1.StCopyFile( InFile,OutFile: String; From_F,Count_F: Longint ): Longint;
var
	InFS,OutFS: TFileStream;
begin
	InFS := TFileStream.Create( InFile, fmOpenRead );//создаем поток
	OutFS := TFileStream.Create( OutFile, fmCreate );//создаем поток
	InFS.Seek( From_F, soFromBeginning );//перемещаем указатель в From
	Result_F := OutFS.CopyFrom( InFS, Count_F );
	InFS.Free;//освобождаем
	OutFS.Free;//освобождаем
end;

function TForm1.TRemoveDir(sDir : String) : Boolean;//Удаление файлов из
var                                                 //рабочих директорий
iIndex : Integer;
SearchRec : TSearchRec;
sFileName : String;
begin
	Result := False;
	sDir := sDir + '\*.*';
	iIndex := FindFirst(sDir, faAnyFile, SearchRec);
	while iIndex = 0 do begin
		sFileName := ExtractFileDir(sDir)+'\'+SearchRec.Name;
		if SearchRec.Attr = faDirectory then begin
			if (SearchRec.Name <> '' ) and
			(SearchRec.Name <> '.') and
			(SearchRec.Name <> '..') then
				TRemoveDir(sFileName);
			end else begin
				if SearchRec.Attr <> faArchive then
					FileSetAttr(sFileName, faArchive);
				if not DeleteFile(sFileName) then
					ShowMessage('Не могу удалить ' + sFileName);
			end;
			iIndex := FindNext(SearchRec);
		end;
		FindClose(SearchRec);
		Result := True;
	end;


procedure TForm1.FormShow(Sender: TObject);
label m1;
var
	i:Integer;
	a,Txt1:String;
	tb:Real;
begin
	GetDir(0,Disc);
	Disc:=ExtractFileDrive(Disc);

	if not( DirectoryExists(Disc+'\legacy\'))            then Createdir(Disc+'\legacy\');
	if not( DirectoryExists(Disc+'\legacy\Rawfiles_c\')) then Createdir(Disc+'\legacy\Rawfiles_c\');
	if not( DirectoryExists(Disc+'\legacy\Rawfiles_h\')) then Createdir(Disc+'\legacy\Rawfiles_h\');
	if not( DirectoryExists(Disc+'\legacy\Syncro_c\'))   then Createdir(Disc+'\legacy\Syncro_c\');
	if not( DirectoryExists(Disc+'\legacy\Syncro_h\'))   then Createdir(Disc+'\legacy\Syncro_h\');
	if not( DirectoryExists(Disc+'\legacy\MailBox\'))    then Createdir(Disc+'\legacy\MailBox\');
	if not( DirectoryExists(Disc+'\legacy\Logs\'))       then Createdir(Disc+'\legacy\Logs\');
	if not( DirectoryExists(Disc+'\legacy\Mjd_File\'))   then Createdir(Disc+'\legacy\Mjd_File\');
	if not( DirectoryExists(Disc+'\legacy\Room\'))       then Createdir(Disc+'\legacy\Room\');

	DecodeTime(TdateTime(time),hour,min,sec,msec);
	DecodeDate(TdateTime(date), Year, Month, Day);
	hourtochange:=23;  //Час смены суточных файлов .
	hourtocopy  :=00;  //Час копирования файлов в репозиторий.
	N19.Enabled:=False;//Запись
	fcalibr:=0;
	calib_on:=0;//Вкл\выкл калибратора
	prepare:=0;
	piece_of_datas:=0;
	GPSRef:=0;
	flag_switch_on_writing:=0;//Флаг включения записи в файлы .
	new_datas:=0;
	eltime:=0;//Время в работе программы
	FlagNewFile:=0;
	rectype_1:=1;
	fshow:=0;//Не показывать данные в Form3!
	target_dir:='\\timeguard\vix\ps\'+'emergency.txt';
	Prefix.Visible:=False;
	flag_countdown:=0;//Флаг разрешения работы счетчика записей .
	not_busy_counter:=0;
	DeviceIndex:=0;//Число приборов T3200
	FT_Device_Count:=0;//Число приборов T3200
	count:=0;
	f_buf:=0;
	Flag_tuning:=0;
	exefile:=0;//флаг записи тхт файла.
	startprogtime:=0;//
	ichas:=0;
	Form1.Width:=296;
	CMD1.Enabled:=false;
	INI1.Enabled:=false;
	for i:=0 to 86400 do
	begin
		arr_n[i]:=0;
		arr_g[i]:=0;
	end;
	present:=Now;
	a:=IntToStr(year);
	Delete(a,1,2);
	date_r:='';
	DecimalSeparator:='.';
	fl_date_en:=0;                      //Разрешение синхронизации даты и времени.
	f_start:=0;                         //запись шапки в общий файл.
	Flag_writefile:=0;                  //Флаг записи файла.
	cnt_sat:=0;
	//Порт открыт .
	fl_off:=1;                         //Если 1 - то вычисление разности шкал с последним значением.
	fl_elapsed:=0;                     //Флаг времени работы.
	fl_mess:=1;                        //Флаг опорных значений



	//  RunSR.Enabled:=True;
	if fixpos=1 then
	begin
		Label21.Caption:=Label21.Caption+'FixPoint';
		Label22.Caption:=Label22.Caption+'FixPoint';
		Label23.Caption:=Label23.Caption+'FixPoint';
	end
	else
	begin
		Label21.Caption:=Label21.Caption+'FreePoint';
		Label22.Caption:=Label22.Caption+'FreePoint';
		Label23.Caption:=Label23.Caption+'FreePoint';
	end;
	m1:
		calendar[1]:=31;
		calendar[2]:=28;
		calendar[3]:=31;
		calendar[4]:=30;
		calendar[5]:=31;
		calendar[6]:=30;
		calendar[7]:=31;
		calendar[8]:=31;
		calendar[9]:=30;
		calendar[10]:=31;
		calendar[11]:=30;
		calendar[12]:=31;
		cs_counter:=0;

		GetFTDeviceCount;//есть-ли T3200?
		S := IntToStr(FT_Device_Count);
		if FT_Device_Count =1 then//Число приборов T3200=1
begin
	count:=1;//1 - значит прибор есть
	GetFTDeviceSerialNo(DeviceIndex);
	Selected_Device_Serial_Number:=FT_Device_String;
	GetFTDeviceDescription (DeviceIndex);
	Selected_Device_Description:=FT_Device_String;
	DeviceIndex := DeviceIndex + 1;
	t3200.Enabled:=True;
	Label10.Visible:=True;
	Label10.Caption:=' Serial = '+Selected_Device_Serial_Number;
	chA.Visible:=False;
	chB.Visible:=False;
	Label4.Visible:=False;
	Label5.Visible:=False;
	Label11.Visible:=False;
	ExtInt.Visible:=False;
end;

end;

procedure TForm1.t3200Click(Sender: TObject);
begin
	if count =2 then
	begin
		Set_USB_Device_TimeOuts(500,500);
		fl_dev:=1;
		CalRes;//калибровка
		Form1.Width:=413;
		ffirstrun:=1;//Первый запуск
		chA.Visible:=True;
		chB.Visible:=True;
		Label4.Visible:=True;
		Label5.Visible:=True;
		Label11.Visible:=True;
		ExtInt.Visible:=True;
	end;
end;


procedure TForm1.ReadINIFile;
begin
	if rectype_1=1 then  ninifile := TIniFile.Create('\\px12-350r\external\sigma1\Room\tune_all_jts.ini');
	if rectype_1=2 then  ninifile := TIniFile.Create('\\px12-350r\external\sigma2\Room\tune_all_jts.ini');
	sendf:=ninifile.readinteger('Файлы','SendFTP',sendf);
	ord_com_file:=ninifile.readinteger('Файлы','Общий файл',ord_com_file);
	copycounter:=ninifile.readinteger('Файлы','N копии файла',copycounter);
	password:=ninifile.readstring('Порты','Пароль',password);
	ticport:=ninifile.readstring('Порты','Порт sr620 ',ticport);
	prefx:=ninifile.readstring('Файлы','Префикс',prefx);
	fl_dev:=ninifile.readinteger('Выбор измерителя','0(SR620) 1(T2600) 2(XA$XB) 3(No one)',fl_dev);
	address_IP:=ninifile.readstring('Порты','Sigma1_net  ',address_IP);
	Filname_dat:=ninifile.readinteger('Файлы','По дате  ',Filname_dat);
	elmask:=ninifile.readstring('Координаты','Маска угла - Угол',elmask);
	fixpos:=ninifile.readinteger('Координаты','Фикс.точка',fixpos);
	cabdelay:=ninifile.readinteger('Координаты','Каб.задержка',cabdelay);
	Rec_Int:=ninifile.readinteger('Интервал записи','В файл  ',Rec_Int);
	sclock_corr:=ninifile.readstring('Редукция T3100','Значение ',sclock_corr);
	ext_int:=ninifile.readinteger('Опорный генератор','0-5мГц 1-10мГц 2-внутренний',ext_int);
	tied_on:=ninifile.readinteger('Метка времени','0-свободная  1-USNO',tied_on);
	messervice:=ninifile.readbool('Рассылка сообщений','True-да  False-нет',messervice);
	target_dir:=ninifile.readstring('Рассылка сообщений','Директория и файл : ',target_dir);
	glotimesend:=ninifile.readinteger('Рассылка сообщений','Время ЦС ГЛОНАСС 0-нет  1-да : ',glotimesend);
	copy_dir:=ninifile.readstring('Рассылка сообщений','Репозиторий,Директория и файл : ',copy_dir);
	ninifile.free;
end;


procedure  TForm1.SaveINIFile;
begin
	if rectype_1=1 then  ninifile := TIniFile.Create('\\px12-350r\external\sigma1\Room\tune_all_jts.ini');
	if rectype_1=2 then  ninifile := TIniFile.Create('\\px12-350r\external\sigma2\Room\tune_all_jts.ini');
	ninifile.writeinteger('Файлы','SendFTP',sendf);
	ninifile.writeinteger('Файлы','Общий файл',ord_com_file);
	ninifile.writeinteger('Файлы','N копии файла',copycounter);
	ninifile.writestring('Порты','Пароль',password);
	ninifile.writestring('Порты','Порт sr620 ',ticport);
	ninifile.writestring('Файлы','Префикс',prefx);
	ninifile.writeinteger('Выбор измерителя','0(SR620) 1(T2600) 2(XA$XB) 3(No one)',fl_dev);
	ninifile.writestring('Порты','Sigma1_net  ',address_IP);
	ninifile.writeinteger('Файлы','По дате  ',Filname_dat);
	ninifile.writestring('Координаты','Маска угла - Угол',elmask);
	ninifile.writeinteger('Координаты','Фикс.точка',fixpos);
	ninifile.writeinteger('Координаты','Каб.задержка',cabdelay);
	ninifile.writeinteger('Интервал записи','В файл  ',Rec_Int);
	ninifile.writestring('Редукция T3100','Значение ',sclock_corr);
	ninifile.writeinteger('Опорный генератор','0-5мГц 1-10мГц 2-внутренний',ext_int);
	ninifile.writeinteger('Метка времени','0-свободная  1-USNO',tied_on);
	ninifile.writebool('Рассылка сообщений','True-да  False-нет',messervice);
	ninifile.writestring('Рассылка сообщений','Директория и файл : ',target_dir);
	ninifile.writeinteger('Рассылка сообщений','Время ЦС ГЛОНАСС 0-нет  1-да : ',glotimesend);
	ninifile.writestring('Рассылка сообщений','Репозиторий,Директория и файл : ',copy_dir);
	ninifile.free;
end;


procedure TForm1.rec_data;//Дата с приемника
label m1;
var
	i,j:LongInt;
	d,m:ShortString;
	td:TSystemTime;
	newtime,newdate:string;
begin
	if lims=0 then goto m1;
	j:=5;
	year_r:=256*ord(text1[7])+ord(text1[6]);
	mon_r:=ord(text1[8]);
	day_r:=ord(text1[9]);
	number_of_days:=0;//Количество дней от начала года .
	for i:=1 to mon_r-1 do number_of_days:=number_of_days+calendar[i];
	number_of_days:=number_of_days+day_r;
	d:=IntToStr(day_r);
	m:=IntToStr(mon_r);
	day:=day_r;
	month:=mon_r;
	year:=year_r;
	if Length(d)<=1 then d:='0'+d;
	if Length(m)<=1 then m:='0'+m;
	datetosend:=IntToStr(year_r)+'-'+m+'-'+d;
	date_r:=d+'.'+m+'.'+IntToStr(year_r);//Дата для данных внутри файла
	date_for_files:=IntToStr(year_r)+m+d;//Для имен файлов
	Delete(date_for_files,1,2);
	Label9.Caption:='Дата(gps)     '+date_r;
	if fl_date_en=0 then
	begin
		//Установка эпохи машины .
		newtime:=IntToStr(hr)+TimeSeparator+IntToStr(Form1.mr)+TimeSeparator+IntToStr(sr);
		newdate:=IntToStr(day_r)+DateSeparator+IntToStr(mon_r)+DateSeparator+IntToStr(Year_r);
		DateTimeToSystemTime(StrToDateTime(NewDate)+StrToDateTime(NewTime),td);
		SetLocalTime(td);
		N19.Enabled:=True;//Запись
	end;
	fl_date_en:=1;//Разрешение синхронизации даты и времени.
	m1://Выход по ошибке.
end;


procedure TForm1.messlen;//Длина сообщения
label m1;
var
	n1,n2,n3:byte;
begin
	lims:=0;
	n1:=ord(L1);
	n2:=ord(L2);
	n3:=ord(L3);
	if n1 in[$30..$39] then n1:=n1-$30 else if n1 in[$41..$46] then n1:=n1-$37;
	if n2 in[$30..$39] then n2:=n2-$30 else if n2 in[$41..$46] then n2:=n2-$37;
	if n3 in[$30..$39] then n3:=n3-$30 else if n3 in[$41..$46] then n3:=n3-$37;
	if (n1 in[0..15])and(n2 in[0..15])and(n3 in[0..15]) then
		try lims:=256*n1+16*n2+n3//Длина сообщения
except
	lims:=0;
end;
if lims>512 then lims:=0;
end;



procedure TForm1.GONOmess;//  Offset_GPS,Offset_ГЛОНАСС .
label egono;
var
	i,l:Integer;
	gr:^Real;
	g4:Real;
	go:array[1..8] of byte;
begin
	if (lims=0)or(lims>17) then goto egono;
	for l:=1 to 8 do go[l]:=0;
	l:=1;
	for i:=6 to 13 do
	begin
		go[l]:=ord(text1[i]);
		l:=l+1;
	end;
	gr:=@go;
	g4:=gr^*1e9;
	if (pos_go>0)and(pos_no=0) then tgps:=g4;
	if (pos_no>0)and(pos_go=0) then tgln:=g4;
	egono:
		pos_go:=0;
		pos_no:=0;
	end;


procedure TForm1.Scale_count;//Расчет положения шкалы эталона отн ЦС.
var
	i:Integer;
	dt:real;
begin
	dt:=tgps-tgln;//разность GO NO времен
	if fl_dev<>2 then  Label3.Visible:=False;
	if fl_dev=3 then label2.Caption:='Без измерителя';
	if (fl_dev=0)or(fl_dev=1) then
	begin
		label2.Caption:='1pps-РШ       '+FloatToStrF(ichas,ffFixed,12,3)+' нc  ';
		if tgps<0 then gps:=1e9-ichas+tgps;
		if tgln<0 then gln:=1e9-ichas+tgln;
		if tgps>0 then gps:=-(ichas-tgps);
		if tgln>0 then gln:=-(ichas-tgln);
	end;
	if (fl_dev=3) then
	begin
		gps:=tgps;
		gln:=tgln;
	end;
	if (fl_dev=2) then
	begin
		Label3.Visible:=True;
		gps:=xa_chas_ns;
		gln:=xb_chas_ns;
		if xb_chas_ns=0 then gln:=xa_chas_ns+dt;
		label2.Caption:='XA='+FloatToStrF(xa_chas_ns,ffFixed,12,1)+'нс ';
		Label3.Caption:='XB='+FloatToStrF(xb_chas_ns,ffFixed,12,1)+'нс';
	end;

	try Label7.Caption:='РШ (GPS)    '+FloatToStrF((gps),ffFixed,10,1)+' нc  ' except Label7.Caption:='РШ (GPS) = NaN' end;
	try Label8.Caption:='РШ (GLO)    '+FloatToStrF((gln),ffFixed,10,1)+' нc  ' except Label8.Caption:='РШ (GLO) = NaN' end;

	if ((abs(gps)< 2000.0) and (abs(gln)< 2000.0)and (abs(gps)> 100.0) and (abs(gln)> 100.0))or(fl_dev=2)then
	begin
		begin
			arr_g[sc_ndx]:=abs(Trunc(gps));
			arr_n[sc_ndx]:=abs(Trunc(gln));
		end;
	end;
	if ((hr=0)and(mr=0)and(sr=0)) then
		for i:=0 to 86400 do
		begin
			arr_n[i]:=0;
			arr_g[i]:=0;
			startprogtime:=0;
			sc_ndx:=0;
		end;
	end;


procedure TForm1.Event_XA;
label exa;
var
	i:Integer;
	s1,s2,l:Integer;
	gr:^LongInt;
	g4:LongInt;
	xa:array[1..4] of byte;
begin
	L1:=text1[3];
	L2:=text1[4];
	L3:=text1[5];
	messlen;
	if (lims=0)or(lims>10) then goto exa;
	for l:=1 to 4 do xa[l]:=0;

	l:=1;
	for i:=6 to 9 do
	begin
		xa[l]:=ord(text1[i]);
		l:=l+1;
	end;
	gr:=@xa;
	g4:=gr^;
	xa_chas_ms:=g4;
	/////////////////////
	for l:=1 to 4 do xa[l]:=0;
	l:=1;
	for i:=10 to 13 do
	begin
		xa[l]:=ord(text1[i]);
		l:=l+1;
	end;
	gr:=@xa;
	g4:=gr^;
	xa_chas_ns:=g4;
	ichas:=xa_chas_ns;
	exa:
		end;


procedure TForm1.Event_XB;
label exb;
var
	i:Integer;
	s1,s2,l:Integer;
	gr:^LongInt;
	g4:LongInt;
	xb:array[1..4] of byte;
begin
	L1:=text1[3];
	L2:=text1[4];
	L3:=text1[5];
	messlen;
	if (lims=0)or(lims>10) then goto exb;
	for l:=1 to 4 do xb[l]:=0;
	l:=1;
	for i:=6 to 9 do
	begin
		xb[l]:=ord(text1[i]);
		l:=l+1;
	end;
	gr:=@xb;
	g4:=gr^;
	xb_chas_ms:=g4;
	/////////////////////
	for l:=1 to 4 do xb[l]:=0;
	l:=1;
	for i:=10 to 13 do
	begin
		xb[l]:=ord(text1[i]);
		l:=l+1;
	end;
	gr:=@xb;
	g4:=gr^;
	xb_chas_ns:=g4;
	ichas:=xb_chas_ns;
	exb:
		end;


procedure TForm1.groups;// Состояние группировки - номера GPS и литерные ГЛОНАСС
label m1;
var                       // на данный момент времени
symb:char;
i,j,k,g:LongInt;
mu,mr,m:byte;
satell,sput:ShortString;
hintstring:string;
begin
	hintstring:='';
	m:=1;
	mu:=1;
	mr:=1;
	ru:=0;
	us:=0;
	if lims=0 then goto m1;
	for i:=1 to 40 do rus_lit[i]:=99;
	for i:=1 to 40 do usa_sat[i]:=99;
	for i:=1 to 40 do ndx[i]:=' ';
	//
	for i:=6 to lims+4 do
	begin
		if((ord(text1[i])<=37)and(ord(text1[i])>=1)) then
		begin
			try
				usa_sat[mu]:=ord(text1[i]);
				ndx[m]:='u';
				hintstring:=hintstring+' '+IntToStr(usa_sat[mu]);
				inc(m);
				inc(mu);
				inc(us);
			except
		end;
	end;
	if(ord(text1[i])in[37..70])then
	begin
		try
			rus_lit[mr]:=ord(text1[i])-45;
			ndx[m]:='r';
			inc(m);
			inc(mr);
			inc(ru);
		except
	end;
end;
end;
//
usa_s:=IntToStr(us);
if (us<>n_usa)or(ru<>n_rus) then group_change:=1;
if Length(usa_s)=1 then usa_s:='0'+usa_s;//Число GPS
GPSndx.Caption:='GPS  : '+usa_s+' units';
GPSndx.Hint:=hintstring;

rus_s:=IntToStr(ru);
if Length(rus_s)=1 then rus_s:='0'+rus_s;//Число Глонасс
Glonnam.Caption:='ГЛОНАСС  : '+rus_s+' units';

totalsat:=us+ru;
n_rus:=ru;
n_usa:=us;

m1://Выход по ошибке.
end;


procedure TForm1.Number;
label m1;
var                       // на данный момент времени
symb:char;
i,j,k:LongInt;
m:byte;
satell,sput:ShortString;
rus_buf:array[1..40] of Integer;
hintstring:string;
begin
	hintstring:='';
	for m:=1 to 24 do rus_nom[m]:=0;
	m:=1;
	ru:=0;
	if lims=0 then goto m1;
	for i:=6 to lims+4 do
	begin
		if((ord(text1[i])<=24)and(ord(text1[i])>=1))or(ord(text1[i])=255) then
		begin
			try
				rus_nom[m]:=ord(text1[i]);
				inc(m);
				inc(ru);
			except
		end;
	end;
end;

if group_change=1 then
begin
	with Form4.rusvisible do
		for i:=1 to ColCount do
			for j:=1 to RowCount do
				cells[i,j]:='';
			Form4.rusvisible.Refresh;
			group_change:=0;
		end;

		k:=1;
		With Form4.RusVisible do
			for i:=1 to ru do//row
		begin
			try
				sput:=IntToStr(rus_nom[i]);
				if length(sput)=1 then sput:='0'+sput;
				if rus_nom[i]>0   then cells[0,k]:=sput; //Слот
				if rus_nom[i]=255 then cells[0,k]:='??'; //Неправильный спутник,но есть литерная
				hintstring:=hintstring+' '+sput;
begin
	sput:=IntToStr(rus_lit[i]);
	if length(sput)=1 then sput:='0'+sput;
	if (rus_lit[i]<99) then cells[1,k]:=sput;//Литерa
end;
if rus_nom[i]>0 then k:=k+1;
		except
	end;
end;
qwant_rus:=k;
Glonnam.Hint:=hintstring;
m1://Выход по ошибке.
end;


procedure TForm1.Elev;
label m1;
var
	Rect:Trect;
	i,j,k:LongInt;
	mr:byte;
	satell,sput:ShortString;
begin
	sput:='';
	satell:='';
	mr:=1;
	L1:=text1[3];
	L2:=text1[4];
	L3:=text1[5];
	messlen;
	if lims=0 then goto m1;
	for i:=6 to lims+5 do
	begin
		try
			if ndx[i-5]='r' then
			begin
				ru_elev_sat[mr]:=(ord(text1[i])and$7F);
				inc(mr);
			end;
		except
	end;
end;
k:=1;
With Form4.RusVisible do
	for i:=1 to mr-1 do
	begin
		if dplr_ru[i] >0 then cells[2,k]:='+'+IntToStr(ru_elev_sat[i]);
		if dplr_ru[i] <0 then cells[2,k]:='-'+IntToStr(ru_elev_sat[i]);
		if dplr_ru[i] =0 then cells[2,k]:=IntToStr(ru_elev_sat[i]);
		k:=k+1;
		if ru_elev_sat[i]>90 then k:=k-1;
	end;

	m1://Выход по ошибке.
end;


procedure TForm1.Dopler;
label m1;
var
	i5:LongInt;
	dr:^Integer;
	dd:byte;
	pos,i,j,s1,s2,l,k,kr:Integer;
	mes:array[1..4] of byte;
begin
	//goto m1;
	pos:=6;
	L1:=text1[3];
	L2:=text1[4];
	L3:=text1[5];
	messlen;
	if lims=0 then goto m1;
	k:=1;
	kr:=1;
	i:=1;
	for j:=1 to totalsat do
	begin
		s1:=pos;
		s2:=pos+3;
		pos:=pos+4;
		l:=1;
		for i:=s1 to s2 do
		begin
			try
				mes[l]:=ord(text1[i]);
				l:=l+1;
			except
		end;
	end;

	if ndx[j]='r' then
	begin
		try
			i5:=not(ord(mes[1]))+not(ord(mes[2]))*256+not(ord(mes[3]))*65536+not(ord(mes[4]))*16777216;
			dplr_ru[kr]:=(i5*1e-7);
		except
	end;
	kr:=kr+1;
end;
	 end;
	 k:=1;
	 With Form4.RusVisible do
		 for i:=1 to kr-1 do
		 begin
			 try
				 cells[3,k]:=FloatToStrF(dplr_ru[i],ffFixed,3,1);
				 k:=k+1;
			 except
		 end;
	 end;
	 m1://Выход по ошибке.

 end;


procedure TForm1.timtr;
var
	i,j,rs,gs,l,k:integer;
	value_tr,value_tu:string;
	sat_tr:Double;
begin
	rs:=1;
	gs:=1;
	for j:=30 to lims do
	begin
		if text1[j]='R' then
		begin
			value_tr:='';
			for i:=j+4 to j+9 do if(ord(text1[i])in[$30..$39])or(text1[i]='.')or(text1[i]='+')or(text1[i]='-')then
				value_tr:=value_tr+text1[i];
			if value_tr='' then value_tr:='0';
			try
				sat_tim_r[rs]:=StrToFloat(value_tr);
				rs:=rs+1;
			except
		end;
	end;
end;
for j:=30 to lims do
begin
	if text1[j]='G' then
	begin
		value_tu:='';
		for i:=j+4 to j+9 do if(ord(text1[i])in[$30..$39])or(text1[i]='.')or(text1[i]='+')or(text1[i]='-')then
			value_tu:=value_tu+text1[i];
		if value_tu='' then value_tu:='0';
		try
			sat_tim_u[gs]:=StrToFloat(value_tu);
			gs:=gs+1;
		except
	end;
end;
end;
k:=1;
With Form4.RusVisible do
	for i:=1 to totalsat do
	begin
		if ndx[i]='r' then
		begin
			try
				cells[4,k]:=FloatToStrF(sat_tim_r[k],ffFixed,3,1);
				k:=k+1;
			except
		end;
	end;
end;
end;



procedure TForm1.N37Click(Sender: TObject);//Калибратор - ВКЛ.
var
	ss:string;
	BytesWritten:dWord;
begin
	calib_on:=1;
	ss:='set,/par/calib/hard/mode,on'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss:='set,/par/calib/hard/use,on'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss := 'em,,jps/gC'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss := 'em,,jps/g1'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss := 'em,,jps/g2'+#13 + #10;
	CS1.Socket.SendText(ss);
end;

procedure TForm1.N38Click(Sender: TObject);//Калибратор - ВЫКЛ.
var
	ss:string;
	BytesWritten:dWord;
begin
	calib_on:=0;
	ss:='set,/par/calib/hard/mode,off'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss:='set,/par/calib/hard/use,off'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss := 'dm,,jps/gC'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss := 'dm,,jps/g1'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss := 'dm,,jps/g2'+#13 + #10;
	CS1.Socket.SendText(ss);
end;


procedure TForm1.gCalibrator;//Значения из Глонасс-калибратора.
label m1;
var
	flog1,flog2:Textfile;//Файл для записи отладочной информации
	flogname1,flogname2:shortstring;//Файл для записи отладочной информации
	i5,i6:Single;
	dr:^Single;
	pos,i,j,s1,s2,l,k,ku,kr:Integer;
	litera:string;
	mes:array[1..4] of byte;
	delay:array[1..14] of Real;
	ranges:array[1..14] of Real;
begin
	if lims=0 then goto m1;
	if calib_on=0 then goto m1;
	fcalibr:=1;
	flogname1:=disc+'\Legacy\Room\delay.txt';
	flogname2:=disc+'\Legacy\Room\ranges.txt';
	pos:=7;
	assignfile(flog1,flogname1);
	if FileExists(flogname1) then append(flog1) else rewrite(flog1);
	write(flog1,time_r+' ');

	assignfile(flog2,flogname2);
	if FileExists(flogname2) then append(flog2) else rewrite(flog2);
	write(flog2,time_r+' ');


	for j:=1 to ((lims-1) div 9) do
	begin
		s1:=pos;
		s2:=pos+3;
		pos:=pos+9;
		l:=1;
		for i:=s1 to s2 do
		begin
			mes[l]:=ord(text2[i]);
			l:=l+1;
		end;
		dr:=@mes;
		i5:=dr^;
		i5:=i5*360;
		delay[j]:=i5;
		//Ranges
		l:=1;
		for i:=s1+4 to s2+4 do
		begin
			mes[l]:=ord(text2[i]);
			l:=l+1;
		end;
		dr:=@mes;
		i6:=dr^;
		ranges[j]:=i6;


		if ord(text2[s1-1])>10 then litera:='-'+IntToStr(256-(ord(text2[s1-1]))) else litera:=IntToStr(ord(text2[s1-1]));
		write(flog1,'['+litera+']='+FloatToStrF(i5,ffFixed,10,1)+' ');
		write(flog2,'['+litera+']='+FloatToStrF(i6,ffExponent,6,6)+' ');
		fdelay[j]:= FloatToStrF(i5,ffFixed,10,1);
	end;
	writeln(flog1);
	closefile(flog1);

	writeln(flog2);
	closefile(flog2);
	m1:
		end;



procedure TForm1.Datas;
label r_err,ga_err,ge_err,na_err,ne_err;
var
	i,j:integer;
	pos_number,pos_group,pos_tr:word;
	pos_xyz,pos_geo,pos_rd,pos_xa,pos_xb,pos_efe,pos_gC,pos_elev,pos_dopler:word;
begin
	if (vch3151='') then goto r_err;
	//if new_datas=0 then goto r_err;

	pos_xyz:=0;
	pos_geo:=0;
	pos_rd:=0;
	pos_group:=0;
	pos_number:=0;
	pos_go:=0;
	pos_no:=0;
	pos_xa:=0;
	pos_xb:=0;
	pos_gC:=0;
	pos_tr:=0;

	pos_dopler:=pos('DC0',vch3151);
	pos_elev:=pos('EL0',vch3151);
	pos_xyz:=pos('PV',vch3151);
	pos_geo:=pos('PG',vch3151);
	pos_rd:=pos('RD',vch3151);
	pos_group:=pos('SI',vch3151);
	pos_number:=pos('NN',vch3151);
	pos_xa:=pos('XA',vch3151);
	pos_xb:=pos('XB',vch3151);
	pos_gC:=pos('gC',vch3151);
	pos_tr:=pos('TR',vch3151);

	if (pos_rd>0)and(vch3151[pos_rd-1]=#10) then
		try
	L1:=vch3151[pos_rd+2];
	L2:=vch3151[pos_rd+3];
	L3:=vch3151[pos_rd+4];
	messlen;
	text1:=copy(vch3151,pos_rd,lims+6);
	if (lims>0)and(text1[lims+6]=#10) then rec_data;
except
 end;


 pos_go:=pos('GO',vch3151);
 if (pos_go>0)and(vch3151[pos_go-1]=#10) then
	 try
 L1:=vch3151[pos_go+2];
 L2:=vch3151[pos_go+3];
 L3:=vch3151[pos_go+4];
 messlen;
 text1:=copy(vch3151,pos_go,lims+6);
 GONOmess ;
 except
 end;

 pos_no:=pos('NO',vch3151);
 if (pos_no>0)and(vch3151[pos_no-1]=#10) then
	 try
 L1:=vch3151[pos_no+2];
 L2:=vch3151[pos_no+3];
 L3:=vch3151[pos_no+4];
 messlen;
 text1:=copy(vch3151,pos_no,lims+6);
 GONOmess ;
 except
 end;



 if (pos_group>0)and(vch3151[pos_group-1]=#10) then
	 try
 L1:=vch3151[pos_group+2];
 L2:=vch3151[pos_group+3];
 L3:=vch3151[pos_group+4];
 messlen;
 text1:=copy(vch3151,pos_group,lims+6);
 sistr:=copy(vch3151,pos_group,lims+6);
 if (lims>0)and(text1[lims+6]=#10) then groups;
 except
 end;



 if (pos_number>0)and(vch3151[pos_number-1]=#10) then
	 try
 L1:=vch3151[pos_number+2];
 L2:=vch3151[pos_number+3];
 L3:=vch3151[pos_number+4];
 messlen;
 text1:=copy(vch3151,pos_number,lims+6);
 nnstr:=copy(vch3151,pos_number,lims+6);
 if (lims>0)and(text1[lims+6]=#10) then  Number;
 except
 end;




 if (pos_elev>0)and(vch3151[pos_elev-1]=#10) then
	 try
 L1:=vch3151[pos_elev+2];
 L2:=vch3151[pos_elev+3];
 L3:=vch3151[pos_elev+4];
 messlen;
 text1:=copy(vch3151,pos_elev,lims+6);
 sistr:=copy(vch3151,pos_elev,lims+6);
 if (lims>0)and(text1[lims+6]=#10) then elev;
 except
 end;


 if (pos_dopler>0)and(vch3151[pos_dopler-1]=#10) then
	 try
 L1:=vch3151[pos_dopler+2];
 L2:=vch3151[pos_dopler+3];
 L3:=vch3151[pos_dopler+4];
 messlen;
 text1:=copy(vch3151,pos_dopler,lims+6);
 sistr:=copy(vch3151,pos_dopler,lims+6);
 if (lims>0)and(text1[lims+6]=#10) then Dopler;
 except
 end;


 if (pos_gC>0)and(vch3151[pos_gC-1]=#10) then
	 try
 L1:=vch3151[pos_gC+2];
 L2:=vch3151[pos_gC+3];
 L3:=vch3151[pos_gC+4];
 messlen;
 text2:=copy(vch3151,pos_gC,lims+6);
 if (lims>0)and(text2[lims+6]=#10) then gCalibrator;
 if (lims>0)and(text2[lims+6]=#10) then Label23.Font.Color:=clRed;
 except
 end;


 if (pos_xa>0)and(vch3151[pos_xa-1]=#10) then
	 try
 L1:=vch3151[pos_xa+2];
 L2:=vch3151[pos_xa+3];
 L3:=vch3151[pos_xa+4];
 messlen;
 text1:=copy(vch3151,pos_xa,lims+6);
 if fl_dev=2 then
	 if (lims>0)and(text1[lims+6]=#10) then Event_XA;
 except
 end;


 if (pos_xb>0)and(vch3151[pos_xb-1]=#10) then
	 try
 L1:=vch3151[pos_xb+2];
 L2:=vch3151[pos_xb+3];
 L3:=vch3151[pos_xb+4];
 messlen;
 text1:=copy(vch3151,pos_xb,lims+6);
 if fl_dev=2 then
	 if (lims>0)and(text1[lims+6]=#10) then Event_XB;
 except
 end;

 pos_tr:=pos('TR',vch3151);
 if (pos_tr>0)and(vch3151[pos_tr-1]=#10) then
	 try
 L1:=vch3151[pos_tr+2];
 L2:=vch3151[pos_tr+3];
 L3:=vch3151[pos_tr+4];
 messlen;
 text1:=copy(vch3151,pos_tr,lims+6);
 timtr;
 except
 end;


 // if (pos_xa>0)or(pos_xb>0)or(pos_go>0)or(pos_no>0) then
	 Scale_count;//Расчет шкал эталона по XA,XB.


 if (pos_geo>0)and(vch3151[pos_geo-1]=#10) then
	 try
 L1:=vch3151[pos_geo+2];
 L2:=vch3151[pos_geo+3];
 L3:=vch3151[pos_geo+4];
 messlen;
 text1:=copy(vch3151,pos_geo,lims+6);
 if (lims>0)and(text1[lims+6]=#10) then coords_geo;
 except
 end;

 r_err:
	 new_datas:=0;
 end;


procedure TForm1.coords_geo;
label m1;
var
	lat,lon,r1,r2,i5,r3,r4,p1,p2:double;
	q1,q2:Real;
	dtt:^double;
	s1,s2,i,j,l:Integer;
	sx,sy,x,y,z,gr_lat,gr_lon:Shortstring;
	mes:array[1..8] of byte;
begin
	if (lims=0)or(lims<$1e) then goto m1;
	l:=1;
	Label21.Caption:='Широта         ';
	Label22.Caption:='Долгота        ';
	Label23.Caption:='Высота         ';
	s1:=6;
	s2:=13;
	for j:=1 to 3 do
	begin
		for i:=s1 to s2 do
		begin
			mes[l]:=ord(Form1.text1[i]);
			l:=l+1;
		end;
		s1:=s1+8;
		s2:=s2+8;
		l:=1;
		dtt:=@mes;
		i5:=dtt^;

		if j=1 then
		begin
			lat:=i5*180/pi;//Градусы - широта
			q1:=int(lat);
			r1:=frac(lat-q1)*60;//Др.часть широты
			r1:=int(r1);
			p1:=frac(frac(lat-q1)*60)*60;
			sx:=FloatToStrF(q1,ffFixed,4,0)+'°';
			gr_lat:=FloatToStrF(r1,ffFixed,2,0);
			if r1<10 then gr_lat:='0'+gr_lat;
			x:=gr_lat+'.'+FloatToStrF(p1,ffFixed,7,5);
			Label21.Caption:=Label21.Caption+sx+x;
		end;
		if j=2 then
		begin
			lon:=i5*180/pi;//Градусы - долгота
			q2:=int(lon);
			r2:=frac(lon-q2)*60;//Др.часть долготы
			r2:=int(r2);
			p2:=frac(frac(lon-q2)*60)*60;
			sy:=FloatToStrF(q2,ffFixed,4,0)+'°';
			gr_lon:=FloatToStrF(r2,ffFixed,2,0);
			if r2<10 then gr_lon:='0'+gr_lon;
			y:=gr_lon+'.'+FloatToStrF(p2,ffFixed,7,5);
			Label22.Caption:=Label22.Caption+sy+y;
		end;
		if j=3 then z:=FloatToStrF(i5,ffFixed,12,3);//Высота
		if j=3 then Label23.Caption:=Label23.Caption+z;
	end;
	m1://Выход по ошибке.
end;

procedure TForm1.sigma11Click(Sender: TObject);
begin
	rectype_1:=1;
	ReadINIFile;
	Connecting;//Соединение...
	Tic_enable;
end;

procedure TForm1.sigma21Click(Sender: TObject);
begin
	rectype_1:=2;
	ReadINIFile;
	Connecting;//Соединение...
	Tic_enable;
end;

procedure TForm1.Tic_enable;
begin
	if count=0 then exit;
	//If (Open_USB_Device_By_Serial_Number(Selected_Device_Serial_Number) = FT_OK)and(fl_dev=1) then
		if (Open_USB_Device_By_Serial_Number(Selected_Device_Serial_Number) = FT_OK) then
		begin
			count:=2;//2 - значит прибор открыт
			Set_USB_Device_TimeOuts(500,500);
			fl_dev:=1;
			CalRes;
			izmer_t3200;
			Form1.Width:=413;
			chA.Visible:=True;
			chB.Visible:=True;
			Label4.Visible:=True;
			Label5.Visible:=True;
			Label11.Visible:=True;
			ExtInt.Visible:=True;
		end;
	end;

procedure TForm1.Connecting;//Соединение...
label m1,merr;
begin
	dir_set;//Установка рабочей директории и читка ini-файла
	N2.Enabled:=False;//Гашение кнопки соединения
	sleep(10);
	CMD1.Enabled:=True;
	INI1.Enabled:=True;
	DecodeTime(TdateTime(time),hour,min,sec,msec);
	if fl_dev>3 then
	begin
		ShowMessage('Не выбран измеритель !');
		goto m1;
	end;

	if StrToInt(elmask)>=45 then
	begin
		ShowMessage('Не слишком-ли большой угол ?!');
		goto m1;
	end;
	//Приемник подключен через ethernet
begin
	CS1.Address:=address_IP;
	CS1.Open;
	CS1.Socket.Connect(1);
end;

if (fl_dev=0)then//SR620
begin
	ffirstrun:=1;
	not_busy_counter:=0;
	izmer620;
end;

merr:
	m1:
		end;





procedure TForm1.N13Click(Sender: TObject);//Переход на фиксированную точку.
begin
	prepare:=0;
	fixpos:=1;
begin
	Label21.Caption:='FixPoint';
	Label22.Caption:='FixPoint';
	Label23.Caption:='FixPoint';
end;
end;

procedure TForm1.N14Click(Sender: TObject);//Режим свободных координат.
begin
	prepare:=0;
	fixpos:=0;
begin
	Label21.Caption:='FreePoint';
	Label22.Caption:='FreePoint';
	Label23.Caption:='FreePoint';
end;
end;


procedure TForm1.N34Click(Sender: TObject);//Разрыв связи с приемником.
var
	ss:string;
	BytesWritten:dword;
begin
	if (rectype_1=1)or(rectype_1=2) then
	begin
		N34.Enabled:=False;
		N35.Enabled:=True;
		fl_hat:=2;
		f_work:=0;
		sleep(1000);
		CS1.Close;
		CS1.Socket.Disconnect(0);
		Label6.Caption:='C L O S E D';
	end;
end;

procedure TForm1.N35Click(Sender: TObject);//Восстановление связи с приемником.
var
	ss:string;
	BytesWritten:dword;
begin
	if (rectype_1=1)or(rectype_1=2) then
	begin
		N34.Enabled:=True;
		N34.Enabled:=False;
		fl_connect:=1;
		CS1.Address:=address_IP;
		CS1.Open;
		CS1.Socket.Connect(1);
	end;
end;

procedure TForm1.CS1Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
	Label6.Caption:='IP:'+address_IP;
	fl_connect:=1;
end;

procedure TForm1.FirstDialog;
label m1,m2;
var
	j,s,pos_RT:Integer;
	c:char;
	ss,stext:string;
	begin//************************************************7
	str_rep:='';
	s:=0;
	s:=pos('id=',vch3151);
	if s>0 then
		for j:=s+3 to length(vch3151) do
		begin
			if vch3151[j]<>',' then str_rep:=str_rep+vch3151[j];
			if vch3151[j]=',' then goto m1;
		end;
		m1:
			if str_rep<>'' then Label19.Caption:='ID: '+str_rep;

			str_rep:='';
			s:=0;
			s:=pos('board=',vch3151);
			if s>0 then
				for j:=s+6 to s+17 do
				begin
					if vch3151[j]<>'}' then str_rep:=str_rep+vch3151[j];
					if vch3151[j]='}' then goto m2;
				end;
				m2:
					if str_rep<>'' then Label18.Caption:='ПРИЕМНИК: '+str_rep+'/'+address_IP;

					s:=0;
					s:=pos('login:',vch3151);
					stext:=#13+#10;
					if s>0 then CS1.Socket.SendText(stext);
					s:=0;
					s:=pos('Password:',vch3151);
					stext:=password+#13+#10;
					if s>0 then CS1.Socket.SendText(stext);
					if s>0 then
					begin
						tot_write:=0;
						how_many:=0;
						total:=0;
						Form1.N10.Enabled:=True;//Выбор источника частоты опорного генератора.
						Form1.N11.Enabled:=True;//Очистка NVRAM или сброс приемника.
						Form1.RT1.Enabled:=True;//Выбор режима метки времени
						if Flag_writefile=0 then Form3.ReceiverMessages;//Настройка приемника на сообщения .
						if Flag_writefile=0 then Form4.PrepareToBegin;//начальные установки : вкл\выкл внутренний измеритель и режим свободной точки.
						str_rep:='';
						buftowr:='';
						fl_connect:=0;
					end;
				end;//***************************************************************

procedure TForm1.find_beg;
var
	times:LongInt;
begin
	//Преобразование во время
	L1:=text2[3];
	L2:=text2[4];
	L3:=text2[5];
	messlen;
	times:=ord(text2[6])+ord(text2[7])*256+ord(text2[8])*65536+ord(text2[9])*16777216;
	times:=(times div 1000);
	hb:=trunc(times div 3600);
	mb:=trunc(times-hb*3600);
	mb:=trunc(Form1.mb div 60);
	sb:=trunc(times-Form1.hb*3600-Form1.mb*60);
end;

procedure TForm1.CS1Read(Sender: TObject; Socket: TCustomWinSocket);
var
	j,pos_RT,pos_SI,pos_EE,pos_dust:Integer;
	c:char;
	ss:Integer;
	sd:string;
begin
	Label10.Visible:=True;
	if fl_connect=1 then vch3151:=Socket.ReceiveText;
	if fl_connect=1 then FirstDialog;
	if fl_connect=1 then exit;
	if fl_connect=0 then
	begin
		vch3151:=Socket.ReceiveText;
		Form4.Temp_time_basic;//Message '~~'l
		if flag_switch_on_writing=1 then Form3.sw_on_writing;//Включение записи файла...
		Datas;
		if (Flag_writefile=1)and(cs_counter<=20)and(fl_hat<2) then
		begin
			Memo1.Lines.Add(vch3151);
			inc(cs_counter);
		end;
	end;
	if (sr=nextime)and(fl_hat=2) then
	begin
		//          +sistr+nnstr
		buftowr:=buftowr+vch3151;
		how_many:=length(buftowr);
		sumstr:='';
		sistr:='';
		nnstr:='';
	end;
	//**********************************************
	if (cs_counter =21)and(fl_hat<2) then
	begin
		btext:=Memo1.Text;
		pos_dust:=pos('JP055RLOGF',btext);
		delete(btext,1,pos_dust-1);
		value:=length(btext);
		Label10.Caption:='Записано : '+FloatToStrF(value,ffFixed,6,0)+' bytes';
		Form1.buftowr:='';
		how_many:=0;
	end;
	if Flag_writefile=1 then Form3.FileWriting;
end;


procedure TForm1.SoLongGNSS;// Завершение работы программы
label m1;
var
	ss:string;
	bytesWritten:dWord;
begin
	ss:='set,/par/lock/glo/fcn,{y,y,y,y,y,y,y,y,y,y,y,y,y,y,n,n,n,n,n,n,n,n,n,n}'+#13 + #10;
	CS1.Socket.SendText(ss);

	ss:='set,/par/lock/gps/sat,{y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y}'+#13 + #10;
	Form1.CS1.Socket.SendText(ss);

	if f_work=0 then goto m1;
	ss := 'dm'+#13 + #10;
	CS1.Socket.SendText(ss);//Остановка выдачи данных из приемника
	//Закрытие потока файлов
	f_work:=0;

	CS1.Close;
	CS1.Socket.Disconnect(0);
	N2.Enabled:=True;

	SaveINIFile;

	if address_IP<>'' then SaveINIFile;
	m1:
		if address_IP<>'' then  SaveINIFile;
		close;
	end;



procedure TForm1.N3Click(Sender: TObject);//Разъединение...
begin
	SoLongGNSS;
end;

procedure TForm1.N19Click(Sender: TObject);//Включение записи файла...
begin
	CS1.Close;
	CS1.Socket.Disconnect(0);

	CS1.Open;
	CS1.Socket.Connect(1);
	cs_counter:=0;
	fl_connect:=1;
	countdown:=Rec_Int;
	nextime:=Rec_int;
	fl_hat:=0;
	flag_switch_on_writing:=1;
	Form1.N10.Enabled:=False;//Изменение частоты опорного генератора.
	Form1.RT1.Enabled:=False;//Режим метки времени
	Label10.Visible:=True;
end;


procedure TForm1.PrefFileClick(Sender: TObject);//Смена префикса.
begin
	PrefDir:=1;
	Prefix.Visible:=True;
	Prefix.SetFocus;
	Prefix.Text:=prefx;
end;

procedure TForm1.N6Click(Sender: TObject);
var i:Integer;
begin
	startprogtime:=sc_ndx;
	for i:=0 to 86400 do
	begin
		arr_n[i]:=0;
		arr_g[i]:=0;
	end;
end;

procedure TForm1.PrefixKeyPress(Sender: TObject; var Key: Char);
begin
	if Key=Chr($0d) then
	begin
		if PrefDir=1 then
		begin //Ввод префикса
	prefx:=Prefix.Text;
	Prefix.Visible:=False;
end;
if PrefDir=2 then
begin//Ввод интервала записи
		try
			Rec_Int:=StrToInt(Prefix.Text);
			countdown:=Rec_Int;
		except
	end;
end;
Prefix.Visible:=False;
	end;
end;

procedure TForm1.starsClick(Sender: TObject);//Управление группировками.
begin
	Number;
	Form4.Visible:=True;
end;



procedure TForm1.SR6201Click(Sender: TObject);//SR620
begin
	GPSRef:=0;
	fl_dev:=0;
	Form4.PrepareToBegin;
	label2.Caption:='Измеритель SR620';
	N26.Enabled:=False;
	N27.Enabled:=True;

	ffirstrun:=1;
	not_busy_counter:=0;
	izmer620;

	Form1.Width:=296;
	chA.Visible:=False;
	chB.Visible:=False;
	Label4.Visible:=False;
	Label5.Visible:=False;
	Label11.Visible:=False;
	ExtInt.Visible:=False;
end;


procedure TForm1.XAXB1Click(Sender: TObject);//Внутренний
var
	ss:ShortString;
	BytesWritten:dWord;
begin
	GPSRef:=1;
	fl_dev:=2;
	Form4.PrepareToBegin;
	label2.Caption:='Внутренний';
	N26.Enabled:=False;
	N27.Enabled:=False;
	Form1.Width:=296;
	chA.Visible:=False;
	chB.Visible:=False;
	Label4.Visible:=False;
	Label5.Visible:=False;
	Label11.Visible:=False;
	ExtInt.Visible:=False;
end;

procedure TForm1.N18Click(Sender: TObject);//Без измерителя.
begin
	GPSRef:=0;
	fl_dev:=3;
	Form4.PrepareToBegin;
	label2.Caption:='Без измерителя';
	N26.Enabled:=False;
	N27.Enabled:=False;
	Form1.Width:=296;
	chA.Visible:=False;
	chB.Visible:=False;
	Label4.Visible:=False;
	Label5.Visible:=False;
	Label11.Visible:=False;
	ExtInt.Visible:=False;
end;



procedure TForm1.N12Click(Sender: TObject);//Сброс приемника...
var
	ss:ShortString;
	BytesWritten:dWord;
begin
	ShowMessage('Все данные приемника будут потеряны !');
	ss:='set,/par/reset,yes'+#13+#10;
	CS1.Socket.SendText(ss);
	ShowMessage('Через 1мин. запустите программу');
	SoLongGNSS;
end;

procedure TForm1.NVRAM1Click(Sender: TObject);//Сброс NVRAM...
var
	ss:ShortString;
	BytesWritten:dWord;
begin
	ShowMessage('NVRAM будет сброшена !');
	ss:='init,/dev/nvm/a'+#13+#10;
	CS1.Socket.SendText(ss);
	sleep(1000);

	ss:='dm'+#13+#10;
	CS1.Socket.SendText(ss);

	f_work:=0;
	N34.Enabled:=False;
	N35.Enabled:=True;
	N2.Visible:=True;
	N2.Enabled:=True;
	ShowMessage('Через 1мин. запустите программу');
	SoLongGNSS;
end;





procedure TForm1.N21Click(Sender: TObject);//порт примника А
begin
	rec_port_ini:='a';
end;

procedure TForm1.B1Click(Sender: TObject);//порт примника B
begin
	rec_port_ini:='b';
end;

procedure TForm1.C1Click(Sender: TObject);//порт примника C
begin
	rec_port_ini:='c';
end;

procedure TForm1.D1Click(Sender: TObject);//порт примника D
begin
	rec_port_ini:='d';
end;

procedure TForm1.N22Click(Sender: TObject);//График РШ по Глон.
var
	t,a:shortstring;
	i:byte;
begin
	a:=prefx+date_for_files;
	SaveDialog1.FileName :=a+'u';
	SaveDialog1.FileName :=a+'g';
	if SaveDialog1.Execute then
	begin
		i:=SaveDialog1.Filterindex;
		if i=1 then
		begin
			t:='.bmp';
			scales.Chart2.SaveToBitmapFile(SaveDialog1.FileName+t);

		end;
		if i=2 then
		begin
			t:='.txt';
			ShowMessage('Не задана ф-ция !');
		end;
	end;
end;

procedure TForm1.USNO1Click(Sender: TObject);//График РШ по USNO.
var
	t,a:shortstring;
	i:byte;
begin
	a:=prefx+date_for_files;
	SaveDialog1.FileName :=a+'u';
	if SaveDialog1.Execute then
	begin
		i:=SaveDialog1.Filterindex;
		if i=1 then
		begin
			t:='.bmp';
			scales.Chart1.SaveToBitmapFile(SaveDialog1.FileName+t);

		end;
		if i=2 then
		begin
			t:='.txt';
			ShowMessage('Не задана ф-ция !');
		end;
	end;

end;




procedure TForm1.N24Click(Sender: TObject);
begin
	PrefDir:=2;
	Prefix.Visible:=True;
	Prefix.SetFocus;
end;

procedure TForm1.Laundry;//Медианная фильтрация
label m_err;
var
	a,b,c:Char;
	t,i,j,k,s,cg,cn:LongInt;
	mini_m,Tnm_GLO,Tnm_GPS:Double;
	q1,q2,q3,q4,qs:Double;
	old_ch_time,new_ch_time:ShortString;
	Dch,Dt,Dt_ch,tgl,tgp:String;
	serial_m: array[1..20] of Double;
	serial_t: array[1..20] of Double;
begin
	med:=9;
	cg:=0;
	cn:=0;
	begin//rgln,rgps
	for i:=startprogtime to sc_ndx-med do
	begin
		k:=i;
		for j:=1 to med+1 do
		begin
			serial_m[j]:=arr_g[k];
			k:=k+1;
		end;
		k:=1;
		s:=1;
		t:=0;
		repeat
			mini_m:=(serial_m[k]);
			for j:=k to med do
			begin
				if (serial_m[j])<mini_m then
				begin
					mini_m:=(serial_m[j]);
					s:=j;
				end;
				//else mini_m:=(serial_m[k]);
			end;
			if mini_m<0 then serial_m[s]:=mini_m/4;
			if mini_m>=0 then serial_m[s]:=4*mini_m;
			serial_t[k]:=mini_m;
			k:=k+1;
			t:=t+1;
		until t=med+1;
		s:=(med) div 2;
		arr_g[i]:=serial_t[s]
	end;
end;//
begin//
for i:=startprogtime to sc_ndx-med do
begin
	k:=i;
	for j:=1 to med+1 do
	begin
		serial_m[j]:=arr_n[k];
		k:=k+1;
	end;
	k:=1;
	s:=1;
	t:=0;
	repeat
		mini_m:=(serial_m[k]);
		for j:=k to med do
		begin
			if (serial_m[j])<mini_m then
			begin
				mini_m:=(serial_m[j]);
				s:=j;
			end;
			//else mini_m:=(serial_m[k]);
		end;
		if mini_m<0 then serial_m[s]:=mini_m/4;
		if mini_m>=0 then serial_m[s]:=4*mini_m;
		serial_t[k]:=mini_m;
		k:=k+1;
		t:=t+1;
	until t=med+1;
	s:=(med) div 2;
	arr_n[i]:=serial_t[s];
end;
	end;//
	m_err://ОБРАБОТКА ДАННЫХ .
end;

procedure TForm1.mx;//Расчет СКО
var
	Idch,t,i,j,k,s:LongInt;
	q1,q2,q3,q4,qs:Double;
begin
	begin
		q1:=0;
		q2:=0;
		q3:=0;
		q4:=0;
		qs:=0;
		Ms_gln:=0;
		Mt_gln:=0;
		Ms_gps:=0;
		Mt_gps:=0;
begin
	for i:=startprogtime to sc_ndx do  if arr_g[i]<>0 then
	begin
		Ms_gps:=Ms_gps+arr_g[i];
		q1:=q1+1;
	end;
	if q1>0 then Ms_gps:=Ms_gps/q1;

	for i:=startprogtime to sc_ndx do  if arr_n[i]<>0 then
	begin
		Ms_gln:=Ms_gln+arr_n[i];
		q2:=q2+1;
	end;
	if q2>0 then Ms_gln:=Ms_gln/q2;

	for i:=startprogtime to sc_ndx do  if arr_g[i]<>0 then q3:=q3+sqr(arr_g[i]-Ms_gps);
	for i:=startprogtime to sc_ndx do  if arr_n[i]<>0 then q4:=q4+sqr(arr_n[i]-Ms_gln);
	if q1>2 then Mt_gps:=sqrt(q3/(q1-1));
	if q2>2 then Mt_gln:=sqrt(q4/(q2-1));
end;
	 end;
 end;

procedure TForm1.N7Click(Sender: TObject);//Фильтр
begin
	rectify:=1;
	laundry;
	mx;
	scales.Visible:=True;
	scales.Chart1.Visible:=True;
	scales.Chart2.Visible:=True;
	scales.Show;
end;

procedure TForm1.N25Click(Sender: TObject);//Как есть
begin
	rectify:=2;
	mx;
	scales.Visible:=True;
	scales.Chart1.Visible:=True;
	scales.Chart2.Visible:=True;
	scales.Show;
end;


procedure TForm1.Show1Click(Sender: TObject);
begin
	Form3.Visible:=True;
	fshow:=1;
end;

procedure TForm1.Becar1Click(Sender: TObject);
begin
	Form3.Visible:=False;
end;


procedure TForm1.GetMJD;
begin
	if(sr=30)or(sr=0) then
	begin
		itime_local:=hr*3600+mr*60+sr;
		itime_local:=(itime_local/30.0)*347.222222;
		//itime_local:=Round(itime_local);
		tmfr:=(FloatToStrF(itime_local,ffFixed,15,0));
		jd:=Julian_Date_of_Year(year_r)+DOY(year_r,mon_r,day_r);
		tmj:=(FloatToStrF(jd,ffFixed,15,1));
		delete(tmj,1,2);
		delete(tmj,6,2);
	end;
end;

Function TForm1.Julian_Date_of_Year(yer : double) : double;
var
	A,B : longint;
begin
	yer := yer - 1;
	A := Trunc(yer/100);
	B := 2 - A + Trunc(A/4);
	Julian_Date_of_Year := Trunc(365.25 * yer)
	+ Trunc(30.6001 * 14)
	+ 1720994.5 + B;
end; {Function Julian_Date_of_Year}


Function TForm1.DOY(yr,mo,dy : word) : word;
const
	days : array [1..12] of word = (31,28,31,30,31,30,31,31,30,31,30,31);
var
	i,day : word;
begin
	day := 0;
	for i := 1 to mo-1 do day := day + days[i];
	day := day + dy;
	if ((yr mod 4) = 0) and
	(((yr mod 100) <> 0) or ((yr mod 400) = 0)) and
	(mo > 2) then
		day := day + 1;
	DOY := day;
end; {Function DOY}


procedure TForm1.N26Click(Sender: TObject);//TIC - запуск
label merr2;
begin
	if fl_dev=0 then
	begin
		ffirstrun:=1;
		not_busy_counter:=0;
		izmer620;
	end;
	N26.Enabled:=False;
	N27.Enabled:=True;
end;

procedure TForm1.N27Click(Sender: TObject);//TIC - стоп
begin
	if fl_dev=0 then
	begin
		ffirstrun:=1;//Перезапуск измерителя
		not_busy_counter:=1;
	end;
	//  snc.Free;
	N26.Enabled:=True;
	N27.Enabled:=False;
end;


procedure TForm1.N51Click(Sender: TObject);//Внешний О.Г. - 5мГц
var
	ss:String;
	BytesWritten,i: DWORD;
begin
	prepare:=0;
	ext_int:=0;
	ss:='set,/par/frq/input,ext'+#13 + #10;//Внешняя частота - 5mHz
	CS1.Socket.SendText(ss);

	ss:='set,/par/frq/ext,5'+#13 + #10;    //5 мГц
	CS1.Socket.SendText(ss);
end;

procedure TForm1.N23Click(Sender: TObject);//Внешний О.Г. - 10мГц
var
	ss:String;
	BytesWritten,i: DWORD;
begin
	prepare:=0;
	ext_int:=1;
	ss:='set,/par/frq/input,ext'+#13 + #10;//Внешняя частота - 10 mHz
	CS1.Socket.SendText(ss);

	ss:='set,/par/frq/ext,10'+#13 + #10;    //10 мГц
	CS1.Socket.SendText(ss);
end;

procedure TForm1.N29Click(Sender: TObject);//Внутренний О.Г.
var
	ss:String;
	BytesWritten,i: DWORD;
begin
	prepare:=0;
	ext_int:=2;
	ss:='set,/par/frq/input,int'+#13 + #10;//Внутренняя частота
	CS1.Socket.SendText(ss);
end;

procedure TForm1.USNO2Click(Sender: TObject);//По USNO
var
	ss:String;
	BytesWritten,i: DWORD;
begin
	prepare:=0;
	tied_on:=1;
	ss:='set,/par/dev/pps/a/tied,on'+#13 + #10;    //Reference time - USNO
	CS1.Socket.SendText(ss);

	ss:='set,/par/dev/pps/b/tied,on'+#13 + #10;    //Reference time - USNO
	CS1.Socket.SendText(ss);
end;

procedure TForm1.N28Click(Sender: TObject);//Свободная МВ
var
	ss:String;
	BytesWritten,i: DWORD;
begin
	prepare:=0;
	tied_on:=0;
	ss:='set,/par/dev/pps/a/tied,off'+#13 + #10;    //No reference time
	CS1.Socket.SendText(ss);

	ss:='set,/par/dev/pps/b/tied,off'+#13 + #10;    //No reference time
	CS1.Socket.SendText(ss);
end;


procedure TForm1.BaseMode1Click(Sender: TObject);//Установка режима базовой станции
var
	ss:String;
	BytesWritten,i: DWORD;
begin
	ss:='set,/par/base/mode/,off'+#13 + #10;    //Сброс режимов
	CS1.Socket.SendText(ss);

	ss:='set,/par/rover/mode/,off'+#13 + #10;   //Сброс режимов
	CS1.Socket.SendText(ss);

	ss:='set,/par/pos/mode/cur,sp'+#13 + #10;   //Сброс режимов
	CS1.Socket.SendText(ss);

	ss:='set,/par/base/mode/,on'+#13 + #10;    //Установка режима
	CS1.Socket.SendText(ss);

end;



procedure TForm1.FormCreate(Sender: TObject);
var
	hMutex : THandle;
begin
	hMutex := CreateMutex(0, true , 'sigma.exe');
	if GetLastError = ERROR_ALREADY_EXISTS then
	begin
		showmessage('ПРОГРАММА УЖЕ ЗАПУЩЕНА !');
		CloseHandle(hMutex);
		Application.Terminate;
	end;

end;

procedure TForm1.Dir_Exists; //Создание директорий в репозитории.
begin
	DecodeDate(TdateTime(date), Year, Month, Day);

	dir_c:=copy_dir+'RawFiles_c\';
	if not( DirectoryExists(dir_c)) then Createdir(dir_c);
	dir_c:=dir_c+IntToStr(year)+'\';
	if not( DirectoryExists(dir_c)) then Createdir(dir_c);
	dir_c:=dir_c+IntToStr(month)+'\';
	if not( DirectoryExists(dir_c)) then Createdir(dir_c);


	dir_t:=copy_dir+'ScaleFiles_t\';
	if not( DirectoryExists(dir_t)) then Createdir(dir_t);
	dir_t:=dir_t+IntToStr(year)+'\';
	if not( DirectoryExists(dir_t)) then Createdir(dir_t);
	dir_t:=dir_t+IntToStr(month)+'\';
	if not( DirectoryExists(dir_t)) then Createdir(dir_t);
end;

procedure TForm1.Repository;
begin//Копирование файлов в репозиторий и удаление скопированных.
Dir_Exists;

if(hr=hourtocopy)and(SendFileName_c<>'')and(SendFileName_t<>'') then
begin
	StCopyFile(SendFileName_c,dir_c+ExtractFileName(SendFileName_c),0,0);
	StCopyFile(SendFileName_t,dir_t+ExtractFileName(SendFileName_t),0,0);
	sleep(100);
	DeleteFile(SendFileName_c);
	DeleteFile(SendFileName_t);
end;
sleep(500);
	   end;




procedure TForm1.izmer620;
label b1,m1,m2,m4,m_err_reading,again,wt,error_counter,ml1,errtimeout;
var
	BytesRead,BytesWritten: DWORD;
	sDeviceName: array[0..8] of Char;
	c,str_init:String;
	rep:char;
	ComStat:TComStat;
	dwMask, dwError: DWORD;
	OverRead: TOverlapped;
	dwRead: DWORD;
	Present:TDateTime;
	i,len,hour,min,sec,msec:word;
	schas:String;
	conto:LongInt;
	contgps,echas:Double;
	d:array[0..100]of char;
begin
	not_busy_counter:=1;//Флаг занятости потока измерителя
	// Открытие порта
	c:=ticport;
	StrPCopy(sDeviceName,c);
	Dcb.BaudRate:=cbr_19200;
	Dcb.ByteSize:=8;
	Dcb.StopBits:=Onestopbit;
	Dcb.Parity:=Noparity;
	sPort := CreateFile(sDeviceName,
		GENERIC_READ or GENERIC_WRITE,
		0,
		nil,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		0);
		if sPort = INVALID_HANDLE_VALUE then
			raise Exception.Create('Error opening port')
		else
			if not SetCommState(sPort,Dcb) then
				raise Exception.Create('Error setting port state');
			//   if Form1.ffirstrun=0 then goto again;
			GetCommTimeOuts(sPort,CommTimeOuts);
begin
	CommTimeOuts.ReadIntervalTimeout         := 20;
	CommTimeOuts.ReadTotalTimeoutMultiplier  := 0;
	CommTimeOuts.ReadTotalTimeoutConstant    := 250;
	CommTimeOuts.WriteTotalTimeoutMultiplier := 100;
	CommTimeOuts.WriteTotalTimeoutConstant   := 1000;
	SetCommTimeOuts(sPort,CommTimeOuts);
end;
again:

	if not PurgeComm(sPort, PURGE_TXABORT or PURGE_RXABORT or PURGE_TXCLEAR or PURGE_RXCLEAR) then
		raise Exception.Create('Error purging port ');
	if not SetCommMask(sPort,EV_RXCHAR) then
		raise Exception.Create('Error setting port mask');
	//Порт открыт!
	//РЕЖИМ СБРОСА И НАСТРОЙКИ
	if(fl_dev=0)and(ffirstrun=1) then    //Если есть sr620 и Первый запуск программы или перезапуск sr620
begin
	for i:=1 to 40 do str_dev[i]:=$20;
	str_init:='MODE0;CLCK1;CLKF0;AUTM0;ARMM1;SIZE1'+#13;
	len:=Length(str_init);
	for i:=1 to len do str_dev[i]:=ord(str_init[i]);
	WriteFile(sPort,str_dev,len, BytesWritten, nil);
end;
if(fl_dev=0) then //Если есть SR620
begin
	for i:=1 to 40 do str_dev[i]:=$20;
	str_init:='MEAS? 0;*WAI'+#13;
	len:=Length(str_init);
	for i:=1 to len do str_dev[i]:=ord(str_init[i]);
	WriteFile(sPort,str_dev,len, BytesWritten, nil);
end;

//
Flag_bad_value:=1;//Флаг правильного значения с SR620
schas:=' ';
repts:=0;
begin
	BytesRead :=0;
	if not ClearCommError(sPort, dwError, @ComStat) then
		raise Exception.Create('Error clearing port');
	dwRead:=ComStat.cbInQue;
	ml1:                                           //Цикл ожидания данных от SR620
	for i := 0 to 100 do d[I]:=' ';
	if not ClearCommError(sPort, dwError, @ComStat) then
		raise Exception.Create('Error clearing port');
	readFile(sPort,d,SizeOf(d),BytesRead, nil);
	repts:=repts+1;
	if repts>10 then
	begin
		goto errtimeout;
	end;
	if BytesRead=0 then goto ml1;              //Цикл ожидания данных от SR620
	for i := 0 to BytesRead-3 do schas := schas + d[I];//
end;
//Проверка текущего отсчета
echas:=StrToFloat(schas);
echas:=echas*1e9;//В наносекундах.
conto:=Round(echas);
conto:=(conto-(conto div 1000)*1000);
if conto=0 then
begin
	ffirstrun:=1;//Перезапуск
	Flag_bad_value:=1;
	goto errtimeout;
end;
if echas>1000000000 then echas:=echas/10;
if ffirstrun=1 then kont_ichas:=echas;
if tgps<0 then contgps:=1e9-echas+tgps;
if tgps>0 then contgps:=-(echas-tgps);
if abs(kont_ichas-echas)<50 then
begin
	ichas:=echas;
	ichas:=ichas-cabdelay;//отсчет измерителя минус компенсационная кабельная задержка.
	kont_ichas:=echas-cabdelay;;
	ffirstrun:=0;
	Flag_bad_value:=0;
end;
errtimeout:
	not_busy_counter:=0;//Сброс флага занятости потока измерителя
	//
	CloseHandle(sPort);
end;


function TForm1.METER_ReaddWord(address: byte): dword;
begin
	FT_out_Buffer[0] := address;
	FT_out_Buffer[1] := 1; // how many
	FT_out_Buffer[2] := 0;
	FT_out_Buffer[3] := 0;
	FT_out_Buffer[4] := 0;
	Write_USB_Device_Buffer(5);
	Read_USB_Device_Buffer(4);
	result:= $00000000 or
	(FT_in_Buffer[$3] shl 24) or
	(FT_in_Buffer[$2] shl 16) or
	(FT_in_Buffer[$1] shl 8) or
	(FT_in_Buffer[$0]);
end;

procedure TForm1.CalRes;
var
	i,j:word;
	a,b,cnt:Real;
	crd1,crd0:dword;
	valcal: dword;
	valuedw: dword;
begin
	if count<2 then exit;//Нету почему-то...
	FT_out_Buffer[0] := $0;//старт калибровки
	FT_out_Buffer[1] := 1; // how many
	FT_out_Buffer[2] := 0;
	FT_out_Buffer[3] := 0;
	FT_out_Buffer[4] := 0;
	Write_USB_Device_Buffer(5);
	j:=0;
	repeat
		valcal:= METER_ReaddWord($F2);
		inc(j);
	until (valcal and $800 = $800)or(j=6000);
	if j=6000 then exit;
	for i:=1 to 2 do
	begin
		valcal:= METER_ReaddWord($F0);//Читаю результат калибровки.
		if i=1 then crd1:=valcal;
		if i=2 then
		begin
			crd0:=valcal;
			a:=crd1 and $000003ff;
			b:=(crd1 and $000ffc00)  shr 10;
			cnt:=(crd1 and $fff00000)shr 20+(crd0 and $f0ffffff)shl 12;
			try calibrs:=4*(cnt+a/1024-b/1024) except calibrs:=0 end;
			Label11.Caption:=' Cal Value = '+FloatTostrF(calibrs,ffFixed,12,3);
		end;
	end;
	INItAll;
end;




procedure TForm1.InitAll;
var
	res,i,j: Integer;
	int_ext,dac:dword;
	b,cnt,wrd1,wrd2:LongInt;
	a,resl:Double;
begin
	if count<2 then exit;//Нету почему-то...
	sclock_corr:=FloatToStrF(clock_corr,ffFixed,12,8);
	FT_out_Buffer[0] := $02;//WR_S
	FT_out_Buffer[1] := $cc;//
	if ExtInt.Checked then FT_out_Buffer[2] := $1b else FT_out_Buffer[2]:=$1c;//$04cc- Внешняя; $00cc - внутренняя опора
	FT_out_Buffer[3] := $ff;
	FT_out_Buffer[4] := $ff;
	Write_USB_Device_Buffer(5);
	sleep(10);
	FT_out_Buffer[0] := $03;//EN
	FT_out_Buffer[1] := $04;//
	FT_out_Buffer[2] := $00;
	FT_out_Buffer[3] := $00;
	FT_out_Buffer[4] := $00;
	Write_USB_Device_Buffer(5);
	sleep(10);
	FT_out_Buffer[0] := $06;//DEC
	FT_out_Buffer[1] := $ff;//
	FT_out_Buffer[2] := $00;
	FT_out_Buffer[3] := $00;
	FT_out_Buffer[4] := $00;
	Write_USB_Device_Buffer(5);
	sleep(10);
	dac:=(((chB.Value+5000) div 40) shl 8)+(chA.Value+5000) div 40;
	FT_out_Buffer[0] := $05;//WR_DAC -уровни  1-й байт:канал А; 2-й байт:канал B
	FT_out_Buffer[1] := (chB.Value+5000) div 40;//
	FT_out_Buffer[2] := (chA.Value+5000) div 40;
	FT_out_Buffer[3] := $00;
	FT_out_Buffer[4] := $00;
	Write_USB_Device_Buffer(5);
	sleep(10);
	FT_out_Buffer[0] := $04;//CTRL - MODE
	FT_out_Buffer[1] := $23;//
	FT_out_Buffer[2] := $00;
	FT_out_Buffer[3] := $00;
	FT_out_Buffer[4] := $00;
	Write_USB_Device_Buffer(5);
end;


procedure TForm1.izmer_t3200;
label m1;
var
	res,i,j: Integer;
	a,b,cnt,wrd1,wrd0,conto,ovfl:dword;
	buf:array[0..3] of dword;
	valresl: dword;
begin
	if count<2 then exit;//Нету почему-то...
	not_busy_counter:=1;//Флаг занятости потока измерителя
	m1:
		FT_out_Buffer[0] := $0a;//WR_RATE
		FT_out_Buffer[1] := $00;//
		Write_USB_Device_Buffer(5);
		sleep(10);
		FT_out_Buffer[0] := $01;//MEAS(URE)
		Write_USB_Device_Buffer(5);
		sleep(10);
		j:=0;
		Label2.Font.Color:=clRed;
		repeat
			FT_out_Buffer[0] := $f1;//RD_MEAS_NO
			Write_USB_Device_Buffer(5);
			sleep(10);
			Read_USB_Device_Buffer(4);
			a:=FT_in_Buffer[0];
			j:=j+1;
		until (a=1) or (j=300);
		if j=300 then
		begin
			not_busy_counter:=0;
			Label11.Caption:=('False Measure ');
			ichas:=kont_ichas;
			exit;
		end;
		for i:=1 to 2 do
		begin
			valresl:=METER_ReaddWord($F0);//Чтение результата
			if i=2 then wrd0:=valresl;
			if i=1 then wrd1:=valresl;
		end;

		Label2.Hint:=(inttohex(wrd0,8)+' '+inttohex(wrd1,8));
		a:=wrd1 and $000003ff;
		b:=(wrd1 and $000ffc00)  shr 10;
		if ExtInt.Checked then clock_corr:=1.000000 else clock_corr:=1.000000525;;
		cnt:=(wrd1 and $fff00000)shr 20+(wrd0 and $000fffff)shl 12;
		try resl:=4*(cnt+a/1024-b/1024)*clock_corr except resl:=0 end;
		resl:=resl-calibrs;
		ichas:=resl;
		ichas:=ichas-cabdelay;//отсчет измерителя минус компенсационная кабельная задержка.
		if ffirstrun=1 then kont_ichas:=resl;
		not_busy_counter:=0;//Флаг занятости потока измерителя
		Label2.Font.Color:=clblue;
	end;

procedure TForm1.chAChange(Sender: TObject);
var
	dac:word;
begin
	dac:=(((chB.Value+5000) div 40) shl 8)+(chA.Value+5000) div 40;
	if count=2 then INItAll;
end;

procedure TForm1.chBChange(Sender: TObject);
var
	dac:word;
begin
	dac:=(((chB.Value+5000) div 40) shl 8)+(chA.Value+5000) div 40;
	if count=2 then INItAll;
end;



procedure TForm1.dir_set;//Sigma
begin
	if (fl_dev=0) then
	begin
		N26.Enabled:=False;
		N27.Enabled:=True;
	end;
	if (fl_dev=2)or(fl_dev=3) then
	begin
		N26.Enabled:=False;
		N27.Enabled:=False;
	end;

	nextime:=Rec_Int;
	countdown:=Rec_Int;
	//++++++++++++++++++++++++++++++++++++++++++
	clock_corr:=StrToFloat(sclock_corr);
	//++++++++++++++++++++++++++++++++++++++++++
	rec_port_ini:=rec_port;//Порт приемника,через который идет поток данных - версия для компортов.
	if rectype_1=1 then
	begin
		if not( DirectoryExists('\\px12-350r\external\sigma1\Legacy\')) then Createdir('\\px12-350r\external\sigma1\Legacy\');
		if not( DirectoryExists('\\px12-350r\external\sigma1\legacy\Rawfiles_c\')) then Createdir('\\px12-350r\external\sigma1\legacy\Rawfiles_c\');
		if not( DirectoryExists('\\px12-350r\external\sigma1\legacy\Rawfiles_h\')) then Createdir('\\px12-350r\external\sigma1\legacy\Rawfiles_h\');
		if not( DirectoryExists('\\px12-350r\external\sigma1\legacy\Syncro_c\'))   then Createdir('\\px12-350r\external\sigma1\legacy\Syncro_c\');
		if not( DirectoryExists('\\px12-350r\external\sigma1\legacy\Syncro_h\'))   then Createdir('\\px12-350r\external\sigma1\legacy\Syncro_h\');
		if not( DirectoryExists('\\px12-350r\external\sigma1\legacy\MailBox\'))    then Createdir('\\px12-350r\external\sigma1\legacy\MailBox\');
		if not( DirectoryExists('\\px12-350r\external\sigma1\legacy\Mjd_File\'))   then Createdir('\\px12-350r\external\sigma1\legacy\Mjd_File\');
	end;
	if rectype_1=2 then
	begin
		if not( DirectoryExists('\\px12-350r\external\sigma2\Legacy\')) then Createdir('\\px12-350r\external\sigma2\Legacy\');
		if not( DirectoryExists('\\px12-350r\external\sigma2\legacy\Rawfiles_c\')) then Createdir('\\px12-350r\external\sigma2\legacy\Rawfiles_c\');
		if not( DirectoryExists('\\px12-350r\external\sigma2\legacy\Rawfiles_h\')) then Createdir('\\px12-350r\external\sigma2\legacy\Rawfiles_h\');
		if not( DirectoryExists('\\px12-350r\external\sigma2\legacy\Syncro_c\'))   then Createdir('\\px12-350r\external\sigma2\legacy\Syncro_c\');
		if not( DirectoryExists('\\px12-350r\external\sigma2\legacy\Syncro_h\'))   then Createdir('\\px12-350r\external\sigma2\legacy\Syncro_h\');
		if not( DirectoryExists('\\px12-350r\external\sigma2\legacy\MailBox\'))    then Createdir('\\px12-350r\external\sigma2\legacy\MailBox\');
		if not( DirectoryExists('\\px12-350r\external\sigma2\legacy\Mjd_File\'))   then Createdir('\\px12-350r\external\sigma2\legacy\Mjd_File\');
	end;

end;





procedure TForm1.CMD1Click(Sender: TObject);//Перечитка CMD-файла
label m1;
var
	a,ss:String;
	i,j,BytesWritten: DWORD;
begin
	if rectype_1=1 then    flogname:='\\px12-350r\external\sigma1\Room\cmdfile.jtf';
	if rectype_1=2 then    flogname:='\\px12-350r\external\sigma2\Room\cmdfile.jtf';
	assignfile(flog,flogname);
	if Fileexists(flogname)then
	begin
		reset(flog);
		while not eof(flog) do
		begin
			readln(flog,ss);
			CS1.Socket.SendText(ss+#13+#10);
			sleep(10);
		end;
		closefile(flog);
	end
	else
		ShowMessage('CMD-файл отсутствует !');
end;

procedure TForm1.INI1Click(Sender: TObject);
begin
	ReadINIFIle;
end;



procedure TForm1.ExtIntClick(Sender: TObject);
begin
	CalRes;
end;


end.


