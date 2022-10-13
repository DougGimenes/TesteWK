object DmConexao: TDmConexao
  OnCreate = DataModuleCreate
  Height = 101
  Width = 176
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=testewk'
      'User_Name=root'
      'Password=segredo902'
      'Server=localhost'
      'DriverID=MySQL')
    Left = 24
    Top = 24
  end
  object DriverFisico: TFDPhysMySQLDriverLink
    VendorLib = 'F:\TesteWK\Dlls\libmariadb.dll'
    Left = 104
    Top = 24
  end
end
