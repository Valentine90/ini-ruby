#==============================================================================
# ** INI
#------------------------------------------------------------------------------
#  Este script lida com arquivos INI.
#------------------------------------------------------------------------------
#  Autor: Valentine
#==============================================================================

class INI
  
  def initialize(filename)
    @data = {}
    create_properties(filename)
  end

  def self.load_file(filename)
    new(filename)
  end
  
  def create_properties(filename)
    file = File.open(filename, 'r:bom|UTF-8', &:read)
    key = nil
    # Divide file em substrings com base apenas na quebra
    #de linha, e não nos espaços em branco
    file.split("\n").each do |line|
      if line.start_with?('[')
        key = line[1...line.size - 1].downcase.to_sym
        @data[key] = {}
      # Se não for uma linha em branco ou comentário
      elsif !line.strip.empty? && !line.include?(';')
        name, value = line.split('=')
        @data[key][name.rstrip.downcase.to_sym] = parse(value.lstrip)
      end
    end
  end
  
  def [](key)
    @data[key]
  end
  
  def each(&block)
    @data.each { |key, property| yield(key, property) }
  end
  
  def parse(value)
    if value =~ /^([\d_]+)$/
      return value.to_i
    elsif value =~ /^([\d_]*\.\d+)$/
      return value.to_f
    elsif value =~ /true|false/i
      return value.downcase == 'true'
    else
      # O gsub, em vez de delete, remove aspas simples e duplas e evita
      #que o caractere \ seja removido do restante do texto
      return value.gsub(/\"|'/, '')
    end
  end
  
end
