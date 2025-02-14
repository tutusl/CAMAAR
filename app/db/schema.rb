# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_01_234020) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cursos", force: :cascade do |t|
    t.string "nomeCurso", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "departamento_id", null: false
    t.index ["departamento_id"], name: "index_cursos_on_departamento_id"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "nomeDepartamento", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplinas", primary_key: "codigoDisciplina", id: :string, force: :cascade do |t|
    t.bigint "departamento_id", null: false
    t.string "nomeDisciplina", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigoDisciplina"], name: "index_disciplinas_on_codigoDisciplina", unique: true
    t.index ["departamento_id"], name: "index_disciplinas_on_departamento_id"
  end

  create_table "formulario_turmas", force: :cascade do |t|
    t.bigint "turma_id", null: false
    t.bigint "formulario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formulario_id"], name: "index_formulario_turmas_on_formulario_id"
    t.index ["turma_id", "formulario_id"], name: "index_formulario_turmas_on_turma_id_and_formulario_id", unique: true
    t.index ["turma_id"], name: "index_formulario_turmas_on_turma_id"
  end

  create_table "formularios", force: :cascade do |t|
    t.bigint "template_id", null: false
    t.datetime "dataCriacao", precision: nil, null: false
    t.string "tipoDestinatario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_formularios_on_template_id"
  end

  create_table "pending_users", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "matricula"
    t.string "curso"
    t.string "departamento"
    t.string "papel"
    t.string "formacao"
    t.string "token"
    t.datetime "token_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questaos", force: :cascade do |t|
    t.bigint "template_id", null: false
    t.text "enunciado", null: false
    t.string "tipoQuestao", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_questaos_on_template_id"
  end

  create_table "respostas", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "formulario_id", null: false
    t.bigint "questao_id", null: false
    t.datetime "dataResposta", precision: nil, null: false
    t.text "valorResposta", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formulario_id"], name: "index_respostas_on_formulario_id"
    t.index ["questao_id"], name: "index_respostas_on_questao_id"
    t.index ["usuario_id"], name: "index_respostas_on_usuario_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "nomeTemplate", null: false
    t.datetime "dataCriacao", precision: nil, null: false
    t.string "semestre", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turmas", force: :cascade do |t|
    t.string "codigoTurma", null: false
    t.string "codigoDisciplina", null: false
    t.string "semestre", null: false
    t.string "horario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuario_turmas", force: :cascade do |t|
    t.bigint "turma_id", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["turma_id", "usuario_id"], name: "index_usuario_turmas_on_turma_id_and_usuario_id", unique: true
    t.index ["turma_id"], name: "index_usuario_turmas_on_turma_id"
    t.index ["usuario_id"], name: "index_usuario_turmas_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "matricula", null: false
    t.bigint "curso_id"
    t.bigint "departamento_id", null: false
    t.string "nome", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "papel", null: false
    t.string "formacao", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curso_id"], name: "index_usuarios_on_curso_id"
    t.index ["departamento_id"], name: "index_usuarios_on_departamento_id"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["matricula"], name: "index_usuarios_on_matricula", unique: true
  end

  add_foreign_key "cursos", "departamentos"
  add_foreign_key "disciplinas", "departamentos"
  add_foreign_key "formulario_turmas", "formularios"
  add_foreign_key "formulario_turmas", "turmas"
  add_foreign_key "formularios", "templates"
  add_foreign_key "questaos", "templates"
  add_foreign_key "respostas", "formularios"
  add_foreign_key "respostas", "questaos"
  add_foreign_key "respostas", "usuarios"
  add_foreign_key "turmas", "disciplinas", column: "codigoDisciplina", primary_key: "codigoDisciplina"
  add_foreign_key "usuario_turmas", "turmas"
  add_foreign_key "usuario_turmas", "usuarios"
  add_foreign_key "usuarios", "cursos"
  add_foreign_key "usuarios", "departamentos"
end