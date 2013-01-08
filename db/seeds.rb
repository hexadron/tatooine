# encoding: utf-8

AdminUser.destroy_all
Level.destroy_all
User.destroy_all
Course.destroy_all
ExerciseType.destroy_all

basico = Level.create({name: "Básico", position: 1})
intermedio = Level.create({name: "Intermedio", position: 2})
avanzado = Level.create({name: "Avanzado", position: 3})

manuel = User.create!({
  first_name: "Manuel",
  last_name: "Eguiluz",
  email: "manuel@tatooine.com",
  password: "password",
  password_confirmation: "password"
})

hoss = User.create({
  first_name: "Hoss",
  last_name: "Fernández",
  email: "hoss@tatooine.com",
  password: "password",
  password_confirmation: "password"
})

julio = User.create({
  first_name: "Julio",
  last_name: "García",
  email: "julio@tatooine.com",
  password: "password",
  password_confirmation: "password"
})

milton = User.create({
  first_name: "Milton",
  last_name: "Chumacero",
  email: "milton@tatooine.com",
  password: "password",
  password_confirmation: "password"
})

lidia = User.create({
  first_name: "Lidia",
  last_name: "Cuchi",
  email: "cuchi_cuchi@tatooine.com",
  password: "password",
  password_confirmation: "password"
})

damaso = User.create({
  first_name: "Dámaso",
  last_name: "López",
  email: "damaso@tatooine.com",
  password: "password",
  password_confirmation: "password"
})

mate_basica = Course.create({
  name: "Matemática Básica",
  available_at: DateTime.now,
  description: "Curso de Matemática para dummies",
  creator_id: hoss.id,
  level_id: basico.id
})

teoria_cuantica_1 = Course.create({
  name: "Teoría Cuántica",
  available_at: 7.days.ago,
  description: "Quema tu cerebro!!",
  creator_id: manuel.id,
  level_id: basico.id
})

daw_2 = Course.create({
  name: "Desarrollo de Aplicaciones Web 2",
  available_at: DateTime.yesterday,
  description: "No le hagan caso al profe",
  creator_id: hoss.id,
  level_id: basico.id
})

base_de_datos_1 = Course.create({
  name: "Base de Datos 1",
  available_at: 1.week.ago,
  description: "No lo lleves con Lidia",
  creator_id: lidia.id,
  level_id: basico.id
})

base_de_datos_2 = Course.create({
  name: "Base de Datos 2",
  available_at: 1.week.ago,
  description: ":D",
  creator_id: damaso.id,
  level_id: basico.id
})

poke_training = Course.create({
  name: "Entrenamiento de Pokemons",
  available_at: 1.week.ago,
  description: "Poke Poke Poke!",
  creator_id: julio.id,
  level_id: basico.id
})

AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')


ExerciseType.create({
  name: 'simple_text',
  implementor: ExerciseTypes::SimpleText
})

ExerciseType.create({
  name: 'true_or_false',
  implementor: ExerciseTypes::TrueOrFalse
})

# ExerciseType.create({
#   name: 'multiple_true_or_false',
#   implementor: ExerciseTypes::MultipleTrueOrFalse
# })

ExerciseType.create({
  name: 'alternatives',
  implementor: ExerciseTypes::Alternatives
})