# frozen_string_literal: true

class ParticipantesController < ApplicationController
  def self.create(participantes_data)
    participantes_data['participantes'].each do |key|
      codigo_disciplina = key['code']
      codigo_turma = key['classCode']
      semestre = key['semester']
      turma = Turma.find_by(codigoTurma: codigo_turma, codigoDisciplina: codigo_disciplina, semestre: semestre)
      %w[dicente docente].each do |tipo|
        key[tipo].each do |participante|
          usuario = Usuario.find_by(email: participante['email'])
          next if usuario.nil?

          participante_existe = UsuarioTurma.find_by(usuario_id: usuario.id, turma_id: turma.id)
          UsuarioTurma.create!(usuario_id: usuario.id, turma_id: turma.id) if participante_existe.nil?
        end
      end
    end
  end
end
