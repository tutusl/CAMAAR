class ParticipantesController < ApplicationController
  def self.create(participantes_data)
    participantes_data["participantes"].each do |key|
      codigo_disciplina = key["code"]
      codigo_turma = key["classCode"]
      semestre = key["semester"]
      turma = Turma.find_by(codigoTurma: codigo_turma, codigoDisciplina: codigo_disciplina, semestre: semestre)
      %w[dicente docente].each do |tipo|
        key[tipo].each do |participante|
          usuario = Usuario.find_by(email: participante["email"])
          if usuario.nil?
            next
          end
          puts usuario.id
          puts turma.id
          UsuarioTurma.create!(usuario_id: usuario.id, turma_id: turma.id)
        end
      end
    end
  end
end
