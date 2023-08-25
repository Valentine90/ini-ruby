# frozen_string_literal: true

# Lê dados de arquivos INI.
#
# Copyright (c) 2021 Valentine.
class INI
  def initialize(filename)
    @data = {}

    create_properties(filename)
  end

  def self.load_file(filename)
    new(filename)
  end

  def [](key)
    @data[key]
  end

  def each
    @data.each { |key, property| yield(key, property) }
  end

  private

  def create_properties(filename)
    file = File.open(filename, 'r:bom|UTF-8', &:read)
    key = nil

    # Divide file em substrings com base apenas na quebra
    # de linha, e não nos espaços em branco.
    file.split("\n").each do |line|
      if line.start_with?('[')
        key = line[1...line.size - 1].downcase.to_sym

        @data[key] = {}
      # Se não for uma linha em branco ou comentário.
      elsif !line.strip.empty? && !line.include?(';')
        name, value = line.split('=')

        @data[key][name.rstrip.downcase.to_sym] = parse(value.lstrip)
      end
    end
  end

  def parse(value)
    if value =~ /^([\d_]+)$/
      value.to_i
    elsif value =~ /^([\d_]*\.\d+)$/
      value.to_f
    elsif value =~ /true|false/i
      value.downcase == 'true'
    else
      # O gsub, em vez de delete, remove aspas simples e duplas e evita
      # que o caractere \ seja removido do restante do texto.
      value.gsub(/\"|'/, '')
    end
  end
end
