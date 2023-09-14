program ContaWise;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {FrmPrincipal},
  fListaLancamento in 'fListaLancamento.pas' {FrameLista: TFrame},
  DataModulo in 'DataModulo.pas' {DM: TDataModule},
  fLancamento in 'fLancamento.pas' {FrmLancamento: TFrame},
  uLoading in 'Units\uLoading.pas',
  VariaveisGlobais in 'VariaveisGlobais.pas',
  Funcoes in 'Function\Funcoes.pas',
  fMensagem in 'fMensagem.pas' {FrameMensagem: TFrame},
  uLogin in 'uLogin.pas' {FrmLogin},
  uCadastroLancamento in 'uCadastroLancamento.pas' {FrmCadastroLancamento},
  uCadastroUsuario in 'uCadastroUsuario.pas' {FrmCadastroUsuario},
  fOpcaoLista in 'fOpcaoLista.pas' {FrameOpcaoLista: TFrame},
  uSplash in 'uSplash.pas' {FrmSplash},
  uCadastroCategoria in 'uCadastroCategoria.pas' {FrmCadastroCategoria};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
