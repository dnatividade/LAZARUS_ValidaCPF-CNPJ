unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    function ValidaCPFCNPJ(C: AnsiString): AnsiString;

  public

  end;

var
  Form1: TForm1;

implementation

uses MaskUtils;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text:= ValidaCPFCNPJ(Edit1.Text);
end;

function TForm1.ValidaCPFCNPJ(C: AnsiString): AnsiString;
var vetInt: array[1..14] of integer;
    val1, val2: integer;
    lenC: integer;
    i,j: integer;

begin
     lenC:= length(C);

     if ((lenC = 11) or (lenC = 14)) then
     begin
          vetInt[1]:= StrToInt(C[1]);
          vetInt[2]:= StrToInt(C[2]);
          vetInt[3]:= StrToInt(C[3]);
          vetInt[4]:= StrToInt(C[4]);
          vetInt[5]:= StrToInt(C[5]);
          vetInt[6]:= StrToInt(C[6]);
          vetInt[7]:= StrToInt(C[7]);
          vetInt[8]:= StrToInt(C[8]);
          vetInt[9]:= StrToInt(C[9]);
          vetInt[10]:= StrToInt(C[10]);
          vetInt[11]:= StrToInt(C[11]);

          if (lenC = 14) then
          begin
            vetInt[12]:= StrToInt(C[12]);
            vetInt[13]:= StrToInt(C[13]);
            vetInt[14]:= StrToInt(C[14]);
            //
            //VALIDACNPJ()
            //digit1: mult
            j:= 5;
            val1:= 0;
            for i:= 1 to 12 do
            begin
              val1:= (vetInt[i]*j) + val1;
              j:= j-1;
              if (j = 1) then
                 j:= 9;
            end;
            //digit1: mult to 10; div to 11
            //val1:= val1*10;
            val1:= val1 mod 11;
            if (val1 < 2) then
              val1:= 0
            else
              val1:= 11 - val1;

            //digit2: summation
            j:= 6;
            val2:= 0;
            for i:= 1 to 13 do
            begin
              val2:= (vetInt[i]*j) + val2;
              j:= j-1;
              if (j = 1) then
                j:= 9;
            end;
            //digit2: mult to 10; div to 11
            //val2:= val2*10;
            val2:= val2 mod 11;
            if (val2 < 2) then
              val2:= 0
            else
              val2:= 11 - val2;

            //valida CNPJ
            if ((val1 = vetInt[13]) and (val2 = vetInt[14])) then
               result:= FormatmaskText('00\.000\.000\/0000\-00;0;', C)
            else
              result:= 'CNPJ_INVALIDO';
          end

          else
            begin
              //VALIDA_CPF()
              //digit1: mult
              j:= 10;
              val1:= 0;
              for i:= 1 to 9 do
              begin
                val1:= (vetInt[i]*j) + val1;
                j:= j-1;
              end;
              //digit1: mult to 10; div to 11
              val1:= val1*10;
              val1:= val1 mod 11;
              if (val1 = 10) then
                val1:= 0;

              //digit2: summation
              j:= 11;
              val2:= 0;
              for i:= 1 to 10 do
              begin
                val2:= (vetInt[i]*j) + val2;
                j:= j-1;
              end;
              //digit2: mult to 10; div to 11
              val2:= val2*10;
              val2:= val2 mod 11;
              if (val2 = 10) then
                val2:= 0;

              //valida CPF
              if ((val1 = vetInt[10]) and (val2 = vetInt[11])) then
                 result:= FormatmaskText('000\.000\.000\-00;0;', C)
              else
                result:= 'CPF_INVALIDO';
            end;

     end
     else
       result:= 'INVALIDO';
end;

end.

