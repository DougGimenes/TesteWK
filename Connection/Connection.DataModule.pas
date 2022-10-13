unit Connection.DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  IniFiles;

type
  TDmConexao = class(TDataModule)
    Conexao: TFDConnection;
    DriverFisico: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarQuery(): TFDQuery;
  end;

var
  DmConexao: TDmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmConexao.DataModuleCreate(Sender: TObject);
var
  ArqConexao: TIniFile;
begin
  Self.DriverFisico.VendorLib  := ExtractFileDir(ParamStr(0)) + '\libmariadb.dll';

  ArqConexao := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\Conexao.ini');
  try
    if FileExists(ExtractFileDir(ParamStr(0)) + '\Conexao.ini') then
    begin
      Self.Conexao.Params.Database := ArqConexao.ReadString('Conexao', 'Database', ParamStr(1));
      Self.Conexao.Params.UserName := ArqConexao.ReadString('Conexao', 'UserName', ParamStr(2));
      Self.Conexao.Params.Password := ArqConexao.ReadString('Conexao', 'Password', ParamStr(3));
    end
    else
    begin
      Self.Conexao.Params.Database := ParamStr(1);
      Self.Conexao.Params.UserName := ParamStr(2);
      Self.Conexao.Params.Password := ParamStr(3);

      ArqConexao.WriteString('Conexao', 'Database', ParamStr(1));
      ArqConexao.WriteString('Conexao', 'UserName', ParamStr(2));
      ArqConexao.WriteString('Conexao', 'Password', ParamStr(3));
    end;
  finally
    FreeAndNil(ArqConexao);
  end;

  Self.Conexao.Connected := True;
end;

function TDmConexao.GerarQuery(): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Conexao;
  Result.Transaction := TFDTransaction.Create(nil);
  Result.Transaction.Options.AutoCommit := False;
  Result.Transaction.Connection := Conexao;
end;

end.
