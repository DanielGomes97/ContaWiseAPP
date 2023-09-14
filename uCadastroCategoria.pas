unit uCadastroCategoria;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.Controls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Edit, FMX.ListView, fMensagem,
  Fmx.Bind.Navigator, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB;

type
  TFrmCadastroCategoria = class(TForm)
    LoBase: TLayout;
    RBackground: TRectangle;
    LoTopo: TLayout;
    RBackgroundTopo: TRectangle;
    LoTopoRight: TLayout;
    BtnNovo: TRectangle;
    Label4: TLabel;
    Layout6: TLayout;
    Rectangle8: TRectangle;
    LoTopoLeft: TLayout;
    BtnVoltar: TRectangle;
    LoTopoCenter: TLayout;
    LblTitulo: TLabel;
    LoCorpo: TLayout;
    Layout2: TLayout;
    Layout17: TLayout;
    BtnExcluir: TRectangle;
    Layout7: TLayout;
    Image4: TImage;
    Label3: TLabel;
    LoRodape: TLayout;
    Rectangle3: TRectangle;
    Layout1: TLayout;
    Layout18: TLayout;
    BtnSalvar: TRectangle;
    Image1: TImage;
    Label7: TLabel;
    BtnCancelar: TRectangle;
    Image5: TImage;
    Label11: TLabel;
    Layout13: TLayout;
    BindNavigator1: TBindNavigator;
    FrameMensagem1: TFrameMensagem;
    RecCombo: TRectangle;
    LVCombo: TListView;
    Layout9: TLayout;
    Rectangle5: TRectangle;
    Layout15: TLayout;
    Layout19: TLayout;
    BtnFecharLV: TRectangle;
    Layout23: TLayout;
    Label9: TLabel;
    Layout4: TLayout;
    Layout5: TLayout;
    EditDescricao: TEdit;
    Layout10: TLayout;
    Label2: TLabel;
    Layout12: TLayout;
    LblCodigo: TLabel;
    Label8: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroCategoria: TFrmCadastroCategoria;

implementation

{$R *.fmx}

uses Funcoes, VariaveisGlobais, DataModulo;

procedure TFrmCadastroCategoria.BtnCancelarClick(Sender: TObject);
begin
    if DM.TblCategoria.State in [dsInsert, dsEdit] then
    begin
        DM.TblCategoria.Cancel;
        ShowMessage('Cancelado com sucesso!');
    end;
end;

procedure TFrmCadastroCategoria.BtnSalvarClick(Sender: TObject);
begin
    if DM.TblCategoria.State in [dsInsert] then
    begin
        if not VerificaExisteDescricao('CATEGORIA', 'DESCRICAO', EditDescricao.Text) then
        begin
            ShowMessage('Adicionado com sucesso');
            DM.TblCategoria.Post;
        end;
    end
    else
    if DM.TblCategoria.State in [dsEdit] then
    begin
        if DM.TblCategoria.FieldByName('Descricao').OldValue <> EditDescricao.Text then
        begin
            if not VerificaExisteDescricao('CATEGORIA', 'DESCRICAO', EditDescricao.Text) then
            begin
                ShowMessage('Modificado com sucesso');
                DM.TblCategoria.Post;
            end
            else
            begin
                ShowMessage('Ja existe');
            end;
        end;
    end;

end;

procedure TFrmCadastroCategoria.BtnVoltarClick(Sender: TObject);
begin
    DM.TblCategoria.Cancel;
    Close;
end;

procedure TFrmCadastroCategoria.FormCreate(Sender: TObject);
begin
    DM.TblCategoria.Open();
end;

end.
