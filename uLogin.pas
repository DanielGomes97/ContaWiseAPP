unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, fMensagem,
  fOpcaoLista;

type
  TFrmLogin = class(TForm)
    RBackground: TRectangle;
    LoBase: TLayout;
    LoCorpo: TLayout;
    LoRodape: TLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    LblRedefinirSenha: TLabel;
    BtnEntrar: TRectangle;
    Label5: TLabel;
    BtnCriarConta: TRectangle;
    Label6: TLabel;
    Label7: TLabel;
    Rectangle3: TRectangle;
    LblDireitosAutorais: TLabel;
    LblDesenvolvedor: TLabel;
    LblVersao: TLabel;
    Layout5: TLayout;
    Label2: TLabel;
    Layout9: TLayout;
    EditUsuario: TEdit;
    RFundoLogoUser: TRectangle;
    ImageUser: TImage;
    Layout6: TLayout;
    Label3: TLabel;
    Layout7: TLayout;
    EditSenha: TEdit;
    RFundoLogoLock: TRectangle;
    ImageLock: TImage;
    FrameMensagem1: TFrameMensagem;
    FrameOpcaoLista1: TFrameOpcaoLista;
    Layout8: TLayout;
    Image1: TImage;
    procedure BtnCriarContaClick(Sender: TObject);
    procedure BtnEntrarClick(Sender: TObject);
    procedure BtnEntrarMouseEnter(Sender: TObject);
    procedure LblRedefinirSenhaClick(Sender: TObject);
    procedure ImageLogoClick(Sender: TObject);
    procedure BtnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses uCadastroUsuario, VariaveisGlobais, uPrincipal;

procedure TFrmLogin.BtnCriarContaClick(Sender: TObject);
begin
    //FrameMensagem1.MostraMensagem(xMsgTipoCONFIRMA��O, 'CONFIRMA��O DE CADASTRO','Deseja realmente criar uma conta?', true);
    FrmCadastroUsuario := TFrmCadastroUsuario.Create(Self);
    FrmCadastroUsuario.Show;
end;

procedure TFrmLogin.BtnEntrarClick(Sender: TObject);
begin
    //FrameMensagem1.MostraMensagem(xMsgTipoSUCESSO, 'LOGADO COM SUCESSO','Suas informa��es est�o correta, ser� direcionado para tela principal!', true);
    FrmPrincipal := TFrmPrincipal.Create(Self);
    FrmPrincipal.Show;
end;

procedure TFrmLogin.BtnEntrarMouseEnter(Sender: TObject);
begin
    {$IFDEF WINDOWS}
       //
    {$ENDIF}
end;

procedure TFrmLogin.BtnTestClick(Sender: TObject);
begin
    FrmPrincipal := TFrmPrincipal.Create(Self);
    FrmPrincipal.Show;
end;

procedure TFrmLogin.ImageLogoClick(Sender: TObject);
begin
    FrameOpcaoLista1.MostraOpcoes('001', 'Descricao do produto xxxxxxxx', 'R$ 159,88', '1/10', True);
end;

procedure TFrmLogin.LblRedefinirSenhaClick(Sender: TObject);
begin
    FrameMensagem1.MostraMensagem(xMsgTipoNome, 'Necessario preencher todas informa��es!', true);
end;

end.
