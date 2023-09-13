unit fLancamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrmLancamento = class(TFrame)
    Layout1: TLayout;
    Rectangle7: TRectangle;
    Layout2: TLayout;
    BtnNovo: TRectangle;
    Label9: TLabel;
    BtnSalvar: TRectangle;
    Label10: TLabel;
    BtnCancelar: TRectangle;
    Label11: TLabel;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Layout5: TLayout;
    Layout6: TLayout;
    BtnFechar: TRectangle;
    Layout7: TLayout;
    Label1: TLabel;
    Layout4: TLayout;
    Layout8: TLayout;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    EditCategoria: TEdit;
    Label6: TLabel;
    Layout10: TLayout;
    Edit5: TEdit;
    Label8: TLabel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label7: TLabel;
    Layout9: TLayout;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    LVCombo: TListView;
    Layout11: TLayout;
    Rectangle2: TRectangle;
    Layout12: TLayout;
    LblFecharLV: TLabel;
    Layout13: TLayout;
    Label12: TLabel;
    Layout14: TLayout;
    Rectangle6: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
