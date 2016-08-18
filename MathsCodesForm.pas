unit MathsCodesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMathsCodes = class(TForm)
    lblMathsCodesIntro: TLabel;
    lblTrigHeading: TLabel;
    lblPowersAndIndicesHeading: TLabel;
    lblTrig1Desc: TLabel;
    lblTrig2Desc: TLabel;
    lblTrig3Desc: TLabel;
    lblTrig4Desc: TLabel;
    lblTrig5Desc: TLabel;
    lblTrig6Desc: TLabel;
    lblTrig7Desc: TLabel;
    lblTrig8Desc: TLabel;
    lblTrig9Desc: TLabel;
    lblPaI1Desc: TLabel;
    lblPaI2Desc: TLabel;
    lblPaI3Desc: TLabel;
    lblPaI4Desc: TLabel;
    lblTrig1Code: TLabel;
    lblTrig2Code: TLabel;
    lblTrig3Code: TLabel;
    lblTrig4Code: TLabel;
    lblTrig5Code: TLabel;
    lblTrig6Code: TLabel;
    lblTrig7Code: TLabel;
    lblTrig8Code: TLabel;
    lblTrig9Code: TLabel;
    lblPaI1Code: TLabel;
    lblPaI2Code: TLabel;
    lblPaI3Code: TLabel;
    lblPaI4Code: TLabel;
    lblSumsIntegralRootsHeading: TLabel;
    lblFractionsBinomialsHeading: TLabel;
    lblSISR1Desc: TLabel;
    lblSISR2Desc: TLabel;
    lblSISR3Desc: TLabel;
    lblSISR4Desc: TLabel;
    lblFB1Desc: TLabel;
    lblFB2Desc: TLabel;
    lblSISR1Code: TLabel;
    lblSISR2Code: TLabel;
    lblSISR3Code: TLabel;
    lblSISR4Code: TLabel;
    lblFB1Code: TLabel;
    lblFB2Code: TLabel;
    lblSymbolsHeading: TLabel;
    lblSym1Desc: TLabel;
    lblSym2Desc: TLabel;
    lblSym3Desc: TLabel;
    lblSym4Desc: TLabel;
    lblSym1Code: TLabel;
    lblSym2Code: TLabel;
    lblSym3Code: TLabel;
    lblSym4Code: TLabel;
    lblSym5Desc: TLabel;
    lblSym6Desc: TLabel;
    lblSym5Code: TLabel;
    lblSym6Code: TLabel;
    btnTrig1Add: TButton;
    btnTrig2Add: TButton;
    btnTrig3Add: TButton;
    btnTrig4Add: TButton;
    btnTrig5Add: TButton;
    btnTrig6Add: TButton;
    btnTrig7Add: TButton;
    btnTrig8Add: TButton;
    btnTrig9Add: TButton;
    btnPaI1Add: TButton;
    btnPaI2Add: TButton;
    btnPaI3Add: TButton;
    btnPaI4Add: TButton;
    btnSISR1Add: TButton;
    btnSISR2Add: TButton;
    btnSISR3Add: TButton;
    btnSISR4Add: TButton;
    btnFB1Add: TButton;
    btnFB2Add: TButton;
    btnSym1Add: TButton;
    btnSym2Add: TButton;
    btnSym3Add: TButton;
    btnSym4Add: TButton;
    btnSym5Add: TButton;
    btnSym6Add: TButton;
    procedure btnTrig1AddClick(Sender: TObject);
    procedure btnTrig2AddClick(Sender: TObject);
    procedure btnTrig3AddClick(Sender: TObject);
    procedure btnTrig4AddClick(Sender: TObject);
    procedure btnTrig5AddClick(Sender: TObject);
    procedure btnTrig6AddClick(Sender: TObject);
    procedure btnTrig7AddClick(Sender: TObject);
    procedure btnTrig8AddClick(Sender: TObject);
    procedure btnTrig9AddClick(Sender: TObject);
    procedure btnPaI1AddClick(Sender: TObject);
    procedure btnPaI2AddClick(Sender: TObject);
    procedure btnPaI3AddClick(Sender: TObject);
    procedure btnPaI4AddClick(Sender: TObject);
    procedure btnSISR1AddClick(Sender: TObject);
    procedure btnSISR2AddClick(Sender: TObject);
    procedure btnSISR3AddClick(Sender: TObject);
    procedure btnSISR4AddClick(Sender: TObject);
    procedure btnFB1AddClick(Sender: TObject);
    procedure btnFB2AddClick(Sender: TObject);
    procedure btnSym1AddClick(Sender: TObject);
    procedure btnSym2AddClick(Sender: TObject);
    procedure btnSym3AddClick(Sender: TObject);
    procedure btnSym4AddClick(Sender: TObject);
    procedure btnSym5AddClick(Sender: TObject);
    procedure btnSym6AddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MathsCodes: TMathsCodes;

implementation

uses QuestionForm;

procedure AddCodeToQuestionForm(Code : String);
begin
  TheQuestionForm.edtAnswerBox.Text := TheQuestionForm.edtAnswerBox.Text + Code;
end;

{$R *.dfm}

procedure TMathsCodes.btnPaI2AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('^{}');
end;

procedure TMathsCodes.btnPaI3AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('_');
end;

procedure TMathsCodes.btnPaI4AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('_{}');
end;

procedure TMathsCodes.btnSISR1AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\sqrt{}');
end;

procedure TMathsCodes.btnSISR2AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\sum{}{}');
end;

procedure TMathsCodes.btnSISR3AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\int{}{}');
end;

procedure TMathsCodes.btnSISR4AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\int');
end;

procedure TMathsCodes.btnSym1AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\theta');
end;

procedure TMathsCodes.btnSym2AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\pm');
end;

procedure TMathsCodes.btnSym3AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\mp');
end;

procedure TMathsCodes.btnSym4AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\leq');
end;

procedure TMathsCodes.btnSym5AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\geq');
end;

procedure TMathsCodes.btnSym6AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\inf');
end;

procedure TMathsCodes.btnTrig1AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\sin');
end;

procedure TMathsCodes.btnTrig2AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\cos');
end;

procedure TMathsCodes.btnTrig3AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\tan');
end;

procedure TMathsCodes.btnTrig4AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\arcsin');
end;

procedure TMathsCodes.btnTrig5AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\arccos');
end;

procedure TMathsCodes.btnTrig6AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\arctan');
end;

procedure TMathsCodes.btnTrig7AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\cot');
end;

procedure TMathsCodes.btnTrig8AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\sec');
end;

procedure TMathsCodes.btnTrig9AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\cosec');
end;

procedure TMathsCodes.btnFB1AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\frac{}{}');
end;

procedure TMathsCodes.btnFB2AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('\binom{}{}');
end;

procedure TMathsCodes.btnPaI1AddClick(Sender: TObject);
begin
  AddCodeToQuestionForm('^');
end;

end.
