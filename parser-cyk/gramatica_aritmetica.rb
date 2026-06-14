class GramaticaAritmetica
  def self.regras
    [
      Regra.new('S', ['E']),

      Regra.new('E', ['E_ADD_T']),
      Regra.new('E', ['E_SUB_T']),
      Regra.new('E', ['T']),
      Regra.new('E_ADD_T', ['E', 'PLUS_T']),
      Regra.new('E_SUB_T', ['E', 'MINUS_T']),
      Regra.new('PLUS_T', ['+']),
      Regra.new('MINUS_T', ['-']),

      Regra.new('T', ['T_MUL_P']),
      Regra.new('T', ['T_DIV_P']),
      Regra.new('T', ['P']),
      Regra.new('T_MUL_P', ['T', 'MUL_P']),
      Regra.new('T_DIV_P', ['T', 'DIV_P']),
      Regra.new('MUL_P', ['*']),
      Regra.new('DIV_P', ['/']),

      Regra.new('P', ['F_POW']),
      Regra.new('P', ['F']),
      Regra.new('F_POW', ['F', 'POW_P']),
      Regra.new('POW_P', ['^', 'P']),

      Regra.new('F', ['NEG_F']),
      Regra.new('F', ['A']),
      Regra.new('NEG_F', ['-', 'F']),

      Regra.new('A', ['num']),
      Regra.new('A', ['LP', 'E_RP']),
      Regra.new('LP', ['(']),
      Regra.new('E_RP', ['E', 'RP']),
      Regra.new('RP', [')'])
    ]
  end
end