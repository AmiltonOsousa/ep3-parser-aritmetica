class GramaticaAritmetica
  def self.regras
    [
      Regra.new('S', ['E']),

      Regra.new('E', ['E_ADD']),
      Regra.new('E', ['E_SUB']),
      Regra.new('E', ['T']),
      Regra.new('E_ADD', ['E', 'PLUS_T']),
      Regra.new('E_SUB', ['E', 'MINUS_T']),
      Regra.new('PLUS_T', ['PLUS', 'T']),
      Regra.new('MINUS_T', ['MINUS', 'T']),
      Regra.new('PLUS', ['+']),
      Regra.new('MINUS', ['-']),

      Regra.new('T', ['T_MUL']),
      Regra.new('T', ['T_DIV']),
      Regra.new('T', ['P']),
      Regra.new('T_MUL', ['T', 'MUL_P']),
      Regra.new('T_DIV', ['T', 'DIV_P']),
      Regra.new('MUL_P', ['MUL', 'P']),
      Regra.new('DIV_P', ['DIV', 'P']),
      Regra.new('MUL', ['*']),
      Regra.new('DIV', ['/']),

      Regra.new('P', ['F_POW']),
      Regra.new('P', ['F']),
      Regra.new('F_POW', ['F', 'POW_T']),
      Regra.new('POW_T', ['POW', 'P']),
      Regra.new('POW', ['^']),

      Regra.new('F', ['NEG']),
      Regra.new('F', ['A']),
      Regra.new('NEG', ['MINUS', 'F']),

      Regra.new('A', ['NUM']),
      Regra.new('A', ['LP', 'E_RP']),
      Regra.new('NUM', ['num']),
      Regra.new('LP', ['(']),
      Regra.new('RP', [')']),
      Regra.new('E_RP', ['E', 'RP'])
    ]
  end
end
