unit fListaLancamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrameLista = class(TFrame)
    Layout1: TLayout;
    Layout2: TLayout;
    ImgPago: TImage;
    Layout3: TLayout;
    Layout6: TLayout;
    LblDescricao: TLabel;
    Layout7: TLayout;
    LblData: TLabel;
    LblCategoria: TLabel;
    Layout5: TLayout;
    RecBarColor: TRectangle;
    LblValor: TLabel;
    Rectangle2: TRectangle;
    LblStatus: TLabel;
    Layout9: TLayout;
    LblParcela: TLabel;
    Layout4: TLayout;
    ImgReceita: TImage;
    ImgDespesa: TImage;
    ImgPendente: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
