unit Model.Produto;

interface

uses
  Controller.Connection,
  FireDAC.Comp.Client,
  SysUtils,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  Connection.DataModule;

type
  TProduto = class(TObject)
  private
    FCodigo: Integer;
    FDescricao: String;
    FPrecoVenda: Double;

  public
    property Codigo: Integer read FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;

    constructor Create(ACodigo : Integer); overload;
  end;

implementation

{ TProduto }


constructor TProduto.Create(ACodigo : Integer);
var
  TbProduto: TFDQuery;
  //Conexao : TConexao;
begin
  //Conexao := TConexao.ObterInstancia();
  TbProduto :=  DmConexao.GerarQuery();
  //Conexao.Conectar();

  TbProduto.SQL.Text := 'SELECT * FROM Produtos WHERE Codigo = ' + IntToStr(ACodigo);
  TbProduto.Open();

  Self.FCodigo     := TbProduto.FieldByName('Codigo').AsInteger;
  Self.FDescricao  := TbProduto.FieldByName('Descricao').AsString;
  Self.FPrecoVenda := TbProduto.FieldByName('PrecoVenda').AsFloat;

  FreeAndNil(TbProduto);
end;

end.
