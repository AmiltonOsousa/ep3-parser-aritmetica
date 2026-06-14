class Lexer
  def initialize(entrada)
    @entrada = entrada
    @posicao = 0
  end

  def tokens
    resultado = []

    while atual
      case atual
      when /\s/
        avancar
      when /\d/
        resultado << 'num'
        ler_numero
      when '+', '-', '*', '/', '^', '(', ')'
        resultado << atual
        avancar
      else
        raise "Caractere invalido: #{atual}"
      end
    end

    resultado
  end

  private

  def atual
    @entrada[@posicao]
  end

  def avancar
    @posicao += 1
  end

  def ler_numero
    avancar while atual =~ /\d/
  end
end
