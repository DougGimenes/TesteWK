unit Model.Cliente;

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
  TCliente = class(TObject)
  private
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    FUF: String;

  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;

    constructor Create(ACodigo : Integer); overload;
  end;

implementation

{ TProduto }


constructor TCliente.Create(ACodigo : Integer);
var
  TbCliente: TFDQuery;
 // Conexao : TConexao;
begin
  //Conexao := TConexao.ObterInstancia();
  TbCliente :=  DmConexao.GerarQuery();
  //Conexao.Conectar();

  TbCliente.SQL.Text := 'SELECT * FROM Clientes WHERE Codigo = ' + IntToStr(ACodigo);
  TbCliente.Open();

  Self.FCodigo := TbCliente.FieldByName('Codigo').AsInteger;
  Self.FNome   := TbCliente.FieldByName('Nome').AsString;
  Self.FCidade := TbCliente.FieldByName('Cidade').AsString;
  Self.FUF     := TbCliente.FieldByName('UF').AsString;

  FreeAndNil(TbCliente);
end;

end.
