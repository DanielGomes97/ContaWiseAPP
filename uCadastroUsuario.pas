unit uCadastroUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrmCadastroUsuario = class(TForm)
    LoBase: TLayout;
    RBackground: TRectangle;
    LoTopo: TLayout;
    RBackgroundTopo: TRectangle;
    LoTopoRight: TLayout;
    LoTopoLeft: TLayout;
    LoTopoCenter: TLayout;
    Label1: TLabel;
    LoCorpo: TLayout;
    Layout1: TLayout;
    Image1: TImage;
    Layout2: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Label2: TLabel;
    Edit1: TEdit;
    Rectangle1: TRectangle;
    Label5: TLabel;
    Layout3: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    LoRodape: TLayout;
    Rectangle3: TRectangle;
    Label8: TLabel;
    Layout9: TLayout;
    Rectangle2: TRectangle;
    Image2: TImage;
    Layout6: TLayout;
    Label3: TLabel;
    Layout7: TLayout;
    Edit2: TEdit;
    Rectangle4: TRectangle;
    Image3: TImage;
    Layout8: TLayout;
    Label4: TLabel;
    Layout10: TLayout;
    Edit3: TEdit;
    Rectangle5: TRectangle;
    Image4: TImage;
    Layout11: TLayout;
    Label6: TLabel;
    Layout12: TLayout;
    Edit4: TEdit;
    Rectangle6: TRectangle;
    Image5: TImage;
    Label7: TLabel;
    BtnVoltar: TRectangle;
    procedure Rectangle1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroUsuario: TFrmCadastroUsuario;

implementation

{$R *.fmx}

procedure TFrmCadastroUsuario.Rectangle1Click(Sender: TObject);
begin
    ShowMessage('Conta criada com sucesso!');
    Close;
end;

end.
