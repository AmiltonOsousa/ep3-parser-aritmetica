class SaidaOperacoes
  def initialize(entrada)
    @tokens = tokenizar(entrada)
    @posicao = 0
  end

  def montar
    resultado = soma_ou_diferenca
    raise 'Expressao incompleta' unless fim?

    resultado
  end

  private

  def soma_ou_diferenca
    esquerda = multiplicacao_ou_divisao

    while atual == '+' || atual == '-'
      operador = consumir
      direita = multiplicacao_ou_divisao
      esquerda = [nome_operacao(operador), esquerda, direita]
    end

    esquerda
  end

  def multiplicacao_ou_divisao
    esquerda = potencia

    while atual == '*' || atual == '/'
      operador = consumir
      direita = potencia
      esquerda = [nome_operacao(operador), esquerda, direita]
    end

    esquerda
  end

  def potencia
    esquerda = fator

    if atual == '^'
      consumir
      direita = potencia
      return ['potencia', esquerda, direita]
    end

    esquerda
  end

  def fator
    if atual == '-'
      consumir
      return ['negativacao', fator]
    end

    if atual == '('
      consumir
      expressao = soma_ou_diferenca
      esperar(')')
      return ['parenteses', expressao]
    end

    token = consumir
    return token[:valor] if token.is_a?(Hash) && token[:tipo] == :numero

    raise 'Expressao invalida'
  end

  def tokenizar(entrada)
    tokens = []
    posicao = 0

    while posicao < entrada.length
      caractere = entrada[posicao]

      if caractere =~ /\s/
        posicao += 1
      elsif caractere =~ /\d/
        inicio = posicao
        posicao += 1 while posicao < entrada.length && entrada[posicao] =~ /\d/
        tokens << { tipo: :numero, valor: entrada[inicio...posicao].to_i }
      elsif ['+', '-', '*', '/', '^', '(', ')'].include?(caractere)
        tokens << caractere
        posicao += 1
      else
        raise "Caractere invalido: #{caractere}"
      end
    end

    tokens
  end

  def atual
    @tokens[@posicao]
  end

  def consumir
    token = atual
    @posicao += 1
    token
  end

  def esperar(token_esperado)
    token = consumir
    raise "Esperado #{token_esperado}" unless token == token_esperado
  end

  def fim?
    @posicao == @tokens.length
  end

  def nome_operacao(operador)
    {
      '+' => 'soma',
      '-' => 'diferenca',
      '*' => 'multiplicacao',
      '/' => 'divisao'
    }[operador]
  end
end
