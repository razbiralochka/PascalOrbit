unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  TAGraph, TASeries, math, TADrawUtils, TACustomSeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1LineSeries5: TLineSeries;
    Chart1LineSeries6: TLineSeries;
    Chart1LineSeries7: TLineSeries;
    Chart1LineSeries8: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Chart1LineSeries2CustomDrawPointer(ASender: TChartSeries;
      ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
    procedure Chart1LineSeries4CustomDrawPointer(ASender: TChartSeries;
      ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
    procedure Chart1LineSeries5CustomDrawPointer(ASender: TChartSeries;
      ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label6Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
// все расчеты в км, с.
const R=6371;
      V1=7.91;

Var del_V, a, ra, rp:real; // для расчета скорости
    x_0, y_0, x, y,x_r, y_r:real;    //для траектории орбит и Земли
    x_c, x_per, y_per, b:real;
     xz1, xz2, yz1, yz2: real;
     xz3, xz4, yz3, yz4: real;
     fi:real;
begin
   // снимаем данные с полей ввода
  a:= StrToFloat(Edit1.Text); //большая полуось орбиты
  ra:= StrToFloat(Edit2.Text); //радиус апогея
  del_V:= V1*sqrt(R/ra)-V1*sqrt(R*(2/ra-1/a));

  //вывод в поле результата
  Label4.Caption:=FloatToStrF(del_V,ffFixed, 10,10);
  //построение траектории перелета
  rp:=2*a-ra;
  x_c:=(-rp+r)/2;
  b:=(rp+r)/2;

  //построение траекторий планет
 fi:=0;
  while fi<=2*pi do
      begin
        x_0:=ra*cos(fi);
        y_0:=ra*sin(fi);
        x:=a*cos(fi)-rp+a;
        y:=(10000+r)*sin(fi);
        x_r:=r*cos(fi);
        y_r:=r*sin(fi);
        Chart1LineSeries2.AddXY(x,y);
        Chart1LineSeries1.AddXY(x_0,y_0);
        Chart1LineSeries3.AddXY(x_r,y_r);
        fi:=fi+0.001;

      end;
  fi:=0;
    while fi<=5*pi/2+pi/3 do
        begin
          if fi<=pi then
           begin
            x_per:=abs(b)*cos(fi)+x_c;
           y_per:=(5000+r)*sin(fi);
           Chart1LineSeries4.AddXY(x_per,y_per);
           Chart1.refresh();
           fi:=fi+0.001;
           end;
          if (fi>pi) and (fi<=2*pi) then
           begin
          x_per:=a*cos(fi)-rp+a;
          y_per:=(10000+r)*sin(fi);
          Chart1LineSeries4.AddXY(x_per,y_per);
          Chart1.refresh();
           fi:=fi+0.001;
           end;
          if fi>2*pi then
           begin
           x_per:=ra*cos(fi);
           y_per:=ra*sin(fi);
           Chart1LineSeries4.AddXY(x_per,y_per);
           Chart1.refresh();
           fi:=fi+0.001;

           end;
       end;
    // построение точки пересечения
    xz1:=-rp-2000;
    xz2:=-rp-2000;
    while (xz1<=-rp+2000) and (xz2<=-rp+2000) do
        begin
        yz1:=abs(xz1+rp);
        yz2:=-abs(xz2+rp);
        Chart1LineSeries5.AddXY(xz1,yz1);
        Chart1LineSeries6.AddXY(xz2,yz2);
        xz1:=xz1+100;
        xz2:=xz2+100;
        end;
    xz3:=ra-2000;
    xz4:=ra-2000;
    while (xz3<=ra+2000) and (xz4<=ra+2000) do
        begin
        yz3:=abs(xz3-ra);
        yz4:=-abs(xz4-ra);
        Chart1LineSeries7.AddXY(xz3,yz3);
        Chart1LineSeries8.AddXY(xz4,yz4);

        xz3:=xz3+100;
        xz4:=xz4+100;
        end;
 end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Chart1LineSeries1.Clear();
  Chart1LineSeries2.Clear();
  Chart1LineSeries3.Clear();
  Chart1LineSeries4.Clear();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form1.Close();
end;

procedure TForm1.Chart1LineSeries2CustomDrawPointer(ASender: TChartSeries;
  ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
begin

end;

procedure TForm1.Chart1LineSeries4CustomDrawPointer(ASender: TChartSeries;
  ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
begin

end;

procedure TForm1.Chart1LineSeries5CustomDrawPointer(ASender: TChartSeries;
  ADrawer: IChartDrawer; AIndex: Integer; ACenter: TPoint);
begin

  end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Label6Click(Sender: TObject);
begin

end;

end.

